# temp-admin

It randomly generates a temporary administrator account and a strong password, adds the account to the `sudo` or `wheel` administrator group, and automatically deletes the account and its home directory after 10 minutes.

It is suitable for temporarily granting SSH / sudo access on a server, then automatically cleaning it up after use.

## Notes

- The password is printed in the terminal only once. Do not paste the output in public places.
- If `openssl` is not installed on the server, install it first: `apt install openssl` or `yum install openssl`.
它会随机生成一个临时管理员账号和强密码，加入 sudo 或 wheel 管理员组，10 分钟后自动删除账号和 home 目录。


适合服务器临时给人 SSH / sudo 权限，用完自动清。

注意两点：

• 密码只会在终端打印一次，别把输出贴到公共地方。
• 如果服务器没装 openssl，先装：apt install openssl 或 yum install openssl。




#一键生成临时admin账户



curl -fsSL https://raw.githubusercontent.com/xuanvivo/temp-admin/main/temp-admin.sh | sudo bash
