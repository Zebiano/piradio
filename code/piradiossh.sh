#!/bin/bash

# LIBRARIES (SORTA)
. code/manager.sh
. code/piradio.conf

clear

# CD TO DIR AND MAKE
echo "Loading..."

# SET VARIABLES TO FALSE
SM_invalid=false
SM_updaterFinished=false
SM_stoppedMusic=false
SM_finishDownload=false
SM_finishConvert=false
SM_changedFrequency=false
getDir
cd $PiRadio_DIR/fm_transmitter-master
make >/dev/null
echo "Load successful!"
sleep 0.5
clear

if [ -z $PiRadio_defaultFreq ]
then
	# ASK FOR FREQ
	chooseFreq
else
	PiRadio_freq=$PiRadio_defaultFreq
fi
clear

# WHILE LOOP FOR THE MENU
while true
do
	clear
	freqUsed
	nowPlaying
	echo

	# MENU
	echo "Menu:"
	echo "1 - Choose music"
	echo "2 - List music"
	echo "3 - Load new music"
	echo "4 - Update screen"
	echo
	echo "s - Stop current song"
	echo
	echo "0 - Exit PiRadio"
	echo "R - restart PiRadio"
	echo
	echo "h - Help"
	echo "u - Check for updates"
	echo "o - Options"
	echo
	statusMessage
	printf "Choose a number of the menu: "
	read -n1 opPiradio
	SM_invalid=false
	SM_stoppedMusic=false

	case $opPiradio in
		h)
			man $PiRadio_DIR/code/help_files/mainmenu
			continue
			;;
		u)
			clear
			echo "One moment plz..."
			SM_invalid=false
			SM_updaterFinished=false
			updater
			
			while true
			do
				clear
				
				# MENU
				echo "Menu:"
				echo "1 - Update all"
				echo
				echo "2 - Update Youtube-dl"
				echo "3 - Update Screen"
				echo "4 - Update fm_transmitter"
				echo "5 - Update mpg123"
				echo "6 - Update dialog"
				echo
				echo "0 - Exit Updater"
				echo "h - Help"
				echo
				statusMessage
				printf "Choose a number of the menu: "
				read -n1 opUpdater
				SM_invalid=false
				SM_updaterFinished=false
				
				case $opUpdater in
					h)
						helpFile=updater.txt
						helpFiles
						;;
					0)
						clear
						echo "Exiting Updater..."
						continue 2
						;;
					1)
						clear
						echo "Working on updates..."
						echo
						UP_all
						SM_updaterFinished=true
						sleep 3
						;;
					2)
						clear
						echo "Checking for youtube-dl"
						UP_youtube_dl
						SM_updaterFinished=true
						;;
					3)
						clear
						echo "Checking for screen"
						UP_screen
						SM_updaterFinished=true
						;;
					4)
						clear
						UP_fm_transmitter
						SM_updaterFinished=true
						;;
					5)
						clear
						echo "Checking for mpg123"
						UP_mpg123
						SM_updaterFinished=true
						;;
					6)
						clear
						echo "Checking for dialog"
						UP_dialog
						SM_updaterFinished=true
						;;	
					*)
						SM_invalid=true
						continue
						;;
				esac
			done
			;;
		o)
			clear
			echo "One moment plz..."
			SM_invalid=false
			SM_changedFrequency=true
			
			while true
			do
				clear
				
				# MENU
				echo "Menu:"
				echo "1 - Change frequency"
				echo
				echo "0 - Exit Options"
				echo "h - Help"
				echo
				statusMessage
				printf "Choose a number of the menu: "
				read -n1 opOptions
				SM_invalid=false
				
				case $opOptions in
					h)
						helpFile=options.txt
						helpFiles
						;;
					0)
						clear
						echo "Exiting Options..."
						continue 2
						;;
					1)
						clear
						chooseFreq
						SM_changedFrequency=true
						statusMessage
						;;
					*)
						SM_invalid=true
						continue
						;;
				esac
			done
			;;
		s)
			killMusic
			SM_stoppedMusic=true
			continue
			;;
		R)
			clear
			echo "Work in progress..."
			#PiRadio_restart=true
			#export PiRadio_restart
			#exec ./piradio.sh
			#PiRadioExit
			;;
		0)
			exit
			;;
		1)
			echo "One moment plz..."
			clear
			testMusic
			;;
		2)
			echo "One moment plz..."
			clear
			freqUsed
			echo
			listMusic
			string=""
			PiRadio_time=10
			pressNoKey=false
			useCountdown=false
			newLine=false
			hit0toExit=true
			countdown
			;;
		3)
			clear
			echo "One moment plz..."
			getTempDir
			SM_invalid=false
			SM_finishDownload=false
			SM_finishConvert=false
			clear
			
			while true
			do
				clear
				
				# MENU
				echo "Menu:"
				echo "1 - Download music through URL (can also be a playlist)"
				echo "2 - Convert .mp3 to .wav"
				echo
				echo "0 - Exit Musicloader"
				echo "h - Help"
				echo
				statusMessage
				printf "Choose a number of the menu: "
				read -n1 opMusicloader
				SM_invalid=false
				SM_finishDownload=false
				SM_finishConvert=false
				
				case $opMusicloader in
					h)
						helpFile=music_loader.txt
						helpFiles
						;;
					0)
						clear
						echo "Exiting Musicloader..."
						delTempDir
						continue 2
						;;
					1)
						clear
						downloadURL
						SM_finishDownload=true
						clear
						;;
					2)
						clear
						conMP3toWAV
						SM_finishConvert=true
						clear
						;;
					*)
						SM_invalid=true
						continue
						;;
				esac
			done
			;;
		4)
			continue
			;;
		*)
			SM_invalid=true
			continue
			;;
	esac
	
	sleep 5
	clear
done
clear
