load ../machista.dylib

if {$argc < 1} {
	puts "Usage: $argv0 filename"
	exit 1
}
set h [machista::create_handle]

for {set i 0} {$i < $argc} {incr i} {
	puts [lindex $argv $i]
	set rlist [machista::parse_file $h [lindex $argv $i]]
	if {[lindex $rlist 0] == $machista::SUCCESS} {
		set r [lindex $rlist 1]
		set a [$r cget -mt_archs]
		while {$a != "NULL"} {
			puts "	Architecture: [$a cget -mat_arch]"
			puts "		         install name: [$a cget -mat_install_name]"
			puts "		      current version: [machista::format_dylib_version [$a cget -mat_version]]"
			puts "		compatibility version: [machista::format_dylib_version [$a cget -mat_comp_version]]"
	
			set l [$a cget -mat_loadcmds]
			while {$l != "NULL"} {
				puts "			[$l cget -mlt_install_name] (current version [machista::format_dylib_version [$l cget -mlt_version]], compatibility version [machista::format_dylib_version [$l cget -mlt_comp_version]])"
				set l [$l cget -next]
			}
	
			set a [$a cget -next]
		}
	} else {
		puts "An error occured: [machista::strerror [lindex $rlist 0]]"
	}
}
machista::destroy_handle $h

