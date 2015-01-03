#
# Makefile - for a collection of Fossil archives, see the README.md 
#   file for details.
#

all:
	@echo what?

# fossil targets

.PHONY: new

# make a new project and fossil archive
new:
	PROJECTS/projects-new.sh

# remove a project and its fossil archive
rm:
	PROJECTS/projects-rm.sh




