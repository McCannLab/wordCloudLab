#!/bin/bash

for f in img/*.svg
do
  # inkscape -z -e $f -w 1024 -h 1024 ${f%.*}.png
  svgexport $f ${f%.*}.png
done

# https://stackoverflow.com/questions/9853325/how-to-convert-a-svg-to-a-png-with-image-magick
