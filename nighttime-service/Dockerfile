FROM nrs:mcr-v81

COPY viirs-watcher nightfire-distrib boats-distrib /opt/

RUN apt-get -qq update \
      && apt-get -qq install -y \
        hdf5-tools \
        libxext6 \
        libxmu6 \
        libxt6 \
      && cd /opt/ \
      && find /opt/boats/mapfiles -name '*.gz' -exec gunzip {} \; \
      && rm -rf /var/lib/apt/lists/*

VOLUME ["/data", "/output", "/log"]

ENV SERVICE_NAME="nighttime"

ENTRYPOINT ["/bin/sh", "-c", "LD_LIBRARY_PATH=${MCR_LIBRARY_PATH} /opt/viirs-watcher $0 > /log/${SERVICE_NAME}_$(date +'%Y_%m_%d_%H_%M_%S').log 2>&1"]
