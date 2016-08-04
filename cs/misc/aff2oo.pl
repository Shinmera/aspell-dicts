#!/usr/bin/perl

#
# .aff -> Open Office afix file convertor; not tested!!!
# Using:
#      perl aff2oo.pl czech.aff
#

use open ':encoding(iso-8859-2)', ':std';
#use locale;

print "SET ISO8859-2\n";

$number='';
while (<>) {
  if (/^wordchars\s+(.*)/ || /^stringchar\s+(.*)/) {
    $chars=$1;
    $chars=~s/\s+$//;
    $expand='';
    if ($chars=~/\[([^\]]*)\]\s+\[([^\]]*)\]/) {
      $list1=$1;
      $list2=$2;
      while ($list1 ne '') {
        if ($list1=~s/^(.)-(.)//) {
          $from=$1;
          $upto=$2;
          $expand='';
          for ($c=$from; $c le $upto; $c++) {
            $expand.=$c;
          }
          $list1=$expand.$list1;
        }
        if ($list2=~s/^(.)-(.)//) {
          $from=$1;
          $upto=$2;
          $expand='';
          for ($c=$from; $c le $upto; $c++) {
            $expand.=$c;
          }
          $list2=$expand.$list2;
        }
        while ($list1 =~ s/^(.)//) {
          $c=$1;
          if ($list2 =~ s/^(.)//) {
            $uc=$1;
            $uc='' if $c eq $uc;
          }
          $try .= $c . $uc;
        }
      }
    } else {
      $chars=~s/^(.)\s+\1/$1/;
      $try.=join('', split(/\s+/, $chars));
    }
  }
  if (/^prefixes/) {
    $affixtype='PFX';
    if ($try) {
      print "TRY $try\n\n";
      $try='';
    }
  } elsif (/^suffixes/) {
    $affixtype='SFX';
    if ($try) {
      print "TRY $try\n\n";
      $try='';
    }
  } else {
    next if (!$affixtype);
    if (/^flag (\*?)(.):/) {
      if ($number ne '') {
        $out=shift(@OUT);
        print "$out $number\n";
        print @OUT;
        print "\n";
      }
      $flag=$2;
      $combined=($1 eq '')? 'N' : 'Y';
      @OUT=("$affixtype $flag $combined");
      $number=0;
    } else {
      s/\n$//;
      s/\s*\#.*$//;
      s/^\s*//;
#print "Line: `$_'\n";
      if (/^([^\>]*)>(.*)/) {
        $cond=$1;
        $rest=$2;
#print "\$cond: `$cond'\n";
#print "\$rest: `$rest'\n";
        $cond=~s/^\s*//;
        $cond=~s/\s*$//;
        $rest=~s/^\s*//;
        $rest=~s/\s*$//;
#print "\$cond: `$cond'\n";
#print "\$rest: `$rest'\n";
        if ($rest=~/-(.*),(.*)/) {
          $remove=$1;
          $add=$2;
        } else {
          $remove='0';
          $add=$rest;
        }
        $remove=~s/\s*$//;
        $add=~s/^\s*//;
        $cond=~s/ //g;
        $remove=lc($remove);
        $add=lc($add);
        $cond=lc($cond);
        
        $add='0' if $add eq '-';
        if ($cond ne '.') {
          @cond = $cond =~ /\[.+?\]|./g;
          die unless join('',@cond) eq $cond;
          $rem_len = $rem eq '.' ? 0 : length($remove);
          @i = ();
          @i = ($rem_len .. $#cond)       if $affixtype eq 'PFX';
          @i = (0 .. ($#cond - $rem_len)) if $affixtype eq 'SFX';
          #print ">>@i $cond\n";
          foreach my $i (@i) {
            ($p, $s) = $cond[$i] =~ /^\[?(\^?)(.+?)\]?$/ or die;
            $cond[$i] = '[' . $p . $s . uc $s . ']';
          }
          $cond = join('',@cond);
          #print "<<@i $cond\n";
        }
        push(@OUT, "$affixtype $flag $remove $add $cond\n");
        $number++;
      }
    }
  }
}
      if ($number ne '') {
        $out=shift(@OUT);
        print "$out $number\n";
        print @OUT;
        print "\n";
      }
