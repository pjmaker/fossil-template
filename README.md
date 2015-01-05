# fossil-template

A very small (trivial) project for managing projects using fossil
(http://www.fossil-scm.org) as the version control software. 
It was written in order to:

* Make the creation of a tiny project such as a presentation easy.
* Ensure that the correct steps are followed each time and that every
one hundred creates we don't put something somewhere else.
* Finally copy templates of things like talks, code, paper or licenses
directly into the archive easily.

The summary use case is make a play,perhaps ``~/projects`` which
contains:

1. ``FOSSIL`` - directory with all the <project>.fossil archives.
1. ``TEMPLATES`` - directory containing templates,
e.g. ``TEMPLATES/talk`` is a template for a generic talk in Beamer.
1. ``PROJECTS`` - various shell scripts supporting the show.along
with a list of words not to index in ``INDEX-STOPLIST``.
1. ``Makefile`` - finally a make file to drive it.

Then to build a project:

````
% make new
Project name: swiss-knife
Possible Templates: talk reportiee paper gnuprog
Template: talk
One liner swiss-knife - a small knife not comparable to a MORA
% cd swiss-knife
```

And ``make rm`` removes projects and archives.

At the end you will have an ``INDEX`` of the one liners available.

### Project naming conventions

By default what you say is what you get so if you want to check project
names have a look at ``PROJECTS/projects-name-ok.sh`` where you can
write your own checker. You might also want to use the name checker
in ``example-name-ok.tcl`` as a replacement. This provides various
options but a typical use case would:

* Name excludes certain characters, e.g. ``:``.
* Name is composed of parts separated by ``-``
* Name must have 3 parts.
* Part 1 must match ``P[0-9]+`` or ...
* Part 2 must match line in the file ``components``
* Part 3 is free text

### TODO in order to be bigger than Ben Hur

1. Perhaps add an archive command to archive both the working
directory and FOSSIL archive away. 
1. Maybe add in some more templates from the real collection.
1. Add a searcher/index running across both the ONELINER and the
project README*
1. Add a per keyword view of the dataset, i.e. a directory that 
in turn symlinks to a subset of the data.
1. Finally develop this as a startup company version of TRIM which
is an outrageously complicated bit of work (TRIM i.e.)
1. Add in a glimpseindex (in the Makefile currently)



 
