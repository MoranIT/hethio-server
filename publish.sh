#! /bin/bash

VERSION=`cat VERSION.txt`


dput -f ppa:danielheth/hethio ../hethio-server_$VERSION-1_source.changes


# ===================================
# MOVE ARTIFACTS INTO PLACE
#if [ ! -d ../hethio-server_artifacts ]; then
#	mkdir ../hethio-server_artifacts
#fi
#mv ../hethio-server_* ../hethio-server_artifacts/
