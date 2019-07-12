#!/bin/bash
read -p "Enter emoji dir path: " emoji_dir
FILES=$emoji_dir/*.svg
for f in $FILES
do
  echo "Processing $f file..."
  icon-gen -i $f -o %final_dir% --ico name=${f%.*} sizes=16,20,24,32,40,48,64,96,256
  # take action on each file. $f store current file name
  cat $f
done
