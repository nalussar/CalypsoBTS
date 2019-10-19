sudo apt install libtool shtool automake autoconf git-core pkg-config make gcc -y
sudo apt-get install build-essential libtool libtalloc-dev shtool autoconf automake git-core pkg-config make gcc libpcsclite-dev libgnutls-dev -y
sudo apt-get install build-essential libgmp-dev libx11-6 libx11-dev flex libncurses5 libncurses5-dev libncursesw5 libpcsclite-dev zlib1g-dev libmpfr4 libmpc3 lemon aptitude libtinfo-dev libtool shtool autoconf git-core pkg-config make libmpfr-dev libmpc-dev libtalloc-dev libfftw3-dev libgnutls28-dev libssl1.0-dev libtool-bin libxml2-dev sofia-sip-bin libsofia-sip-ua-dev sofia-sip-bin libncursesw5-dev libncursesw5-dbg bison libgmp3-dev alsa-oss gcc-4.9 g++-4.9 -y
sudo apt install libdbi-dev libdbd-sqlite3 libortp-dev build-essential libtool autoconf autoconf-archive automake git-core pkg-config libtalloc-dev libpcsclite-dev libpcap-dev -y
sudo apt-get install sqlite3 libsqlite3-dev libsctp-dev -y
sudo apt install libdbi-dev libdbd-sqlite3 build-essential libtool autoconf automake git-core pkg-config libortp-dev libtalloc-dev libpcsclite-dev libsctp-dev libsctp1 libssl-dev libc-ares-dev libgtp-dev libsofia-sip-ua-glib-dev doxygen -y
sudo apt install gcc-arm-none-eabi -y


git clone git://git.osmocom.org/libosmocore.git
cd libosmocore/
autoreconf -fi
./configure
make
sudo make install
sudo ldconfig -i
cd ..

git clone git://git.osmocom.org/libosmo-netif.git
cd libosmo-netif
autoreconf -fi
./configure
make
sudo make install
sudo ldconfig
cd ..



git clone git://git.osmocom.org/osmocom-bb.git
cd osmocom-bb
git pull --rebase
cd src
make -e CROSS_TOOL_PREFIX=arm-none-eabi-
cd ..
cd ..

git clone git://git.osmocom.org/libosmo-dsp.git
cd libosmo-dsp/
autoreconf -fi
./configure
make
sudo make install
cd ..

git clone git://git.osmocom.org/osmocom-bb.git -b jolly/testing trx
cd trx/src/
make HOST_layer23_CONFARGS=--enable-transceiver
cd ..
cd ..

wget https://sourceforge.net/projects/libdbi/files/libdbi/libdbi-0.8.3/libdbi-0.8.3.tar.gz/download
tar -xvzf download
sudo rm -r download
cd libdbi-0.8.3
./autogen.sh
./configure --disable-docs
make
sudo make install
sudo ldconfig
cd ..


tar -xf libdbi-drivers-0.8.3.alterado.tar.gz 
cd libdbi-drivers-0.8.3
./autogen.sh
./configure --disable-docs --with-sqlite3 --with-sqlite3-dir=/usr/bin --with-dbi-incdir=/usr/local/include
make
sudo make install
sudo ldconfig
cd ..

wget http://download.savannah.gnu.org/releases/linphone/ortp/sources/ortp-0.22.0.tar.gz
tar -xvf ortp-0.22.0.tar.gz
cd ortp-0.22.0/
./autogen.sh
./configure
make
sudo make install
sudo ldconfig
cd ..

git clone git://git.osmocom.org/libosmo-abis.git
cd libosmo-abis
autoreconf -fi
./configure
make
sudo make install
sudo ldconfig
cd ..

git clone git://git.osmocom.org/libsmpp34.git
cd libsmpp34
autoreconf -fi
./configure
make
sudo make install
sudo ldconfig
cd ..


git clone git://git.osmocom.org/osmo-ggsn/
cd osmo-ggsn
autoreconf -fi
./configure
make
sudo make install
sudo ldconfig
cd ..

git clone git://git.osmocom.org/osmo-sgsn/
cd osmo-sgsn
autoreconf -fi
./configure
make
sudo make install
sudo ldconfig
cd ..

git clone git://git.osmocom.org/osmo-sip-connector
cd osmo-sip-connector
autoreconf -fi
./configure
make
sudo make install
sudo ldconfig
cd ..









sudo apt-get install libssl1.0.0 libssl-dev -y
sudo ldconfig

git clone git://git.osmocom.org/openbsc.git
cd openbsc/openbsc/
autoreconf -i
./configure
make
sudo make install
cd ..
cd ..

git clone git://git.osmocom.org/osmo-bts.git
cd osmo-bts
autoreconf -i
./configure --enable-trx
make
sudo make install
cd..























