#!/bin/bash
temp=$(mktemp)

#directory="/sdcard/Movies/TikTok/"
directory="$HOME/Videos/"
options=$(find $directory -mindepth 1 -maxdepth 1 -type f -not -name '.*' -printf "%f %TY-%Tm-%Td off\n");
selected_files=$(dialog --checklist "Pick files out of $directory" 60 70 25 $options --output-fd 1);

for f in $selected_files
do
fpS=$(ffmpeg -i $directory$f  2>&1 | sed -n "s/.*, \(.*\) tbr.*/\1/p")
echo $fpS
echo "$f" >  $temp
fold=$(sed 's/.mp4//g' "$temp")
mkdir $directory".$fold"
#ffmpeg -i $directory$f -framerate $fpS -pix_fmt rgb48be  $directory".$fold"/output_%04d.png
ffmpeg -i $directory$f -vf fps=$fpS -f image2 -vcodec png $directory".$fold"/output_%04d.png
done

