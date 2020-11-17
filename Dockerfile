#
# Build stage
#
# FROM maven:3.6.0-jdk-11-slim AS build
# COPY matching-web/src /home/app/src
# COPY pom.xml /home/app
# RUN mvn package -DskipTests

#
# Package stage
#
# FROM openjdk:8-jdk
# COPY ./map-data /map-data
# COPY --from=build ./home/app/matching-web/target/graphhopper-map-matching-web-3.0-SNAPSHOT.jar /matching-web/target/graphhopper-map-matching-web-3.0-SNAPSHOT.jar
# COPY config.yml /
# EXPOSE 8989
# CMD ["java","-jar","/matching-web/target/graphhopper-map-matching-web-3.0-SNAPSHOT.jar", "import", "map-data/greece-latest.osm.pbf"]
# CMD ["java","-jar","/matching-web/target/graphhopper-map-matching-web-3.0-SNAPSHOT.jar", "server", "config.yml"]


FROM openjdk:8-jdk
COPY ./map-data /map-data
COPY ./matching-web/target/graphhopper-map-matching-web-3.0-SNAPSHOT.jar ./
# COPY --from=build ./home/app/matching-web/target/graphhopper-map-matching-web-3.0-SNAPSHOT.jar /matching-web/target/graphhopper-map-matching-web-3.0-SNAPSHOT.jar
COPY config.yml ./
EXPOSE 8989
# CMD ["java","-jar","/matching-web/target/graphhopper-map-matching-web-3.0-SNAPSHOT.jar", "import", "map-data/greece-latest.osm.pbf"]
ENTRYPOINT ["java","-jar","./graphhopper-map-matching-web-3.0-SNAPSHOT.jar", "server", "config.yml"]


# FROM openjdk:8-jdk
#
# ENV JAVA_OPTS "-server -Xconcurrentio -Xmx1g -Xms1g -XX:+UseG1GC -XX:MetaspaceSize=100M -Ddw.server.applicationConnectors[0].bindHost=0.0.0.0 -Ddw.server.applicationConnectors[0].port=8989"
#
# RUN mkdir -p /map-data && \
#     mkdir -p /graphhopper
#
# # COPY . /graphhopper/
#
# WORKDIR /graphhopper
#
# RUN ./graphhopper.sh build
#
# VOLUME [ "/map-data" ]
#
# EXPOSE 8989
#
# ENTRYPOINT [ "./graphhopper.sh", "web" ]
#
# CMD [ "/map-data/greece-latest.osm.pbf" ]