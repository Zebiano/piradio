#!/bin/bash
clear

chooseFreq(){
	echo "What frequency? [FM]"
	read freq
	echo "One moment plz..."
}

listMusic(){
	echo "Available music:"
	cd /home/pi/Desktop/piradio/fm_transmitter-master/music
	ls
#	count=ls -1 | wc -l >/dev/null
#	if 0<=$count<=5
#	then
#		sleep 3
#	elif 5<$count<=10
#	then
#		sleep 5
#	elif 10<$count<=20
#	then
#		sleep 10
#	elif 20<$count<=30
#	then
#		sleep 15
#	else
#		sleep 20
#	fi
}

freqUsed(){
	echo "Frequency used: $freq FM"
}

testMusic(){
	# IF NAME EXISTS, THEN PLAY THAT FOLDER
	if cd $name 2>/dev/null
	then
		for f in $name/*
		do 
			lxterminal -e /home/pi/Desktop/piradio/fm_transmitter-master/fm_transmitter -f $freq -r /home/pi/Desktop/piradio/fm_transmitter-master/music/$f
		done
	# ELSE SAY IT DOESNT EXIST OR PLAY A SONG AT THE ROOT DIR
	else
		if test -e $name.wav 2>/dev/null
		then
			lxterminal -e /home/pi/Desktop/piradio/fm_transmitter-master/fm_transmitter -freq -r /home/pi/Desktop/piradio/fm_transmitter-master/music/$name.wav
		else
			echo "That playlist or artist isnt available on the Pi yet. Please choose another one!"
		fi
	fi
}

# CD TO DIR AND MAKE
cd /home/pi/Desktop/piradio/fm_transmitter-master
echo "Loading..."
make >/dev/null
echo "Load successful!"
sleep 1
clear

# CD TO MUSIC FOLDER, ASK FOR FREQ
cd music
chooseFreq
clear

# WHILE LOOP PARA VOLTAR A FAZER O MENU
while true
do
	freqUsed
	echo

	# MENU
	echo "Menu:"
	echo "1 - Choose music"
	echo "2 - List music"
	echo "3 - Change frequency"
	echo "0 - Exit PiRadio"
	echo
	echo "Choose a number of the menu: "
	read op

	case $op in
		0)
			echo "One moment plz..."
			clear
			echo
			echo "Cya m8!"
			sleep 1
			clear
			exit
			;;
		1)
			echo "One moment plz..."
			clear
			freqUsed
			echo
			listMusic
			echo
			echo "Which one do you want to play?"
			read name
			echo
			testMusic
			;;
		2)
			echo "One moment plz..."
			clear
			freqUsed
			echo
			listMusic
			;;
		3)
			echo "One moment plz..."
			clear
			chooseFreq
			;;
	esac
	
	sleep 5
	clear
done

clear
