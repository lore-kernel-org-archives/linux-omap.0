From: "Ishigami, Tatsuya" <ishigami@ti.com>
Subject: RE: How to build Kernel Modules
Date: Thu, 13 Jul 2006 21:08:14 -0500
Message-ID: <772F5D89C5E0734B8A86D85DFC6A202403FBCCB7@dlee03.ent.ti.com>
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
To: Richard Copeman <richard.copeman@lauterbach.co.uk>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Richard.C,

 Another interesting (and great) information
=20
 http://free-electrons.com/training/drivers

 Please note the way to develop kernel modules are very different
between 2.4.x and 2.6.x version. You might ensure you are
referring the one for you.

 Regards,
 Ishigami

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Woodruff, Richard
Sent: Friday, July 14, 2006 12:44 AM
To: Richard Copeman; linux-omap-open-source@linux.omap.com
Subject: RE: How to build Kernel Modules

http://examples.oreilly.com/linuxdrive3/



> -----Original Message-----
> From: Richard Copeman [mailto:richard.copeman@lauterbach.co.uk]
> Sent: Thursday, July 13, 2006 9:08 PM
> To: Woodruff, Richard; linux-omap-open-source@linux.omap.com
> Subject: RE: How to build Kernel Modules
>=20
> Hi Richard,
>=20
> Thanks. I just had a look and couldn't see the wood for the trees. Do
you
> have a link or something that I can put into their search engine that
will
> get me close?
>=20
> Thanks,
>=20
> Richard.
>=20
> -----Original Message-----
> From: Woodruff, Richard [mailto:r-woodruff2@ti.com]
> Sent: 13 July 2006 16:24
> To: Richard Copeman; linux-omap-open-source@linux.omap.com
> Subject: RE: How to build Kernel Modules
>=20
> Down load the Linux Device Drivers module examples.  It has a nice and
> easy to use dummy module.  You can find them on the O'Riley site.
>=20
> You can just compile and insmod .o like your trying.  There are a few
> more steps.
>=20
> Regards,
> Richard W.
>=20
> > -----Original Message-----
> > From: linux-omap-open-source-bounces@linux.omap.com
> [mailto:linux-omap-
> > open-source-bounces@linux.omap.com] On Behalf Of Richard Copeman
> > Sent: Thursday, July 13, 2006 8:30 PM
> > To: linux-omap-open-source@linux.omap.com
> > Subject: How to build Kernel Modules
> >
> > Hi,
> >
> > I don't know if this is the right place to ask...
> >
> > I have OMAP 5912OSK with a 2.6.15 kernel cross compiled from SUSE
9.2
> > using
> > GCC 3.4.1. That works and I am happy with it. I can build my own
tasks
> and
> > include them into my RAM disk image.
> >
> > The next challenge is to build a kernel module. I followed the
> guidelines
> > in
> > Peter Salzman's book/FAQ/tutorial and tried to adapt it for cross
> > compiling:
> >
> > Arm-linux-gcc -c hellomod.c -Wall
> >
> > This produced hellomod.o but when I tried to insmod it on my target
I
> got
> > an
> > error:
> >
> > / # ls
> > ascii       etc         lib         proc        sys         var
> > bin         hello       linuxrc     sbin        tmp
> > dev         hellomod.o  lost+found  sieve       usr
> > / # insmod ./hellomod.o
> > Using ./hellomod.o
> > No module found in object
> > insmod: cannot insert `./hellomod.o': Invalid module format (-1):
Exec
> > format error
> > / # _
> >
> > I suspect I haven't done something right in the build stage for my
KO.
> >
> > My source code is simple and looks like this:
> >
> > #define __KERNEL__
> > #define MODULE
> >
> > #include "/usr/local/arm/3.4.1/arm-linux/include/linux/module.h"
> > #include "/usr/local/arm/3.4.1/arm-linux/include/linux/kernel.h"
> >
> > #include "/usr/local/arm/3.4.1/arm-linux/include/linux/tty.h"
> >
> > int init_module()
> > {
> > 	console_print("Hello World from Rico\n");
> > 	return 0;
> > }
> >
> > void cleanup_module()
> > {
> > 	console_print("Goodbye from Rico!\n");
> > }
> >
> > Can somebody point me at an FAQ or how to for cross compiling Kernel
> > Modules
> > please?
> >
> > TIA,
> >
> > Richard.
> >
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
