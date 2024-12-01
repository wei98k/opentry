FROM wordpress:5.2.4-php7.2-fpm-alpine

COPY ./wp_setup.sh /usr/local/bin/wp_setup.sh
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/wp_setup.sh && chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["php-fpm"]