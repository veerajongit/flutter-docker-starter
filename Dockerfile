
FROM alvrme/alpine-android-base
LABEL maintainer="Veeraj S. <veerajthegreat@gmail.com>"

ENV BUILD_TOOLS "30.0.2"
ENV TARGET_SDK "30"
ENV PATH $PATH:${ANDROID_HOME}/build-tools/${BUILD_TOOLS}

# Install SDK Packages
RUN sdkmanager "build-tools;${BUILD_TOOLS}" "platforms;android-${TARGET_SDK}"

# install sudo as root and curl
RUN apk add curl
RUN apk add sudo

# Create User
ARG USER=default
RUN adduser -D $USER \
        && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
        && chmod 0440 /etc/sudoers.d/$USER && chown -R $USER /opt
USER $USER
WORKDIR /home/$USER

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /opt/flutter
ENV PATH $PATH:/opt/flutter/bin

# Run basic check to download Dark SDK
RUN flutter doctor