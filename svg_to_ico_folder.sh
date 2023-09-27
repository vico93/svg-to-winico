#!/bin/bash
SCRIPT_PATH=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
pushd $SCRIPT_PATH
read -p "Enter SVG folder path: " EMOJI_DIR

SRC_FOLDER=$SCRIPT_PATH/src/folder
TMP_FOLDER=$SCRIPT_PATH/tmp/folder
DIST_FOLDER=$SCRIPT_PATH/dist/folder

mkdir -p $DIST_FOLDER

FILES=$EMOJI_DIR/*.svg
for f in $FILES
do
	echo "Processing $(basename "${f%.*}") file..."
	
	# Take action on each file. $f store current file name
	mkdir -p "$TMP_FOLDER/$(basename "${f%.*}")"
	pushd "$TMP_FOLDER/$(basename "${f%.*}")"
	
	rsvg-convert "$f" -w 120 -h 120 -o emoji_256.png
	rsvg-convert "$f" -w 32 -h 32 -o emoji_64.png
	rsvg-convert "$f" -w 24 -h 24 -o emoji_48.png
	rsvg-convert "$f" -w 20 -h 20 -o emoji_40.png
	rsvg-convert "$f" -w 16 -h 16 -o emoji_32.png
	rsvg-convert "$f" -w 12 -h 12 -o emoji_24.png
	rsvg-convert "$f" -w 10 -h 10 -o emoji_20.png
	
	# Composite the folder icon
	magick composite -gravity SouthEast -geometry +16+29 emoji_256.png "$SRC_FOLDER/256.png" compositeicon_256.png
	magick composite -gravity SouthEast -geometry +4+6 emoji_64.png "$SRC_FOLDER/64.png" compositeicon_64.png
	magick composite -gravity SouthEast -geometry +3+6 emoji_48.png "$SRC_FOLDER/48.png" compositeicon_48.png
	magick composite -gravity SouthEast -geometry +2+5 emoji_40.png "$SRC_FOLDER/40.png" compositeicon_40.png
	magick composite -gravity SouthEast -geometry +3+3 emoji_32.png "$SRC_FOLDER/32.png" compositeicon_32.png
	magick composite -gravity SouthEast -geometry +1+3 emoji_24.png "$SRC_FOLDER/24.png" compositeicon_24.png
	magick composite -gravity SouthEast -geometry +2+2 emoji_20.png "$SRC_FOLDER/20.png" compositeicon_20.png
	
	# Make the .ico	
	magick convert compositeicon_256.png compositeicon_64.png compositeicon_48.png compositeicon_40.png compositeicon_32.png compositeicon_24.png compositeicon_20.png emoji_32.png "$DIST_FOLDER/$(basename "${f%.*}").ico"
	
	popd
 
	rm -rf "$TMP_FOLDER/$(basename "${f%.*}")"
done

popd
