# Build scrcpy with Docker

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
