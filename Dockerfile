
FROM alvrme/alpine-android-base
LABEL maintainer="Veeraj S. <veerajthegreat@gmail.com>"

ENV BUILD_TOOLS "30.0.2"
ENV TARGET_SDK "30"
ENV PATH $PATH:${ANDROID_HOME}/build-tools/${BUILD_TOOLS}

# Install SDK Packages
RUN sdkmanager "build-tools;${BUILD_TOOLS}" "platforms;android-${TARGET_SDK}"

# Download Flutter SDK
RUN apk add curl
RUN git clone https://github.com/flutter/flutter.git /opt/flutter
ENV PATH $PATH:/opt/flutter/bin

# Run basic check to download Dark SDK
RUN /opt/flutter/bin/flutter doctor
