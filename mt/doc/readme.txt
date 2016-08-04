DICTIONARY FOR MALTESE SPELL-CHECKERS
-------------------------------------

Compiled by:     Ramon Casha
email:           ramon.casha@linux.org.mt
Website:         http://linux.org.mt/projects/spellcheck
Number of words: ~530,000


LICENSING
=========

This word list, and other files included with it, is released under the
terms of the Lesser General Public License. Please see the file COPYING
for the complete license text. In short, you may use this word list in/with
your software (eg. to add a spell check to a word processor), but if you
make changes to the word list itself (adding, changing or removing words)
and redistribute the modified version in any way, you are required to
make the modified word list available under the same conditions as this one.

Details on the LGPL can be found at http://www.gnu.org/copyleft/lesser.html


WARNING
=======

The process of weeding out errors is a lengthy, laborious and ongoing one.
This list may, and probably does, contain errors. Do not use in life-or-death
situations :)


SOURCES
=======
  Laws of Malta
  German-Maltese lexicon
  Electoral Register
  various websites



BEFORE INSTALLING make sure that you have the aspell and/or ispell
packages installed on your system.


AUTOMATIC INSTALLATION
======================

To perform the automatic installation, extract the contents of the 
distribution archive file into a temporary directory, then execute
the install.sh file.

If you encounter any problems with this method, please use the
instructions for manual installation, below.


MANUAL INSTALLATION
===================

To install the files "manually", log in as root, go to the directory
containing the extracted contents of the archive and enter the following
commands:

  FOR ISPELL:

    cp malti_phonet.dat /usr/share/aspell/
    cp malti.dat /usr/share/aspell/
    aspell --lang=malti create master malti < words.iso8859-3

  FOR ASPELL:

    cp malti.aff /usr/lib/ispell/
    buildhash words.iso8859-3 /usr/lib/ispell/malti.aff /usr/lib/ispell/malti.hash

