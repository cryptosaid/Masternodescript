RPCP=$(date +%s | sha256sum | base64 | head -c 32 ;)
export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get -y upgrade && apt-get -y install libwww-perl build-essential libtool automake autotools-dev autoconf pkg-config libssl-dev libgmp3-dev libevent-dev bsdmainutils libdb++-dev libboost-all-dev libqrencode-dev unzip && fallocate -l 4G /swapfile && chmod 600 /swapfile && mkswap /swapfile && swapon /swapfile && echo "vm.swappiness=10" >> /etc/sysctl.conf && echo "/swapfile none swap sw 0 0" >> /etc/fstab && mkdir ~/.neutron && echo -e "rpcuser=neutronuser\nrpcpassword=$RPCP\nrpcallowip=127.0.0.1\nport=32001\nserver=1\nlisten=1\ndaemon=1\nmasternode=1\nmasternodeaddr=$(curl http://checkip.amazonaws.com/):32001\nmasternodeprivkey=$MNPRVKEY\nstaking=0" > ~/.neutron/neutron.conf && git clone --branch v1.1.2 https://github.com/neutroncoin/neutron.git && cd ./neutron/src && make -f makefile.unix USE_UPNP= && strip ./neutrond && mv ./neutrond  /usr/local/bin/ && cd /root/ && echo "@reboot root /usr/local/bin/neutrond " >> /etc/crontab && neutrond stop && reboot
