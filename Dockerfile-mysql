FROM php:7.2-apache

# Enable mod_rewrite for apache
RUN a2enmod rewrite

# Install pdo_mysql extension for php
RUN docker-php-ext-configure pdo_mysql && docker-php-ext-install pdo_mysql
