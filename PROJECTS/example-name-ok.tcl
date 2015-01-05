#! /usr/bin/tclsh
#
# example-name-ok.tcl - an example naming convention checkerer
#
# This is extreme overkill for the task and could also be done
# directly in a program but might be useful.
#
# Typically you'd edit the default arguments on the next
# page and be done.
#

# option handling
foreach {o v d} {
  -v 1 "Verbose debugging"
  -accept_anything 0 "if 1 accept anything regardless"
  -final_check 0 "ask the user for a final check at the end"
  -only_re {.*} "accept anything matching regexp"
  -not_re {[ \t:@/\\$]} "reject if any substring matches regexp"
  -split {-} "split name by chars ({} = no splitting of name)"
  -parts_min 3 "minimum number of parts"
  -parts_max 3 "maximum number of parts"
  -parts {
    {re {P[0-9]+} {Q[0-9]+}}
    {file component-names}
  } "rules for each part of the name"
} { 
  set options($o) $v
  set descriptions($o) $d
}
 
proc msg {s} {
  if {$::options(-v)} {
    puts $s
  }
}

array set options [lrange $argv 0 end-1]
set name [lindex $argv end]
foreach k [lsort -dictionary [array names options]] {
  msg "option [format %10s $k] [format %20s $options($k)] $descriptions($k)"
}

# checking support
proc ok {} {
  if {$::options(-final_check)} {
    puts "confirm that: '$::name' is correct? (y/n)"
    while {[gets stdin response] > 0} {
      if {$response eq "y"} {
	exit 0
      } elseif {$response eq "n"} {
	exit 1
      } else {
	puts "y/n?"
      }
    }
  } else {
    puts "'$::name' is ok!"
  }
  exit 0
}

proc fail {msg code} {
  puts "$::name is NOT ok!: $msg"
  exit $code
}

proc check {msg exprn} {
  msg "check $msg $exprn"
  if {[uplevel #0 [list expr $exprn]]} {
    # ok for now
  } else {
    fail "$msg: $exprn -> [uplevel #0 [list subst $exprn]]" 101
  }
}

# tools to check parts of the name which called
# when -parts options is processed.

# these check routines assume the data
proc part:re {args} {
  foreach re $args {
    if {[regexp -- $re $::part]} {
      # ok
      return
    } else {
      # no match but keep trying
    }
  }
  check "part_re $args failed to match $::part" 0
}

proc part:file {file} {
  set fd [open $file]
  while {[gets $fd line] > 0} {
    if {$line eq $::part} {
      # ok
      return
    } else {
      # no match so keep looking
    }
  }
  check "part_fromfile $file failed to match $::part" 0
}

# the actual rules

if {$::options(-accept_anything)} {
  ok
}

check "anything matching -only_re" \
    {[regexp -- ^$options(-only_re)\$ $name] == 1}

check "anything not matching -not_re" \
    {[regexp -- $options(-not_re) $name] == 0}

if {$options(-split) != {}} {
  set parts [split $name $::options(-split)]
  set nparts [llength $parts]

  check "require -parts_min fields" \
      {$nparts >= $options(-parts_min)} 
  
  check "require -parts_max fields" \
      {$nparts <= $options(-parts_max)} 

  set i 0
  foreach c $options(-parts) {
    set part [lindex $parts $i]
    msg "checking part $part"
    eval part:$c
    incr i
  }
}

ok




