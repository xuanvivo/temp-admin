#!/usr/bin/env bash
# SPDX-License-Identifier: MIT

set -euo pipefail

PREFIX="${PREFIX:-tmpadmin_}"

if [ "$(id -u)" -ne 0 ]; then
  echo "Please run as root: sudo $0"
  exit 1
fi

usage() {
  echo "Usage:"
  echo "  $0 USERNAME"
  echo "  $0 --all"
}

delete_user() {
  local username="$1"
  local cleanup_script="/root/.delete-${username}.sh"

  if [[ "$username" != "${PREFIX}"* ]]; then
    echo "Refusing to delete non-temporary user: $username"
    return 1
  fi

  if ! id "$username" >/dev/null 2>&1; then
    echo "User does not exist: $username"
    rm -f "$cleanup_script"
    systemctl stop "delete-${username}.timer" >/dev/null 2>&1 || true
    return 0
  fi

  systemctl stop "delete-${username}.timer" >/dev/null 2>&1 || true
  pkill -KILL -u "$username" >/dev/null 2>&1 || true
  userdel -r "$username" >/dev/null 2>&1 || true
  rm -f "$cleanup_script"

  if id "$username" >/dev/null 2>&1; then
    echo "Failed to delete: $username"
    return 1
  fi

  echo "Deleted temporary administrator: $username"
}

if [ "$#" -ne 1 ]; then
  usage
  exit 1
fi

if [ "$1" = "--all" ]; then
  found=0

  while IFS=: read -r username _; do
    if [[ "$username" == "${PREFIX}"* ]]; then
      found=1
      delete_user "$username"
    fi
  done < /etc/passwd

  if [ "$found" -eq 0 ]; then
    echo "No temporary administrator accounts found"
  fi
else
  delete_user "$1"
fi
