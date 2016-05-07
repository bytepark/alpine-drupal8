# alpine-drupal8
Drupal 8 docker image with Alpine Linux, Nginx and PHP7

## Content
Container contains latest drupal version availabe.
Also included drupal Console and drush.

## How to run Image
You can directly run the image via Docker Hub (and have it listen on port 80).
Replace /yoursrc with a path on your host that holds the folders modules/, profiles/, themes/ and sites/
```
sudo docker run -p 80:80 \
  -v /yoursrc/modules:/usr/share/nginx/html/modules \
  -v /yoursrc/profiles:/usr/share/nginx/html/profiles \
  -v /yoursrc/themes:/usr/share/nginx/html/themes \
  -v /yoursrc/sites/default:/usr/share/nginx/html/sites/default \
  -it drupal8 bash
```


## How to Build image from source
```
sudo docker build -t drupal8 .
```

## How to run (you will be dropped into the docker container)
```
sudo docker run -p 80:80 \
  -v /yoursrc/modules:/usr/share/nginx/html/modules \
  -v /yoursrc/profiles:/usr/share/nginx/html/profiles \
  -v /yoursrc/themes:/usr/share/nginx/html/themes \
  -v /yoursrc/sites/default:/usr/share/nginx/html/sites/default \
  -it drupal8 bash
```

## Install a default drupal site with standard profile inside the container (see drupal site:install -h for all options).
Either use ```/setup.sh``` inside of the container or use the following command inside of the container 
to install a default site with user "admin" and password "admin" and uses a sqlite database.
```
cp /usr/share/nginx/html/sites/default/default.settings.php /usr/share/nginx/html/sites/default/settings.php && \
/usr/local/bin/drupal -n --root=/usr/share/nginx/html site:install standard --langcode=en \
  --site-name="test install" --site-mail=admin@example.com \
  --account-name=admin --account-mail=admin@example.com --account-pass=admin \
  --db-type=sqlite --db-file=sites/default/files/.ht.sqlite && \
chown -R nginx.nginx /usr/share/nginx/html
```

