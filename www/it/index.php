  <?php
    $DOCUMENT_ROOT = $_SERVER['DOCUMENT_ROOT'];
    include_once("$DOCUMENT_ROOT/it/includes/common.inc");
    include_once("$DOCUMENT_ROOT/it/includes/functions.inc");
    print_header('Home di DarwinPorts', 'utf-8');
  ?>

    <div id="content">
      <h2 class="hdr">Introduzione a DarwinPorts</h2>

      <p>L'obiettivo principale del progetto DarwinPorts è fornire un metodo
	per semplificare l'installazione di vario software open-source
	sui sistemi operativi della famiglia Darwin (
	<a href="http://www.opendarwin.org/"> OpenDarwin</a>,
	<a href="http://www.apple.com/macosx/">Mac OS X</a> e
	<a href="http://developer.apple.com/darwin/projects/darwin/">
	Darwin</a>).</p>

      <p>Attualmente sono disponibili circa 2500 <a href="/it/ports/">ports</a>
	funzionanti ed il numero è in costante crescita. Inscrivendoti alla
	mailing list
	<a href="http://www.opendarwin.org/mailman/listinfo/cvs-darwinports-all">
	cvs-darwinports-all</a> potrai tenere traccia dei ports recentemente
	aggiunti.</p>

      <p>Maggiori informazioni su come ottenere e su come installare
	DarwinPorts sono presenti alla sezione <a href="/it/getdp/">Ottenere
	DarwinPorts</a> di questo sito. Inoltre ti invitiamo a consultare la
	<a href="/docs/">documentazione</a> (attualmente disponibile solo in
	inglese). Per eventuali problemi puoi sempre <a href="/it/help/">
	richiedere aiuto</a>.</p>

      <p>Ti ricordiamo che tutte le segnalazioni di bug, le richieste di nuove
	funzionalità e di nuovi ports devono essere inviate tramite
	<a href="http://www.opendarwin.org/bugzilla/">Bugzilla</a>. Leggi
	il paragrafo <a href="docs/ch01s05.html#user_bugs">Bug reports</a>
	della documentazione per facilitare e migliorare il processo di un
	bug report.</p>

      <p>Il wiki di DarwinPorts è disponibile
	<a href="http://wiki.opendarwin.org/index.php/DarwinPorts">qui</a>.</p>

      <div id="news">
	<h2 class="hdr">Ultime notizie</h2>

	<?php
	  print_headlines();
	?>

		<p><a href="archives.php">Archivio delle notizie</a>.</p>
	
      </div>
    </div>
  </div>

<?php
  print_footer();
?>