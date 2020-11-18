#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY ./matching-web /matching-web
COPY ./matching-core /matching-core
COPY ./matching-web-bundle /matching-web-bundle
COPY ./hmm-lib /hmm-lib
COPY ./map-data /map-data

COPY config.yml ./
COPY mvn-settings.xml ./
COPY pom.xml ./


RUN mvn package -DskipTests

#
# Package stage
#
FROM openjdk:8-jdk
EXPOSE 8989
CMD ["java","-jar",".matching-web/target/graphhopper-map-matching-web-3.0-SNAPSHOT.jar", "import", "greece-latest.osm.pbf"]
ENTRYPOINT ["java","-jar",".matching-web/target/graphhopper-map-matching-web-3.0-SNAPSHOT.jar", "server", "config.yml"]

# FROM openjdk:8-jdk
# COPY ./map-data /map-data
# COPY ./matching-web/target/graphhopper-map-matching-web-3.0-SNAPSHOT.jar ./
# COPY config.yml ./
# EXPOSE 8989
# ENTRYPOINT ["java","-jar","./graphhopper-map-matching-web-3.0-SNAPSHOT.jar", "server", "config.yml"]
