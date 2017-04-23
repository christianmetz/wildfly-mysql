# Wildfly MySQL DevStack

[![Docker Build Status](https://img.shields.io/docker/build/metz/wildfly-mysql.svg)]()
[![Docker Automated build](https://img.shields.io/docker/automated/metz/wildfly-mysql.svg)]()

## About

This repo contains the DevStack Dockerfile.  
Your feedback is always welcome.

### Features

The development stack consists of:

- [x] **Wildfly**: Java EE application server
	- [x] Preconfigured [JNDI datasource]()
	- [x] Administration Console
- [x] **MySQL**: Relational database management system

### Requirements

- [Docker](https://docs.docker.com/engine/installation/) (including docker-compose)

## Quick Start

This section gives you a quick overview on how to get started.

Boot the environment by running:

```sh
# starts the `app` and `db` containers
$ docker-compose up
```

Now you can access the components:

- **Wildfly**
	- Application: http://localhost:8080
	- Administration Console: http://localhost:9990
	- JNDI name: `/jdbc/datasources/sampleDS`
- **MySQL**
	- Connection: http://localhost:3306

Stop the environment:

```sh
# remove the containers
$ docker-compose down
```

## Deep dive

> The following environment variables show the default values.

Configure your environment:

#### Appserver

[Official WildFly image documentation](https://store.docker.com/community/images/jboss/wildfly)

- WILDFLY_USER=admin
- WILDFLY_PASS=adminPassword
- Database configuration  
	*This config must match the one of the MySQL database (name, user, password).*
	- DB_NAME=sample  
		**Important:** The JNDI name follows the pattern: `/jdbc/datasources/<DB_NAME>DS`
	- DB_USER=mysql
	- DB_PASS=mysql

#### Database

[Official MySQL image documentation](https://store.docker.com/images/mysql)

- MYSQL_DATABASE=sample
- MYSQL_USER=mysql
- MYSQL_PASSWORD=mysql
- MYSQL_ROOT_PASSWORD=supersecret
	- **Hint:** This is the password for the MySQL `root` user.

## Issues

Please submit issues through the *issue tracker* on GitHub.

## Development

## Credits

Released under the [MIT License](LICENSE).
