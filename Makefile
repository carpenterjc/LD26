SWFFILE = main.swf

PATH=/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/X11/bin:/usr/local/git/bin:/usr/local/go/bin:/Users/jamescarpenter/flex_sdk_4.6/bin:/Users/jamescarpenter/code/mc_fcsh/bin

all: swf

swf:
	#/usr/local/lib/audacity/ffmpeg -y -i sounds/handbag.wav sounds/handbag.mp3
	#/usr/local/lib/audacity/ffmpeg -y -i sounds/spin.wav sounds/spin.mp3
	#/usr/local/lib/audacity/ffmpeg -y -i sounds/swag.wav sounds/swag.mp3
	#/usr/local/lib/audacity/ffmpeg -y -i sounds/ooo.wav sounds/ooo.mp3
	echo $(PATH)
	/Users/jamescarpenter/flex_sdk_4.6/bin/mxmlc Preloader.as -static-link-runtime-shared-libraries=true -default-frame-rate 60 -frames.frame mainframe Main
	mv Preloader.swf ${SWFFILE}

debug:
	mxmlc Preloader.as -debug=true -static-link-runtime-shared-libraries=true -default-frame-rate 60 -frames.frame mainframe Main
	mv Preloader.swf debug_${SWFFILE}