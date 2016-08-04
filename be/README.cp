GNU Aspell 0.50 Belarusian (��������) Dictionary Package
Version 0.01
2004-07-05
Original Word List By:
  Vital Khilko <vk at mova dot org>
  Koshchanka Uladzimir <dassax at tut dot by>
  Yaugenuja Volkava <volkava at eml dot cc>
  Valjancina Avilava <valoshka at mail dot ru>
Copyright Terms: GPL (see the file Copyright for the exact terms)

This is the Belarusian dictionary for Aspell.  It requires Aspell 
version 0.50 or better.

If Aspell is installed and aspell and word-list-compress are all
in the path first do a:

  ./configure

Which should output something like:

  Finding Dictionary file location ... /usr/local/lib/aspell
  Finding Data file location ... /usr/local/share/aspell

if it did not something likely went wrong.

After that build the package with:
  make
and then install it with
  make install

If any of the above mentioned programs are not in your path than the
variables, ASPELL and/or PREZIP need to be set to the
commands (with path) to run the utilities.  These variables may be set
in the environment before configure is run or specified at the command
line using the following syntax
  ./configure --vars VAR1=VAL1 ...
Other useful variables configure recognizes are ASPELL_PARMS, and DESTDIR.

To clean up after the build:
  make clean

To uninstall the files:
  make uninstall

After the dictionaries are installed you can use the main one (be) by
setting the LANG environmental variable to be or running Aspell
with "--lang=be".  You may also chose the dictionary directly
with the "-d" or "--master" option of Aspell.  You can chose from any of
the following dictionaries:
  be (be_BY belarusian)
  be_SU (belarusian-soviet)
Whereas the names in parentheses are alternate names for the
dictionary preceding the parentheses.

The individual word lists have an extension of ".cwl" and are
compressed to save space.  To uncompress a word list use
"word-list-compress < BASE.cwl > BASE.wl" or simply
"word-list-compress < BASE.cwl" to dump it to standard output.

If you have any problem with installing or using the word lists please
let the Aspell maintainer, Kevin Atkinson, know at kevina@gnu.org.

If you have problems with the actual word lists please contact one of
the Word lists authors as the Aspell maintainer does not maintain the
actual Word Lists.

Any additional documentation that came with the original word list can
be found in the doc/ directory.

