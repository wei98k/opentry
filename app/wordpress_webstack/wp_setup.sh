#!/bin/bash
set -e

# 配置 WordPress
cd /var/www/html

if [ ! -f wp-config.php ]; then
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
    mv /usr/src/webstack /var/www/html/wp-content/themes/
    wp theme activate webstack

    echo "Setup completed."
fi