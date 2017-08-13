# PiRadio

Welcome!

This is a little project that turns any Pi (1, 2 and 3) into an FM Radio Transmitter.

The core of my project is markondej's project (https://github.com/markondej/fm_transmitter) to turn the Pi into a transmitter. But I felt that there should be an easier way to choose songs to play, stop the radio, etc so I decided to make a little interface for it. It should be pretty straight-forward, and I'm working on help files as well.

Keep in mind that this is still being worked on, and later on I plan to redo it all and use "dialog" (interface), but we all know how plans usually fail...



Dependencies:

1) fm_transmitter (FM transmitter...)
	- https://github.com/markondej/fm_transmitter
2) youtube-dl (Download youtube videos and audios and much more)
3) ffmpeg (Audio converter)
4) screen (Full-screen window manager for terminals)
5) mpg123 (mp3 to wav converter)


–--- WORK IN PROGRESS -----

This is the MusicLoader. Here you can download or import new songs into your music folder. It's also possible to do this manually: naviagte to /piradio/music/ and put your songs in there. But remember that the PiRadio only reads .wav files (not .mp3). That being said, there's an option that lets you convert .mp3 into .wav. I don't recommend trying to convert the files yourself, there's a slight chance that the PiRadio doesn't recognize them only to say they're corrupted.

1) Download music through URL (can also be a playlist)
This option lets you download .mp3 files of basically anything since youtube-dl has a variety of supported sites. When asked for the URL, insert a link of any available website that is listed here:
	https://rg3.github.io/youtube-dl/supportedsites.html

Examples:
I) If you wanted to download a song from a youtube video (in this case “Tobu – Hope”), you would simply insert the youtube link of the video:
	https://www.youtube.com/watch?v=EP625xQIGzs
II) If you wanted to download a youtube playlist (in this case “global 50”), you would simply insert the youtube link of the playlist:
	https://www.youtube.com/playlist?list=PLgzTt0k8mXzEk586ze4BjvDXR7c-TUSnx
III) If you wanted to download a song from soundcloud (in this case “Tcahmi - siaw”), you would simply insert the soundcloud link of the song:
	https://soundcloud.com/iamtchami/tchami-siaw

2) Convert .mp3 to .wav
Here you can convert songs manually. Simply put your .mp3 files into the downloads folder inside /piradio/music and choose this option to start converting. If there's no downloads folder, create one yourself please and name it “downloads”. After converting, the .wav files will automatically be moved into the /piradio/music folder. There you can order them the way you want.
