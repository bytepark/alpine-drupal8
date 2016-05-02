FROM bytepark/alpine-nginx-php7:latest
MAINTAINER bytepark GmbH <code@bytepark.de>

# Add some tools
RUN apk upgrade -U && \
    apk --update --repository=http://dl-4.alpinelinux.org/alpine/edge/testing add \
    php7-zlib \
    php7-gd \
    php7-session \
    php7-sqlite3 \
    php7-mysqlnd \
    git \
    tar \
    gzip 

COPY /rootfs /

# Install Drupal console
RUN curl https://drupalconsole.com/installer -L -o /usr/local/bin/drupal && chmod +x /usr/local/bin/drupal && /usr/local/bin/drupal init && /usr/local/bin/drupal check

# Install drush
RUN wget -O /usr/local/bin/drush http://files.drush.org/drush.phar && chmod 700 /usr/local/bin/drush

# download drupal
RUN cd /tmp && \
    drupal site:new drupal 8.1.0 && \
    rm -rf /usr/share/nginx/html && \
    mv -f /tmp/drupal /usr/share/nginx/html && \
    mv /usr/share/nginx/html/sites/default /usr/share/nginx/html/sites/default.init

# fix permissions
RUN chown -Rf nginx.nginx /usr/share/nginx/html

VOLUME ["/usr/share/nginx/html/sites/default"]
VOLUME ["/usr/share/nginx/html/modules"]
VOLUME ["/usr/share/nginx/html/profiles"]
VOLUME ["/usr/share/nginx/html/themes"]

ENTRYPOINT ["/init"]
