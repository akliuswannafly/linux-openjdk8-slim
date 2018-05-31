FROM openjdk:8-slim
MAINTAINER Apollos

COPY ./sbt-launch.jar /var

RUN touch /usr/lib/jvm/java-8-openjdk-amd64/release \
    && apt-get update \
    && apt-get install -y curl mongodb redis-server redis-tools unzip wget procps locales \
    && echo '#!/bin/bash' > /usr/bin/sbt \
    && echo 'java -Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled -jar /var/sbt-launch.jar "$@"' >> /usr/bin/sbt \
    && chmod u+x /usr/bin/sbt \
    && rm -rf /var/lib/apt/lists/* \
    && cp /usr/share/zoneinfo/Asia/Harbin /etc/localtime

