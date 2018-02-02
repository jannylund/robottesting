#!/usr/bin/env bash
set -e
set -o pipefail
set -o xtrace

if [ "`uname`" == "Darwin" ]; then
  alias md5sum='md5 -r' 
fi

BASE=$(pwd)
VERSION=rfdocker:$(cat ./ui/Dockerfile | md5sum | awk '{print $1}')
BROWSER=chrome
SCREEN_COLOUR_DEPTH=24
SCREEN_HEIGHT=1080
SCREEN_WIDTH=1920

function test() {
  docker build --tag ${VERSION} . --file ./ui/Dockerfile  
  docker run --rm -t\
          -e HOST_UID=$(id -u)\
          -e HOST_GID=$(id -g)\
          -e BROWSER=${BROWSER}\
          -e SCREEN_COLOUR_DEPTH=${SCREEN_COLOUR_DEPTH}\
          -e SCREEN_HEIGHT=${SCREEN_HEIGHT}\
          -e SCREEN_WIDTH=${SCREEN_WIDTH}\
          -v ${BASE}/tests-ui:/opt/robotframework/tests\
          -v ${BASE}/results-ui-${BROWSER}:/opt/robotframework/reports ${VERSION} 
}

function testChrome() {
  BROWSER=chrome
  test
}

function testFirefox() {
  BROWSER=firefox
  test
}

case "$1" in
  test)
    test
    ;;

  testChrome)
    testChrome
    ;;

  testFirefox)
    testFirefox
    ;;

  *)
    echo $"Usage: $0 {test|testChrome|testFirefox}"
esac