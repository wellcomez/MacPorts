QUE ES EL SISTEMA DARWIN PORTS?

	DarwinPorts es una infraestructura de software de compilacion, instalacion y empaquetado
disenada para cumplir con los mismos requisitos de funcionalidad de la arquitectura FreeBSD ports,
manteniendo al mismo tiempo extensibilidad para futuras mejoras.

	Actualmente DarwinPorts compila y corre en MacOS X 10.2 (Darwin 6.0) y en MacOS X 10.3.
El sistema es portable, escrito en TCL con un set limitado de extensiones en C de TCL.

	La guia de usuario de DarwinPorts ("DarwinPorts User Guide") esta disponible en:
		http://www.opendarwin.org/projects/darwinports/guide/

	Para documentacion mas profunda acerca de los procesos internos de la arquitectura del sistema
DarwinPorts, refierase a base/doc/INTERNALS.

	Por favor note que DarwinPorts esta dividido en dos partes. Primero la "infraestructura de
DarwinPorts", que vive en el subdirectorio base/ y es el unico componente necesario del sistema, y
el directorio "dports/" que contiene las descripciones del software portado. Este ultimo es opcional
y puede ser obtenido bien sea por demanda a traves de internet, o usado a traves de una copia local.
Vea la documentacion en /etc/ports/sources.conf mas abajo.

INSTALACION

	Para instrucciones especificas a una plataforma en particular, lea base/doc/README.platforms.

	Pasos para la Instalacion:

		1. cd base/
		   ./configure
			Entrar al directorio base/ y correr el script de configuracion. Opcionalmente,
			parametros pueden ser pasados al script (ver mas abajo).

		2. make
			Correr 'make' para compilar el software necesario.

		3. sudo make install
			Correr 'sudo make install' para instalar DarwinPorts en su sistema.

		4. [opcional] editar /etc/ports/ports.conf
			El documento de configuracion /etc/ports/ports.conf define varias opciones de
			configuracion para la infraestructura de DarwinPorts. Si desea cambiar el prefijo
			de instalacion o la locacion donde diversos grupos de data especificos al software
			portado son almacenados, modifique los siguientes settings:

			portdbpath - Especifica el camino donde almacenar data especifica al software portdo
			prefix - Especifica el directorio en donde instalar el software portado.

		5. [opcional] editar /etc/ports/sources.conf
			El documento /etc/ports/sources.conf muestra la locacion tanto de la copia local
			como remota de la jerarquia del software portado. Si el argumento --with-dports-dir=DIR
			no fue especificado al script ./configure, el directorio dports/ por defecto
			(darwinports/dports, la copia desde donde instala) sera anadida a sources.conf

	Todo el codigo y TCL necesario seran compilados e instalados a continuacion:
		[Mac OS X 10.2] /System/Library/Tcl/darwinports1.0
		[Mac OS X 10.3] /Library/Tcl/darwinports1.0
		[FreeBSD] /usr/local/lib/tcl8.3/darwinports1.0
		    - libreria TCL de interfaz con el sistema DarwinPorts

		PREFIX es fijado a /opt/local pero puede ser modificado entrando al
		directorio base/ y corriendo ./configure manualmente con el argumento
		--prefix

		$PREFIX/bin/port
		    - Utilidad de la linea de comando para compilacion del software portado
		$PREFIX/share/darwinports/
		    - Librerias TCL internas a DarwinPorts

		Los siguientes documentos son provistos para personalizacion del sistema:

		/etc/ports/ports.conf
		    - Settings de DarwinPorts personalizables por el usuario
		/etc/ports/sources.conf
		    - Lista de fuentes de DarwinPorts (lugares donde conseguir data del software portado)


USANDO EL COMANDO PORT

	Si todavia no lo ha hecho, agregue /opt/local/bin a su $PATH (o $PREFIX/bin si ha
escogido instalar DarwinPorts en algun otro lugar).

	Si no esta seguro como, y esta usando Jaguar (OS X 10.2), agrague la siguiente linea
a su documento de configuracion ~/.cshrc. (Esto tambien se aplica si esta usando tcsh en
Panther)

		set path=($path /opt/local/bin)

	Si esta usando Panther (OS X 10.3), agrague la siguiente linea a su documento de configuracion
~/.profile. ( Esto tambien se aplica si esta usando un shell bourne en Jaguar)

		export PATH=$PATH:/opt/local/bin

	Los cambios no tomaran efecto hasta que haya abierto otro shell.

	El siguiente comando compilara e instalara un porte:

		port install <nombre-de-porte>

	Para encontrar un porte en especifico, intente usar "port search":

		port search vi

	Por favor refierase al manual de port(1) para una documentacion completa del comando
port.

	Tambien es posible hacer operaciones, como compilar o bajar, para todos los portes
en el sistema usando el comando "portall". Toma escencialmente los mismos argumentos que el
comando "port" pero opera iterativamente en cada porte en dports/. Cuando se corre "make clean"
desde este directorio, por ejemplo, "port clean" tambien es invocado para limpiar todo completamente.


CREANDO PORTES NUEVOS

	Portes consisten de un directorio conteniendo tanto un Portfile como documentos asociados.
Actualmente los unicos documentos incluidos son parches, y estos probablemente seran mantenidos
a un minimo.

	Un Portfile consiste de un TCL valido, evaluado por un interpretador de TCL inicializado
por el sistema DarwinPorts. Los Portfiles usan una sintaxis de par parametro/valor extremadamente
directa, permitiendo al mismo tiempo al autor usar a completitud la funcionalidad de TCL de ser
necesario.

	Para comenzar, refierase a base/doc/exampleport y al manual portfile(7).

