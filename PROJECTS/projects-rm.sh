#
# projects-rm.sh - remove a project
#

echo "Remove project: "
read PROJECT
rm FOSSILS/${PROJECT}.fossil
rm -rf ${PROJECT}
 

