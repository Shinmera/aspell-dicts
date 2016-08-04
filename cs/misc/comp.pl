# This script compares the expansion of Aspell and Ispell expansion 
# and removes affixes flags that have different expansions

use warnings;

use open ':encoding(iso-8859-2)', ':std';

use IPC::Open2;
use IO::Handle;

open A, "| aspell --local-data-dir=./ --lang=cs expand 2 > aspell.exp";
open I, "| ispell -d ~/ispell-czech/czech -e2 > ispell.exp";

open F, "cs.wl";
open O, ">res.wl";

while (<F>) {
  if (m~(.+?)/(.+)~) {
    my $w = $1;
    my @f = $2 =~ /./g;
    foreach (@f) {
      print A "$w/$_\n";
      print I "$w/$_\n";
    }
    print A "\n";
    print I "\n";
  } else {
    print O;
  }
}

close A;
close I;

open A, "aspell.exp";
open I, "ispell.exp";

while ($a = readline(A), $b = readline(I), defined $a) {
  chop $a;
  chop $b;
  if (length $a == 1) {
    print O "$w";
    print O "/$flags\n" if length $flags > 0;
    $flags = '';
    next
  }
  @a = split ' ', $a;
  @b = split ' ', $b;
  $a = shift @a;
  $b = shift @b;
  die "$a != $b" unless $a eq $b;
  $a =~ m~^(.+)/(.)$~ or die "?\?$a\??";
  $w = $1;
  my $f = $2;
  @a = sort @a;
  @b = sort @b;
  @bb = sort map {$_ eq uc $_ ? ucfirst lc $_ : $_} @b;
  if (join(' ',@a) ne join(' ',@b) && join(' ',@a) ne join(' ',@bb)) {
    print STDERR "expansion of \"$a\" differ\n";
    print STDERR "  aspell: ", join(' ',@a), "\n";
    print STDERR "  ispell: ", join(' ',@b), "\n";
    #foreach (@b) {print O "$_\n";}
  } else {
    $flags .= $f;
  }
}
