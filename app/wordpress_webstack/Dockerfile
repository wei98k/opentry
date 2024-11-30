FROM wordpress:5.2.4-php7.2-fpm-alpine

ADD ./wp_setup.sh /opt/wp_setup.sh

ENTRYPOINT ["wp_setup.sh"]
CMD ["php-fpm"]