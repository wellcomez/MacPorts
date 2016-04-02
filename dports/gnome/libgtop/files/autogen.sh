#!/bin/sh
# Run this to generate all the initial makefiles, etc.

srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.

PKG_NAME="Gnome Top Library"

(test -f $srcdir/configure.ac \
  && test -f $srcdir/copyright.txt \
  && test -d $srcdir/sysdeps) || {
    echo -n "**Error**: Directory "\`$srcdir\'" does not look like the"
    echo " top-level gnome directory"
    exit 1
}

which gnome-autogen.sh || {
    echo "You need to install gnome-common from the GNOME CVS"
    exit 1
}
REQUIRED_AUTOMAKE_VERSION=1.9
. gnome-autogen.sh
