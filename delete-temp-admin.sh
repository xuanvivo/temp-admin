#!/usr/bin/env bash
# SPDX-License-Identifier: MIT

set -euo pipefail

PREFIX="${PREFIX:-tmpadmin_}"

if [ "$(id -u)" -ne 0 ]; then
  echo "请使用 root 权限运行：sudo $0"
  exit 1
fi

usage() {
  echo "用法："
  echo "  $0 用户名"
  echo "  $0 --all"
}

delete_user() {
  local username="$1"
  local cleanup_script="/root/.delete-${username}.sh"

  if [[ "$username" != "${PREFIX}"* ]]; then
    echo "拒绝删除非临时账号：$username"
    return 1
  fi

  if ! id "$username" >/dev/null 2>&1; then
    echo "账号不存在：$username"
    rm -f "$cleanup_script"
    systemctl stop "delete-${username}.timer" >/dev/null 2>&1 || true
    return 0
  fi

  systemctl stop "delete-${username}.timer" >/dev/null 2>&1 || true
  pkill -KILL -u "$username" >/dev/null 2>&1 || true
  userdel -r "$username" >/dev/null 2>&1 || true
  rm -f "$cleanup_script"

  if id "$username" >/dev/null 2>&1; then
    echo "删除失败：$username"
    return 1
  fi

  echo "已删除临时管理员账号：$username"
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
    echo "未找到临时管理员账号"
  fi
else
  delete_user "$1"
fi
