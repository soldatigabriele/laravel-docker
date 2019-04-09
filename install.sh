#!/bin/bash

while getopts d:p: option 
do 
 case "${option}" 
 in 
 d) DIRECTORY=${OPTARG};; 
 p) PASSWORD=${OPTARG};; 
 esac 
done 

# Clone laravel app
git clone https://github.com/laravel/laravel.git ${DIRECTORY:-laravel}


# Mount the directories that you will need for your Laravel project and avoid the overhead of installing Composer globally
cd ${DIRECTORY:-laravel}
docker run --rm -v $(pwd):/app composer install

# Add the permissions to the user
cd .. && sudo chown -R $USER ${DIRECTORY:-laravel}

# Copy the configuration files to the right folder
mkdir -p ${DIRECTORY:-laravel}/nginx/conf.d
mkdir -p ${DIRECTORY:-laravel}/mysql
mkdir -p ${DIRECTORY:-laravel}/php

cp config/app.conf ${DIRECTORY:-laravel}/nginx/conf.d/app.conf
cp config/my.cnf ${DIRECTORY:-laravel}/mysql/my.cnf
cp config/php.ini ${DIRECTORY:-laravel}/php/php.ini
cp config/env ${DIRECTORY:-laravel}/.env
cp config/Dockerfile ${DIRECTORY:-laravel}/Dockerfile
cp config/docker-compose.yml ${DIRECTORY:-laravel}/docker-compose.yml

# Move in the directory again and run docker-compose up
cd ${DIRECTORY:-laravel}
docker-compose up -d
docker-compose exec app php artisan key:generate
docker-compose exec app php artisan config:cache
