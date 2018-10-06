BITCORED=bitcored
BITCOREGUI=bitcore-qt
BITCORECLI=bitcore-cli
B1_FLAGS=
B2_FLAGS=
B1=-datadir=1 $(B1_FLAGS)
B2=-datadir=2 $(B2_FLAGS)
BLOCKS=1
ADDRESS=
AMOUNT=
ACCOUNT=

start:
	$(BITCORED) $(B1) -daemon
	$(BITCORED) $(B2) -daemon

start-gui:
	$(BITCOREGUI) $(B1) &
	$(BITCOREGUI) $(B2) &

generate1:
	$(BITCORECLI) $(B1) generate $(BLOCKS)

generate2:
	$(BITCORECLI) $(B2) generate $(BLOCKS)

getnetworkinfo:
	$(BITCORECLI) $(B1) getnetworkinfo
	$(BITCORECLI) $(B2) getnetworkinfo

getblockchaininfo:
	$(BITCORECLI) $(B1) getblockchaininfo
	$(BITCORECLI) $(B2) getblockchaininfo

getwalletinfo:
	$(BITCORECLI) $(B1) getwalletinfo
	$(BITCORECLI) $(B2) getwalletinfo

sendfrom1:
	$(BITCORECLI) $(B1) sendtoaddress $(ADDRESS) $(AMOUNT)

sendfrom2:
	$(BITCORECLI) $(B2) sendtoaddress $(ADDRESS) $(AMOUNT)

address1:
	$(BITCORECLI) $(B1) getnewaddress $(ACCOUNT)

address2:
	$(BITCORECLI) $(B2) getnewaddress $(ACCOUNT)

stop:
	$(BITCORECLI) $(B1) stop
	$(BITCORECLI) $(B2) stop

clean:
	find 1/regtest/* -not -name 'server.*' -delete
	find 2/regtest/* -not -name 'server.*' -delete
