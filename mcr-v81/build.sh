#!/bin/bash
if [ ! -f "MCR_R2013a_glnxa64_installer.zip" ]; then
  wget "https://www.mathworks.com/supportfiles/MCR_Runtime/R2013a/MCR_R2013a_glnxa64_installer.zip"
fi
docker build -t nrs:mcr-v81 --rm ./
