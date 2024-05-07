FROM php:8.3.0-apache

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN install-php-extensions gd xdebug bcmath csv intl pdo_mysql pdo_pgsql mysqli uuid imagick json zip curl xml openssl mbstring tokenizer

COPY ./apache/000-default.conf /etc/apache2/sites-available/000-default.conf

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && a2enmod rewrite && a2enmod rewrite && service apache2 restart


RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer


RUN apt-get update && apt-get upgrade -y
RUN apt install zip unzip nano

# EXPOSE 80
# EXPOSE 443

# RUN install-php-extensions php-cli mbstring  


# RUN docker-php-ext-install gd && docker-php-ext-enable gd
# RUN docker-php-ext-install curl && docker-php-ext-enable  curl

# RUN apt update && apt install -y zlib1g-dev libpng-dev
# RUN docker-php-ext-install zip && docker-php-ext-enable zip

# 

# RUN a2dismod php8.3

# RUN a2enmod proxy_fcgi setenvif | a2enconf php8.3-fpm | a2enmod rewrite

# RUN systemctl restart apache2 

# RUN chown -R www-data:www-data /var/www/

