# WildFly 10 on Docker with Centos 7 and OpenJDK 1.7
FROM jboss/wildfly:latest

# Maintainer
MAINTAINER Christian Metz <christian@metzweb.net>

# Environment configuration
ENV DB_URI db:3306
ENV MYSQL_VERSION 6.0.6
ENV DEPLOYMENT_DIR /opt/jboss/wildfly/standalone/deployments/

RUN echo "=> Download MySQL driver" && \
    curl --location \
         --output /tmp/mysql-connector-java-${MYSQL_VERSION}.jar \
         --url http://search.maven.org/remotecontent?filepath=mysql/mysql-connector-java/${MYSQL_VERSION}/mysql-connector-java-${MYSQL_VERSION}.jar

# Expose the web, admin and debug port
EXPOSE 8080 9990 8787

ADD docker-entrypoint.sh /opt/jboss/wildfly/customization/
CMD ["/opt/jboss/wildfly/customization/docker-entrypoint.sh"]
