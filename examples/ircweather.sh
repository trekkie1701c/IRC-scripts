#!/bin/bash

# Script to post weather status to an irc network.  Use an airport/location code after calling the script.
# Requires weather-util to be installed.

source screen-irssi.sh

temp1=pre
temp2=post
temp3=msg

# We'll also need to launch a screen instance.  To prevent collisions, enter a screen-name here:

screenname="weather"

# Configure your command and temp files here.  If your command has arguments, enclose it in quotes

command="weather $1"

# Irssi doesn't like being fed multiple lines at once, so we'll need to define what the "newline" will become.  Do that here.

newline="	*	"

# Enter the lines you want to strip from your output file.  Use '$' to strip to end of file

stripstart=1
stripstop=2

# Let's run the command and output to the first temp file

$command > "$temp1"

# Alright, now let's use sed a bit.  Sed will let us first truncate the file to remove any lines we don't need.

sed '1,2 d' "$temp1" > "$temp2"

# Next, we want to establish a character that'll be present instead of newlines.  Sed is finicky about this between platforms, so we're just going to maybe append a bit of text
# At the end of each line.  This may actually replace newlines on some platforms.  This is what you get for using software from the 70s.

sed 's/$/	*	/' "$temp2" > "$temp1"

# Then, we'll run tr to remove the newlines that might remain.  We need two tempfiles, otherwise this results in a blank file.

tr -d '\r\n' < "$temp1" > "$temp3"

# Now we should have a single line of text that we can use.  Let's finally fire up irssi to post the output.

msg=$(<$temp3)

irssi_auto $screenname $msg

# And you know, delete those tempfiles
rm "$temp1" "$temp2" "$temp3"
