FROM scrcpy as build

# Copy source code
ENV BUILD_DIR=/home/builder/build
WORKDIR $BUILD_DIR
COPY --chown=builder . .

# Build
RUN meson setup x --buildtype=release --strip -Db_lto=true
RUN ninja -Cx

FROM debian:bookworm-slim

# Update dependencies
RUN apt-get update

# Install runtime dependencies
RUN apt-get install ffmpeg libsdl2-2.0-0 libglvnd0 libgl1 libglx0 libegl1 libxext6 libx11-6 adb libusb-1.0-0 -y

# Copy build
COPY --from=build /home/builder/build/x/app/scrcpy /usr/local/bin/scrcpy
COPY --from=build /home/builder/build/x/server/scrcpy-server /usr/local/share/scrcpy/scrcpy-server
COPY --from=build /home/builder/build/app/data/icon.png /usr/local/share/icons/hicolor/256x256/apps/scrcpy.png

ENTRYPOINT ["scrcpy"]
