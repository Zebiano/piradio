#!/bin/bash

#inputbox - demonstrate the input dialog box with a temporary file

 #Define the dialog exit status codes
#: ${DIALOG_OK=0}
#: ${DIALOG_CANCEL=1}
#: ${DIALOG_HELP=2}
#: ${DIALOG_EXTRA=3}
#: ${DIALOG_ITEM_HELP=4}
#: ${DIALOG_ESC=255}

 #Create a temporary file and make sure it goes away when we're dome
#tmp_file=$(tempfile 2>/dev/null) || tmp_file=/tmp/test$$
#trap "rm -f $tmp_file" 0 1 2 5 15

 #Generate the dialog box
#dialog --title "INPUT BOX" \
  #--clear  \
  #--inputbox "Hi, this is an input dialog box. You can use \n
#this to ask questions that require the user \n
#to input a string as the answer. You can \n
#input strings of length longer than the \n
#width of the input box, in that case, the \n
#input field will be automatically scrolled. \n
#You can use BACKSPACE to correct errors. \n\n
#Try entering your name below:" 16 51 2> $tmp_file

 #Get the exit status
#return_value=$?

 #Act on it
#case $return_value in
  #$DIALOG_OK)
    #echo "Result: `cat $tmp_file`";;
  #$DIALOG_CANCEL)
    #echo "Cancel pressed.";;
  #$DIALOG_HELP)
    #echo "Help pressed.";;
  #$DIALOG_EXTRA)
    #echo "Extra button pressed.";;
  #$DIALOG_ITEM_HELP)
    #echo "Item-help button pressed.";;
  #$DIALOG_ESC)
    #if test -s $tmp_file ; then
      #cat $tmp_file
    #else
      #echo "ESC pressed."
    #fi
    #;;
#esac

cd /home/pi/Desktop/piradio
cat test.txt
