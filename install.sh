#!/bin/bash

# Clone laravel app
git clone https://github.com/laravel/laravel.git ${1:-laravella}

# Mount the directories that you will need for your Laravel project and avoid the overhead of installing Composer globally
cd ${1:-laravel}
docker run --rm -v $(pwd):/app composer install

# Add the permissions to the user
cd .. && sudo chown -R $USER ${1:-laravel}

# Copy the configuration files to the right folder
mkdir -p ${1:-laravel}/nginx/conf.d
mkdir -p ${1:-laravel}/mysql
mkdir -p ${1:-laravel}/php

cp config/app.conf ${1:-laravel}/nginx/conf.d/app.conf
cp config/my.cnf ${1:-laravel}/mysql/my.cnf
cp config/php.ini ${1:-laravel}/php/php.ini
cp config/env ${1:-laravel}/.env
cp config/Dockerfile ${1:-laravel}/Dockerfile
cp config/docker-compose.yml ${1:-laravel}/docker-compose.yml

# Move in the directory again and run docker-compose up
cd ${1:-laravel}
docker-compose up -d
docker-compose exec app php artisan key:generate
docker-compose exec app php artisan config:cache
