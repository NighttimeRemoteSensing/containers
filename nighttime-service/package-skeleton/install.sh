#!/bin/bash
CONFIG=$1
DATADIR=$2
OUTPUTDIR=$3
LOGDIR=$4

if [[ -z ${LOGDIR} ]]; then 
  echo 'Usage:'
  echo 'install.sh $CONFIG $DATADIR $OUTPUTDIR $LOGDIR'
  echo 'Example:'
  echo 'install.sh config.yml /mnt/nighttime-data /mnt/nighttime-output /var/log/nighttime'
  exit 1;
fi

CONFIG=$(readlink -m "$CONFIG")
DATADIR=$(readlink -m "$DATADIR")
OUTPUTDIR=$(readlink -m "$OUTPUTDIR")
LOGDIR=$(readlink -m "$LOGDIR")

if [[ "$(docker ps -a | grep nighttime-service)" ]]; then 
  while true; do
    read -p "Found existing nighttime-service. Stop and remove? [Y/N]: " yn
    case $yn in
      [Yy]* ) 
        if [[ "$(docker ps -a | grep nighttime-service)" ]]; then 
          docker stop nighttime-service
        fi && docker rm -v nighttime-service && break || exit 2;;
      [Nn]* ) exit 0;;
      * ) echo "Please answer yes or no.";;
    esac
  done
fi


if [[ "$(docker images -q nrs:nighttime-service 2> /dev/null)" ]]; then
  while true; do
    read -p "Found existing nrs:nighttime-service image. Do you wish to remove it? [Y/N]: " yn
    case $yn in
      [Yy]* ) docker rmi nrs:nighttime-service && break || exit 3;;
      [Nn]* ) break ;;
      * ) echo "Please answer yes or no.";;
    esac
  done
fi
  
echo 'Deploying nighttime-service...' \
  && gunzip -c nighttime-service.docker.tgz | docker load \
  && docker create --name nighttime-service -v "$DATADIR":/data -v "$OUTPUTDIR":/output \
      -v "$LOGDIR":/log --restart=always nrs:nighttime-service /opt/config.yml \
  && docker cp "$CONFIG" nighttime-service:/opt/config.yml \
  && echo 'Starting nighttime-service...' \
  && docker start nighttime-service



