#!/bin/bash

build_firmware() {
  cd /micropython && make -C mpy-cross
  cd esp8266 && make axtls && make
}


case "$1" in
  "unix")
    exec /micropython/unix/micropython
    ;;
  "build")
    build_firmware
    ;;
  *)
    /sbin/my_init &
    eval "$@"
    ;;
esac