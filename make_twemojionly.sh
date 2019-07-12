#!/bin/bash
read -p "Enter emoji dir path: " emoji_dir
FILES=$emoji_dir/*.svg
for f in $FILES
do
	echo "Processing $f file..."
	# take action on each file. $f store current file name
	echo $f
done
