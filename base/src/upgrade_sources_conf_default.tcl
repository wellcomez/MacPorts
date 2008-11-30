#!/usr/bin/tclsh
#
# $Id$
#
# Upgrade sources.conf for a given prefix (passed as the first and only
# argument).
#
# For an rsync: repository, if it is the standard MacPorts one and not
# already tagged, then make it default, if another wasn't already default.
# For a file:// respository, if it is an svn checkout from the MacPorts
# server, then make it default if another hasn't already been tagged.
#

if {[llength $::argv] == 0} {
   puts "Usage: ${::argv0} <prefix>"
   exit 1
}

set prefix [lindex $::argv 0]
set sourcesConf ${prefix}/etc/macports/sources.conf
if {[catch {set sourcesConfChannel [open $sourcesConf r]}]} {
   exit 0
}


proc append_default_tag_to_line {line} {
   if {[regexp {^(.* )\[(.*)\](.*)$} $line -> line_begin current_tag line_end]} {
      return "${line_begin}\[${current_tag},default\]${line_end}"
   } else {
      return "${line} \[default\]"
   }
}


set mktempChannel [open "|/usr/bin/mktemp -t macports_sources_upgrade" r]
set tempfile [read -nonewline $mktempChannel]
close $mktempChannel

set tempfileChannel [open $tempfile w]
set defaultSeen false
set defaultWritten false

while {[gets $sourcesConfChannel line] >= 0} {
   if {!$defaultSeen && ![regexp {^\s*#|^$} $line]} {
      if {[string first {[default]} $line] >= 0} {
         set defaultSeen true
      } elseif {[regexp {^\s*rsync://rsync\.macports\.org/release/ports/} $line]} {
         set line [append_default_tag_to_line $line]
         set defaultSeen true
         set defaultWritten true
      } elseif {[regexp {^\s*file://(/[^ #]+)} $line -> filepath]} {
         if {[file exists [file join ${filepath} .svn]]} {
            set svnChannel [open "|svn info ${filepath}" r]
            set svnURL {}
            while {[gets $svnChannel svnLine] >= 0} {
               regexp {^URL: (.*)} $svnLine -> svnURL
            }
            close $svnChannel
            if {[regexp {^https?://svn\.macports\.org/repository/macports/trunk/dports} $svnURL]} {
               set line [append_default_tag_to_line $line]
               set defaultSeen true
               set defaultWritten true
            }
         }
      }
   }
   puts $tempfileChannel $line
}
close $tempfileChannel
close $sourcesConfChannel

if {$defaultWritten} {
   set attributes [file attributes ${sourcesConf}]
   if {[catch {file rename ${sourcesConf} "${sourcesConf}.mpsaved"}]} {
      file rename -force ${sourcesConf} "${sourcesConf}.mpsaved_[clock seconds]"
   }
   file rename ${tempfile} ${sourcesConf}
   eval file attributes ${sourcesConf} $attributes
}
exit 0

