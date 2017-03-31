#!/bin/bash
GZIP=$(which pigz)
if [[ -z $GZIP ]]; then GZIP="gzip"; fi
docker build -t nrs:nighttime-service --rm ./ \
  && echo 'Packaging. This may take a while...' \
  && rm -rf nighttime-service \
  && cp -r package-skeleton nighttime-service \
  && docker save nrs:nighttime-service | $GZIP -c > nighttime-service/nighttime-service.docker.tgz \
  && cp boats-distrib/BOATS_VERSION nighttime-service/ \
  && cp nightfire-distrib/NIGHTFIRE_VERSION nighttime-service/
