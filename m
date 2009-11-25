From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH] OMAP: DMA: move LCD DMA related code from plat-omap to mach-omap1 (Re: [PATCH] OMAP1: PM: Fix omapfb/lcd on Amstrad Delta broken when PM set)
Date: Wed, 25 Nov 2009 23:57:08 +0100
Message-ID: <200911252357.10812.jkrzyszt@tis.icnet.pl>
References: <200910292339.48610.jkrzyszt@tis.icnet.pl> <alpine.DEB.2.00.0911230154230.26334@utopia.booyaka.com> <200911251454.49078.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:36806 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754184AbZKYW5b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 17:57:31 -0500
In-Reply-To: <200911251454.49078.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Wednesday 25 November 2009 14:54:47 Janusz Krzysztofik napisa=C5=82(a):
> Wednesday 25 November 2009 10:02:52 Paul Walmsley napisa=C5=82(a):
> > On Sat, 21 Nov 2009, Janusz Krzysztofik wrote:
> > >
> > > diff -uprN git.orig/arch/arm/mach-omap1/Makefile git/arch/arm/mac=
h-omap1/Makefile
> > > --- git.orig/arch/arm/mach-omap1/Makefile	2009-11-21 00:38:45.000=
000000 +0100
> > > +++ git/arch/arm/mach-omap1/Makefile	2009-11-21 01:27:12.00000000=
0 +0100
> > > @@ -3,7 +3,7 @@=20
> > >  #
> > >
> > >  # Common support
> > > -obj-y :=3D io.o id.o sram.o clock.o irq.o mux.o serial.o devices=
=2Eo
> > > +obj-y :=3D io.o id.o sram.o clock.o irq.o lcd_dma.o mux.o serial=
=2Eo devices.o
> >
> > It seems that this LCD DMA controller is not present on OMAPs prior=
 to
> > the 1510, given all the references in the LCD DMA code to 1510 and =
1610,
> > etc. It might be good to add a Kconfig option so OMAP730/850 users =
can
> > skip compiling it and save some memory.  The drivers that use these
> > routines can then include Kconfig dependencies on that option so it=
 is
> > automatically included when those drivers are built.
>
> OK, will prepare that for next iteration.

Paul,

It turned out not that simple. Since arch/arm/mach-omap1/lcd_dma.c expo=
rts
several functions that are called unconditionaly from
drivers/video/omap/lcdc.c AND the latter is linked into the omapfb driv=
er
based on CONFIG_ARCH_OMAP1=3Dy, linking in the former can't be limited =
to
selected OMAP1 subarchs unless at least drivers/video/omap/{Kconfig,Mak=
efile},
if not drivers/video/omap/lcdc.c itself either, are modified for that a=
s well.
Am I missing something?

If not, I can see two options:
1. Keep arch/arm/mach-omap1/lcd_dma.c linked in for any OMAP1 subarch u=
nless
CONFIG_FB_OMAP is not set. That can be cleaned up further after the=20
drivers/video/omap/* stuff is ever modified.
2. Include drivers/video/omap/* modifications into this series.

What do you suggest?

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
