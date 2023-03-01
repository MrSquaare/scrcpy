# Docker

## Build

Here are the instructions to build _scrcpy_ (client and server) for Linux and Windows via Docker.

First, build the Docker image:
```shell script
docker build -t scrcpy:latest .
```

Then, run the Docker image with the `docker-build.sh` script:
```shell script
docker run --rm -v $(pwd):/app -w /app scrcpy /bin/bash docker-build.sh
```

Linux binaries will be available in `./build/linux` and Windows binaries will be available in `./build/windows`.

## Run

Here are the instructions to run _scrcpy_ (client and server) via Debian Docker image

First, if not done, build the base Docker image:
```shell script
docker build -t scrcpy:latest .
```

Then, build the runner Docker image:
```shell script
docker build -f run.Dockerfile -t scrcpy-run:latest .
```

### For Linux

Then, allow X server access to Docker:
```shell script
xhost + local:docker
```

Finally, run the runner Docker image:
```shell script
docker run --rm -i -t --privileged \
  -v /dev/bus/usb:/dev/bus/usb \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=$DISPLAY \
  scrcpy-run:latest
```
