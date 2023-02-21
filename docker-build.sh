#!/bin/bash
# Create temporary directory
cp -r /app /tmp
cd /tmp/app

# Clean and create build directory
rm -rf /app/build
mkdir -p /app/build

# Build for Linux
meson setup x --buildtype=release --strip -Db_lto=true
ninja -Cx

# Copy Linux artifacts
cp -r /tmp/app/x/ /app/build/linux/

# Build for Windows
./release.sh

# Copy Windows artifacts
cp -r /tmp/app/dist/ /app/build/windows/
