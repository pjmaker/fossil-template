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
	find . -name ONELINER -o -name KEYWORDS -exec cat {} \; | \
	ptx --ignore-file=PROJECTS/INDEX-STOPLIST \
	   --ignore-case --width=80 >INDEX

# glimpseindex across the entire system - the current
#   just indexes the whole directory. You can do individual
#   updates as well buts its probably best to run this
#   in cron on the server every night.man
#
# search with glimpse -H. pattern
# 


glimpse-index-all:
	glimpseindex -B -t -f -H . -M 128 .



