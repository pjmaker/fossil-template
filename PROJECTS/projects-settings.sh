#
# project-settings.sh - set up fossil settings for the project
#

# editor to use (possibly mg -n which is just a small emacs clone) which 
# has the benefit it doesn't make backups of checkin comments and is quite
# fast.
# fossil set editor "emacs -nw"
# fossil set editor "vi"
fossil set editor "mg -n"

fossil set ignore-glob "*~ *.o *.log *.nav *.out *.snm *.toc *.aux"
fossil set binary-glob "*.jpg *.pdf"
# sign with GPG
fossil set clearsign true 
fossil set gdiff-command tkdiff
fossil set localauth true



