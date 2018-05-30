FROM openjdk:8-slim
MAINTAINER Apollos

ENV SCALA_VERSION 2.11.6
ENV SBT_VERSION 0.13.8

RUN touch /usr/lib/jvm/java-8-openjdk-amd64/release \
    && apt-get update \
    && apt-get install -y curl mongodb redis-server redis-tools unzip wget procps locales

RUN curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ \
    && echo >> /root/.bashrc \
    && echo "export PATH=~/scala-$SCALA_VERSION/bin:$PATH" >> /root/.bashrc \
    && curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb \
    && dpkg -i sbt-$SBT_VERSION.deb \
    && rm sbt-$SBT_VERSION.deb \
    && apt-get update \
    && apt-get install sbt \
    && sbt sbtVersion

RUN rm -rf /var/lib/apt/lists/* \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && rm -rf /etc/localtime \
    && ln -s /usr/share/zoneinfo/Asia/Harbin /etc/localtime

ENV LC_ALL="en_US.UTF-8"
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US:en"
