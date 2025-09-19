FROM eclipse-temurin:17-jdk-jammy

ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:ActiveProcessorCount=2"

RUN apt-get update && apt-get install -y curl tar && \
    curl -fSL https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.105/bin/apache-tomcat-9.0.105.tar.gz -o tomcat.tar.gz && \
    mkdir -p $CATALINA_HOME && \
    tar xzf tomcat.tar.gz -C $CATALINA_HOME --strip-components=1 && \
    rm tomcat.tar.gz && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY target/payment-webapp.war $CATALINA_HOME/webapps/
RUN chmod -R 755 $CATALINA_HOME/webapps/

EXPOSE 8080

CMD ["sh", "-c", "catalina.sh run"]

