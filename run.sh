#!/bin/bash

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
