#!/bin/bash
docker run --rm -it \
    -v "$(pwd)":/usr/src/app \
    -e LOG_LEVEL=debug \
    -e RENOVATE_PLATFORM=local \
    -e GITHUB_COM_TOKEN=dummy \
    renovate/renovate
