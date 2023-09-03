FROM ubuntu:20.04

# Configure OS
ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update 
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb  libglu1-mesa fonts-droid-fallback  python3
RUN apt-get clean

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Install Flutter dependencies
RUN flutter doctor

# Configure flutter for web
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web
