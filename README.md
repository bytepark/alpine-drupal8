# alpine-drupal8
Drupal 8 docker image with Alpine Linux, Nginx and PHP

## How to Build
sudo docker build -t drupal8 .

## How to run
sudo docker run -p 80:80 \
  -v /yoursrc/modules:/usr/share/nginx/html/modules \
  -v /yoursrc/profiles:/usr/share/nginx/html/profiles \
  -v /yoursrc/themes:/usr/share/nginx/html/themes \
  -v /yoursrc/sites/default:/usr/share/nginx/html/sites/default \
  -it drupal8 bash
