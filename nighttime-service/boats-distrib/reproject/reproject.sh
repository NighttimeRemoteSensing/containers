#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
java -Xmx16484M -cp "$DIR/sis-jhdf5-batteries_included.jar:$DIR/jcoord-1.1-b.jar:$DIR/viirs_reprojection.jar" viirs.ViirsProcessor $1
