#et:ts=4
# $Id: perl5-1.0.tcl,v 1.4 2004/04/08 09:13:34 toby Exp $
#
# perl5-1.0.tcl
# 
# Group file for 'perl5' group.
#
# Copyright (c) 2002 - 2004 Apple Computer, Inc.
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
#

# Set some variables.
set perl5.bin ${prefix}/bin/perl

proc perl5.extract_config {var {default ""}} {
	global perl5.bin

	if {[catch {set val [lindex [split [exec ${perl5.bin} -V:${var}] {'}] 1]}]} {
		set val ${default}
	}

	return $val
}

set perl5.version [perl5.extract_config version]
set perl5.arch [perl5.extract_config archname ${os.platform}]

# define installation libraries as vendor location
set perl5.lib ${prefix}/lib/perl5/vendor_perl/${perl5.version}
set perl5.archlib ${perl5.lib}/${perl5.arch}

# define these empty initially, they are set by perl5.setup arguments
set perl5.module ""
set perl5.cpandir ""

# perl5 group setup procedure
proc perl5.setup {module vers {cpandir ""}} {
	global perl5.bin perl5.lib perl5.module perl5.cpandir

	# define perl5.module
	set perl5.module ${module}

	# define perl5.cpandir
	# check if optional CPAN dir specified to perl5.setup
	if {[string length ${cpandir}] == 0} {
		# if not, default to the first word (before a dash) from the
		# module name, this is the normal convention on CPAN
		set perl5.cpandir [lindex [split ${perl5.module} {-}] 0]
	} else {
		# else, use what was passed
		set perl5.cpandir ${cpandir}
	}

	name                p5-[string tolower ${perl5.module}]
	version             ${vers}
	categories          perl
	homepage            http://search.cpan.org/dist/${perl5.module}/

	master_sites        perl_cpan:${perl5.cpandir}
	distname            ${perl5.module}-${vers}
	dist_subdir         perl5

	depends_build       path:${perl5.bin}:perl5.8

	configure.cmd       ${perl5.bin}
	configure.pre_args  Makefile.PL
	configure.args      INSTALLDIRS=vendor

	test.run            yes

	destroot.target     pure_install

	post-destroot {
		foreach packlist [exec find ${destroot}${perl5.lib} -name .packlist] {
			ui_info "Fixing packlist ${packlist}"
			reinplace "s|${destroot}||" ${packlist}
		}
	}
}
