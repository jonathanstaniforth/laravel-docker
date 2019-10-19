# Laravel Docker

This repository contains Docker images that can be used with the PHP framework [Laravel](https://laravel.com). In total, three images are available, listed below:

* laravel - Docker image for a pure laravel setup;
* laravel-mysql - Docker image for laravel and a MySQL database;
* laravel-postgresql - Docker image for laravel with a PostgreSQL database.

> Click the **package** tab of this repository to find the available Docker images.

These images provide a portable environment for conveniently developing and deploying Laravel projects, with all the tools needed available out of the box.

## Setup

To use the Docker image, following the below steps.

First, download the Docker image to your local machine, selecting one of the available images.

```bash
docker pull docker.pkg.github.com/jonathanstaniforth/laravel-docker/<image>:<tag>
```

Next, run the Docker image as a container as follows, mounting the current directory for the laravel project:

```bash
docker run -v $(pwd):/var/www/laravel -p 80:80 -p 443:443 <image>:<tag>
```

Now, enter the container:

```bash
docker container ls # Get the container ID

docker exec -it <container_id> bash
```

Once you are inside the container, setup a fresh Laravel project at **/var/www/laravel**:

```bash
composer create-project --prefer-dist laravel/laravel .
```

Finally, navigate to **localhost** using a browser to check that the project is running.

## Apache

The apache configuration is set to serve the **public** folder in **/var/www/laravel**, as shown in the file **/apache.conf**.

If you would like to change the apache configuration, you can override the **sites-available** and **sites-enabled** folders with your own configuration, like so:

```bash
docker run \
    -v $(pwd):/var/www/laravel \
    -v ./apache:/etc/apache2/sites-available \
    -v ./apache:/etc/apache2/sites-enabled \
    -p 80:80 \
    -p 443:443 \
    <image>:<tag>
```

## Compose file

Several Docker Compose files are available, providing a convenient way to running the Laravel image with a database. These files are:

* [docker-compose-laravel-mysql](https://gist.github.com/jonathanstaniforth/e03cfd0a91566d382f300d3853b63ffb)
* [docker-compose-laravel-postgresql](https://gist.github.com/jonathanstaniforth/21db87c998d84d10defd4523a3aae4e7)

To use the Compose files, follow the steps below.

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
