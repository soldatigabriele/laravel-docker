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

cd .. && sudo chown -R $USER ${DIRECTORY:-laravel}

cp Dockerfile ${DIRECTORY:-laravel}/Dockerfile
cp docker-compose.yml ${DIRECTORY:-laravel}/docker-compose.yml


mkdir -p ${DIRECTORY:-laravel}/nginx/conf.d && cp app.conf ${DIRECTORY:-laravel}/nginx/conf.d/app.conf
mkdir -p ${DIRECTORY:-laravel}/mysql && cp my.cnf ${DIRECTORY:-laravel}/mysql/my.cnf







