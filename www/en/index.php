<?

//
// File     : index.php
// Version  : $Id: index.php,v 1.21 2003/05/05 17:20:14 landonf Exp $
// Location : /projects/darwinports/index.php
//

	include_once("$DOCUMENT_ROOT/includes/od_lib.inc.php");
	od_print_header("DarwinPorts", "en", "iso-8859-1", "", 0, "/projects/darwinports");
?>

<center>
<table border="0" width="500" cellspacing="0" cellpadding="3">
<tr><td>

<h2>Projects :: DarwinPorts</h2>

<p>
<i>Project Leads: </i>
<a href="mailto:landonf@opendarwin.org">Landon Fuller</a>, 
<a href="mailto:jkh@opendarwin.org">Jordan Hubbard</a>,
<a href="mailto:kevin@opendarwin.org">Kevin Van Vechten</a>
</p>

<p>
The DarwinPorts project aims to provide a large amount of software ports that make it easy to install freely available software on a Darwin system.  For more information, please read the <a href="http://www.opendarwin.org/projects/darwinports/en/faq.php">FAQ</a>.  For a tutorial on writing a Portfile, please read the <a href="http://www.opendarwin.org/projects/darwinports/en/portfileHOWTO.php">Portfile HOWTO</a>.
</p>
<p>
The <a href="http://darwinports.gene-hacker.net/docs/guide/">DarwinPorts User Guide</a> is an excellent reference on DarwinPorts syntax and concepts.  (Note it is a work in progress, so please feel free to make suggestions and report bugs in the doc component of the DarwinPorts <a href="http://www.opendarwin.org/bugzilla/">Bugzilla</a> product.)
</p>

<p><strong>Project Status</strong></p>

<p>
A number of ports are done and the system is reasonably usable as
a <i>BETA</i> for anyone who's interested.  
You can search a list of <a href="http://www.opendarwin.org/projects/darwinports/en/ports.php">available software</a> here.
</p>
<p>
A Cocoa-based GUI for DarwinPorts, <a href="http://www.opendarwin.org/cgi-bin/cvsweb.cgi/proj/darwinports/dports/sysutils/portmanager/">Ports Manager.app</a>, is available and under active development. <a href="http://www.opendarwin.org/~fkr/portsmanager.png">Screenshot.</a>
</p>
<p>
Bug reports and feature requests should be submitted to <a href="http://www.opendarwin.org/bugzilla/">Bugzilla</a>.
</p>

<p><strong>Getting the project from CVS</strong></p>

<p>
Use the following commands to get DarwinPorts from the OpenDarwin CVS server (required for Ports Manager.app):
</p>

<p>
<pre>
cvs -d :pserver:anonymous@anoncvs.opendarwin.org:/Volumes/src/cvs/od login
cvs -d :pserver:anonymous@anoncvs.opendarwin.org:/Volumes/src/cvs/od co -P darwinports
</pre>

<p>
Use the following commands to get Ports Manager.app from the OpenDarwin CVS server:
</p>

<p>
<pre>
cvs -d :pserver:anonymous@anoncvs.opendarwin.org:/Volumes/src/cvs/od login
cvs -d :pserver:anonymous@anoncvs.opendarwin.org:/Volumes/src/cvs/od co -P PortsManager
</pre>

When the server asks you for a password you can simply hit return; the password is empty.
The CVS repository can be browsed through <a href="http://www.opendarwin.org/cgi-bin/cvsweb.cgi/proj/darwinports/">CVSweb</a>.
</p>

<p>
In order to install and run DarwinPorts, the Mac OS X <a href="http://developer.apple.com/tools/">Developer Tools</a> must be installed.</p>

<p><strong>Project mailing lists and IRC channels</strong></p>

<p>The <a
href="http://www.opendarwin.org/mailman/listinfo/darwinports">darwinports
mailing list</a> is open to all and is where most architectural and
feature discussions are held.  Those wishing to see the cvs commit
logs which detail the change-by-change progress of the project can
also subscribe to the <a
href="http://www.opendarwin.org/mailman/listinfo/cvs-darwinports-all">cvs-darwinports-all</a>
mailing list.</p>

<p>For more real-time discussion, the #opendarwin channel on the <a
href="http://freenode.net/">open projects network</a> is generally
where we hang out.</p>

<p><strong>Joining the project </strong></p>

<p>
We are looking for people who would like to help to make this project a success. There are still many parts of the project that need work, including: documentation, making ports, maintaining ports and testing.
</p>

<p>
All contributions are very much welcomed! If you are interested, then either send an e-mail to one of the project leads asking what needs to be done or simply submit an application to join the project with <a href="/en/joinproject.php">this form</a>.  Thanks!
</p>

</td></tr>
</table>
</center>


<? 
	od_print_footer("en"); 
?>
