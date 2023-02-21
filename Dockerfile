FROM debian:bookworm

# Update dependencies
RUN apt-get update

# Install build dependencies
RUN apt-get install build-essential git pkg-config meson ninja-build libsdl2-dev \
  libavcodec-dev libavdevice-dev libavformat-dev libavutil-dev \
  libusb-1.0-0-dev openjdk-17-jdk -y

# Install Windows-specific build dependencies
RUN apt-get install mingw-w64 mingw-w64-tools zip p7zip-full -y

# Install utilities
RUN apt-get install wget unzip -y

# Switch user
RUN useradd -ms /bin/bash builder
USER builder

# Install Android SDK Manager
WORKDIR /home/builder
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O commandlinetools-linux.zip
ENV ANDROID_HOME=/home/builder/android
RUN unzip commandlinetools-linux.zip
RUN mkdir -p $ANDROID_HOME/cmdline-tools
RUN mv cmdline-tools $ANDROID_HOME/cmdline-tools/latest
RUN rm commandlinetools-linux.zip

# Install Android Platform Tools
RUN $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --sdk_root=$ANDROID_HOME "platform-tools"
RUN yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --licenses

# Copy source code
ENV BUILD_DIR=/home/builder/build
WORKDIR $BUILD_DIR
COPY --chown=builder . .
