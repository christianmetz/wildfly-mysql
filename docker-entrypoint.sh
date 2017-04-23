#!/bin/bash

# set environment variables
JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh
DATASOURCE=java:/jdbc/datasources/${DB_NAME}DS

function wait_for_server() {
  until `$JBOSS_CLI -c ":read-attribute(name=server-state)" 2> /dev/null | grep -q running`; do
    sleep 1
  done
}

# Setting up WildFly admin user
echo "=> Adding WildFly administrator"
$JBOSS_HOME/bin/add-user.sh -u $WILDFLY_USER -p $WILDFLY_PASS --silent

# the server must be started before configuring a new datasource
echo "=> Starting WildFly server"
$JBOSS_HOME/bin/standalone.sh &

echo "=> Waiting for the server to boot"
wait_for_server

echo "=> Adding MySQL module"
$JBOSS_CLI -c "module add \
  --name=com.mysql \
  --resources=/tmp/mysql-connector-java-${MYSQL_VERSION}.jar \
  --dependencies=javax.api,javax.transaction.api"

echo "=> Adding MySQL driver"
$JBOSS_CLI -c '/subsystem=datasources/jdbc-driver=mysql:add(driver-name=mysql,driver-module-name=com.mysql,driver-xa-datasource-class-name=com.mysql.jdbc.jdbc2.optional.MysqlXADataSource)'

echo "=> Creating a new datasource: '${DATASOURCE}'"
$JBOSS_CLI -c "data-source add \
  --name=${DB_NAME}DS \
  --jndi-name=${DATASOURCE} \
  --user-name=${DB_USER} \
  --password=${DB_PASS} \
  --driver-name=mysql \
  --connection-url=jdbc:mysql://${DB_URI}/${DB_NAME} \
  --use-ccm=false \
  --max-pool-size=25 \
  --blocking-timeout-wait-millis=5000 \
  --enabled=true"

echo "=> Shutting down WildFly"
$JBOSS_CLI -c ":shutdown"

echo "=> Cleaning up"
rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history/ $JBOSS_HOME/standalone/log/*
rm -f /tmp/*.jar
unset $WILDFLY_USER $WILDFLY_PASS $DB_NAME $DB_USER $DB_PASS $DATASOURCE

echo "=> Restarting WildFly"
# Boot WildFly in standalone mode and bind it to all interfaces (enable admin console)
$JBOSS_HOME/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0
