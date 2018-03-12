FROM shaula/rpi-php7-fpm:7.1.9

# install PHP extensions & PECL modules with dependencies
RUN apt-get update \
 && apt-get install -y \
        bzip2 git wget \
        zlib1g-dev \
        libicu-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN docker-php-ext-install zip \
 && docker-php-ext-install bcmath \
 && docker-php-ext-install mbstring

# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php composer-setup.php --filename=composer \
 && php -r "unlink('composer-setup.php');" \
 && mv composer /usr/local/bin/composer

RUN apt-get update \
  && apt-get install python wiringpi \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN ln -s /usr/local/bin/php /usr/bin/php
