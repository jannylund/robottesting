#!/usr/bin/env bash
set -e
set -o pipefail
set -o xtrace

if [ "`uname`" == "Darwin" ]; then
  alias md5sum='md5 -r' 
fi

BASE=$(pwd)
VERSION=rfdocker:$(cat ./rest/Dockerfile | md5sum | awk '{print $1}')

# build the container.
docker build --tag ${VERSION} . --file ./rest/Dockerfile
# build the container.
docker run --rm -t\
        -e HOST_UID=$(id -u)\
        -e HOST_GID=$(id -g)\
        -v ${BASE}/tests-rest:/home/robot/tests\
        -v ${BASE}/results-rest:/home/robot/results ${VERSION} tests
