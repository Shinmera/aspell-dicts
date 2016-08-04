#!/bin/sh
#
# This script converts BrOffice.org's spell checking dictionary to Aspell.
# (BrOffice.org is the Brazilian OpenOffice.org development community.)
#

FILE="pt_BR-2009-07-02AOC.zip"
URL="http://www.broffice.org/files/${FILE}"

die() {
	echo "$1"
	exit 1
}

[ -x proc ] && [ -x configure ] || \
	die "$(basename $0) must be run inside an aspell-lang directory"
[ -x $(which unzip) ] || die "Could not find unzip"

echo ">>> Fetching dictionary..."
wget --timestamping --no-verbose "${URL}" || die "Could not fetch ${URL}"

echo ">>> Uncompressing dictionary..."
unzip -joq "${FILE}" || die "Could not unzip ${FILE}"

echo ">>> Converting dictionary..."
[ -e README_pt_BR.TXT ] && mv README_pt_BR.TXT doc/LEIAME_ooo.txt
[ -e README_en.TXT ] && mv README_en.TXT doc/README_ooo.txt

mv pt_BR.aff pt_BR_affix.dat \
    && sed -i -e "s/\r//g" pt_BR_affix.dat \
    || die "Error converting pt_BR.aff"
mv pt_BR.dic pt_BR.wl \
    && sed -i -e "s/\r//g" -e "1d" -e "/\./d" pt_BR.wl \
    || die "Error converting pt_BR.dic"

echo ">>> Packaging dictionary..."
./proc || die "proc failed"
./configure || die "configure failed"
LC_ALL=C LANG=C make dist || die "make dist failed"
