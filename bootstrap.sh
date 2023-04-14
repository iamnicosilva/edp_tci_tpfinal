#!/bin/bash

install_app() {
	echo "Instalando aplicación"
	SYNCPATH=$(pwd)/script/sync/sync.txt

	sed "s|\#REPLACEME|$SYNCPATH|" service/service_tpedp.template > service/service_tpedp.service

	cp service/service_tpedp.service /etc/systemd/system
	cp service/service_tpedp.timer /etc/systemd/system

	systemctl daemon-reload
	systemctl start service_tpedp.timer

	docker-compose up -d --build
	echo "Aplicación instalada y corriendo"
}

stop_app() {
	docker-compose stop
	systemctl stop service_tpedp.timer
	echo "Aplicación detenida"
}

continue_app() {
	docker-compose start
	systemctl start service_tpedp.timer
	echo "Aplicación reanudada"
}

uninstall_app() {
	rm /etc/systemd/system/service_tpedp.timer
	rm /etc/systemd/system/service_tpedp.service
	docker-compose down -v
	echo "Aplicación desinstalada"
}

status_app() {
	echo "Estado de la aplicación:"
	docker-compose ps
	systemctl status service_tpedp.timer
}

show_menu() {
	echo "Seleccione una opción:"
	echo "-i: Instalar y ejecutar app"
	echo "-s: Stop app"
	echo "-c: Continuar ejecución"
	echo "-u: Desinstalar app"
	echo "-e: Estado de aplicación"
}


while getops "iscue" opt
do
case $opt in
	i) install_app
	s) stop_app
	c) continue_app
	u) stop_app
	uninstall_app
	e) status_app
	\?) echo "Opción inválida - argumento requerido"
	show_menu
	exit 1
esac
done

