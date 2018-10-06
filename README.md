# bitcore-testnet-box
[![docker pulls](https://img.shields.io/docker/pulls/dalijolijo/bitcore-testnet-box.svg?style=flat)](https://hub.docker.com/r/dalijolijo/bitcore-testnet-box/)

Create your own private bitcore testnet

You must have `bitcored` and `bitcore-cli` installed on your system and in the
path unless running this within a [Docker](https://www.docker.com) container
(see [below](#using-with-docker)).

## GitHub Repository Clone
```
git clone https://github.com/dalijolijo/bitcore-testnet-box.git
git checkout testnet
```

## Starting the testnet-box

This will start up two nodes using the two datadirs `1` and `2`. They
will only connect to each other in order to remain an isolated private testnet.
Two nodes are provided, as one is used to generate blocks and it's balance
will be increased as this occurs (imitating a miner). You may want a second node
where this behavior is not observed.

Node `1` will listen on port `19000`, allowing node `2` to connect to it.

Node `1` will listen on port `19001` and node `2` will listen on port `19011`
for the JSON-RPC server.


```
$ make start
```

## Check the status of the network

```
$ make getnetworkinfo
bitcore-cli -datadir=1  getnetworkinfo
{
  "version": 150200,
  "subversion": "/BitCore:0.15.2/",
  "protocolversion": 80000,
  "localservices": "000000000000000d",
  "localrelay": true,
  "timeoffset": 0,
  "networkactive": true,
  "connections": 1,
  "networks": [
    {
      "name": "ipv4",
      "limited": false,
      "reachable": true,
      "proxy": "",
      "proxy_randomize_credentials": false
    },
    {
      "name": "ipv6",
      "limited": false,
      "reachable": true,
      "proxy": "",
      "proxy_randomize_credentials": false
    },
    {
      "name": "onion",
      "limited": true,
      "reachable": false,
      "proxy": "",
      "proxy_randomize_credentials": false
    }
  ],
  "relayfee": 0.00001000,
  "incrementalfee": 0.00001000,
  "localaddresses": [
  ],
  "warnings": ""
}
bitcore-cli -datadir=2  getnetworkinfo
{
  "version": 150200,
  "subversion": "/BitCore:0.15.2/",
  "protocolversion": 80000,
  "localservices": "000000000000000d",
  "localrelay": true,
  "timeoffset": 0,
  "networkactive": true,
  "connections": 1,
  "networks": [
    {
      "name": "ipv4",
      "limited": false,
      "reachable": true,
      "proxy": "",
      "proxy_randomize_credentials": false
    },
    {
      "name": "ipv6",
      "limited": false,
      "reachable": true,
      "proxy": "",
      "proxy_randomize_credentials": false
    },
    {
      "name": "onion",
      "limited": true,
      "reachable": false,
      "proxy": "",
      "proxy_randomize_credentials": false
    }
  ],
  "relayfee": 0.00001000,
  "incrementalfee": 0.00001000,
  "localaddresses": [
  ],
  "warnings": ""
}
```

## Check the status of the blockchain

```
$ make getblockchaininfo
bitcore-cli -datadir=1  getblockchaininfo
{
  "chain": "testnet",
  "blocks": 0,
  "headers": 0,
  "bestblockhash": "604148281e5c4b7f2487e5d03cd60d8e6f69411d613f6448034508cea52e9574",
  "difficulty": 0.000244140625,
  "mediantime": 1492973331,
  "verificationprogress": 1,
  "chainwork": "0000000000000000000000000000000000000000000000000000000000100010",
  "pruned": false,
  "softforks": [
    {
      "id": "bip34",
      "version": 2,
      "reject": {
        "status": false
      }
    },
    {
      "id": "bip66",
      "version": 3,
      "reject": {
        "status": false
      }
    },
    {
      "id": "bip65",
      "version": 4,
      "reject": {
        "status": false
      }
    }
  ],
  "bip9_softforks": {
    "csv": {
      "status": "defined",
      "startTime": 0,
      "timeout": 999999999999,
      "since": 0
    },
    "segwit": {
      "status": "defined",
      "startTime": 0,
      "timeout": 999999999999,
      "since": 0
    }
  }
}
bitcore-cli -datadir=2  getblockchaininfo
[...]
```

## Check the status of the wallets

```
$ make getwalletinfo
bitcore-cli -datadir=1  getwalletinfo
{
  "walletname": "wallet.dat",
  "walletversion": 139900,
  "balance": 0.00000000,
  "unconfirmed_balance": 0.00000000,
  "immature_balance": 0.00000000,
  "txcount": 0,
  "keypoololdest": 1538866494,
  "keypoolsize": 1000,
  "keypoolsize_hd_internal": 1000,
  "paytxfee": 0.00000000,
  "hdmasterkeyid": "993ee3eadb5908e123a07ad2f306b67c4db9deb5"
}
bitcore-cli -datadir=2  getwalletinfo
{
  "walletname": "wallet.dat",
  "walletversion": 139900,
  "balance": 0.00000000,
  "unconfirmed_balance": 0.00000000,
  "immature_balance": 0.00000000,
  "txcount": 0,
  "keypoololdest": 1538866494,
  "keypoolsize": 1000,
  "keypoolsize_hd_internal": 1000,
  "paytxfee": 0.00000000,
  "hdmasterkeyid": "e1566b68645ab6cf3d5381c6f4b3424986336b3f"
}
```


## Generating blocks

Normally on the live, real, bitcore network, blocks are generated, on average,
every 2.5 minutes. Since this testnet-in-box uses BitCore Core's (bitcored)
testnet mode, we are able to generate a block on a private network
instantly using a simple command.

To generate a block:

```
$ make generate
```

To generate more than 1 block:

```
$ make generate BLOCKS=10
```

## Need to generate at least 100 blocks before there will be a balance in the first wallet
```
$ make generate BLOCKS=200
```

## Verify that there is a balance on the first wallet
```
$ make getwalletinfo
```

## Generate a wallet address for the second wallet
```
$ make address2
```

## Sending BTX coins
To send BTX coins that you've generated to the second wallet: (be sure to change the ADDRESS value below to wallet address generated in the prior command)

```
$ make sendfrom1 ADDRESS=mxwPtt399zVrR62ebkTWL4zbnV1ASdZBQr AMOUNT=10
```

## Does the balance show up?
Run the getwalletinfo command again. Does the balance show up?
```
$ make getwalletinfo
```
 Why not? Min. one new block is needed for confirmation.

## Generate another block
```
$ make generate
```

## Stopping the testnet-box

```
$ make stop
```

To clean up any files created while running the testnet and restore to the
original state:

```
$ make clean
```

## Using with docker
This testnet-box can be used with [Docker](https://www.docker.com/) to run it in
an isolated container.

### Download and execute the docker-ce installation script
Download and execute the automated docker-ce installation script - maintained by the Docker project.

```
sudo curl -sSL https://get.docker.com | sh
```

### Building docker image

Pull the image
  * `docker pull dalijolijo/bitcore-testnet-box`

or build it yourself from this directory
  * `docker build -t bitcore-testnet-box .`

### Running docker container
The docker image will run two bitcore nodes in the background and is meant to be
attached to allow you to type in commands. The image also exposes
the two JSON-RPC ports from the nodes if you want to be able to access them
from outside the container.
      
``$ docker run --rm -d -p 20001:20001 -p 20011:20011 --name btx-testnet-box dalijolijo/bitcore-testnet-box``
docker run --rm -d -v /root/python-OP_RETURN/:/root/app -p 19001:19001 -p 19011:19011 --name btx-testnet-box dalijolijo/bitcore-testnet-box

or if you built the docker image yourself:

``$ docker run --rm -d -p 20001:20001 -p 20011:20011 --name btx-testnet-box bitcore-testnet-box``

Jump into the docker container with:

``$ docker exec -it btx-testnet-box bash``
