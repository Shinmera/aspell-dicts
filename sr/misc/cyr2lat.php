#!/usr/local/bin/php
<?php
 
  /* 

     Author: Goran Rakic, 09/29/2005
     
     Known bug: 
     
        This simple tool does not handle transliteration of capital
        Cyrillic characters that are written as two characters in Latin
        script correctly. For example, word "ЊЕГОВ" should be converted
        to "NJEGOV" (this tool will do that correctly), but word "Његов" 
        should be converted to "Njegov" and script will convert it to 
        "NJegov".
         
        You can find more robust solutions at URL:
        http://www.cirilica.org/programi.html
        
  */

  if (!function_exists('file_get_contents')) require_once('file_get_contents.php');
  if (!function_exists('file_put_contents')) require_once('file_put_contents.php');

  $small = array('а' => 'a', 'б' => 'b', 'в' => 'v', 'г' => 'g', 'д' => 'd',
                 'ђ' => 'đ', 'е' => 'e', 'ж' => 'ž', 'з' => 'z', 'и' => 'i',
                 'ј' => 'j', 'к' => 'k', 'л' => 'l', 'љ' => 'lj', 'м' => 'm',
                 'н' => 'n', 'њ' => 'nj', 'о' => 'o', 'п' => 'p', 'р' => 'r',
                 'с' => 's', 'т' => 't', 'ћ' => 'ć', 'ч' => 'č', 'ф' => 'f',
                 'х' => 'h', 'ц' => 'c', 'у' => 'u', 'џ' => 'dž', 'ш' => 'š');
  
  $capital = array('А' => 'A', 'Б' => 'B', 'В' => 'V', 'Г' => 'G', 'Д' => 'D',
                   'Ђ' => 'Đ', 'Е' => 'E', 'Ж' => 'Ž', 'З' => 'Z', 'И' => 'I',
                   'Ј' => 'J', 'К' => 'K', 'Л' => 'L', 'Љ' => 'LJ', 'М' => 'M',
                   'Н' => 'N', 'Њ' => 'NJ', 'О' => 'O', 'П' => 'P', 'Р' => 'R',
                   'С' => 'S', 'Т' => 'T', 'Ћ' => 'Ć', 'Ч' => 'Č', 'Ф' => 'F',
                   'Х' => 'H', 'Ц' => 'C', 'У' => 'U', 'Џ' => 'DŽ', 'Ш' => 'Š');


  echo "\nSerbian Cyrillic to Serbian Latin transliteration tool\n\n";

  echo "Enter input filename: ";  
  $in = trim(fgets(STDIN));
  
  echo "Enter output filename: ";  
  $out = trim(fgets(STDIN));
  
  $input = file_get_contents($in);
  $rep = array_merge($small, $capital);
  $output = strtr($input, $rep);
  file_put_contents($out, $output);

  echo "Done.\n";
  
?>
