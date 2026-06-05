#!/usr/bin/env bash
# MIT License
#
# Copyright (c) 2026 Taxol G
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

set -euo pipefail

TTL="${TTL:-600}"
PREFIX="${PREFIX:-tmpadmin}"
SHELL_PATH="${SHELL_PATH:-/bin/bash}"

if [ "$(id -u)" -ne 0 ]; then
  echo "请用 root 运行：sudo $0"
  exit 1
fi

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "缺少命令：$1"
    exit 1
  }
}

need_cmd openssl
need_cmd useradd
need_cmd chpasswd
need_cmd userdel

if getent group sudo >/dev/null; then
  ADMIN_GROUP="sudo"
elif getent group wheel >/dev/null; then
  ADMIN_GROUP="wheel"
else
  echo "找不到 sudo 或 wheel 管理员组"
  exit 1
fi

rand_hex() {
  openssl rand -hex "$1"
}

USERNAME="${PREFIX}_$(rand_hex 4)"
PASSWORD="$(openssl rand -base64 24 | tr -d '=+/[:space:]' | cut -c1-24)"

if id "$USERNAME" >/dev/null 2>&1; then
  echo "账号已存在：$USERNAME，请重试"
  exit 1
fi

useradd -m -s "$SHELL_PATH" -G "$ADMIN_GROUP" "$USERNAME"
echo "$USERNAME:$PASSWORD" | chpasswd

cleanup_script="/root/.delete-${USERNAME}.sh"
cat > "$cleanup_script" <<EOF
#!/usr/bin/env bash
set +e
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

echo "临时管理员账号已创建"
echo "用户名：$USERNAME"
echo "密码：$PASSWORD"
echo "管理员组：$ADMIN_GROUP"
echo "自动删除时间：$EXPIRE_AT"
