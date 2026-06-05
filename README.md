# temp-admin

Generate a temporary Linux administrator account with a random username and a strong password.

The account is automatically added to the `sudo` or `wheel` administrator group, and will be deleted together with its home directory after 10 minutes by default.

This is useful when you need to temporarily grant SSH / sudo access to someone on a Linux server, then automatically clean it up after use.

## 一键生成临时 admin 账户

```bash
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo bash

Custom Expiration Time

The default expiration time is 10 minutes.

You can customize it with TTL, in seconds:

# 5 minutes
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo TTL=300 bash

# 10 minutes
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo TTL=600 bash

# 30 minutes
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo TTL=1800 bash

# 1 hour
curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo TTL=3600 bash

Safer Usage

If you want to inspect the script before running it:

curl -fsSL -o temp-admin.sh https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh
chmod +x temp-admin.sh
sudo ./temp-admin.sh

What It Does

• Randomly generates a temporary administrator username
• Generates a strong random password
• Adds the account to the sudo or wheel administrator group
• Prints the username and password once in the terminal
• Automatically deletes the account after the expiration time
• Removes the account home directory
• Kills active processes owned by the temporary account before deletion

Requirements

• Linux server
• Root or sudo access
• openssl
• useradd
• chpasswd
• userdel
• systemd-run, at, or sleep for scheduled cleanup

If openssl is not installed, install it first:

apt install openssl
# or
 yum install openssl

Notes

• The password is printed in the terminal only once. Do not paste the output in public places.
• This script creates a real administrator account. Only run it on servers you own or manage.
• The account is temporary, but anyone with the password can use sudo before it expires.
• For public or production servers, inspect the script before running it.

中文说明

temp-admin 会随机生成一个临时管理员账号和强密码，加入 sudo 或 wheel 管理员组，并在默认 10 分钟后自动删除账号和 home 目录。

适合服务器临时给人 SSH / sudo 权限，用完自动清。

注意：

• 密码只会在终端打印一次，别把输出贴到公共地方。
• 这是一个真实管理员账号，过期前拥有 sudo 权限。
• 建议只在你自己拥有或管理的服务器上运行。

License

MIT License
