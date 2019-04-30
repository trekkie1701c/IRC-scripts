#!/bin/bash
# Basic logging script.  Only takes argument for what to log.
logfile=/var/log/scriptlog

log() { #Logging function
	echo "$1" >> "$logfile"
}
