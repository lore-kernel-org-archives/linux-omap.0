From: "M Letti" <m.letti@gmx.net>
Subject: gdbserver hangs on target
Date: Fri, 6 Jan 2006 22:16:21 +0100
Message-ID: <200601062116.k06LGSUM013218@frio.ext.ti.com>
References: <200601061347.k06Dl0JP006201@brazos.ext.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200601061347.k06Dl0JP006201@brazos.ext.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'OMAP' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Dear Sirs,

finally I managed to crosscompile my gdb and gdbserver. Though it would
still be interesting how to patch the according file (see mail below), =
it
works now with the newer gdb version 6.4.

Now that I would like to debug a simple hello world on my target, I
experience the problem, that gdbserver hangs on executing (on the host, =
I
get the error message "Ignoring packet error, continuing...")

Is there any hint you can give me?

Below my tasks to start debugging:

----------------------- target: OSK 5912 ------------------------------

> gdbserver hostip:port helloworld_arm

# following output appears:
Process helloworld_arm created; pid=3D49
Listening on port 6666
=20
# After having connected via gdb on the host, this output appears:
Remote debugging from host 192.168.0.4

# After executing run, this appears:
Killing inferior
GDBserver restarting
Process helloworld_arm created; pid=3D50

# from now on, it just hangs


--------------------- host: fedora linux ------------------------------

> arm-linux-gdb helloworld_arm
# note, that I compiled the program with debug-option:
# arm-linux-gcc -g -o helloworld_arm helloworld.c

gdb starts...
> (gdb) target extended-remote targetip:port
Remote debugging using 192.168.0.6:6666
...
> (gdb) run
The program being debugged has been started already.
Start it from the beginning? (y or n) y
Starting program: ./helloworld_arm

# after a while, following appears:
Ignoring packet error, continuing...
Ignoring packet error, continuing...
Ignoring packet error, continuing...

# from now on, it just hangs

-----------------------------------------------------------------------

Therefore, on the host I get the errors "Ignoring packet error,
continuing..." - the network connection is okay, since the server =
responds
to my debug request.

Do you have any ideas what's wrong?

Maybe I should add, that after copying gdbserver on my target, it was =
not
able to start due to lack of a library called "libthread_db.so.1". I =
have
copied it from the host (from the same toolchain with which I compiled =
gdb)
to the target in the lib-directory, and then it worked.
Maybe it has something to do with this aspect. Otherwise I have no clue =
:-(



Any help is appreciated very much,
Thanks in advance,

Letti


-----Urspr=FCngliche Nachricht-----
Von: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] Im Auftrag von M
Letti
Gesendet: Freitag, 06. J=E4nner 2006 14:47
An: 'Vineet Tuli'; 'OMAP'
Betreff: AW: where to find cross-compiled versions of gdbserver?

Dear Vineet,

thank you for your assistance. I think it can help me.

I just experience one problem: your friend mentioned, that the file
"/usr/src/debug/gdb-6.3/sim/arm/iwmmxt.c" has to be patched for =
successful
compilation of gdb.

My question:
- where do I get the patched file?
- once obtained, do I just need to replace this single file?


Thanks again,
Letti


-----Urspr=FCngliche Nachricht-----
Von: Vineet Tuli [mailto:vineet@cybernetra.com]=20
Gesendet: Freitag, 30. Dezember 2005 05:02
An: OMAP
Cc: M Letti
Betreff: Re: where to find cross-compiled versions of gdbserver?

Dear M Letti,

One of my friend, Meenakshi prepared the following howto for cross
compiling GDB for ARM. I am enclosing the same.

Thanks

Vineet

*************************************************************************=
***
*******************
Howto build gdb for ARM

NOTE: The following compilation was done on Fedora Core 4 Linux.

Download the gdb pakage from the following site:

ftp://ftp.gnu.org/gnu/gdb	wget -c
ftp://ftp.gnu.org/gnu/gdb/gdb-6.3.tar.bz2

Place the downloaded file in /usr/src directory of your system.

Under /usr/src, create a debug directory and extract the gdb package in =
this
(/usr/src/debug) directory.=20

[root@localhost]# cd /usr/src/debug
[root@localhost]# tar jxf ../gdb-6.3.tar.bz2

Build gdb debugger

The debugger must be built into directories separate from the source. =
Thus,
create a directory for gdb within the /usr/src/debug directory.

[root@localhost]# mkdir /usr/src/debug/build_gdb

NOTE: The following file of source code of gdb-6.3 needs to be patched =
for
successful compilation of gdb:

	/usr/src/debug/gdb-6.3/sim/arm/iwmmxt.c=20

Chose the prefix for the new debugger. This is a directory where the =
binary
and other debugger files resides. This application report uses =
/opt/gdebug
for the new debugger. The directory is created by the installation of =
the
tools. Go to the /usr/src/debug/gdb-6.3 directory to configure and then
build the binary and other debugger files with the commands shown below.

[root@localhost]# cd /usr/src/debug/build_gdb
[root@localhost]# ../gdb-6.3/configure --target=3Darm-linux
--prefix=3D/opt/gdebug
[root@localhost]# make
[root@localhost]# make install

The binary generated resides in /opt/gdebug and is fairly large. This is =
why
the gdb binary can't be used as-is on the target and the gdbserver is =
used
instead.

Build gdb server

The gdb server wasn't built earlier because it has to be cross-compiled =
for
the target using the appropriate tools. To do so, create a directory to
build the gdb server, move to it and build the gdb server:

[root@localhost]# mkdir /usr/src/debug/build_gdbserver
[root@localhost]# cd /usr/src/debug/build_gdbserver
[root@localhost]# export PATH=3D/opt/arm/3.4.1/bin:$PATH
[root@localhost]# CC=3Darm-linux-gcc ../gdb-6.3/gdb/gdbserver/configure
--host=3Darm-linux --prefix=3D/opt/gdebug/arm-linux
[root@localhost]# make
[root@localhost]# make install

The gdb server binary, 'gdbserver', has now been installed in your
/opt/gdebug/arm-linux/bin directory.

Once built, copy gdbserver to the target's root file system.

On Thu, 2005-12-29 at 21:00 +0100, M Letti wrote:
> Dear Sirs,
>=20
> =20
>=20
> I use the precompiled toolchain (version 3.3.2) on my OSK5912, which =
is
> available from http://linux.omap.com/pub/toolchain/ .
>=20
> So far so good, I can use the arm-linux-gcc command to compile my own
> programs for my target.
>=20
> =20
>=20
> But now that I want to debug these apps remotely, I'm looking for the
> cross-compiled versions of gdb and gdbserver (that is, arm-linux-gdb =
and
> arm-linux-gdbserver.and wonder, if they shouldn't be included in the
> toolchain I downloaded already? I just can't find them.(they are not =
in
the
> 3.3.2/bin directory where for example the arm-linux-gcc resides)
>=20
> =20
>=20
> Could anyone please point me out where they normally would be located, =
or
if
> I have to cross-compile them on my own (in fact, I have already tried =
this
> step, but got mass of errors when executing "make").
>=20
> =20
>=20
>=20
>=20
> By the way, I would like to ask you if you by chance can recommend any
> graphical development and debugging tools for my target (besides DDD &
co)?
> Are there for example any special Eclipse plugins I could use, or =
should I
> use normal Eclipse environment and just set the remote debugging
> configuration appropriately to develop for my target?
>=20
> =20
>=20
>=20
>=20
> Thank you very much in advance,
>=20
> =20
>=20
> Michael
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source



_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
