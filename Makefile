#
# Makefile - for a collection of Fossil archives, see the README.md 
#   file for details.
#

all:
	@echo what?

# fossil targets

.PHONY: new rm ptx

# make a new project and fossil archive
new:
	PROJECTS/projects-new.sh

# remove a project and its fossil archive
rm:
	PROJECTS/projects-rm.sh

# ptx - generate the complete keyword in context list
#  from the ONELINER file in each project. 
ptx:
	find . -name ONELINER -exec cat {} \; | \
	ptx --ignore-file=PROJECTS/INDEX-STOPLIST \
	   --ignore-case --width=80 



