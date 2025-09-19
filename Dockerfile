FROM openjdk:17-jdk-slim

ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

RUN apt-get update && apt-get install -y curl tar && \
    curl -fSL https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.105/bin/apache-tomcat-9.0.105.tar.gz -o apache-tomcat-9.0.105.tar.gz && \
    mkdir -p /opt/tomcat && \
    tar xzf apache-tomcat-9.0.105.tar.gz -C /opt/tomcat --strip-components=1 && \
    rm apache-tomcat-9.0.105.tar.gz && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY target/payment-webapp.war $CATALINA_HOME/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
