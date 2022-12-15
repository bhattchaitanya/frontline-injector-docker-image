#!/bin/bash

set -eux

java_major="$1"

base_image="openjdk:${java_major}-jdk-slim"

docker pull "$base_image"

java_version=$(docker run --rm "$base_image" java -version 2>&1 | awk -F '"' '/version/ {print $2}')

docker build \
  --build-arg=base_image="$base_image" \
  -t bhattchaitanya/classic-openjdk-x86:"$java_version" \
  .

docker tag \
  bhattchaitanya/classic-openjdk-x86:"$java_version" \
  bhattchaitanya/classic-openjdk-x86:"$java_major"

docker push bhattchaitanya/classic-openjdk-x86:"$java_version"
docker push bhattchaitanya/classic-openjdk-x86:"$java_major"
