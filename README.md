# alpine-drupal8
Drupal 8 docker image with Alpine Linux, Nginx and PHP

## How to Build
sudo docker build -t drupal8 .

## How to run (you will be dropped into the docker container)
```
sudo docker run -p 80:80 \
  -v /yoursrc/modules:/usr/share/nginx/html/modules \
  -v /yoursrc/profiles:/usr/share/nginx/html/profiles \
  -v /yoursrc/themes:/usr/share/nginx/html/themes \
  -v /yoursrc/sites/default:/usr/share/nginx/html/sites/default \
  -it drupal8 bash
```

## Install a site with standard profile inside container (see drupal site:install -h for all options)
```
cp /usr/share/nginx/html/sites/default/default.settings.php /usr/share/nginx/html/sites/default/settings.php && \
/usr/local/bin/drupal -n --root=/usr/share/nginx/html site:install standard --langcode=en \
  --site-name="test install" --site-mail=admin@example.com 
  --account-name=admin --account-mail=admin@example.com --account-pass=admin \
  --db-type=sqlite --db-file=sites/default/files/.ht.sqlite && \
chown -R nginx.nginx /usr/share/nginx/html
```

