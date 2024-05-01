#FROM adoptopenjdk/openjdk13:jdk-13.0.2_8-ubuntu-slim
#
#WORKDIR /flyway
#
#ARG FLYWAY_VERSION
#
#RUN apt-get update && \
#    apt-get install -y \
#      curl && \
#    apt-get -y autoremove && \
#    apt-get -y clean && \
#    rm -rf /var/lib/apt/lists/*
#
#RUN curl -L https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz -o flyway-commandline-${FLYWAY_VERSION}.tar.gz \
#  && tar -xzf flyway-commandline-${FLYWAY_VERSION}.tar.gz --strip-components=1 \
#  && rm flyway-commandline-${FLYWAY_VERSION}.tar.gz \
#  && ln -s /flyway/flyway /usr/local/bin/flyway
#
#COPY --chown=flyway ./sql /flyway/sql

ARG FLYWAY_VERSION
FROM redgate/flyway:${FLYWAY_VERSION}
COPY --chown=flyway ./sql /flyway/sql
