#!/bin/bash

SWARM01="192.168.200.3"
SWARM02="192.168.200.4"

case "$1" in
start)
		vagrant up
		exit 0
		;;
stop)
		vagrant halt
		exit 0
		;;
destroy)
		vagrant destroy -f
		exit 0
		;;
*)
		echo "Usage: run.sh {start|stop|destroy}"
		exit 1
esac
exit 0
