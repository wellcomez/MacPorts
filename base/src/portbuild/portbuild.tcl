#!/usr/bin/tclsh
# portbuild.tcl
#
# Copyright (c) 2002 Apple Computer, Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. Neither the name of Apple Computer, Inc. nor the names of its contributors
#    may be used to endorse or promote products derived from this software
#    without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

package require darwinports

# globals
set portdir .

# Standard procedures
proc print_usage args {
    global argv0
    puts "Usage: $argv0 \[target\] \[-d portdir\] \[options\]"
}

proc fatal args {
    global argv0
    puts stderr "$argv0: $args"
    exit
}

# Main
set target "build"
for {set i 0} {$i < $argc} {incr i} {
	switch -regexp -- [lindex $argv $i] {
		{^-d$} {
			incr i
			set portdir [lindex $argv $i]
		}
		{^[A-Za-z0-9_\.]+=.+$} {
			if {[regexp {([A-Za-z0-9_\.]+)=(.+)} [lindex $argv $i] match key val] == 1} {
				lappend options [lindex $argv $i]
			}
		}
		{^[A-Za-z0-9]+$} {
			set target [lindex $argv $i]
		}
		default { print_usage; exit }
	}
}
dportinit
if [info exists options] {
    set workername [dportopen $portdir $options]
} else {
    set workername [dportopen $portdir]
}
set result [dportbuild $workername $target]
dportclose $workername
return $result
