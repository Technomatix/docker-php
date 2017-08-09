FROM php:5.6-cli

MAINTAINER Technomatix team <team@tmx-learning.com>

ENV TZ=UTC
ENV COMPOSER_HOME=/home/composer/.composer
ENV COMPOSER_ALLOW_SUPERUSER=1
   
RUN set -xe && \
    apt-get -qq update && \
    
    # Configure timezone
    ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone && \
    
    # Install php extensions

    ## MySQL Functions http://php.net/manual/en/ref.pdo-mysql.php
    docker-php-ext-install -j$(nproc) pdo_mysql && \

    ## BCMath Arbitrary Precision Mathematics http://php.net/manual/en/book.bc.php
    docker-php-ext-install -j$(nproc) bcmath && \

    ## Multibyte String http://php.net/manual/en/book.mbstring.php
    docker-php-ext-install -j$(nproc) mbstring && \

    ## Zip http://php.net/manual/en/book.zip.php
    apt-get -qq install -y zlib1g-dev && \
    docker-php-ext-install -j$(nproc) zip && \

    ## XML-RPC http://php.net/manual/en/book.xmlrpc.php
    apt-get -qq install -y libxml2-dev && \
    docker-php-ext-install -j$(nproc) xmlrpc && \

    ## cURL http://php.net/manual/en/book.curl.php
    apt-get -qq install -y libcurl4-openssl-dev && \ 
    docker-php-ext-install -j$(nproc) curl && \

    ## XSL http://php.net/manual/en/book.xsl.php
    apt-get -qq install -y libxslt-dev && \
    docker-php-ext-install -j$(nproc) xsl && \

    ## Intl http://php.net/manual/en/book.intl.php
    apt-get -qq install -y libicu-dev && \
    docker-php-ext-install -j$(nproc) intl && \

    ## Mcrypt http://php.net/manual/en/book.mcrypt.php
    apt-get -qq install -y libmcrypt-dev && \
    docker-php-ext-install -j$(nproc) mcrypt && \

    # Install xDebug
    pecl install xdebug && \
    docker-php-ext-enable xdebug && \
    echo "xdebug.remote_enable=on" | tee -a /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo "xdebug.remote_connect_back=on" | tee -a /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo "xdebug.idekey=IDE" | tee -a /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    
    # Configure PHP
    echo "date.timezone = "${TZ} >> /usr/local/etc/php/php.ini && \
    
    # Tools
    apt-get -qq install -y git && \
    apt-get -qq install -y mysql-client && \
        
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
