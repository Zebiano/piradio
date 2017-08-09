#!/bin/bash

# LIBRARIES (SORTA)
. code/manager.sh

for f in $PiRadio_DIR/music/"$PiRadio_name"/*
do
	clear
	PiRadio_file=$(basename "$f")
	export PiRadio_file
	freqUsed
	echo
	$PiRadio_DIR/fm_transmitter-master/fm_transmitter -f $PiRadio_freq -r "$f"		# STARTS A NEW SCREEN AND THEN STARTS RADIO IN $freq WITH $f SONG
done
unset PiRadio_file
exit
