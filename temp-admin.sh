#!/usr/bin/env bash
# SPDX-License-Identifier: MIT

set -euo pipefail

TTL="${TTL:-600}"
PREFIX="${PREFIX:-tmpadmin}"
SHELL_PATH="${SHELL_PATH:-/bin/bash}"
SERVER_HOST="${SERVER_HOST:-}"
SERVER_PORT="${SERVER_PORT:-}"

if [ "$(id -u)" -ne 0 ]; then
  echo "Please run as root: sudo $0"
  exit 1
fi

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing command: $1"
    exit 1
  }
}

need_cmd openssl
need_cmd useradd
need_cmd chpasswd
need_cmd userdel

detect_server_host() {
  local detected=""

  detected="$(curl -fsS --connect-timeout 2 \
    http://169.254.169.254/latest/meta-data/public-ipv4 2>/dev/null || true)"

  if [ -z "$detected" ]; then
    detected="$(curl -4fsS --connect-timeout 3 https://ifconfig.co 2>/dev/null || true)"
  fi

  if [ -z "$detected" ]; then
    detected="$(curl -4fsS --connect-timeout 3 https://api.ipify.org 2>/dev/null || true)"
  fi

  if [ -z "$detected" ]; then
    detected="$(ip -4 route get 1.1.1.1 2>/dev/null |
      awk '{for (i = 1; i <= NF; i++) if ($i == "src") {print $(i + 1); exit}}')"
  fi

  printf '%s' "${detected:-UNKNOWN}"
}

detect_server_port() {
  local detected=""

  if [ -n "${SSH_CONNECTION:-}" ]; then
    detected="$(awk '{print $4}' <<< "$SSH_CONNECTION")"
  fi

  if [ -z "$detected" ] && [ -n "${SSH_CLIENT:-}" ]; then
    detected="$(awk '{print $3}' <<< "$SSH_CLIENT")"
  fi

  if [ -z "$detected" ] && command -v ss >/dev/null 2>&1; then
    detected="$(ss -H -ltnp 2>/dev/null |
      awk '/sshd/ {
        count = split($4, address, ":")
        print address[count]
        exit
      }')"
  fi

  if [ -z "$detected" ] && command -v sshd >/dev/null 2>&1; then
    detected="$(sshd -T 2>/dev/null |
      awk '$1 == "port" {print $2; exit}')"
  fi

  printf '%s' "${detected:-22}"
}

if getent group sudo >/dev/null; then
  ADMIN_GROUP="sudo"
elif getent group wheel >/dev/null; then
  ADMIN_GROUP="wheel"
else
  echo "Could not find sudo or wheel administrator group"
  exit 1
fi

if [ -z "$SERVER_HOST" ]; then
  SERVER_HOST="$(detect_server_host)"
fi

if [ -z "$SERVER_PORT" ]; then
  SERVER_PORT="$(detect_server_port)"
fi

USERNAME="${PREFIX}_$(openssl rand -hex 4)"
PASSWORD="$(openssl rand -hex 16)"

if id "$USERNAME" >/dev/null 2>&1; then
  echo "User already exists: $USERNAME. Please retry."
  exit 1
fi

useradd -m -s "$SHELL_PATH" -G "$ADMIN_GROUP" "$USERNAME"
echo "$USERNAME:$PASSWORD" | chpasswd

cleanup_script="/root/.delete-${USERNAME}.sh"
cat > "$cleanup_script" <<EOF
#!/usr/bin/env bash
set +e
systemctl stop 'delete-${USERNAME}.timer' >/dev/null 2>&1
pkill -KILL -u '$USERNAME' >/dev/null 2>&1
userdel -r '$USERNAME' >/dev/null 2>&1
rm -f '$cleanup_script'
EOF
chmod 700 "$cleanup_script"

if command -v systemd-run >/dev/null 2>&1; then
  systemd-run --quiet --unit="delete-${USERNAME}" --on-active="${TTL}s" "$cleanup_script"
elif command -v at >/dev/null 2>&1; then
  echo "$cleanup_script" | at now + "$TTL" seconds >/dev/null 2>&1
else
  nohup bash -c "sleep '$TTL'; '$cleanup_script'" >/dev/null 2>&1 &
fi

EXPIRE_AT="$(date -d "+${TTL} seconds" '+%Y-%m-%d %H:%M:%S %Z' 2>/dev/null || date)"

echo "Temporary administrator account created"
echo "Username: $USERNAME"
echo "Password: $PASSWORD"
echo "Admin group: $ADMIN_GROUP"
echo "Expires at: $EXPIRE_AT"
echo "Server: $SERVER_HOST:$SERVER_PORT"
echo "SSH command: ssh -p $SERVER_PORT $USERNAME@$SERVER_HOST"
echo "Delete now: sudo $cleanup_script"
