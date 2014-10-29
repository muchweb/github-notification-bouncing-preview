all: all.gif

all.gif: bounce_light_cropped.gif bounce_dark_cropped.gif
	convert bounce_light_cropped.gif -repage 240x0 -coalesce null: \( bounce_dark_cropped.gif -coalesce \) -geometry +120+0 -layers Composite all.gif

bounce_dark_cropped.gif: frames_dark/001.png
	convert -delay 1x24 `seq -f frames_dark/%03g.png 1 1 20` -coalesce -layers OptimizeTransparency bounce_dark_cropped.gif

frames_dark/001.png: bounce_dark.webm
	mkdir -p frames_dark
	ffmpeg -i bounce_dark.webm -filter:v "crop=120:60:677:60" frames_dark/%03d.png

bounce_light_cropped.gif: frames_light/005.png
	convert -delay 1x24 `seq -f frames_light/%03g.png 8 1 27` -coalesce -layers OptimizeTransparency bounce_light_cropped.gif

frames_light/005.png: bounce_light.webm
	mkdir -p frames_light
	ffmpeg -i bounce_light.webm -filter:v "crop=120:60:678:59" frames_light/%03d.png

clean:
	rm -r frames_dark frames_light
	rm bounce_light_cropped.gif bounce_dark_cropped.gif all.gif
