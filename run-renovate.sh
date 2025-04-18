#!/bin/bash
set -e

DOCKER_FLAGS="--rm"
if [ -t 1 ]; then
  DOCKER_FLAGS+=" -it"
fi

docker run $DOCKER_FLAGS \
    -v "$(pwd)":/usr/src/app \
    -e LOG_LEVEL=debug \
    -e RENOVATE_PLATFORM=local \
    -e GITHUB_COM_TOKEN=dummy \
    renovate/renovate