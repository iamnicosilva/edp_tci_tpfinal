#!/bin/bash

SYNCPATH="../script/sync/sync.txt"


echo 1 > $SYNCPATH
sleep 30
echo 1 > $SYNCPATH


UNAHORA=3600

while :
do

 DIA=$(date +%a)

 if [ $DIA == "Sat" ]
 then
  sleep $((24*$UNAHORA))
  continue
 else
  if [ $DIA == "Sun" ]
  then
   HORA=$(date +%H)
   FALTA=$((24-$HORA))
   sleep $(($FALTA*$UNAHORA+9*$UNAHORA))
   continue
  else
   HORA=$(date +%H)
   MINUTO=$(date +%M)
   HORAENMIN=$(($HORA*60+$MINUTO))
   if [ $HORAENMIN -lt 600 ]
   then
    sleep $((600-$HORAENMIN))
    continue
   else
    if [ $HORAENMIN -gt 900 ]
    then
     FALTA=$((1440-$HORAENMIN))
     sleep $(($FALTA*60+600))
     continue
    else
     echo 1 > #REPLACEME
     sleep 1800
     continue
    fi
   fi
  fi
 fi
done
