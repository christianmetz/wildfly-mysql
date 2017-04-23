# Wildfly MySQL DevStack

## About

This repo contains Continuous Integration Tools.  
Your feedback is always welcome.

### Features

The development stack consists of:

- [x] **Wildfly**: Java EE application server, preconfigured with a MySQL datasource
- [x] **MySQL**: Relational database management system

### Requirements

- Docker

## Quick Start

This section gives you a quick overview on how to get started.

Start the environment by running:

```sh
# start the Docker `app` and `db` containers
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

- WILDFLY_USER=admin
- WILDFLY_PASS=adminPassword
- Database configuration  
	*This config must match the one of the MySQL database.*
	- DB_NAME=sample  
		the JNDI name follows the pattern: `/jdbc/datasources/<DB_NAME>DS`
	- DB_USER=mysql
	- DB_PASS=mysql

#### Database

- MYSQL_DATABASE=sample
- MYSQL_USER=mysql
- MYSQL_PASSWORD=mysql
- MYSQL_ROOT_PASSWORD=supersecret
	- The password for the MySQL `root` user.

## Issues

Please submit issues through the *issue tracker* on GitHub.

## Development

> Suggestions?

## Credits

Copyright (c) 2017 - Programmed by Christian Metz

Released under the [... License](LICENSE).
