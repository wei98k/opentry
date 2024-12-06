#!/bin/bash
envs=(
    WORDPRESS_DB_HOST
    WORDPRESS_DB_USER
    WORDPRESS_DB_PASSWORD
    WORDPRESS_DB_NAME
    WORDPRESS_DB_CHARSET
    WORDPRESS_DB_COLLATE
    WORDPRESS_TABLE_PREFIX
    WORDPRESS_DEBUG
    WORDPRESS_CONFIG_EXTRA
    WP_URL
    WP_TITLE
    WP_ADMIN
    WP_ADMIN_PASSWORD
    WP_ADMIN_EMAIL
)
# 检查 MySQL 服务是否就绪
wait_for_mysql() {
    echo "Waiting for MySQL to be ready..."
    
    until php -r "
        \$mysqli = new mysqli('$WORDPRESS_DB_HOST', '$WORDPRESS_DB_USER', '$WORDPRESS_DB_PASSWORD');
        if (\$mysqli->connect_errno) {
            exit(1);
        }
        exit(0);
    " 2>/dev/null; do
        echo "MySQL is not ready yet. Retrying in 3 seconds..."
        sleep 3
    done

    echo "MySQL is ready!"
}
# 清空数据库
reset_database() {
    wp db reset --yes --path=/var/www/html --allow-root
}

# 清空目录
reset_files() {
    rm -rf /var/www/html/*
}

# 检查环境变量是否要求重新安装
if [[ "$WORDPRESS_RESET" == "true" ]]; then
    echo "Reinstallation mode: Clearing database and files..."

    # 等待 MySQL 服务就绪
    wait_for_mysql

    # 重置文件和数据库
    reset_database

    reset_files

fi

if [ ! -d "/var/www/html/wp-config.php" ]; then
    
    echo "install wordpress ..."
    cp -r /usr/src/wordpress/* /var/www/html/
    cp -r /usr/src/webstack /var/www/html/wp-content/themes/
    
    wait_for_mysql

    
    wp config create --dbname="$WORDPRESS_DB_NAME" --dbuser="$WORDPRESS_DB_USER" --dbpass="$WORDPRESS_DB_PASSWORD" --dbhost="$WORDPRESS_DB_HOST" --path=/var/www/html --allow-root
    wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --locale=zh_CN --path=/var/www/html --skip-email --allow-root
    echo 'wordpress install done ^_^'
    wp theme activate webstack --path=/var/www/html --allow-root
    echo 'webstack theme activate done ^_^'
fi

# 启动 Apache
exec apache2-foreground