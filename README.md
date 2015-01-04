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
1. ``PROJECTS`` - various shell scripts supporting the show.
1. ``Makefile`` - finally a make file to drive it.

Then to build a project:

````
% make new
Project name: swiss-knife
Possible Templates: talk reportiee paper gnuprog
Template: talk
% cd swiss-knife
```

And ``make rm`` removes projects and archives.

### TODO in order to be bigger than Ben Hur

1. Perhaps add an archive command to archive both the working
directory and FOSSIL archive away. 
1. Perhaps a one liner summary so they its easy to find the battery
energy storage talk from Alaska.Maybe use ``ptx``.
1. Maybe add in some more templates from the real collection.
1. Add a project naming convention checker
1. Add a searcher/index running across both the oneliner and the
project README*
1. Add a per keyword view of the dataset, i.e. a directory that 
in turn symlinks to a subset of the data.
1. Finally develop this as a startup company version of TRIM which
is an outrageously complicated bit of work.



 
