#!/bin/bash
set -xe
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
# Updating system
sudo apt update -y
sudo apt upgrade -y
# Installing required packages
sudo apt install -y putty minicom build-essential libtool libtalloc-dev libudev-dev \
    libsctp-dev shtool autoconf automake git-core pkg-config make gcc gnutls-dev python3 \
    libusb-dev libmnl-dev libpcsclite-dev extrepo
# Adding a osmocom repository
sudo extrepo enable osmocom-nightly
# Updating system
sudo apt update -y
sudo apt upgrade -y
# Creating dirs
cd ~
if [ ! -d "osmocom" ]; then
  echo "Creating an osmocomirectory..."
  mkdir osmocom
fi
cd osmocom
if [ ! -d "liburing" ]; then
  echo "Creating an liburing directory..."
  git clone https://github.com/axboe/liburing.git
  cd liburing/
  ./configure --cc=gcc --cxx=g++
  make
  make liburing.pc
  sudo make install
  sudo ldconfig -i
  cd ..
fi
if [ ! -d "libusb" ]; then
  echo "Creating an llibusb directory..."
  git clone https://github.com/libusb/libusb.git
  cd libusb/
  autoreconf -i
  ./configure
  make
  sudo make install
  sudo ldconfig -i
  cd ..
fi
if [ ! -d "libosmocore" ]; then
  echo "Building libosmocore...."
  git clone https://gitea.osmocom.org/osmocom/libosmocore.git
  cd libosmocore
  autoreconf -i
  ./configure
  make
  sudo make install
  sudo ldconfig -i
  cd ..
fi
# Installing packages
sudo apt install -y liblua5.3-dev  \
    libasound2-dev libopencore-amrnb-dev libgsm1-dev gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib
cd ~/osmocom
# Getting an gapk sources and building libs
if [ ! -d "gapk" ]; then
  echo "Creating an osmocomirectory..."
  git clone https://gitea.osmocom.org/osmocom/gapk
  cd gapk/
  autoreconf -i
  ./configure
  make
  sudo make install
  sudo ldconfig -i
fi
cd ~/osmocom
if [ ! -d "libosmo-gprs" ]; then
  echo "Creating an libosmo-gprs directory..."
  git clone https://gitea.osmocom.org/osmocom/libosmo-gprs.git
  cd libosmo-gprs/
  autoreconf -i
  ./configure
  make
  sudo make install
  sudo ldconfig -i
fi
cd ~/osmocom
echo $PKG_CONFIG_PATH
if [ ! -d "osmocom-bb" ]; then
  echo "Creating an osmocom-bb directory..."
  git clone https://gitea.osmocom.org/phone-side/osmocom-bb.git
  cd osmocom-bb/
  git pull --rebase
  cd src/
  make
fi
cd ~/osmocom
if [ ! -d "libosmo-cc" ]; then
  echo "Creating an libosmo-cc directory..."
  git clone https://gitea.osmocom.org/cc/libosmo-cc
  cd libosmo-cc/
  autoreconf -if
  ./configure
  make
  sudo make install
  sudo ldconfig -i
fi
cd ~/osmocom
if [ ! -d "osmocom-analog" ]; then
  echo "Creating an osmocom-analog directory..."
  git clone https://gitea.osmocom.org/cellular-infrastructure/osmocom-analog
  cd osmocom-analog/
  autoreconf -if
  ./configure
  make
  sudo make install
fi
cd ~/osmocom
if [ ! -d "fftw-3.3.10" ]; then
  wget https://fftw.org/fftw-3.3.10.tar.gz
  tar zxvf fftw-3.3.10.tar.gz
  cd fftw-3.3.10/
  ./configure --enable-shared --enable-float
  make
  sudo make install
  sudo ldconfig -i
 fi
cd ~/osmocom
if [ ! -d "libosmo-dsp" ]; then
  echo "Creating an libosmo-dsp directory..."
  git clone https://gitea.osmocom.org/sdr/libosmo-dsp
  cd libosmo-dsp/
  autoreconf -i
  ./configure
  make
  sudo make install
  sudo ldconfig -i
fi
cd ~/osmocom
if [ ! -d "rtx" ]; then
  echo "Creating an trx directory..."
  git clone https://gitea.osmocom.org/phone-side/osmocom-bb -b fixeria/trx trx
  cd trx/
  git pull --rebase
  cd src/
  make HOST_layer23_CONFARGS=--enable-transceiver
fi
