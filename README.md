## docker-esp8226-micropython
### A MicroPython for the ESP8226 microcontroller development environment
======================

A Docker image for building the [Micropython](https://micropython.org/) firmware for [ESP8266](https://en.wikipedia.org/wiki/ESP8266) boards.

The underlying [ESP Open SDK](https://github.com/pfalcon/esp-open-sdk) takes a significant time to build extending the build time of the docker image.  Once the initial build is finished however, the resulting container can be used to build additional firmware binaries with shorter build times.

Requires:
  
 * docker engine
 * esptool.py
 * picocom


Build Instructions
------------------

Building the docker image compiles the ESP Open SDK, the MicroPython interpreter shell for unix and the vendor provided firmware binary of Micropython for the ESP8266 boards.  To specify a particular version of MicroPython provide the docker `--build-arg` option with the `VERSION` argument. 

```bash
bash ./projctl build
```

or

```bash
docker build -t micropython --build-arg VERSION=v1.8.6 .
docker create --name micropython micropython
```

Once the docker image is built the firmware can be copied to the host machine.

```bash
bash ./projctl copy
```

or

```bash
docker cp micropython:/micropython/esp8266/build/firmware-combined.bin firmware-combined.bin
```


Flash the board
------------------

Erase the board's flash to ensure a clean write:

```bash
bash ./projctl erase
```

Write the firmware to the board's flash:

```bash
bash ./projctl write
```

or

```bash
esptool.py --port $SERIAL_PORT --baud 115200 write_flash --verify --flash_size=detect 0 firmware-combined.bin
```


Additional functionality
------------------

Connecting to the serial console:

```bash
bash ./projctl connect
```

Access the container's shell:

```bash
bash ./projctl manual
```

or

```bash
docker run --rm -it micropython /bin/bash -l
```

Access the MicroPython interpreter shell for unix:

```bash
bash ./projctl unix
```

