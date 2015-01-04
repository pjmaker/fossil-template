#! /usr/bin/tclsh
#
# example-name-ok.tcl - an example naming convention checkerer
#
# The method used:
# 
# split a name using the separators split
# then match each part against a series of regexp patterns in match
#

set split {-}
set match {
  {P90 P91}
  {WP[0-9]+}
  {FS CD TP TUT}
}

set name [lindex $argv 0]
set parts [split $name $::options(-split)]

if {[llength $parts] != [llength $::options(-match)]} {
  puts "# of parts mismatch!"
  exit 1
}

set i 0
foreach f $::options(-match) { 
  set ok 0
  foreach pat [lindex $::options(-match) $i] {
    if {[regexp -exact "^$pat\$" [lindex $parts $i]]} { 
      set ok 1
      break
    }
    incr i
  }
  if {!$ok}} {
    exit 102
  }
}

exit 0 ;# success


