⚡️ temp-admin
Generate a temporary Linux administrator account with a random username and a strong password.

temp-admin adds the account to the sudo or wheel administrator group, then automatically deletes the account and its home directory after the expiration time.

适合临时给服务器创建 SSH / sudo 管理员账号，用完自动清理。

🚀 Quick Start
Create a temporary admin account. Default expiration time: 10 minutes.

curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo bash

⏱️ Custom Expiration Time

Set expiration time with TTL, in seconds.

5 minutes

curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo TTL=300 bash

10 minutes

curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo TTL=600 bash

30 minutes

curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo TTL=1800 bash

1 hour

curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo TTL=3600 bash

🔍 Inspect Before Running

Download the script first:

curl -fsSL -o temp-admin.sh https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh

Make it executable:

chmod +x temp-admin.sh

Run it:

sudo ./temp-admin.sh

✨ Features

• Generates a random temporary admin username
• Generates a strong random password
• Adds the account to the sudo or wheel group
• Prints the username and password once
• Automatically deletes the account after expiration
• Removes the account home directory
• Kills active processes owned by the temporary account before deletion

📦 Requirements

• Linux server
• Root or sudo access
• openssl
• useradd
• chpasswd
• userdel
• systemd-run, at, or sleep

Install openssl if it is missing.

Debian / Ubuntu:

apt install openssl

CentOS / RHEL:

yum install openssl

⚠️ Security Notes

• The password is printed in the terminal only once.
• Do not paste the generated password in public places.
• This script creates a real administrator account.
• Anyone with the password can use sudo before the account expires.
• Only run this script on servers you own or manage.
• For production servers, inspect the script before running it.

🇨🇳 中文说明

temp-admin 会随机生成一个临时管理员账号和强密码，并把账号加入 sudo 或 wheel 管理员组。

默认情况下，账号会在 10 分钟后自动删除，包括对应的 home 目录。

适合服务器临时给人 SSH / sudo 权限，用完自动清。

📄 License

MIT License
