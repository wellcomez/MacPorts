  <?php
    $DOCUMENT_ROOT = $_SERVER['DOCUMENT_ROOT'];
    include_once("$DOCUMENT_ROOT/includes/common.inc");
    /* include_once("$DOCUMENT_ROOT/includes/functions.inc"); */
    print_header('Get Help', 'iso-8859-1');
  ?>

	<div id="content">
		<h2 class="hdr">Get Help</h2>

		<p>If you get stuck while using DarwinPorts and have a problem you 
			can't figure out, we have a lot of resources to help you.</p>
	  
		<h5 class="subhdr">Documentation</h5>

		<p>The <a href="/docs/">DarwinPorts Guide</a> has a section for DarwinPorts users, 
		<a href="http://www.darwinports.org/docs/pt01.html">Part 1: Using DarwinPorts</a>.</p>

		<p>The <a href="http://wiki.opendarwin.org/index.php/DarwinPorts:FAQ">DarwinPorts FAQ</a>
		is now an ongoing, user driven effort part of our <a href="http://wiki.opendarwin.org/index.php/DarwinPorts">Wiki</a>,
		where anyone with a <a href="http://wiki.opendarwin.org/index.php?title=Special:Userlogin&returnto=DarwinPorts">Wiki account</a>
		and DarwinPorts knowledge can contribute with information to help others.</p>

		<p>All of our documentation is a work in progress, so if you spot 
			an error, or have a quesiton about some part of the document, 
			let us know!  This will help us </p>
	
		<h5 class="subhdr">Mailing Lists</h5>

		<p>The 	
			<a href="http://www.opendarwin.org/mailman/listinfo/darwinports">General DarwinPorts 
			mailing list</a> is open to all.  It is the best place to ask 
			questions about DarwinPorts, for new users, developers, 
			everyone alike!  It is also where all discussion about 
			DarwinPorts itself takes place.  Please note that due to spam problems,
			the DarwinPorts mailing list requires posts from 
			non-subscribers to be approved.  It may be better to susbcribe.</p>

		<p>Although not strictly a requirement, you may check the 
			<a href="http://www.opendarwin.org/pipermail/darwinports/">list archives</a>
			before posting a question. We try to be as helpful as possible, but
			if it's a common question our answers may be fairly short.</p>

		<p>Otherwise, indexed archives of this list are easily browsable at 
			<a href="http://gmane.org/">Gmane.org</a> as well as through 
			<a href="nntp://news.gmane.org/">NNTP</a>.</p>

		<p>When you post a question to the mailing list, please included 
			any information you think might be relevent to the problem, 
			such as what operating system and version you're using, Mac OS X 
			10.3.2 for example, whether you have any other third party 
			software installed, in /usr/local for instance, and any error 
			messages that DarwinPorts might give (use the -d and -v port(1)'s 
			flags to turn on debugging informations, it's a lot easier for 
			us to help you once these are used).</p>

		<h5 class="subhdr">IRC</h5>

		<p>For more real-time discussion, the #darwinports channel on the <a
			href="http://freenode.net/">Freenode IRC network</a> is generally
			where we hang out.</p>
	
		<p>Though it is generally helpful, please keep in mind that no one is
			obligated to help or even answer your question if you join the IRC
			channel.  Do not take it personally, simply ask your question
			on the <a href="http://www.opendarwin.org/mailman/listinfo/darwinports">mailing list</a>
			instead.</p>

	</div>
</div>

<?php
  print_footer();
?>
