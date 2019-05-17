# Docker PHP Sandbox

![GitHub](https://img.shields.io/github/license/l-vo/docker-php-sandbox.svg) ![GitHub release](https://img.shields.io/github/release/l-vo/docker-php-sandbox.svg)

This project provides containers with any PHP version for sandboxing purpose. It allows two main usages:

- Try PHP-CLI scripts from a container command line
- Play with web PHP scripts through Nginx/PHP-FPM containers

The PHP containers are the [PHP officials](https://hub.docker.com/_/php).

## Usage
Put your scripts in this project `src` directory. These scripts will be available in the current directory (when using the command line) and at the root of the Nginx web server.

### PHP-CLI scripts on command line
```bash
$ make run
```

### PHP web pages through Nginx/PHP-FPM
The web server will be available on the port `80` of the Nginx container.

* Start the containers
```bash
$ make start
```

* Stop the containers
```bash
$ make stop
```

* View logs
```bash
$ make logs
```

* Log into PHP-FPM container
```bash
$ make exec
```

* Destroy stopped containers
```bash
$ make clean
```

* Stop, destroy and start new containers
```bash
$ make new
```

### Common commands
* View containers status
```bash
$ make status
```

## Using various PHP versions
The default PHP version used in the containers is `7.3`. To use another PHP version, specify it on the `start` or `run` command (depending if you play with command line or web server):
```bash
$ make start PHP_VERSION=5.6  # Web server
$ make run PHP_VERSION=5.6  # Command line
```

You can use any version that have a matching PHP-FPM image (for instance if the tag 7.2.18-fpm exists, you can use the 7.2.18 version) in the [PHP official docker repository](https://hub.docker.com/_/php?tab=tags).

## Using custom PHP default version
If you need to use a another default PHP version, create at the root of the project a `.env` file with your default PHP version as `PHP_VERSION` value:
```.dotenv
PHP_VERSION=7.1
``` 