# PHP Docker image for Yii 2.0 Framework runtime
# ==============================================

ARG PHP_BASE_IMAGE_VERSION
FROM php:${PHP_BASE_IMAGE_VERSION}

# Install system packages for PHP extensions recommended for Yii 2.0 Framework
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get -y install \
        gnupg2 && \
    apt-key update && \
    apt-get update && \
    apt-get -y install \
            g++ \
            git \
            curl \
            imagemagick \
            libcurl3-dev \
            libicu-dev \
            libfreetype6-dev \
            libjpeg-dev \
            libjpeg62-turbo-dev \
            libmagickwand-dev \
            libpq-dev \
            libpng-dev \
            libxml2-dev \
            libzip-dev \
            zlib1g-dev \
            default-mysql-client \
            openssh-client \
            nano \
            unzip \
            libcurl4-openssl-dev \
            libssl-dev \
        --no-install-recommends && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install PHP extensions required for Yii 2.0 Framework
RUN docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-configure bcmath && \
    docker-php-ext-install \
        soap \
        zip \
        curl \
        bcmath \
        exif \
        gd \
        iconv \
        intl \
        mbstring \
        opcache \
        pdo_mysql \
        pdo_pgsql

# Install PECL extensions
# see http://stackoverflow.com/a/8154466/291573) for usage of `printf`
RUN printf "\n" | pecl install \
        imagick \
        mongodb && \
    docker-php-ext-enable \
        imagick \
        mongodb

# Xdebug extension
RUN pecl install -f xdebug && docker-php-ext-enable xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" >> /usr/local/etc/php/php.ini \
    && touch /tmp/xdebub.log


#RUN pecl install -f xdebug \
#    && touch /tmp/xdebub.log \
#    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini;

# Add configuration files
# COPY image-files/ /

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- \
        --filename=composer \
        --install-dir=/usr/local/bin && \
        chmod +x /usr/local/bin/composer \
        composer --version \
        composer clear-cache
#Plugin 'composer-asset-plugin' for yii2
RUN composer global require "fxp/composer-asset-plugin:^1.4.1"

# Add GITHUB_API_TOKEN support for composer
# RUN chmod 700 \
#         /usr/local/bin/docker-php-entrypoint \
#         /usr/local/bin/composer

# Install composer plugins
# RUN composer global require --optimize-autoloader \
#         "hirak/prestissimo:${VERSION_PRESTISSIMO_PLUGIN}" && \
#     composer global dumpautoload --optimize && \
#     composer clear-cache

# Enable mod_rewrite for images with apache
RUN if command -v a2enmod >/dev/null 2>&1; then \
       a2enmod rewrite headers \
   ;fi

RUN a2enmod rewrite

RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf
# Install Yii framework bash autocompletion
#RUN curl -L https://raw.githubusercontent.com/yiisoft/yii2/master/contrib/completion/bash/yii \
#        -o /etc/bash_completion.d/yii

# Application environment
# WORKDIR /php