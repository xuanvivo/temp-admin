# ⚡️ temp-admin

Generate a temporary Linux administrator account with a random username and a strong password.

`temp-admin` automatically adds the account to the `sudo` or `wheel` administrator group, then deletes the account and its home directory after the expiration time.

Perfect for temporarily granting SSH / sudo access to a Linux server, then cleaning it up automatically.

---

## 🚀 Quick Start

Create a temporary admin account with the default expiration time: **10 minutes**.

```bash
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo bash

───

⏱️ Custom Expiration Time

You can customize the expiration time with TTL, in seconds.

# 5 minutes
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo TTL=300 bash

# 10 minutes, default
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo TTL=600 bash

# 30 minutes
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo TTL=1800 bash

# 1 hour
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo TTL=3600 bash

───

🔍 Safer Usage

If you want to inspect the script before running it:

curl -fsSL -o temp-admin.sh https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh
chmod +x temp-admin.sh
sudo ./temp-admin.sh

───

✨ Features

• 🔐 Generates a strong random password
• 👤 Creates a random temporary admin username
• 🛡️ Adds the account to the sudo or wheel group
• 🖥️ Prints the username and password once in the terminal
• ⏳ Automatically deletes the account after expiration
• 🧹 Removes the account home directory
• 🔪 Kills active processes owned by the temporary account before deletion

───

📦 Requirements

• Linux server
• Root or sudo access
• openssl
• useradd
• chpasswd
• userdel
• systemd-run, at, or sleep for scheduled cleanup

Install openssl if it is missing:

apt install openssl
# or
 yum install openssl

───

⚠️ Security Notes

• The password is printed in the terminal only once.
• Do not paste the generated password in public places.
• This script creates a real administrator account.
• Anyone with the password can use sudo before the account expires.
• Only run this script on servers you own or manage.
• For production servers, inspect the script before running it.

───

🇨🇳 中文说明

temp-admin 会随机生成一个临时管理员账号和强密码，并把账号加入 sudo 或 wheel 管理员组。

默认情况下，账号会在 10 分钟后自动删除，包括对应的 home 目录。

适合服务器临时给人 SSH / sudo 权限，用完自动清。

一键运行

curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo bash

注意事项

• 密码只会在终端打印一次。
• 不要把终端输出贴到公开地方。
• 这是一个真实管理员账号，过期前拥有 sudo 权限。
• 建议只在你自己拥有或管理的服务器上运行。

───

📄 License

MIT License
