# 2018 The Bitcore BTX Core Developers (dalijolijo)
# forked from https://github.com/freewil/bitcoin-testnet-box
# BitCore-Testnet-Box Docker Solution Image

# Use an official Ubuntu runtime as a parent image
FROM limxtec/crypto-lib-ubuntu:16.04
LABEL maintainer="The Bitcore BTX Core Developers"

# Compiled BitCore Version
LABEL version="0.15.2.0.0"

RUN echo '*** BitCore-Testnet-Box Docker Solution ***'

# Change sh to bash
SHELL ["/bin/bash", "-c"]

# Installing required packages for compiling
RUN apt-get install -y  apt-utils \
                        autoconf \
                        automake \
                        autotools-dev \
                        build-essential \
                        libboost-all-dev \
                        libevent-dev \
                        libminiupnpc-dev \
                        libssl-dev \
                        libtool \
                        pkg-config \
                        software-properties-common
RUN sudo add-apt-repository ppa:bitcoin/bitcoin
RUN sudo apt-get update && \
    sudo apt-get -y upgrade
RUN apt-get install -y libdb4.8-dev \
                       libdb4.8++-dev

# Copy bitcored to bin/mynode
RUN mkdir -p /home/tester/src/ && \
    cd /home/tester/src/ && \
    wget https://github.com/LIMXTEC/BitCore/releases/download/0.15.2.0.0/linux.Ubuntu.16.04.LTS-static-libstdc.tar.gz && \
    tar xzf *.tar.gz && \
    chmod 775 bitcore* && \
    cp bitcore* /usr/local/bin && \
    rm *.tar.gz

# create a non-root user
RUN adduser --disabled-login --gecos "" tester

# run following commands from user's home directory
WORKDIR /home/tester

# copy the testnet-box files into the image
ADD . /home/tester/bitcore-testnet-box

# make tester user own the bitcore-testnet-box
RUN chown -R tester:tester /home/tester/bitcore-testnet-box

# color PS1 and remove .git dirs
RUN mv /home/tester/bitcore-testnet-box/.bashrc /home/tester/ && \
    rm -rf /home/tester/bitcore-testnet-box/.gitignore && \
    rm -rf /home/tester/bitcore-testnet-box/.git && \
    cat /home/tester/.bashrc >> /etc/bash.bashrc

# use the tester user when running the image
USER tester

# run commands from inside the testnet-box directory
WORKDIR /home/tester/bitcore-testnet-box

# expose two rpc ports for the nodes to allow outside container access
# DEPRECATED: Use 'docker run -p 19001:19001 -p 19011:19011 ...'
# EXPOSE 19001 19011

ENV TERM linux
ENTRYPOINT ["top", "-b"]
CMD ["-c"]
