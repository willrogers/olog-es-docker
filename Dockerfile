FROM ubuntu:latest
RUN apt update
# Avoid prompt for locale.
RUN DEBIAN_FRONTEND="noninteractive" apt install -y tzdata
RUN apt install -y git netcat wget
RUN apt install -y openjdk-11-jdk maven
# Used for waiting for services before starting Olog.
RUN apt install -y wait-for-it
RUN git clone https://github.com/Olog/olog-es.git
WORKDIR /olog-es
# Configuration
COPY application.properties src/main/resources/application.properties
RUN mvn clean install -DskipTests=true -Pdeployable-jar
EXPOSE 8181
# Command run in docker-compose.yml instead.
# CMD java -jar target/olog-es*.jar
