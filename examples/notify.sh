#!/bin/bash
# Usage:  ./notify.sh "command"
# Notifies an operator on IRC when the command exits.

source screen-irssi.sh

echo "Running $1"
$1
echo "Done.  Notifying operator."

irssi_auto notify "Command $1 complete."

echo "Done."
