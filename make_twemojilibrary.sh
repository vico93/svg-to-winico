#!/bin/bash
cd "${0%/*}"

# Start this bash with the twemoji svg folder as a argument
# e.g.:make_twemojilibrary.sh <path to your Twemoji folder>\2\svg
emoji_dir=$1

# Folder where you extracted the standard Windows library icon
baseicons_dir=${0%/*}/src/library
# Temp dir
set temp_dir=${0%/*}/tmp
# The dir where the finished icons are stored
set final_dir=${0%/*}/bin/library

mkdir /p $final_dir

for f in $emoji_dir
do
	echo "Processing $f file..."
	# Pasta temporária
	mkdir /p $temp_dir$/${f%%.*}
	cd $temp_dir$/${f%%.*}
	
	# Processa svg do emoji
	inkscape $emoji_dir/$f --export-png="emoji_256.png" -w120 -h120 --without-gui
	inkscape $emoji_dir/$f --export-png="emoji_64.png" -w32 -h32 --without-gui
	inkscape $emoji_dir/$f --export-png="emoji_48.png" -w24 -h24 --without-gui
	inkscape $emoji_dir/$f --export-png="emoji_40.png" -w20 -h20 --without-gui
	inkscape $emoji_dir/$f --export-png="emoji_32.png" -w16 -h16 --without-gui
	inkscape $emoji_dir/$f --export-png="emoji_24.png" -w12 -h12 --without-gui
	inkscape $emoji_dir/$f --export-png="emoji_20.png" -w10 -h10 --without-gui
	inkscape $emoji_dir/$f --export-png="emoji_16.png" -w16 -h16 --without-gui
	
	# Composite the folder icon
	magick $baseicons_dir/256.png emoji_256.png -gravity center -geometry +0+8 -composite "compositeicon_256.png"
	magick $baseicons_dir/64.png emoji_64.png -gravity center -geometry +0+0 -composite "compositeicon_64.png"
	magick $baseicons_dir/48.png emoji_48.png -gravity center -geometry +0+0 -composite "compositeicon_48.png"
	magick $baseicons_dir/40.png emoji_40.png -gravity center -geometry +0+0 -composite "compositeicon_40.png"
	magick $baseicons_dir/32.png emoji_32.png -gravity center -geometry +0+0 -composite "compositeicon_32.png"
	magick $baseicons_dir/24.png emoji_24.png -gravity center -geometry +0+0 -composite "compositeicon_24.png"
	magick $baseicons_dir/20.png emoji_20.png -gravity center -geometry +0+0 -composite "compositeicon_20.png"
	magick $baseicons_dir/16.png emoji_16.png -gravity center -geometry +0-1 -composite "compositeicon_16.png"
	
	# Make the .ico	
	magick compositeicon_256.png compositeicon_64.png compositeicon_48.png compositeicon_40.png compositeicon_32.png compositeicon_24.png compositeicon_20.png compositeicon_16.png $final_dir/${f%%.*}.ico

	# Clear screen
	clear
done

cd "${0%/*}"
rm -rf $temp_dir

read -n1 -r -p "Press any key to continue..." key
