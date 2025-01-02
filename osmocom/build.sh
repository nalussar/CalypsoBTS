#!/bin/bash
set -ex
cd libosmo-gprs/
autoreconf -if
./configure
make
make install
ldconfig -i
cd ..
cd libosmo-dsp/
autoreconf -if
./configure
make
make install
cd ..
cd trx/src
echo "CFLAGS += -DCONFIG_TX_ENABLE" >> target/firmware/Makefile
make HOST_layer23_CONFARGS=--enable-transceiver
