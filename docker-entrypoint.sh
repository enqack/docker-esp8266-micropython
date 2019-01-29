#!/bin/bash

build_firmware() {
  cd /micropython && make -C mpy-cross/ V=1
  cd ports/esp8266 && make V=1
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