#! /bin/sh
#
# make-keyword-views.sh - generate views (directories containing
#   symlinks) based on keyword
#
# Implementation: a few of the finds in here are to 
# avoid limits in argument length, grep x * easy but will
# will break for too may projects
#

if [ ! -d VIEWS ]
then 
  mkdir VIEWS
fi

find . -name KEYWORDS -exec cat {}  \; | 
tr ' ' '\n' | 
grep "[a-zA-Z]*" | 
grep -v "^-" | 
grep -v "^$" |
sort -u >$$.kw
sort -u PROJECTS/INDEX-STOPLIST >$$.st
comm -23 $$.kw $$.st |  
while read kw 
do 
    echo "processing $kw"
    if [ ! -d VIEWS/$kw ]
    then 
	mkdir VIEWS/$kw
    fi
    cd VIEWS/$kw
    echo "* $kw"
    find ../.. -name KEYWORDS |
    while read kwf
    do
	grep -l $kw $kwf
    done |
    while read dir 
    do
	ln -fs `dirname $dir` .
    done
    cd ../..
done
