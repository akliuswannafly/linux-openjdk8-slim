# based on openjdk:8-slim
# with sbt redis mongo net-tools procps installed

FROM openjdk:8
MAINTAINER Apollos

# copy ivy2 cache lib and sbt-launch.jar to docker
COPY ./sbt-launch.jar /var
COPY ./cache.zip /root

# install sbt redis mongo unzip net-tools procps
# config timezone
RUN apt-get update -y \
    && apt-get install -y --force-yes unzip procps net-tools mongodb redis-server redis-tools \
    && echo '#!/bin/bash' > /usr/bin/sbt \
    && echo 'java -Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled -jar /var/sbt-launch.jar "$@"' >> /usr/bin/sbt \
    && chmod u+x /usr/bin/sbt \
    && cd /root && unzip cache.zip && mkdir -p /root/.ivy2 && mv /root/cache /root/.ivy2 \
    && echo "Asia/Harbin" > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata \
    && rm /root/cache.zip
