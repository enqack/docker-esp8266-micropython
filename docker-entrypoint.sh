#!/bin/bash

build_firmware() {
  cd /micropython && make -C mpy-cross/
  cd ports/esp8266 && make
}


case "$1" in
  "unix")
    exec /micropython/ports/unix/micropython
    ;;
  "build")
    build_firmware
    ;;
  *)
    echo "test"
    /sbin/my_init &
    eval "$@"
    ;;
esac