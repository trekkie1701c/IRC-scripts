#!/bin/bash

# A shutdown warning script for ZNC based bouncers.  Takes one argument - the number of minutes to give warning for - and gives a notification every minute before saving ZNC's config and shutting down.

source screen-irssi.sh

shutdown_warning () {

warning=$1 #How many minutes to wait before shutting down.


irssi_connect shutdown

while [[ $warning -gt 1 ]] #A quick and dirty timer.  While the warning number is greater than 1, it runs through these operations.
	do
	#Sending the shutdown warning message
	irssi_opersend shutdown "broadcast The Server is shutting down for a brief maintenance in $warning minutes!" "*status"
	# Sleep for a minute.
	sleep 50
	# Take 1 off the counter
	let warning=warning-1
done
irssi_opersend shutdown "broadcast The server is shutting down for a brief maintainence in $warning minute!" "*status" # I was really tempted to change this to just say 1 minute(s) as an easter egg but I doubted anyone would notice

sleep 50 #Sleeping 50 seconds.  50 + the default 10 second timeout is 60 seconds.

irssi_opersend shutdown "SaveConfig" "*status" #Save ZNC's config!  Just to be safe.

irssi_opersend shutdown "shutdown" "*status" #Tell ZNC to gracefully shut down.

}
