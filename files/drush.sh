#!/bin/bash

git clone https://github.com/drush-ops/drush.git /usr/local/src/drush
cd /usr/local/src/drush
git checkout 8.1.0  #or whatever version you want.
ln -s /usr/local/src/drush/drush /usr/bin/drush
composer install
drush --version

