#!/bin/sh

# copy default settings file
cp /usr/share/nginx/html/sites/default/default.settings.php /usr/share/nginx/html/sites/default/settings.php 

# install a fresh drupal site with default values and sqlite as db
/usr/local/bin/drupal -n --root=/usr/share/nginx/html site:install standard --langcode=en \
  --site-name="test install" --site-mail=admin@example.com \
  --account-name=admin --account-mail=admin@example.com --account-pass=admin \
  --db-type=sqlite --db-file=sites/default/files/.ht.sqlite 

# set correct permissions
chown -R nginx.nginx /usr/share/nginx/html
