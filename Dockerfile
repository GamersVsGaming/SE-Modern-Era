FROM php:7.4-apache
LABEL Name=web Version=0.0.1

# Install libraries for gd
RUN apt update && apt install -y libfreetype6-dev libjpeg-dev libwebp-dev libpng-dev zlib1g-dev

# Configure gd for php
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp

# Install both mysqli and gd and enable both for php
RUN docker-php-ext-install mysqli gd && docker-php-ext-enable mysqli gd

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/bin/composer

RUN a2enmod rewrite

WORKDIR /var/www/html

EXPOSE 80
