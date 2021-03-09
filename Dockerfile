FROM ubuntu:latest
RUN apt update
# Avoid prompt for locale.
RUN DEBIAN_FRONTEND="noninteractive" apt install -y tzdata
RUN apt install -y git
RUN apt install -y openjdk-11-jdk maven
RUN git clone https://github.com/Olog/olog-es.git
WORKDIR /olog-es
# Configuration
COPY application.properties src/main/resources/application.properties
RUN mvn clean install -DskipTests=true -Pdeployable-jar
EXPOSE 8181
CMD java -jar target/olog-es*.jar
