#!/bin/bash
pushd . \
  && cd mcr-v81 \
  && ./build.sh \
  && popd \
  && pushd . \
  && cd nighttime-service \
  && ./build.sh \
  && tar czf nighttime-service.tgz nighttime-service \
  && mv nighttime-service.tgz ../ \
  && popd
