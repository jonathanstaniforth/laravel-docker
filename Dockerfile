FROM php:7.4.2-apache

LABEL maintainer="jonathanstaniforth@gmail.com"

RUN apt-get update && \
    apt-get install wget unzip -y

WORKDIR /var/www/laravel

# Install Composer
COPY composer-installer.sh .

RUN sh composer-installer.sh && \
    mv composer.phar /usr/local/bin/composer && \
    rm composer-installer.sh

# Setup Apache
COPY laravel.local.conf /etc/apache2/sites-available

RUN a2ensite laravel.local.conf && \
    a2dissite 000-default.conf && \
    a2enmod rewrite

EXPOSE 80/tcp
EXPOSE 443/tcp
