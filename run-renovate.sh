#!/bin/bash
set -e

DOCKER_FLAGS="--rm"
if [ -t 1 ]; then
  DOCKER_FLAGS+=" -it"
fi

docker run $DOCKER_FLAGS \
    -v "$(pwd)":/usr/src/app \
    -e LOG_LEVEL="$LOG_LEVEL" \
    -e RENOVATE_PLATFORM="$RENOVATE_PLATFORM" \
    -e GITHUB_COM_TOKEN="$GITHUB_COM_TOKEN" \
    renovate/renovate