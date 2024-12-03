#!/bin/bash
echo "Insalling liburing"
git clone https://gitea.osmocom.org/sdr/libosmo-dsp
cd libosmo-dsp/
autoreconf -i
./configure
make
make install
cd ..
git clone https://gitea.osmocom.org/phone-side/osmocom-bb -b fixeria/trx trx
cd trx/src
echo "CFLAGS += -DCONFIG_TX_ENABLE" >> target/firmware/Makefile
make HOST_layer23_CONFARGS=--enable-transceiver
