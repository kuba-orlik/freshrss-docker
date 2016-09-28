FROM php:7-apache

RUN apt-get update
RUN apt-get -y upgrade
RUN a2enmod headers expires rewrite ssl

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y mysql-server mysql-client curl libcurl4-gnutls-dev
RUN ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h 
RUN apt-get install -y libgmp-dev
RUN docker-php-ext-configure gmp --with-gmp=/usr/include/x86_64-linux-gnu

RUN apt-get install -y libicu-dev
RUN apt-get install -y libxml2
RUN apt-get install -y libxml2-dev
RUN apt-get install -y zlib1g-dev

RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install curl
RUN docker-php-ext-install intl
RUN docker-php-ext-install json
RUN docker-php-ext-install dom
RUN docker-php-ext-install xml
RUN docker-php-ext-install iconv
RUN docker-php-ext-install zip

RUN apt-get install -y git

RUN service apache2 restart

WORKDIR /usr/share/

RUN git clone https://github.com/FreshRSS/FreshRSS.git

COPY ./config.php FreshRSS/data/config.php
COPY ./config.php FreshRSS/data/config.default.php

WORKDIR FreshRSS


RUN chown -R :www-data .
RUN chmod -R g+w ./data/
RUN rm -rf /var/www/html
RUN ln -s /usr/share/FreshRSS/p /var/www/html

RUN echo "#!/bin/bash" > /start.sh
RUN echo "service apache2 restart" > /start.sh
RUN chmod +x /start.sh