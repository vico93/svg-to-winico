#!/bin/bash
SCRIPT_PATH=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
cd $SCRIPT_PATH
echo $SCRIPT_PATH
read -p "Enter SVG folder path: " EMOJI_DIR

TMP_FOLDER=$SCRIPT_PATH/tmp/simple
DIST_FOLDER=$SCRIPT_PATH/dist/simple

mkdir -p $DIST_FOLDER

FILES=$EMOJI_DIR/*.svg
for f in $FILES
do
	echo "Processing $(basename "${f%.*}") file..."
	
	# Take action on each file. $f store current file name
	mkdir -p "$TMP_FOLDER/$(basename "${f%.*}")"
	cd "$TMP_FOLDER/$(basename "${f%.*}")"
	
	rsvg-convert "$f" -w 256 -h 256 -o emoji_256.png 
	rsvg-convert "$f" -w 96 -h 96 -o emoji_96.png
	rsvg-convert "$f" -w 64 -h 64 -o emoji_64.png
	rsvg-convert "$f" -w 48 -h 48 -o emoji_48.png
	rsvg-convert "$f" -w 40 -h 40 -o emoji_40.png
	rsvg-convert "$f" -w 32 -h 32 -o emoji_32.png
	rsvg-convert "$f" -w 24 -h 24 -o emoji_24.png
	rsvg-convert "$f" -w 20 -h 20 -o emoji_20.png
	rsvg-convert "$f" -w 16 -h 16 -o emoji_16.png
	
	# Make the .ico	
	magick convert emoji_256.png emoji_96.png emoji_64.png emoji_48.png emoji_40.png emoji_32.png emoji_24.png emoji_20.png emoji_16.png "$DIST_FOLDER/$(basename "${f%.*}").ico"
	
	cd ../../../
	rm -rf "$TMP_FOLDER/$(basename "${f%.*}")"
done
