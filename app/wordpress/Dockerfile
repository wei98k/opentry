# 使用 PHP 7.4 和 Apache 基础镜像
FROM php:7.4-apache

# 设置环境变量
ENV WORDPRESS_VERSION=5.1.19
ENV WP_CLI_VERSION=2.11.0

# 安装必要的依赖
RUN apt-get update && apt-get install -y \
    mariadb-client \
    wget \
    unzip \
    less \
    && docker-php-ext-install mysqli \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

# 下载 WordPress 和 wp-cli
RUN curl -L -o /tmp/wordpress.tar.gz https://cn.wordpress.org/wordpress-${WORDPRESS_VERSION}-zh_CN.tar.gz \
    && tar -xzf /tmp/wordpress.tar.gz -C /usr/src/ \
    && rm /tmp/wordpress.tar.gz \
    && curl -L -o /tmp/wp-cli.phar https://github.com/wp-cli/wp-cli/releases/download/v${WP_CLI_VERSION}/wp-cli-${WP_CLI_VERSION}.phar \
    && chmod +x /tmp/wp-cli.phar \
    && mv /tmp/wp-cli.phar /usr/local/bin/wp \
    && curl -L -o /tmp/webstack.zip https://github.com/owen0o0/WebStack/archive/refs/tags/1.2024.zip \
    && unzip /tmp/webstack.zip -d /tmp && \
    mv /tmp/WebStack-1.2024 /usr/src/webstack && \
    rm /tmp/webstack.zip

# 拷贝入口脚本
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# 设置工作目录
WORKDIR /var/www/html

# 暴露端口
EXPOSE 80

# 启动入口点
ENTRYPOINT ["entrypoint.sh"]