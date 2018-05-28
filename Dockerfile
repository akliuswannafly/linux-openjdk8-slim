FROM openjdk:8-slim

RUN apt-get update && apt-get install -y unzip procps net-tools
RUN echo "Asia/Harbin" > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata
