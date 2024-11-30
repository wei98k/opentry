#!/usr/bin/env bash
set -Eeuo pipefail

exec /usr/local/bin/docker-entrypoint.sh "$@"

# 下载webstack主题
curl -L -o /tmp/webstack.zip https://ghp.ci/https://github.com/owen0o0/WebStack/archive/refs/tags/1.2024.zip && \
    unzip /tmp/webstack.zip -d /tmp && \
    mv /tmp/WebStack-1.2024 /usr/src/webstack && \
    rm /tmp/webstack.zip

# 安装 WordPress CLI 工具
curl -L -o wp-cli.phar https://ghp.ci/https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

# 配置 WordPress
cd /var/www/html

echo "Setting up WordPress..."
wp core install \
    --allow-root \
    --url="http://webstack.opentry.test" \
    --title="WebStack Demo" \
    --admin_user="opentry" \
    --admin_password="opentry@123" \
    --admin_email="demo@opentry.com"

# 下载并激活中文语言包
echo "Installing zh_CN language..."
wp --allow-root language core install zh_CN
wp --allow-root language core activate zh_CN

# 安装并激活 WebStack 主题
echo "Installing WebStack theme..."
if [ ! -d "/var/www/html/wp-content/themes/webstack" ]; then
    mv /usr/src/webstack /var/www/html/wp-content/themes/
fi

wp --allow-root theme activate webstack

echo "Setup completed."