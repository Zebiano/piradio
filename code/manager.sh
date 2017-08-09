#!/bin/bash

# GLOBAL BASH COLORS
NC='\033[0m' 	# NO COLOR
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'

# LET THE USER CHOOSE A FREQUENCY
chooseFreq(){
	echo "FM frequencies range from 88 to 108 (megahertz)."
	echo "What frequency? [FM]"
	read PiRadio_freq
	export PiRadio_freq
	echo "One moment plz..."
	continue
}

# LIST THE /music FOLDER
listMusic(){
	echo "Available music:"
	echo
	cd $PiRadio_DIR/music
	ls
}

# TELLS THE USER WHAT FREQUENCY IS BEING USED
freqUsed(){
	printf "Frequency used: ${GREEN}$PiRadio_freq${NC} FM\n"
}

# CHECKS IF THE SONG IS AVAILABLE OR NOT. PLAYS THE SONG IN CASE IT IS
testMusic(){
	while true
	do
		clear
		freqUsed
		echo
		listMusic
		echo
		echo "Which one do you want to play?"
		statusMessage
		#if [ $invalid = true ]		# CHECK IF USER INPUT IS INCORRECT
		#then
			#echo "Invalid option. Please choose another one."
		#fi
		read PiRadio_name
		export PiRadio_name
		SM_invalid=false
		echo
		# IF NAME EXISTS, THEN PLAY THAT FOLDER
		if [ "$PiRadio_name" != "" ]
		then
			if [ -d "$PiRadio_DIR/music/"$PiRadio_name"" ]
			then
				killMusic
				echo "Starting piRadio: "$PiRadio_name" at $PiRadio_freq FM, 16 bits"
				cd $PiRadio_DIR		# CD TO PiRadio_DIR SO THAT code/player.sh USES /code.manager.sh AS A LIBRARY (SORTA)
				screen -d -m -S Player $PiRadio_DIR/code/player.sh		# STARTS A NEW SCREEN AND RUNS code/player.sh TO PLAY THE SONG
				break
			# ELSE SAY IT DOESNT EXIST OR PLAY A SONG AT THE ROOT DIR
			else
				if [ -e "$PiRadio_DIR/music/"$PiRadio_name.wav"" ]
				then
					killMusic
					echo "Starting piRadio: "$PiRadio_name" at $PiRadio_freq FM, 16 bits"
					screen -d -m -S Player $PiRadio_DIR/fm_transmitter-master/fm_transmitter -f $PiRadio_freq -r $PiRadio_DIR/music/"$PiRadio_name".wav		# STARTS A NEW SCREEN AND THEN STARTS RADIO IN $freq WITH $name SONG
					break
				else
					# IF USER PRESSES 0 GO BACK TO MENU
					if [ "$PiRadio_name" -eq 0 ]
					then
						echo "One moment plz..."
						PiRadio_name=
						continue 2
					fi
					clear
					unset PiRadio_name
					PiRadio_time=10
					string="${RED}ERROR:${NC} That playlist or artist isnt available on the Pi yet. Please choose another one!\nIf you dont want to play any song just hit 0 and ENTER."
					pressNoKey=false
					useCountdown=false
					newLine=true
					hit0toExit=true
					countdown
				fi
			fi
		else
			SM_invalid=true
		fi
	done
}

nowPlaying(){
	PiRadio_nowPlDIR=`ps au | grep [f]m_transmitter | awk '{print $15}'`
	PiRadio_nowPlDIR=$(echo $(basename "$PiRadio_nowPlDIR"))
	if [ -n "$PiRadio_nowPlDIR" ]		# IF PiRadio_nowPlDIR IS SET
	then	
		PiRadio_nowPlDIR=${PiRadio_nowPlDIR:0:-4}		# SHORTEN IT OUT BY REMOVING THE EXTENSION
	fi
	if [[ -z "$PiRadio_nowPlDIR" ]]		# IF PiRadio_nowPlDIR IS UNSET
	then
		printf "There's ${YELLOW}no${NC} song playing right now.\n"
	else
		printf "Song playing now: ${GREEN}$PiRadio_nowPlDIR${NC}\n"
	fi
}

# KILL THE PROCESS OF THE SONG BEING PLAYED
killMusic(){
	pid=$(pgrep fm_transmitter) 2>/dev/null		# GET PID OF RADIO RUNNING
	playerVar=$(sudo ls -laR /var/run/screen/ | grep Player)
	if [ -n "$playerVar" ]
	then
		screen -X -S Player quit 	# KILLS Player IF THERES ONE PLAYING
	fi
	kill $pid 2>/dev/null		# KILL Player WITH PID
}

# GETS THE DIRECTORY OF THE BASH SCRIPT
getDir(){
	dirname="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"		# GETS DIRECTORY NAME OF THE BASH SOURCE (ALWAYS IN path/piradio/code)
	PiRadio_DIR=${dirname:0:-5}		# CHANGE THAT DIRECTORY TO THE PARENT DIRECTORY (path/piradio)
	export PiRadio_DIR
}

# CREATES AND GETS THE TEMPORARY DIRECTORY CREATED
getTempDir(){
	mkdir -p $PiRadio_DIR/music/Downloads
	TEMP_DIR="$PiRadio_DIR/music/Downloads"
}

# DELETES THE TEMPORARY DIRECTORY
delTempDir(){
	rm -rf "$TEMP_DIR" 2>/dev/null
}

# DOWNLOADS THE MP3 FROM THE URL GIVEN
downloadURL(){
	echo "Write/Paste the URL of the video:"
	read url
	echo
	echo "Downloading your video and saving MP3 only..."
	echo
	youtube-dl --extract-audio --yes-playlist --audio-format mp3 --output "$TEMP_DIR/%(title)s.%(ext)s" $url
	sleep 0.5
	conMP3toWAV
}

# CONVERTS THE SONG .MP3 INTO .WAV
conMP3toWAV(){
	getTempDir
	for i in $TEMP_DIR/*.mp3	
	do
		clear
		input=$(echo $(basename "$i"))
		echo $input
		out=$(echo $(basename "$i"))
		output=${out:0:-4}
		echo $output
		echo "mpg123 -w "$output.wav" "$input""
		cd $TEMP_DIR
		mpg123 -w "$output.wav" "$input"
		rm "$input"
		mv $TEMP_DIR/"$output.wav" $PiRadio_DIR/music
		sleep 0.5
	done
}

statusMessage(){
	if [ $SM_invalid = true ]
	then
		printf "${YELLOW}Invalid option.${NC} Please choose another one.\n"
	elif [ $SM_updaterFinished = true ]
	then
		printf "${GREEN}Updates finished.${NC}\n"
	elif [ $SM_stoppedMusic = true ]
	then
		printf "${YELLOW}Stopped${NC} the current song.\n"
	elif [ $SM_finishDownload = true ]
	then
		printf "${YELLOW}Finished downloading.${NC}\n"
	elif [ $SM_finishConvert = true ]
	then
		printf "${YELLOW}Finished converting.${NC}\n"
	fi
}

# COUNTDOWN 10 SECS
countdown(){
	while [ $PiRadio_time -gt 0 ]
	do
		printf "$string"
		printf "\n"
		if [ $newLine = true ]
		then
			echo
		fi
		if [ $useCountdown = true ]
		then
			printf "This window will close in ${YELLOW}$PiRadio_time${NC} seconds.\n"
		fi
		if [ $pressNoKey = true ]
		then
			printf "Please don't press ${GREEN}any${NC} key while this message is displayed.\n"
		fi
		if [ $hit0toExit = true ]
		then
			echo "Press "0" to exit this message."
			read -n1 opCountdown
		
			case $opCountdown in
				0)
					break
					;;
				*)
					;;
			esac
		fi
		sleep 1
		PiRadio_time=$(( PiRadio_time - 1 ))
		clear
	done
	pressNoKey=false
	useCountdown=false
	newLine=false
	hit0toExit=false
}

# COMMANDS THAT HAPPEN WHEN EXITING PiRadio
PiRadioExit(){
	echo "Exiting..."
	delTempDir		# DELETES TEMPORARY DIRECTORY
	killMusic		# KILLS MUSIC PLAYING
	# UNSET ALL ENVIRONMENTAL VARIABLES
	unset PiRadio_freq
	unset PiRadio_name
	unset PiRadio_DIR
	unset PiRadio_file
	unset PiRadio_invalid
	echo "Exit complete."
	exit
}

updater(){
	UP_youtube_dl(){
		youtube-dl -U
		sleep 1
	}
	UP_screen(){
		apt-get install screen
		sleep 1
	}
	UP_fm_transmitter(){
		echo "Please check if you have the latest version of fm_transmitter on the website. Most likely you do because the project is either done or not active anymore"
		echo "Website will shortly open..."
		xdg-open https://github.com/markondej/fm_transmitter
		sleep 2
		echo "If it doesnt, copy and paste this link: https://github.com/markondej/fm_transmitter"
		sleep 5
	}
	UP_mpg123(){
		apt-get install mpg123
		sleep 1
	}
	UP_dialog(){
		apt-get install dialog
		sleep 1
	}
}

helpFiles(){
	clear
	echo -n "------"
	printf " ${GREEN}Start of help file${NC} "
	echo -n "------"
	echo
	less -FX $PiRadio_DIR/code/help_files/$helpFile
	echo
	echo -n "-------"
	printf " ${GREEN}End of help file${NC} "
	echo "-------"
	echo
	echo "When you're done reading hit "0" to exit."
	read -n1 opHelp
	
	while true
	do	
		case $opHelp in
			0)
				break
				;;
			*)
				break
				#echo -en "\r\033"
				;;
		esac
	done
}
