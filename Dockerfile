FROM ubuntu:16.04
ARG CUID
ARG CGID
ARG USER_NAME
RUN echo $CUID
RUN echo $CGID
RUN echo $USER_NAME
RUN echo 
RUN apt -y update 
RUN apt search liburing
RUN apt-get install -y sudo wget git build-essential python3 libusb-1.0 pkg-config m4 libtool libgnutls-dev automake autoconf libgmp3-dev libmpfr-dev libx11-6 libx11-dev texinfo flex bison libncurses5 \
    libncurses5-dbg libncurses5-dev libncursesw5 libncursesw5-dbg libncursesw5-dev zlibc zlib1g-dev libmpfr4 libmpc-dev libpcsclite-dev libtalloc-dev libortp-dev libsctp-dev \
    libmnl-dev libdbi-dev libdbd-sqlite3 libsqlite3-dev sqlite3 libc-ares-dev libxml2-dev libssl-dev libfftw3-dev
RUN mkdir /opt/build
RUN addgroup --force-badname --gid $CGID  $USER_NAME
RUN adduser --force-badname --uid $CUID --gid $CGID --disabled-password --gecos ""  $USER_NAME
RUN echo "$USER_NAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers 
RUN chown -R $USER_NAME:$USER_NAME /home/$USER_NAME
RUN chown -R $USER_NAME:$USER_NAME /opt/*
WORKDIR /opt/build
RUN echo "Insalling liburing"
RUN git clone -b liburing-2.4 https://github.com/axboe/liburing.git
WORKDIR /opt/build/liburing
RUN ./configure --cc=gcc --cxx=g++
RUN make
RUN make liburing.pc
RUN sudo make install
RUN ldconfig -i
WORKDIR /opt/build
RUN echo "Getting sources"
RUN git clone https://gitea.osmocom.org/osmocom/libosmocore
WORKDIR /opt/build/libosmocore
RUN autoreconf -f -i
RUN ./configure
RUN make
RUN make install
RUN ldconfig -i
WORKDIR /opt/build
RUN mkdir build install src
ADD https://osmocom.org/attachments/download/2052/gnu-arm-build.3.sh .
RUN chmod +x gnu-arm-build.3.sh
WORKDIR /opt/build/src
RUN wget http://ftp.gnu.org/gnu/binutils/binutils-2.21.1a.tar.bz2
RUN wget https://sourceware.org/pub/newlib/newlib-1.19.0.tar.gz
RUN wget http://ftp.gnu.org/gnu/gcc/gcc-4.8.2/gcc-4.8.2.tar.bz2
RUN ls -la
WORKDIR /opt/build
RUN sh ./gnu-arm-build.3.sh
ENV PATH=$PATH:/opt/build/install/bin
WORKDIR /opt/osmocom
CMD sh ./build.sh
# CMD tail -f /dev/null
