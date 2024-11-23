#!/bin/sh

# We need access to UID + GID info, so source it
. /tmp/env

now="$(date +"%Y-%m-%d_%H:%M:%S")"
filename="/scans/$now.pdf"

# Actuall scan the document
/usr/local/bin/scan -d -r 300 -v --mode 'Color' --size Letter --crop -o "$filename"

# Change the owner of the file to the user/group specified
[ -f "$filename" ] && chown $OUTPUT_UID:$OUTPUT_GID "$filename"
