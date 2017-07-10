FROM php:5.6-cli

MAINTAINER Technomatix team <team@tmx-learning.com>

ENV TZ=UTC
ENV COMPOSER_HOME=/home/composer/.composer
ENV COMPOSER_ALLOW_SUPERUSER=1
   
RUN apt-get update && \
    
    # Configure timezone
    ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone && \
    
    # Install php extensions
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-install bcmath && \
    docker-php-ext-install mbstring && \
    apt-get install -y zlib1g-dev && docker-php-ext-install zip && \
    apt-get install -y libxml2-dev && docker-php-ext-install xmlrpc && \
    apt-get install -y libcurl4-openssl-dev && docker-php-ext-install curl  && \
    apt-get install -y libxslt-dev && docker-php-ext-install xsl && \
    apt-get install -y libicu-dev && docker-php-ext-install intl && \
    apt-get install -y libmcrypt-dev && docker-php-ext-install mcrypt && \

    # Install xDebug
    pecl install xdebug && \
    docker-php-ext-enable xdebug && \
    echo "xdebug.remote_enable=on" | tee -a /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo "xdebug.remote_connect_back=on" | tee -a /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo "xdebug.idekey=IDE" | tee -a /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    
    # Configure PHP
    echo "date.timezone = "${TZ} >> /usr/local/etc/php/php.ini && \
    
    # Tools
    apt-get install -y git && \
    apt-get install -y mysql-client && \
        
    # Install Composer
    curl -sS https://getcomposer.org/installer | php -- \
         --filename=composer \
         --install-dir=/usr/local/bin && \

    # Install Codeception
    composer global require --optimize-autoloader codeception/codeception && \

    # Clean
    composer clearcache && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV PATH="/home/composer/.composer/vendor/bin:${PATH}"

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]

WORKDIR /project

CMD ["php", "-a"]
