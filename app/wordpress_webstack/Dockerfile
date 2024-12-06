FROM wordpress:5.2.4-php7.2-fpm-alpine

# 安装必要工具并下载 wp-cli
RUN curl -L -o /tmp/wp-cli.phar https://github.com/wp-cli/wp-cli/releases/download/v2.11.0/wp-cli-2.11.0.phar && \
    chmod +x /tmp/wp-cli.phar && \
    mv /tmp/wp-cli.phar /usr/local/bin/wp && \
    wp --info    # 验证 wp-cli 安装是否成功


# 下载并解压 WebStack 主题
RUN curl -L -o /tmp/webstack.zip https://github.com/owen0o0/WebStack/archive/refs/tags/1.2024.zip && \
    unzip /tmp/webstack.zip -d /tmp && \
    mv /tmp/WebStack-1.2024 /usr/src/webstack && \
    rm /tmp/webstack.zip

COPY ./wp-docker-entrypoint.sh /usr/local/bin/wp-docker-entrypoint.sh.sh
RUN chmod +x /usr/local/bin/wp-docker-entrypoint.sh

#ENTRYPOINT ["/usr/local/bin/wp-docker-entrypoint.sh"]
#CMD ["php-fpm"]