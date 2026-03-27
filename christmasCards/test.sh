#!/bin/bash
# Author: Monica Keith
# Created: 2026-03-12
# Description: Create a christmas card

min_h=$(identify -format "%h\n" image1.jpg image2.jpeg image3.JPG | sort -n | head -1)
for img in image1.jpg image2.jpeg image3.JPG
do
    [ ! -f "${img}" ] && magick "${img}" -auto-orient -resize x"${min_h}" "${img%.*}_resized.png"
done

min_h=$(identify -format "%h\n" image4.jpg image5.jpg image6.jpeg | sort -n | head -1)
for img in image4.jpg image5.jpg image6.jpeg
do
    [ ! -f "${img}" ] && magick "${img}" -auto-orient -resize x"${min_h}" "${img%.*}_resized.png"
done

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
[ ! -f output_merged_msg.png ] && magick output_merged.png -fill "#0a8f39" -stroke "#c40000" -strokewidth 2 -font "MerryChristmasStar-dJnR.ttf" -pointsize 230 -annotate +150+180  "Happy Holidays" output_merged_msg.png

# Add border
#[ ! -f output_merged_msg_bdr1.png ] && 
magick output_merged_msg.png -bordercolor red -border 20 output_merged_msg_bdr1.png
#[ ! -f output_merged_msg_bdr2.png ] && 
magick output_merged_msg.png -bordercolor green -border 20 output_merged_msg_bdr2.png
#[ ! -f output_merged_msg_bdr3.png ] && 
magick output_merged_msg.png -bordercolor red -border 20 -bordercolor green -border 10 output_merged_msg_bdr3.png
#[ ! -f output_merged_msg_bdr4.png ] && 
magick output_merged_msg.png -bordercolor green -border 20 -bordercolor red -border 10 output_merged_msg_bdr4.png