# et:ts=4
# portlint.tcl
# $Id: portlint.tcl $

package provide portlint 1.0
package require portutil 1.0

set org.macports.lint [target_new org.macports.lint lint_main]
target_runtype ${org.macports.lint} always
target_provides ${org.macports.lint} lint
target_requires ${org.macports.lint} main
target_prerun ${org.macports.lint} lint_start

set_ui_prefix

set lint_required [list \
	"name" \
	"version" \
	"description" \
	"long_description" \
	"categories" \
	"maintainers" \
	"platforms" \
	"homepage" \
	"master_sites" \
	"checksums" \
	]

set lint_optional [list \
	"epoch" \
	"revision" \
	"worksrcdir" \
	"distname" \
	"use_automake" \
	"use_autoconf" \
	"use_configure" \
	]


proc seems_utf8 {str} {
    set len [string length $str]
    for {set i 0} {$i<$len} {incr i} {
        set c [scan [string index $str $i] %c]
        if {$c < 0x80} {
            # ASCII
            continue
        } elseif {($c & 0xE0) == 0xC0} {
            set n 1
        } elseif {($c & 0xF0) == 0xE0} {
            set n 2
        } elseif {($c & 0xF8) == 0xF0} {
            set n 3
        } elseif {($c & 0xFC) == 0xF8} {
            set n 4
        } elseif {($c & 0xFE) == 0xFC} {
            set n 5
        } else {
            return false
        }
        for {set j 0} {$j<$n} {incr j} {
            incr i
            if {$i == $len} {
                return false
            } elseif {([scan [string index $str $i] %c] & 0xC0) != 0x80} {
                return false
            }
        }
    }
    return true
}


proc lint_start {args} {
    global UI_PREFIX portname
    ui_msg "$UI_PREFIX [format [msgcat::mc "Verifying Portfile for %s"] ${portname}]"
}

proc lint_main {args} {
	global UI_PREFIX portname portpath
	set portfile ${portpath}/Portfile

	set warnings 0
	set errors 0

    ###################################################################
    ui_debug "$portfile"

    set require_blank false
    set require_after ""
    set seen_portsystem false
    set seen_portgroup false
    set in_description false

    set f [open $portfile RDONLY]
    # read binary (to check UTF-8)
    fconfigure $f -encoding binary
    set lineno 1
    while {1} {
        set line [gets $f]
        if {[eof $f]} {
            close $f
            break
        }
        ui_debug "$lineno: $line"

        if {![seems_utf8 $line]} {
            ui_error "Line $lineno seems to contain an invalid UTF-8 sequence"
            incr errors
        }

        if {[string equal "PortSystem" $require_after] && \
            [string match "PortGroup*" $line]} {
            set require_blank false
        }

        if {$require_blank && ($line != "")} {
            ui_warn "Line $lineno should be a newline (after $require_after)"
            incr warnings
        }
        set require_blank false

        if {[string match "* " $line] || [string match "*\t" $line]} {
            ui_warn "Line $lineno has trailing whitespace before newline"
            incr warnings
        }

        if {($lineno == 1) && ![string match "*\$Id*" $line]} {
            ui_warn "Line 1 is missing RCS tag (\$Id)"
            incr warnings
        } elseif {($lineno == 1)} {
            ui_info "OK: Line 1 has RCS tag (\$Id)"
            set require_blank true
            set require_after "RCS tag"
        }

        if {[string match "PortSystem*" $line]} {
            if ($seen_portsystem) {
                 ui_error "Line $lineno repeats PortSystem information"
                 incr errors
            }
            ### TODO: check version
            set seen_portsystem true
            set require_blank true
            set require_after "PortSystem"
        }
        if {[string match "PortGroup*" $line]} {
            if ($seen_portgroup) {
                 ui_error "Line $lineno repeats PortGroup information"
                 incr errors
            }
            ### TODO: check group
            set seen_portgroup true
            set require_blank true
            set require_after "PortGroup"
        }

        # TODO: check for repeated variable definitions
        # TODO: check the definition order of variables
        # TODO: check length of description against max

        if {[string match "long_description*" $line]} {
            set in_description true
        }
        if {$in_description && ([string range $line end end] != "\\")} {
            set in_description false
            #set require_blank true
            #set require_after "long_description"
        } elseif {$in_description} {
            set require_blank false
        }

        ### TODO: more checks to Portfile syntax

        incr lineno
    }

    ###################################################################

    global os.platform os.arch os.version
    global portversion portrevision portepoch
    # hoping for "noarch" :
    set portarch ${os.arch}
    global description long_description categories maintainers platforms homepage master_sites checksums
    
    global lint_required lint_optional

    if (!$seen_portsystem) {
        ui_error "Didn't find PortSystem specification"
        incr errors
    }  else {
        ui_info "OK: Found PortSystem specification"
    }
    if ($seen_portgroup) {
        ui_info "OK: Found PortGroup specification"
    }

    foreach req_var $lint_required {
        if {$req_var == "name"} {
            set var "portname"
        } elseif {$req_var == "version"} {
            set var "portversion"
        } else {
            set var $req_var
        }
       if {![info exists $var]} {
            ui_error "Missing required variable: $req_var"
            incr errors
        } else {
            ui_info "OK: Found required variable: $req_var"
        }
    }

    # TODO: check platforms against known names
    # TODO: check categories against known ones

    foreach opt_var $lint_optional {
       if {$opt_var == "epoch"} {
            set var "portepoch"
        } elseif {$opt_var == "revision"} {
            set var "portrevision"
        } else {
            set var $opt_var
       }
       if {[info exists $var]} {
            # TODO: check whether it was seen (or default)
            ui_info "OK: Found optional variable: $opt_var"
       }
    }

    # TODO: check that ports revision is numeric
    # TODO: check that any port epoch is numeric

    if {[string match "*darwinports@opendarwin.org*" $maintainers]} {
        ui_warn "Using legacy email for no/open maintainer"
        incr warnings
    }

    ### TODO: more checks to Tcl variables/sections

    ui_debug "Name: $portname"
    ui_debug "Epoch: $portepoch"
    ui_debug "Version: $portversion"
    ui_debug "Revision: $portrevision"
    ui_debug "Arch: $portarch"
    ###################################################################

	ui_msg "$UI_PREFIX [format [msgcat::mc "%d errors and %d warnings found."] $errors $warnings]"

	return {$errors > 0}
}
