#!/bin/bash
# Author: Monica Keith
# Created: 2026-03-12
# Description: Create a christmas card

#min_h=$(identify -format "%h\n" IMG_2806.jpeg image2.jpeg 214330677.jpg | sort -n | head -1)
#for img in IMG_2806.jpeg image2.jpeg 214330677.jpg
#do
#    magick "${img}" -auto-orient -resize x"${min_h}" "${img%.*}_resized.png"
#done

#min_h=$(identify -format "%h\n" image4.jpg image5.jpg image6.jpeg | sort -n | head -1)
#for img in image4.jpg image5.jpg image6.jpeg
#do
#    magick "${img}" -auto-orient -resize x"${min_h}" "${img%.*}_resized.png"
#done

#magick IMG_2806_resized.png image2_resized.png 214330677_resized.png +append test.png

#identify -format "%h\n" image7.jpg image8.jpeg image9.jpeg
#magick image7.jpg -auto-orient -resize x591 image7_resized.png
#magick image8.jpeg -auto-orient -resize x591 image8_resized.png
#magick image9.jpeg -auto-orient -resize x591 image9_resized.png
#magick image7_resized.png image8_resized.png image9_resized.png +append output3.png

#identify -format "%w\n" output1.png output2.png output3.png
#magick test.png -resize 1378x test_resized.png
#magick output1.png -resize 1378x output1_resized.png
#magick output2.png -resize 1378x output2_resized.png
#magick output3.png -resize 1378x output3_resized.png

##magick test_resized.png output2_resized.png output3_resized.png -append output_merged.png
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
##magick output_merged.png -fill "#0a8f39" -stroke "#c40000" -strokewidth 2 -font "MerryChristmasStar-dJnR.ttf" -pointsize 270 -annotate +40+650  "Happy Holidays" output_merged_msg.png
magick  output_merged_msg.png -fill "#0a8f39" -stroke "#c40000" -strokewidth 2 -font "Georgia" -pointsize 200 -annotate +455+1220  "2026" output_merged_msg2.png
#magick  output_merged_msg.png -fill "#0a8f39" -stroke "#c40000" -strokewidth 2 -font "MerryChristmasFlake-mJY9.ttf" -pointsize 230 -annotate +150+850  "01234\n56789" output_merged_msg3.png

# Add border
#magick output_merged_msg2.png -bordercolor green -border 20 -bordercolor red -border 10 output_merged_msg2_bdr.png

#img="merry-christmas-red-ornament-decorations/eee4ab84-36ac-4a2a-9a9b-734e12ac002c.jpg"
#magick "${img}" -auto-orient -resize 600x600 ornament.png
#magick ornament.png -fuzz 12% -transparent white fixed.png
#magick output_merged_msg2_bdr.png fixed.png -gravity southwest -geometry -60-70 -composite output_merged_msg2_bdr_orn.png
magick output_merged_msg2.png fixed.png -gravity southwest -geometry -210-152 -composite output_merged_msg2_orn.png

img="orn2/orn2.jpg"
magick "${img}" -auto-orient -resize 400x400 ornament2.png
magick ornament2.png -fuzz 12% -transparent white fixed2.png
magick output_merged_msg2_orn.png fixed2.png -gravity northeast -geometry +240+0 -composite output_merged_msg2_orn_orn.png
magick output_merged_msg2_orn_orn.png fixed2.png -gravity northwest -geometry +240+0 -composite output_merged_msg2_orn_orn2.png