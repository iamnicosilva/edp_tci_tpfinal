#!/bin/bash

SYNCPATH=$(pwd)/script/sync/sync.txt

sed "s|\#REPLACEME|$SYNCPATH|" service/service_tpedp.template > service/service_tpedp.service

cp service/service_tpedp.service /etc/systemd/system
cp service/service_tpedp.timer /etc/systemd/system

systemctl daemon-reload
systemctl start service_tpedp.timer

docker-compose up -d --build

