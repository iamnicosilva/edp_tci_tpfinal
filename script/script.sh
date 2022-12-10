#!/bin/bash

SYNC="sync/sync.txt"
SYNC_OLD=$(stat -c %y $SYNC)

[[ $URL ]] || URL=127.0.0.1
[[ $PORT ]] || PORT=5000
[[ $MONEDA ]] || MONEDA=usd

 
while (true)
do
	sleep 1
	SYNC_NEW=$(stat -c %y $SYNC)

#	echo $SYNC_NEW
	if [[ $SYNC_NEW != $SYNC_OLD ]]
	then
		COMPRA=$(curl $URL:$PORT/$MONEDA 2>/dev/null | jq .compra)
		VENTA=$(curl $URL:$PORT/$MONEDA 2>/dev/null | jq .venta)
		FECHA=$(date +%F_%H:%M)
		echo "$FECHA, $COMPRA, $VENTA" >> sync/historico.txt
		SYNC_OLD=$SYNC_NEW
	fi
done
