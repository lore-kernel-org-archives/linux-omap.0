From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH] OMAP: DMA: move LCD DMA related code from plat-omap to mach-omap1 (Re: [PATCH] OMAP1: PM: Fix omapfb/lcd on Amstrad Delta broken when PM set)
Date: Wed, 25 Nov 2009 14:54:47 +0100
Message-ID: <200911251454.49078.jkrzyszt@tis.icnet.pl>
References: <200910292339.48610.jkrzyszt@tis.icnet.pl> <200911211658.31404.jkrzyszt@tis.icnet.pl> <alpine.DEB.2.00.0911230154230.26334@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:53262 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933562AbZKYNyx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 08:54:53 -0500
In-Reply-To: <alpine.DEB.2.00.0911230154230.26334@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Wednesday 25 November 2009 10:02:52 Paul Walmsley napisa=C5=82(a):
> Hello Janusz,
>
> On Sat, 21 Nov 2009, Janusz Krzysztofik wrote:
> > (probably less interested persons and lists dropped)
> >
> > Tuesday 10 November 2009 11:50:52 Paul Walmsley wrote:
> > > ...  All of the LCD DMA code in plat-omap/dma.c appears to be
> > > OMAP1-only (and apparently only is available on a subset of OMAP1
> > > chips). It would be great if this code could be moved to
> > > mach-omap1/lcd_dma.c or a similar place.
> >
> > The patch just tries to implement this idea.
> >
> > Created against linux-omap for-next,
> > commit 2963c21fab52bfa8227da7f22864db393ebbc858
> >
> > Tested on OMAP1510 Amstrad Delta.
> > Compile tested using omap_generic_2420_defconfig.
> >
> > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> >
> > ---
> > Hi Paul,
> >
> > I hope the patch meets your suggestion closely enough.
>
> Thanks, just scanned it quickly and it looks carefully done.  Two
> suggestions below, both minor:

Paul,
Thanks for your review time.

Since I started with just duplicating files and then removing unnecessa=
ry
sections, I wondered how I could split that work into several subsequen=
t
patches so it is more easy to verify how those chunks put into a new fi=
le
differ from those extracted from the old one, but didn't find a good so=
lution
yet.=20

> > diff -uprN git.orig/arch/arm/mach-omap1/Makefile git/arch/arm/mach-=
omap1/Makefile
> > --- git.orig/arch/arm/mach-omap1/Makefile	2009-11-21 00:38:45.00000=
0000 +0100
> > +++ git/arch/arm/mach-omap1/Makefile	2009-11-21 01:27:12.000000000 =
+0100
> > @@ -3,7 +3,7 @@
> >  #
> >
> >  # Common support
> > -obj-y :=3D io.o id.o sram.o clock.o irq.o mux.o serial.o devices.o
> > +obj-y :=3D io.o id.o sram.o clock.o irq.o lcd_dma.o mux.o serial.o=
 devices.o
>
> It seems that this LCD DMA controller is not present on OMAPs prior t=
o the
> 1510, given all the references in the LCD DMA code to 1510 and 1610, =
etc.
> It might be good to add a Kconfig option so OMAP730/850 users can ski=
p
> compiling it and save some memory.  The drivers that use these routin=
es
> can then include Kconfig dependencies on that option so it is
> automatically included when those drivers are built.

OK, will prepare that for next iteration.

> > diff -uprN git.orig/arch/arm/mach-omap1/include/mach/lcd_dma.h git/=
arch/arm/mach-omap1/include/mach/lcd_dma.h
> > --- git.orig/arch/arm/mach-omap1/include/mach/lcd_dma.h	1970-01-01 =
01:00:00.000000000 +0100
> > +++ git/arch/arm/mach-omap1/include/mach/lcd_dma.h	2009-11-21 03:22=
:25.000000000 +0100
> > @@ -0,0 +1,78 @@=20
[snip]
> > +#ifndef __MACH_LCD_DMA_H__
>
> Consider adding _OMAP1_ in this macro name.  I doubt that name collis=
ions
> here will be a serious issue, but adding a few extra bytes here might
> avoid some bug-hunting frustration in the long run...

OK, will do that too.

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
