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

<details>
<summary><strong>展开完整中文文档</strong></summary>

### 🚀 快速开始

创建一个默认有效期为 **10 分钟** 的临时管理员账号：

```bash
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo bash
```

脚本会输出连接服务器和清理账号所需的全部信息：

```text
用户名：tmpadmin_xxxxxxxx
密码：xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
服务器：公网IP:SSH端口
SSH 命令：ssh -p SSH端口 tmpadmin_xxxxxxxx@公网IP
立即删除：sudo /root/.delete-tmpadmin_xxxxxxxx.sh
```

### ⏱️ 选择有效期

#### 5 分钟

```bash
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo TTL=300 bash
```

#### 10 分钟

```bash
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo TTL=600 bash
```

#### 30 分钟

```bash
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo TTL=1800 bash
```

#### 1 小时

```bash
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo TTL=3600 bash
```

### 🗑️ 立即删除

删除指定临时管理员：

```bash
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/delete-temp-admin.sh | sudo bash -s -- tmpadmin_xxxxxxxx
```

删除所有以 `tmpadmin_` 开头的账号：

```bash
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/delete-temp-admin.sh | sudo bash -s -- --all
```

### ✨ 功能

- 随机生成临时管理员用户名
- 生成 32 位十六进制强密码
- 自动识别 `sudo` 或 `wheel` 管理员组
- 自动检测公网 IP 和 SSH 端口
- 在结果中输出完整 SSH 登录命令
- 支持自定义账号有效期
- 到期后自动结束用户进程
- 自动删除账号及 home 目录
- 提供立即删除命令

### 🔍 运行前检查

下载脚本：

```bash
curl -fsSL -o temp-admin.sh https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh
```

查看脚本：

```bash
less temp-admin.sh
```

添加执行权限并运行：

```bash
chmod +x temp-admin.sh && sudo ./temp-admin.sh
```

### 📦 环境要求

- Linux
- Root 或 sudo 权限
- Bash
- OpenSSL
- 标准 Linux 用户管理命令

安装 OpenSSL：

```bash
# Debian / Ubuntu
sudo apt install openssl
```

```bash
# CentOS / RHEL
sudo yum install openssl
```

### ⚠️ 安全说明

- 临时账号在到期前拥有真实管理员权限。
- 密码只显示一次，不要公开分享终端输出。
- 在生产服务器上运行前，请先检查脚本内容。
- 只能在你拥有或获授权管理的服务器上使用本项目。
- 如果 SSH 端口由外部 NAT 网关映射，服务器内部无法检测公网映射端口。

</details>

---

## 📄 License

Released under the [MIT License](LICENSE).
