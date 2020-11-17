FROM openjdk:8-jdk
COPY ./map-data /map-data
COPY ./matching-web/target/graphhopper-map-matching-web-3.0-SNAPSHOT.jar ./
COPY config.yml ./
EXPOSE 8989
ENTRYPOINT ["java","-jar","./graphhopper-map-matching-web-3.0-SNAPSHOT.jar", "server", "config.yml"]
