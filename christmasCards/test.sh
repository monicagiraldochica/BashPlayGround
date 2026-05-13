#!/bin/bash
# Author: Monica Keith
# Created: 2026-03-12
# Description: Create a christmas card

merge_horizontal(){
    inputs=("${@:1:$#-1}")
    min_h=$(identify -format "%h\n" "${inputs[@]}" | sort -n | head -1)
    resized=()
    
    for img in "${inputs[@]}"
    do
        if [[ -f "${img}" ]]; then
            output="${img%.*}_resized.png"
            magick "${img}" -auto-orient -resize x"${min_h}" "${output}"
            resized+=("${output}")
        fi
    done

    if (( ${#resized[@]} == 0 )); then
        echo "Error: no valid input images" >&2
        return 1
    fi

    magick "${resized[@]}" +append "${@: -1}"
}

merge_vertical(){
    inputs=("${@:1:$#-1}")
    min_w=$(identify -format "%w\n" "${inputs[@]}" | sort -n | head -1)
    resized=()
    
    for img in "${inputs[@]}"
    do
        if [[ -f "${img}" ]]; then
            output="${img%.*}_resized.png"
            magick "${img}" -auto-orient -resize "${min_w}"x "${output}"
            resized+=("${output}")
        fi
    done

    if (( ${#resized[@]} == 0 )); then
        echo "Error: no valid input images" >&2
        return 1
    fi

    magick "${resized[@]}" -append "${@: -1}"
}

main(){
    # Detect flag
    rewrite=false
    if [[ "${!#}" == "-rewrite" ]]; then
        rewrite=true
        set -- "${@:1:$#-1}"   # remove flag from arguments
    fi

    # Validate input count (must be multiple of 9)
    if (( $# == 0 || $# % 9 != 0 )); then
        echo "Error: number of input files must be a multiple of 9" >&2
        exit 1
    fi

    args=("$@")
    n=${#args[@]}

    # Merge inputs horizontally in groups of 3
    i=1
    horizontals=()
    for ((idx=0; idx<n; idx+=3)); do
        output="horizontal${i}.png"

        if $rewrite && [[ -f "$output" ]]; then
            echo "Skipping existing ${output}"
        else
            merge_horizontal "${args[idx]}" "${args[idx+1]}" "${args[idx+2]}" "${output}"
        fi

        ((i++))
        horizontals+=("${output}")
    done

    # Merge horizontal images vertically, in groups of 3
    j=1
    for ((idx=0; idx<n; idx+=3)); do
        output="vertical${j}.png"

        if $rewrite && [[ -f "$output" ]]; then
            echo "Skipping existing ${output}"
        else
            merge_vertical "${horizontals[idx]}" "${horizontals[idx+1]}" "${horizontals[idx+2]}" "${output}"
        fi
    done    
}
main "$@"

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
#magick  output_merged_msg.png -fill "#0a8f39" -stroke "#c40000" -strokewidth 2 -font "Georgia" -pointsize 200 -annotate +455+1220  "2026" output_merged_msg2.png
#magick  output_merged_msg.png -fill "#0a8f39" -stroke "#c40000" -strokewidth 2 -font "MerryChristmasFlake-mJY9.ttf" -pointsize 230 -annotate +150+850  "01234\n56789" output_merged_msg3.png

# Add border
#magick output_merged_msg2.png -bordercolor green -border 20 -bordercolor red -border 10 output_merged_msg2_bdr.png

#img="merry-christmas-red-ornament-decorations/eee4ab84-36ac-4a2a-9a9b-734e12ac002c.jpg"
#magick "${img}" -auto-orient -resize 600x600 ornament.png
#magick ornament.png -fuzz 12% -transparent white fixed.png
#magick output_merged_msg2_bdr.png fixed.png -gravity southwest -geometry -60-70 -composite output_merged_msg2_bdr_orn.png
#magick output_merged_msg2.png fixed.png -gravity southwest -geometry -210-152 -composite output_merged_msg2_orn.png

#img="orn2/orn2.jpg"
#magick "${img}" -auto-orient -resize 400x400 ornament2.png
#magick ornament2.png -fuzz 12% -transparent white fixed2.png
#magick output_merged_msg2_orn.png fixed2.png -gravity northeast -geometry +240+0 -composite output_merged_msg2_orn_orn.png
#magick output_merged_msg2_orn_orn.png fixed2.png -gravity northwest -geometry +240+0 -composite output_merged_msg2_orn_orn2.png