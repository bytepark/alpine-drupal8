FROM bytepark/alpine-nginx:latest
MAINTAINER bytepark GmbH <code@bytepark.de>

# Add PHP 7
RUN apk upgrade -U && \
    apk --update --repository=http://dl-4.alpinelinux.org/alpine/edge/testing add \
    php7 \
    php7-xml \
    php7-xsl \
    php7-pdo_mysql \
    php7-mcrypt \
    php7-curl \
    php7-zlib \
    php7-gd \
    php7-session \
    php7-sqlite3 \
    php7-mysqlnd \
    php7-json \
    php7-fpm \
    php7-phar \
    php7-openssl \
    php7-mysqli \
    php7-ctype \
    php7-opcache \
    php7-mbstring \
    git

COPY /rootfs /

# Small fixes
RUN ln -s /etc/php7 /etc/php && \
    ln -s /usr/bin/php7 /usr/bin/php && \
    ln -s /usr/sbin/php-fpm7 /usr/bin/php-fpm && \
    ln -s /usr/lib/php7 /usr/lib/php && \
    rm -fr /var/cache/apk/*

# Install composer global bin
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Run this in your terminal to get the latest Drupal Console version:
RUN cd /tmp && curl https://drupalconsole.com/installer -L -o drupal.phar && mv drupal.phar /usr/local/bin/drupal && chmod +x /usr/local/bin/drupal && /usr/local/bin/drupal check

# Install drush
RUN wget -O /usr/local/bin/drush http://files.drush.org/drush.phar && chmod 700 /usr/local/bin/drush

# install drupal
#RUN cd /usr/share/nginx/html && /usr/local/bin/drush site-install standard -y --account-name=admin --account-pass=admin --db-url=sqlite://tmp/drupal.sqlite

# download drupal
RUN mkdir -p /usr/share/nginx/html && cd /tmp && /usr/local/bin/drush dl drupal && mv /tmp/drupal*/* /usr/share/nginx/html/

# set perms
RUN mkdir -p /usr/share/nginx/html && chown -Rf nginx:nginx /usr/share/nginx/html

# ADD SOURCE
ONBUILD COPY ./src /usr/share/nginx/html
ONBUILD RUN chown -Rf nginx:nginx /usr/share/nginx/html

# Setup Volume
VOLUME ["/usr/share/nginx/html"]

ENTRYPOINT ["/init"]
