#! /bin/bash
#
# projects-new.sh - create a new project
#
# Aside: the dash shell in Ubuntu has various issues 
# with things like trap, whence the bash above

# lock file to stop race conditions in the update process
# Note this is Linux specific at this time (du)
LOCKFILE=./lockfile
LOCKTIMEOUT=60
(
echo "Waiting for lockfile $LOCKFILE"
flock -x --timeout ${LOCKTIMEOUT} 9 || 
  (echo "$0: failed to acquire lock $LOCKFILE" ; exit 201)
echo "Acquired lockfile $LOCKFILE ok"
function remove_lockfile {
    echo "removing lockfile $LOCKFILE"
    rm -f $LOCKFILE
}
trap remove_lockfile EXIT

# Ask for project name etc
echo -n "Project name: "
read PROJECT

# check that we are allowed to make this project
if [ -f FOSSILS/${PROJECT}.fossil ]
then
    echo "$0: FOSSILS/${PROJECT}.fossil already exists"
    exit 101
fi

if [ -d ${PROJECT} ] 
then
    echo "$0: ${PROJECT} already exists"
    exit 102
fi

if ./PROJECTS/project-name-ok.sh ${PROJECT}
then
    true ; # name ok
else
   echo "$0: ${PROJECT} name NOT ok exiting"
   exit 103
fi

# create the fossil and the directory
fossil new FOSSILS/${PROJECT}.fossil
mkdir ${PROJECT}
cd ${PROJECT}
fossil open ../FOSSILS/${PROJECT}.fossil

# simple template mechanism: just copy a list of whitespace
#   seperated names from TEMPLATES into the working directory
echo -n "Possible Templates: "
for t in ../TEMPLATES/*
do
    echo -n "`basename $t` "
done
echo ""
echo -n "Template: "
read TL
for t in $TL
do
    t=../TEMPLATES/$t
    (cd $t ; make distclean; rm *~ ) ;# to avoid *~ etc coming across
    if [ -d $t ]
    then 
	cp -r $t/* .
    else
	cp $t .
    fi
done
if [ ! -d ${PROJECT} ] 
then
   mkdir ${PROJECT}
fi

# get the one line summary from the user
echo -n "One liner: ${PROJECT} - "
read ONELINER
echo "${PROJECT} - ${ONELINER}" > $PROJECT/ONELINER

# make the ptx
make ptx

# finally do the first commit and setup the fossil project 
# propeties

fossil add .
fossil commit -m "In the beginning"
../PROJECTS/projects-settings.sh 
fossil ui &

# unlock everything at the end.
) 9>$LOCKFILE
rm -f $LOCKFILE
