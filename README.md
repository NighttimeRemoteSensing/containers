-------------------------------------------------------------------
Building:
-------------------------------------------------------------------
Use build-nighttime-service.sh to build nighttime-service package. The package consists of docker container with all the dependencies and nighttime.config.yml for the full Pipeline (the both Nightfire and Boats algorithms).

--------------------------------------------------------------------
Installing:
--------------------------------------------------------------------
Unpack the installation package:

tar xf nighttime-service.tgz

Use installation script install.sh inside the package. To see script usage invoke it without any arguments.

--------------------------------------------------------------------
Upgrading
--------------------------------------------------------------------
Follow the installation routine providing the same arguments. Be carefull not to run upgrade while algortihms are working or data is arriving. Otherwise it may be needed to kickstart the processing.

--------------------------------------------------------------------
Configuring
--------------------------------------------------------------------
The nighttime-service is architectured to work with data located in the filesystem (possibly remotely mounted). The service scans specified data directory at fixed time intervals looking for an appearance of new directories with the specified prefix, once new directory appears the service starts repeatedly observe it's content until all the files with required prefixes appear and stop changing. Once the presence of all the required files confirmed the service executes algorithms pipeline.

It is possible to configure lookup locations and pipeline operations of the service by modifying the accompaning YAML configuration file. After configuration modifications it is neccessary to reinstall the container.
