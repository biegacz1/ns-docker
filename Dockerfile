FROM ubuntu:16.04

RUN apt-get update
RUN apt-get -y install wget unzip curl 

RUN curl -sL https://deb.nodesource.com/setup_8.x 
RUN apt-get install -y nodejs

RUN dpkg --add-architecture i386
RUN apt-get -y install lib32z1 lib32ncurses5 lib32stdc++6
RUN apt-get -y install g++


RUN apt-get -y install python-software-properties
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && apt-get -y install oracle-java8-installer

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN mkdir -p /android/sdk
RUN unzip sdk-tools-linux-4333796.zip -d /android/sdk
RUN rm sdk-tools-linux-4333796.zip

ENV ANDROID_HOME /android/sdk 
RUN ( sleep 5 && while [ 1 ]; do sleep 1; echo y; done ) | \
    $ANDROID_HOME/tools/bin/sdkmanager "tools" "platform-tools" "platforms;android-25" "build-tools;27.0.3" "extras;android;m2repository" "extras;google;m2repository"

ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

RUN curl -sL https://deb.nodesource.com/setup_8.x  | bash -
RUN apt-get install -y nodejs
RUN npm install nativescript -g --unsafe-perm
