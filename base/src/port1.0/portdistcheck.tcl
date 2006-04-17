# et:ts=4
# portdistcheck.tcl
#
# $Id: portdistcheck.tcl,v 1.1 2006/04/17 21:49:19 pguyot Exp $
#
# Copyright (c) 2005-2006 Paul Guyot <pguyot@kallisys.net>,
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. Neither the name of Apple Computer, Inc. nor the names of its
#    contributors may be used to endorse or promote products derived from
#    this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

package provide portdistcheck 1.0
package require portutil 1.0
package require portfetch 1.0

set com.apple.distcheck [target_new com.apple.distcheck distcheck_main]
target_runtype ${com.apple.distcheck} always
target_state ${com.apple.distcheck} no
target_provides ${com.apple.distcheck} distcheck
target_requires ${com.apple.distcheck} main

# define options
options distcheck.check

# defaults
default distcheck.check moddate

proc distcheck_main {args} {
	global distcheck.check
	global fetch.type
	global portname portpath
	
	set port_moddate [file mtime ${portpath}/Portfile]

	ui_debug "Portfile modification date is [clock format $port_moddate]"

	# Check the distfiles if it's a regular fetch phase.
	if {"${distcheck.check}" != "none"
		&& "${fetch.type}" == "standard"} {
		# portfetch 1.0::checkfiles sets fetch_urls list.
		global fetch_urls
		checkfiles
		
		# Check all the files.
		foreach {url_var distfile} $fetch_urls {
			global portfetch::$url_var
			if {![info exists $url_var]} {
				ui_error [format [msgcat::mc "No defined site for tag: %s, using master_sites"] $url_var]
				set url_var master_sites
				global portfetch::$url_var
			}
			if {${distcheck.check} == "moddate"} {
				set count 0
				foreach site [set $url_var] {
					ui_debug [format [msgcat::mc "Checking %s from %s"] $distfile $site]
					set file_url [portfetch::assemble_url $site $distfile]
					if {[catch {set urlnewer [curl isnewer $file_url $port_moddate]} error]} {
						ui_warn "couldn't fetch $file_url for $portname ($error)"
					} else {
						if {$urlnewer} {
							ui_warn "port $portname: $file_url is newer than portfile"
						}
						incr count
					}
				}
				if {$count == 0} {
					ui_error "no mirror had $distfile for $portname"
				}
			} else {
				ui_error "unknown distcheck.check ${distcheck.check}"
				break
			}
		}
	}
}
