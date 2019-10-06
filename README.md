# Laravel Docker

This repository contains a Dockerfile that can be used to run a Docker container with a [Laravel](https://laravel.com) project. Both PostgreSQL and MySQL images are provided, found under the package tab.

## Setup

To use the Docker image, following the below steps.

First, download the Docker image to your local machine, selecting either the **laravel-mysql** or **laravel-postgresql** image.

```bash
docker pull docker.pkg.github.com/jonathanstaniforth/laravel-docker/<image>:<tag>
```
> Navigate to the package tab and select laravel 1.0 for more information on how to use the Docker image.

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
abled -p 80:80 -p 443:443 <image>:<tag>
```

## Compose file
The best way to setup the Laravel container is to use a Docker compose file. Two Compose files are available, [**docker-compose-laravel-mysql**](https://gist.github.com/jonathanstaniforth/e03cfd0a91566d382f300d3853b63ffb) and [**docker-compose-laravel-postgresql**](https://gist.github.com/jonathanstaniforth/21db87c998d84d10defd4523a3aae4e7). To use the Compose file, follow the steps below.

First, clone a Compose file to your local machine at the root of the Laravel project, for example with the MySQL Compose file:

```bash
git clone https://gist.github.com/jonathanstaniforth/e03cfd0a91566d382f300d3853b63ffb
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
