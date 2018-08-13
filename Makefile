gettext:
	for f in pdf/*.pdf; pdftotext -enc ASCII7 -nopgbrk $f
