#!/bin/bash

# LIBRARIES (SORTA)
. code/manager.sh
. code/piradio.conf

trap PiRadioExit 0 1 2 5 15	 # TRAP Control C TO DELETE TEMPORARY FILES IF NECESSARY

# IF piradio.sh IS RUN WITHOUT sudo, TELL USER TO RUN IT WITH sudo
var=$(id -u)
if [ "$var" -eq 0 ]
then
	#if [ PiRadio_softwaresInstalled = true ] 
	#then
		#screen -m -S PiRadioSSH code/piradiossh.sh
	#else
		#checkSoftware
	#fi
	sudo screen -m -S PiRadioSSH code/piradiossh.sh
else
	clear
	string="Please run piradio.sh as sudo.\nType ${GREEN}sudo sh piradio.sh${NC} to run piradio in sudo mode.\n"
	PiRadio_time=10
	pressNoKey=false
	newLine=false
	hit0toExit=false
	useCountdown=true
	countdown
fi
