#!/bin/bash

# Script to notify an IRC channel/operator about whether a system is starting up or shutting down.

source startupshutdown.tasks #This file will contain any other functions that should be executed during startup and shutdown as part of this script.  Useful if you're running a service and wish to have a countdown before the server running the service shuts down when the shutdown command is issued.
source screen-irssi.sh

case $1 in
	start)
		irssi_auto "powerup" "$HOSTNAME is starting up."
		start_tasks
		;;
	stop)
		irssi_auto "powerdown" "$HOSTNAME is shutting down."
		stop_tasks
		;;
	*)
		sleep 0
		;;
esac
