# PiRadio

Welcome!

This is a little project that turns the Pi 3 into an FM Radio Transmitter.

The core of my project is [markondej's project] (https://github.com/markondej/fm_transmitter) to turn the Pi into a transmitter. But I felt that there should be an easier way to choose songs to play, stop the radio, etc so I decided to make a little interface for it. It should be pretty straight-forward, and I'm working on help files as well.

Keep in mind that this is still being worked on, and later on I plan to redo it all and use "dialog" (interface), but we all know how plans usually fail...

## Requirements:

- RaspberryPi 3 (maybe 1 and 2 work as well)
- Antenna on Pin 4 (Check how to here on step 1: http://makezine.com/projects/raspberry-pirate-radio/)

## How to install:

Simply download this repository and put it inside your RaspberryPi. Recommended is on the Desktop, but it should work elsewhere...

## Instructions:

In order to run the PiRadio, you have to open a terminal window and navigate to the PiRadios's location (~/piradio) and then write `sudo sh piradio.sh`.
It will load up and ask you for the frequency you want your songs to play at. Enter your desired frequency. Afterwards you'll be at the main menu. Each menu works the same way: you press one of the options to perform them.

If you need any help at the menus, just hit `h` and a man-page should pop up. In case you still don't have your desired answer feel free to ask it on github!

## Examples:

1. Play a song:
	- In order to play a song, you need to be at the main menu and enter the “Play music” menu. From there on you'll have a list of songs and playlists available to play, just write one of the names of it to start playing that song/playlist. Try writing `star_wars`!

2. Load/Download new songs:
	- Start at the main menu and navigate into the “Load new music” menu. From there on you can download new songs or playlists. 	If you have a URL of a 	playlist or a song choose the designated option for it. When asked for the URL, insert a link of any 	available website that is listed here: https://rg3.github.io/youtube-dl/supportedsites.html Soon you'll have the song(s) in your music folder. Download times depend on your internet speed and might be different for everyone. After it's done, you should be able to play the song through the first example in this README file.

	- In case you have your songs downloaded already and just want to play them, put them inside the piradio/music folder. Keep in mind that the PiRadio only reads `.wav` files (not `.mp3`). That being said, there's an option that lets you convert `.mp3` into `.wav` covered in the next example. I don't recommend trying to convert the files yourself, there's a slight chance that the PiRadio doesn't recognize them only to say they're corrupted.
	
3. Convert `.mp3` to `.wav`
	- Here you can convert songs manually. Simply put your .mp3 files into the downloads folder inside /piradio/music and choose this option to start converting. If there's no downloads folder, create one yourself please and name it “downloads”. After converting, the `.wav` files will automatically be moved into the /piradio/music folder. There you can order them the way you want.

## To-dos:

- [] Create an uninstaller
- [] Option to skip song
- [] Create it all in dialog
- [x] Check if dependencies are installed on first boot and if not automatically install them
- [] When hitting `s` to stop the current song and/or “0” to exit PiRadio, there will still be white noise on the radio if a song started playing earlier
- [] Ffmpeg installer might not work because it has to be compiled with lame support, gotta find a way to fix that

## Dependencies:
All these are installable through the software itself. Launch PiRadio and they should install automatically. If not, go to the “options” menu and install them there.

1) fm_transmitter (FM transmitter...)
	- https://github.com/markondej/fm_transmitter
2) youtube-dl (Download youtube videos and audios and much more)
	- https://rg3.github.io/youtube-dl/
3) ffmpeg (Audio converter)
	- https://www.ffmpeg.org/
4) screen (Full-screen window manager for terminals)
	- https://www.gnu.org/software/screen/manual/screen.html
5) mpg123 (mp3 to wav converter)
	- https://www.mpg123.de
