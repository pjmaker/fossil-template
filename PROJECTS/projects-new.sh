#
# projects-new.sh - create a new project
#

echo -n "Project name: "
read PROJECT

if [ -f FOSSILS/${PROJECT}.fossil ]
then
    echo "$0: FOSSILS/${PROJECT}.fossil already exists"
    exit 101
fi

if [ -d ${PROJECT} ] 
then
    echo "$0: ${PROJECT} already already exists"
    exit 102
fi


fossil new FOSSILS/${PROJECT}.fossil
mkdir ${PROJECT}
cd ${PROJECT}
fossil open ../FOSSILS/${PROJECT}.fossil

# simple template mechanism.
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

fossil add .
fossil commit -m "In the beginning"
../PROJECTS/projects-settings.sh 
fossil ui &
