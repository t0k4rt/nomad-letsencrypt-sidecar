#!/usr/bin/env bash

IMAGE_NAME=certbot-gandi
CONTAINER_NAME=certbot-gandi

# Build image with tag image name
docker build --progress=plain --pull -t "$IMAGE_NAME" -f Dockerfile .

# if run then start image in docker container
if [ -n "$RUN" ]; then
  docker container stop "$CONTAINER_NAME"
  docker rm "$CONTAINER_NAME"

  docker run --name "$CONTAINER_NAME"  "$IMAGE_NAME" ls
fi

