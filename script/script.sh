#!/bin/bash

SYNC="sync/sync.txt"
SYNC_OLD=$(stat -c %y $SYNC)
 
while (true)
do
	sleep 1
	SYNC_NEW=$(stat -c %y $SYNC)

#	echo $SYNC_NEW
	if [[ $SYNC_NEW != $SYNC_OLD ]]
	then
		COMPRA=$(curl 127.0.0.1:5000/usd 2>/dev/null | ./jq .compra)
		VENTA=$(curl 127.0.0.1:5000/usd 2>/dev/null | ./jq .venta)
		FECHA=$(date +%F_%H:%M)
		echo "$FECHA, $COMPRA, $VENTA" > historico.txt
		SYNC_OLD=$SYNC_NEW
	fi
done
