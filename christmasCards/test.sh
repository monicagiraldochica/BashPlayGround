#!/bin/bash
# Author: Monica Keith
# Created: 2026-03-12
# Description: Create a christmas card

min_h=$(identify -format "%h\n" image1.jpg image2.jpeg image3.JPG | sort -n | head -1)
for img in image1.jpg image2.jpeg image3.JPG
do
    [ ! -f "${img}" ] && magick "${img}" -auto-orient -resize x"${min_h}" "${img%.*}_resized.png"
done

#identify -format "%h\n" image4.jpg image5.jpg image6.jpeg
#magick image4.jpg -auto-orient -resize x1386 image4_resized.png
#magick image5.jpg -auto-orient -resize x1386 image5_resized.png
#magick image6.jpeg -auto-orient -resize x1386 image6_resized.png
#magick image4_resized.png image5_resized.png image6_resized.png +append output2.png

#identify -format "%h\n" image7.jpg image8.jpeg image9.jpeg
#magick image7.jpg -auto-orient -resize x591 image7_resized.png
#magick image8.jpeg -auto-orient -resize x591 image8_resized.png
#magick image9.jpeg -auto-orient -resize x591 image9_resized.png
#magick image7_resized.png image8_resized.png image9_resized.png +append output3.png

#identify -format "%w\n" output1.png output2.png output3.png
#magick output1.png -resize 1378x output1_resized.png
#magick output2.png -resize 1378x output2_resized.png
#magick output3.png -resize 1378x output3_resized.png
#magick output1_resized.png output2_resized.png output3_resized.png -append output_merged.png

#40% Transparency. factor = 1-(transparency%/100)
#magick output_merged.png -alpha Set -channel A -evaluate Multiply 0.3 +channel output_transp.png

# Add message on top
#IW=$(magick identify -format "%w" "output_merged.png")
#W=$(magick identify -format "%w" "output_merged.png")
#H=$(magick identify -format "%h" "output_merged.png")
#PT=$(( W / 12 ))       # a bit smaller text
#XOFF=$(( W / 20 ))     # 5% of width from the left
#YOFF=$(( H / 15 ))     # ~6.7% down from the top
magick output_merged.png -fill "#0a8f39" -stroke "#c40000" -strokewidth 2 -font "MerryChristmasStar-dJnR.ttf" -pointsize 180 -annotate +310+150  "Happy Holidays" output_merged_msg.png
