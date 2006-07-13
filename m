From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: How to build Kernel Modules
Date: Thu, 13 Jul 2006 10:24:24 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A506945C52@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Richard Copeman <richard.copeman@lauterbach.co.uk>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Down load the Linux Device Drivers module examples.  It has a nice and
easy to use dummy module.  You can find them on the O'Riley site.

You can just compile and insmod .o like your trying.  There are a few
more steps.

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Richard Copeman
> Sent: Thursday, July 13, 2006 8:30 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: How to build Kernel Modules
>=20
> Hi,
>=20
> I don't know if this is the right place to ask...
>=20
> I have OMAP 5912OSK with a 2.6.15 kernel cross compiled from SUSE 9.2
> using
> GCC 3.4.1. That works and I am happy with it. I can build my own tasks
and
> include them into my RAM disk image.
>=20
> The next challenge is to build a kernel module. I followed the
guidelines
> in
> Peter Salzman's book/FAQ/tutorial and tried to adapt it for cross
> compiling:
>=20
> Arm-linux-gcc -c hellomod.c -Wall
>=20
> This produced hellomod.o but when I tried to insmod it on my target I
got
> an
> error:
>=20
> / # ls
> ascii       etc         lib         proc        sys         var
> bin         hello       linuxrc     sbin        tmp
> dev         hellomod.o  lost+found  sieve       usr
> / # insmod ./hellomod.o
> Using ./hellomod.o
> No module found in object
> insmod: cannot insert `./hellomod.o': Invalid module format (-1): Exec
> format error
> / # _
>=20
> I suspect I haven't done something right in the build stage for my KO.
>=20
> My source code is simple and looks like this:
>=20
> #define __KERNEL__
> #define MODULE
>=20
> #include "/usr/local/arm/3.4.1/arm-linux/include/linux/module.h"
> #include "/usr/local/arm/3.4.1/arm-linux/include/linux/kernel.h"
>=20
> #include "/usr/local/arm/3.4.1/arm-linux/include/linux/tty.h"
>=20
> int init_module()
> {
> 	console_print("Hello World from Rico\n");
> 	return 0;
> }
>=20
> void cleanup_module()
> {
> 	console_print("Goodbye from Rico!\n");
> }
>=20
> Can somebody point me at an FAQ or how to for cross compiling Kernel
> Modules
> please?
>=20
> TIA,
>=20
> Richard.
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
