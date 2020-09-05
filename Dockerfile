FROM ubuntu:20.04

# Prerequisites
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget

# Setup new user
RUN useradd -ms /bin/bash developer
USER developer
WORKDIR /home/developer

# Prepare Android directories and system variables
RUN mkdir -p Android/Sdk
ENV ANDROID_SDK_ROOT /home/developer/Android/Sdk
ENV ANDROID_HOME /home/developer/Android/Sdk
RUN mkdir -p .android && touch .android/repositories.cfg

# Setup Android SDK
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools Android/Sdk/tools
RUN cd Android/Sdk/tools/bin && yes | ./sdkmanager --licenses --sdk_root=ANDROID_SDK_ROOT
RUN cd Android/Sdk/tools/bin && ./sdkmanager --sdk_root=ANDROID_SDK_ROOT "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/developer/flutter/bin"
ENV PATH "$PATH:/home/developer/Android/Sdk/tools/bin/ANDROID_SDK_ROOT/platform-tools"
ENV PATH "$PATH:/home/developer/Android/Sdk/tools/bin/ANDROID_SDK_ROOT/tools"

# Run basic check to download Dark SDK
RUN flutter doctor
RUN flutter create myapp
RUN cd myapp && flutter build apk
RUN rm -Rf myapp