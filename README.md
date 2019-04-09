## Docker Laravel

This script creates a fresh Laravel application and builds docker containers to run it, along with a mysql container. Credits: [Digital Ocean Tutorial](https://www.digitalocean.com/community/tutorials/how-to-set-up-laravel-nginx-and-mysql-with-docker-compose)

### Instructions

1 - Run the installation script:

```
./install.sh
```
2 - Provide your root password when prompted

3 - Visit the site at [http://localhost](http://localhost)

-

#### Optional parameters:

 - app directory

```bash
./install.sh my_website
```


#### Configuration

You can change the DB name and password in the `config/env` and in the `docker-compose.yml` files.


