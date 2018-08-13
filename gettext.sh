#!/bin/bash

for f in pdf/*.pdf
do
  pdftotext -nopgbrk "$f"
done
