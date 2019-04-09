#!/bin/bash

while getopts d:p: option 
do 
 case "${option}" 
 in 
 d) DIRECTORY=${OPTARG};; 
 p) PASSWORD=${OPTARG};; 
 esac 
done 

# clone laravel app
git clone https://github.com/laravel/laravel.git ${DIRECTORY:-laravel}



