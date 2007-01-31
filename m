From: "zhangshigeng" <zsg@dislab.nju.edu.cn>
Subject: how to partition a flash in linux 2.6-18 kernel
Date: Wed, 31 Jan 2007 21:30:25 +0800
Message-ID: <200701311239.l0VCcxPW030465@dislab.nju.edu.cn>
References: <20070130180002.CDA1D80664@linux.omap.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070130180002.CDA1D80664@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi, everybody. We are now trying to port a 2.6-18 linux kernel to an
omap_5912-based board, and we want to partition the flash on it. But it
seems this should be different from partition a flash in a 2.6-10 =
kernel. In
2.6-10 kernel we just have to modify the /drivers/mtd/maps/omap-nor.c to
give the partition information, but it doesn't work in the 2.6-18 =
kernel.
Which file should I modify to partition the flash?
Thanks!

-----Original Message-----
From: =
linux-omap-open-source-bounces+zsg=3Ddislab.nju.edu.cn@linux.omap.com
[mailto:linux-omap-open-source-bounces+zsg=3Ddislab.nju.edu.cn@linux.omap=
.com]
On Behalf Of linux-omap-open-source-request@linux.omap.com
Sent: 2007=C4=EA1=D4=C231=C8=D5 2:00
To: linux-omap-open-source@linux.omap.com
Subject: Linux-omap-open-source Digest, Vol 33, Issue 55

Send Linux-omap-open-source mailing list submissions to
	linux-omap-open-source@linux.omap.com

To subscribe or unsubscribe via the World Wide Web, visit
	http://linux.omap.com/mailman/listinfo/linux-omap-open-source
or, via email, send a message with subject or body 'help' to
	linux-omap-open-source-request@linux.omap.com

You can reach the person managing the list at
	linux-omap-open-source-owner@linux.omap.com

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Linux-omap-open-source digest..."


Today's Topics:

   1. RE: Noise causes gpio interrupt  (Arnold) (Saint-Etienne, Eric)
   2. RE: Problem in linking with montavista toolchain for omap2420
      (Indraneel)
   3. Re: Problem in linking with montavista toolchain for omap2420
      (andrzej zaborowski)


----------------------------------------------------------------------

Message: 1
Date: Tue, 30 Jan 2007 09:29:38 +0100
From: "Saint-Etienne, Eric" <e-saint-etienne@ti.com>
Subject: RE: Noise causes gpio interrupt  (Arnold)
To: <linux-omap-open-source@linux.omap.com>
Message-ID:
	<0AB0CB5257FF3C43A27E201CC8AADA8602E4B1AC@dnce02.ent.ti.com>
Content-Type: text/plain;	charset=3D"us-ascii"


> I am working on omap5912 and I am using linux 2.6.17.
> I am using a gpio to handle interrupts. I believe that
> I am having a noise interrupt which my firmware thinks
> is a really interrupt. Is there a way to distinguish a
> noise interrupt from a real interrupt?

It looks like you have a floating input. On omap2 it's possible to
enable a pull-down on the pad. This is done using System Control Module
(see TRM).
There may be an equivalent on omap5912.

~eric


------------------------------

Message: 2
Date: Tue, 30 Jan 2007 16:55:49 +0530
From: Indraneel <indraneel.m@samsung.com>
Subject: RE: Problem in linking with montavista toolchain for omap2420
To: Madhava Gauranga <Madhava.Gauranga@ittiam.com>
Cc: Linux-omap-open-source@linux.omap.com
Message-ID: <1170156349.4387.20.camel@localhost.localdomain>
Content-Type: text/plain

Hello Madhava,

On Tue, 2007-01-30 at 11:46 +0530, Madhava Gauranga wrote:
> Hey indranil,
>=20
> I reckon u have copied the toolchain already installed somewhere,
> instead of installing them. try installing(perhaps from the cd(s)
> provided) the toolchain.


It shouldn't be a case of missing libs as i am able to build and run the
kernel from the same. I played around with the linker options

LDFLAGS=3D -nostdlib -L/opt/montavista/devkit/arm/v5t_le/target/usr/lib
-L/opt/montavista/devkit/arm/v5t_le/lib/gcc-lib/armv5tl-hardhat-linux/3.3=
.1
-L/opt/montavista/devkit/arm/v5t_le/armv5tl-hardhat-linux/lib

With this i am past the previous error and the new error is

/opt/montavista/devkit/arm/v5t_le/lib/gcc-lib/armv5tl-hardhat-linux/3.3.1=
/..
/../../../armv5tl-hardhat-linux/bin/ld: warning: cannot find entry =
symbol
_start; defaulting to 00008074
/tmp/cc0VA6xr.o(.text+0x8): In function `main':
: undefined reference to `puts'
collect2: ld returned 1 exit status

I guess it's something to do with path but i'm not sure what exactly.

The code i'm trying to build is

#include<stdio.h>
int main (void)
{
printf("Hello World - arm linux\n");
return 0;
}


Regards,
Indraneel

>  The problem should be fixed then.
>=20
> Respect,
> Madhava Gauranga
> =20
>=20
> Ittiam Systems | www.ittiam.com
> A Red Herring Asia 100 Company, 2005
> Forward Concepts' Worlds Most Preferred DSP IP Supplier, 2004, 2005
>=20
> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
> Indraneel
> Sent: Sunday, January 28, 2007 5:23 PM
> To: Linux-omap-open-source@linux.omap.com
> Subject: Problem in linking with montavista toolchain for omap2420
>=20
> Hi,
> I'm trying to cross-compile a program using the montavista tool chain
> for arm_v5t_le architecture for the omap2420(h4 board). I get the
> following error when linking a simple c program:
>=20
> $ arm_v5t_le-gcc -DPOSIX -DMD=3D2 rz.c
> =
/opt/montavista/devkit/arm/v5t_le/lib/gcc-lib/armv5tl-hardhat-linux/3.3.
> 1/../../../../armv5tl-hardhat-linux/bin/ld: cannot find libc.so.6
> collect2: ld returned 1 exit status
>=20
>=20
> Surprisingly i couldn't find any file or link by the name libc.so.6 in
> the toolchain, although there was
> /opt/montavista/devkit/arm/v5t_le/target/usr/lib/libc.so
>=20
> Other info
> gcc
> version 3.3.1 (MontaVista 3.3.1-7.0.15.0500230 2005-02-20)
> --with-sysroot=3D/opt/montavista/devkit/arm/v5t_le/target
>=20
> GNU ld
> version 2.14 20030612 (MontaVista 2.14-11.0.7.0500230 2005-02-20)
>=20
> PATH=3D/opt/montavista/devkit/arm/v5t_le/bin:$PATH
>=20
>=20
> I have searched for the error but couldn't find anything definitive.
>=20
> Can anyone provide any clues as to what is wrong and how can i solve
> this linking issue?
>=20
> Any pointers will be appreciated.
>=20
> Regards,
> Indraneel
>=20
>=20
>=20
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20
> **********************************************************************
> This email and any files transmitted with it are confidential and
> intended solely for the use of the individual or entity to whom they
> are addressed. If you have received this email in error please notify
> helpdesk@ittiam.com.
> **********************************************************************
>=20
>=20
>=20



------------------------------

Message: 3
Date: Tue, 30 Jan 2007 15:55:25 +0100
From: "andrzej zaborowski" <balrog@zabor.org>
Subject: Re: Problem in linking with montavista toolchain for omap2420
To: Indraneel <indraneel.m@samsung.com>
Cc: Madhava Gauranga <Madhava.Gauranga@ittiam.com>,
	Linux-omap-open-source@linux.omap.com
Message-ID:
	<fb249edb0701300655t50b86cc0g1cf00284a62bf44f@mail.gmail.com>
Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed

Hi,

On 30/01/07, Indraneel <indraneel.m@samsung.com> wrote:
> LDFLAGS=3D -nostdlib =
-L/opt/montavista/devkit/arm/v5t_le/target/usr/lib
> =
-L/opt/montavista/devkit/arm/v5t_le/lib/gcc-lib/armv5tl-hardhat-linux/3.3=
.
1 -L/opt/montavista/devkit/arm/v5t_le/armv5tl-hardhat-linux/lib
>
> With this i am past the previous error and the new error is
>
>
/opt/montavista/devkit/arm/v5t_le/lib/gcc-lib/armv5tl-hardhat-linux/3.3.1=
/..
/../../../armv5tl-hardhat-linux/bin/ld: warning: cannot find entry =
symbol
_start; defaulting to 00008074
> /tmp/cc0VA6xr.o(.text+0x8): In function `main':
> : undefined reference to `puts'
> collect2: ld returned 1 exit status
>
> I guess it's something to do with path but i'm not sure what exactly.

These function (puts, _start) are part of the C library, which you
disabled by passing -nostdlib so it's understandable that the linker
is not finding them.

Personally I'd just try a different toolchain. Tools like "scratchbox"
or "crosstool" or Gentoo's "crossdev"  make it particularly easy to
compile a working toolchain. You can also build it using only bare
gcc, binutils and glibc/uclibc sources.

If you have libc.so but not libc.so.6 try symlinking libc.so.6 ->
libc.so (not guarranted to work but may help, maybe someone forgot to
pack the link).

Regards,
Andrew


------------------------------

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source


End of Linux-omap-open-source Digest, Vol 33, Issue 55
******************************************************
