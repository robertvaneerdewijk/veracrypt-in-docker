FROM ubuntu:22.04 as base

# install stuff
RUN apt update \
    && apt install -y sudo make yasm pkg-config gcc openssh-server build-essential git

# libs for linking veracrypt
RUN apt update \
    && apt install -y libfuse-dev libpcsclite-dev libwxgtk3.0-gtk3-dev

RUN git clone https://github.com/veracrypt/VeraCrypt.git \
    && cd VeraCrypt/src \
    && make NOGUI=1

# notes
# run this container with some directory mounted for creating/opening encrypted volumes
# docker run --privileged -it -v /tmp:/tmp_in_container veracrypt /bin/bash
#
# create a volume
# ./veracrypt -t -c
#
# To mount a volume:
# mkdir -p /media/veravol1 && ./veracrypt -m=nokernelcrypto /tmp_in_container/veravol /media/veravol1
#
# WARNING: always unmount a volume because the container will not stop if still mounted
#
# unmount a volume:
# veracrypt -d /media/veravol1