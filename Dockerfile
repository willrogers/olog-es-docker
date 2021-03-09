FROM ubuntu:latest
RUN apt update
# Avoid prompt for locale.
RUN DEBIAN_FRONTEND="noninteractive" apt install -y tzdata
RUN apt install -y git netcat wget
RUN apt install -y openjdk-11-jdk maven
RUN apt install -y wait-for-it
RUN git clone https://github.com/willrogers/olog-es.git
WORKDIR /olog-es
RUN wget https://raw.githubusercontent.com/eficode/wait-for/master/wait-for
RUN git checkout debug
# Configuration
COPY application.properties src/main/resources/application.properties
RUN mvn clean install -DskipTests=true -Pdeployable-jar
EXPOSE 8181
#CMD java -jar target/olog-es*.jar
