
open F, "hu_HU.dic";

<F>;

while (<F>)
{
  chop;
  s/#.+$//;
  ($w, $a) = split /\//;
  next unless $w =~ /^[^\/_&§%°0-9]+$/;
  next if $w =~ /(^[-.])|([.]$)/;
  next if $w eq '';
  print "$_\n";
}
