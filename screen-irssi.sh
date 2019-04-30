#!/bin/bash

# Simple communication script for screen in conjunction with irssi to send messages.
# First argument will always be screen name, further arguments are messages to send.


source irc.config #Contains username/password/etc.
source log.sh #For logging to log file.

irssi_connect () { #Connects to the server
	screen -S $1 -d -m irssi -c $server -p $port -w $password
	log "$1 Connected to server $server:$port"
	sleep $timeout
}

irssi_join () { #Joins the channel.  Argument 2 may be specified to join a channel not specified in irc.config
	if [[ $2 ]]
		then
			screen -S $1 -X stuff "/join $2
"
			log "$1 joined channel $2"
		else
			screen -S $1 -X stuff "/join $channel
"
			log "$1 joined channel $channel"
	fi
	sleep $timeout
}

irssi_chansend () { #Send a message to joined channel
	screen -S $1 -X stuff "$2
"
	log "$1 sent message $2 to channel."
	sleep $timeout
}

irssi_opersend () { #Send a message to the operator.  Alternatively, send a message to another user using the third argument.
	if [[ $3 ]]
		then
			screen -S $1 -X stuff "/msg $3 $2
"
			log "$1 sent message $2 to $3"
		else
			screen -S $1 -X stuff "/msg $oper $2
"
			log "$1 sent message $2 to $oper."
	fi
	sleep $timeout
}

irssi_exit () { #Quits the irssi session and closes the screen.
	screen -S $1 -X stuff "/quit
"
	log "$1 disconnected."
	sleep $timeout
}

irssi_auto () { #Great for one-off messages.  Takes two arguments - screen name and the message - and automatically connects, joins, and sends to channel/operator before exiting.
	irssi_connect $1
	irssi_join $1
	irssi_chansend $1 "$2"
	irssi_opersend $1 "$2"
	irssi_exit $1
}
