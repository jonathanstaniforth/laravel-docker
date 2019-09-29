# Laravel Docker

This repository contains a Dockerfile that can be used to run a Docker container with a [Laravel](https://laravel.com) project. This image assumes a MySQL database will be used with Laravel.

## Setup

To use the Docker image, following the below steps.

First, download the Docker image to your local machine:

```bash
docker pull docker.pkg.github.com/jonathanstaniforth/laravel-docker/laravel:latest
```

Next, create a folder called **apache** at the root of the Laravel project. Inside this folder, create a apache configuration file, the filename must end with **.conf**. An example configuration file is shown below:

```
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName localhost

    DocumentRoot /var/www/html/public
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

Finally, run the Docker image as follows:

```bash
docker run -v $(pwd):/var/www/html -v $(pwd)/apache:/etc/a
pache2/sites-available -v $(pwd)/apache:/etc/apache2/sites-en
abled -p 80:80 -p 443:443 laravel
```

## Compose file
The best way to setup the Laravel container with a MySQL database is to use a Docker compose file. To use the Compose file, follow the steps below.

First, clone the Compose file to your local machine at the root of the Laravel project:

```bash
git clone https://gist.github.com/e03cfd0a91566d382f300d3853b63ffb.git
```

Next, move the file to the root of the project:

```bash
cd e03cfd0a91566d382f300d3853b63ffb

mv docker-compose-laravel.yml ../docker-compose.yml
```

Finally, run the Compose file as follows:

```bash
docker-compose up
```

> Make sure to setup the apache configuration, discussed above in Setup.

## Issues

Below lists issues which you may encounter, with solutions.

### PDOException php_network_getaddresses: getaddrinfo failed

This error may occur when running the command: ```php artisan migrate```.

```
Illuminate\Database\QueryException  : SQLSTATE[HY000] [20
02] php_network_getaddresses: getaddrinfo failed: nodename n
or servname provided, or not known
```

To solve this issue, firstly, make sure to configure the .env file to use the correct database settings:

* DB_CONNECTION=mysql
* DB_HOST=\<container\_name\>
  * The name of the MySQL container, which is database if you used the Docker Compose file.
* DB_PORT=3306
* DB_DATABASE=\<database\_name\>
  * The name of the database to use inside the MySQL container, which should be the MYSQL_DATABASE environment variable if you used the Docker Compose file.
* DB_DATABASE=\<database\_user\>
  * The name of the user to connect to the database, which should be the MYSQL_USER environment variable if you used the Docker Compose file.
* DB_PASSWORD=\<database\_password\>
  * The password for the user, which should be the MYSQL_PASSWORD environment variable if you used the Docker Compose file.

Also, make sure to run the database commands inside of the Laravel container, as the .env file uses the database container name to connect. You can do this as follows:

```bash
docker exec -it <laravel_container_id> bash

php artisan migrate
```
