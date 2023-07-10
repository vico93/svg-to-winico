#!/bin/bash
SCRIPT_PATH=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
cd $SCRIPT_PATH
echo $SCRIPT_PATH
read -p "Enter emoji dir path: " EMOJI_DIR

SRC_FOLDER=$SCRIPT_PATH/src/file
TMP_FOLDER=$SCRIPT_PATH/tmp/file
DIST_FOLDER=$SCRIPT_PATH/dist/file

mkdir -p $DIST_FOLDER

FILES=$EMOJI_DIR/*.svg
for f in $FILES
do
	echo "Processing $(basename "${f%.*}") file..."
	
	# Take action on each file. $f store current file name
	mkdir -p "$TMP_FOLDER/$(basename "${f%.*}")"
	cd "$TMP_FOLDER/$(basename "${f%.*}")"
	
	rsvg-convert "$f" -w 128 -h 128 -o emoji_256.png
	rsvg-convert "$f" -w 32 -h 32 -o emoji_64.png
	rsvg-convert "$f" -w 24 -h 24 -o emoji_48.png
	rsvg-convert "$f" -w 20 -h 20 -o emoji_40.png
	rsvg-convert "$f" -w 16 -h 16 -o emoji_32.png
	rsvg-convert "$f" -w 12 -h 12 -o emoji_24.png
	rsvg-convert "$f" -w 10 -h 10 -o emoji_20.png
	rsvg-convert "$f" -w 8 -h 8 -o emoji_16.png
	
	# Composite the file icon
	composite -gravity North -geometry +0+84 emoji_256.png "$SRC_FOLDER/256.png" compositeicon_256.png
	composite -gravity North -geometry +0+17 emoji_64.png "$SRC_FOLDER/64.png" compositeicon_64.png
	composite -gravity North -geometry +0+12 emoji_48.png "$SRC_FOLDER/48.png" compositeicon_48.png
	composite -gravity North -geometry +0+10 emoji_40.png "$SRC_FOLDER/40.png" compositeicon_40.png
	composite -gravity North -geometry +0+9 emoji_32.png "$SRC_FOLDER/32.png" compositeicon_32.png
	composite -gravity North -geometry +0+6 emoji_24.png "$SRC_FOLDER/24.png" compositeicon_24.png
	composite -gravity North -geometry +0+5 emoji_20.png "$SRC_FOLDER/20.png" compositeicon_20.png
	composite -gravity North -geometry +0+4 emoji_16.png "$SRC_FOLDER/16.png" compositeicon_16.png
	
	# Make the .ico	
	convert compositeicon_256.png compositeicon_64.png compositeicon_48.png compositeicon_40.png compositeicon_32.png compositeicon_24.png compositeicon_20.png compositeicon_16.png "$DIST_FOLDER/$(basename "${f%.*}").ico"
	
	cd ../../../
	rm -rf "$TMP_FOLDER/$(basename "${f%.*}")"
done
