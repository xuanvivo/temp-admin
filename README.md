<div align="center">

# ⚡ temp-admin

**Create a temporary Linux administrator account in seconds.**

Random username · Strong password · Automatic cleanup

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Shell](https://img.shields.io/badge/Shell-Bash-4EAA25?logo=gnu-bash&logoColor=white)](temp-admin.sh)
[![Platform](https://img.shields.io/badge/Platform-Linux-blue)](#requirements)

</div>

---

## 🚀 Quick Start

Create a temporary administrator account valid for **10 minutes**:

```bash
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo bash
```

The script prints everything needed to connect and clean up:

```text
Username: tmpadmin_xxxxxxxx
Password: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Server: PUBLIC_IP:SSH_PORT
SSH command: ssh -p SSH_PORT tmpadmin_xxxxxxxx@PUBLIC_IP
Delete now: sudo /root/.delete-tmpadmin_xxxxxxxx.sh
```

---

## ⏱️ Choose a Duration

<details>
<summary><strong>5 minutes</strong></summary>

```bash
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo TTL=300 bash
```

</details>

<details>
<summary><strong>10 minutes</strong></summary>

```bash
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo TTL=600 bash
```

</details>

<details>
<summary><strong>30 minutes</strong></summary>

```bash
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo TTL=1800 bash
```

</details>

<details>
<summary><strong>1 hour</strong></summary>

```bash
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo TTL=3600 bash
```

</details>

---

## 🗑️ Delete Immediately

Delete one temporary administrator:

```bash
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/delete-temp-admin.sh | sudo bash -s -- tmpadmin_xxxxxxxx
```

Delete every `tmpadmin_` account:

```bash
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/delete-temp-admin.sh | sudo bash -s -- --all
```

---

## ✨ Features

- Random temporary administrator username
- Strong 32-character hexadecimal password
- Automatic `sudo` or `wheel` group detection
- Automatic public IP and SSH port detection
- Complete SSH login command in the output
- Configurable expiration time
- Automatic process, account, and home directory cleanup
- Immediate deletion command

---

## 🔍 Inspect Before Running

```bash
curl -fsSL -o temp-admin.sh https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh
```

```bash
less temp-admin.sh
```

```bash
chmod +x temp-admin.sh && sudo ./temp-admin.sh
```

---

## 📦 Requirements

- Linux
- Root or sudo access
- Bash
- OpenSSL
- Standard user-management commands

Install OpenSSL if needed:

```bash
# Debian / Ubuntu
sudo apt install openssl
```

```bash
# CentOS / RHEL
sudo yum install openssl
```

---

## ⚠️ Security

- The generated account has real administrator privileges until it expires.
- The password is displayed only once. Do not share terminal output publicly.
- Review the script before running it on production servers.
- Only use this project on systems you own or are authorized to manage.
- External NAT-mapped SSH ports cannot be detected from inside the server.

---

## 🇨🇳 中文说明

`temp-admin` 用于快速创建一个临时 Linux 管理员账号。

脚本会随机生成用户名和强密码，自动加入 `sudo` 或 `wheel` 管理员组，并在到期后删除账号、用户进程和 home 目录。

默认有效期为 **10 分钟**，适合临时提供 SSH / sudo 权限。

---

## 📄 License

Released under the [MIT License](LICENSE).
