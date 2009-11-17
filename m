From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4, for-next] OMAP: DMA: Use some define rather than a
 hexadecimal constant for LCD register
Date: Mon, 16 Nov 2009 17:24:35 -0800
Message-ID: <20091117012435.GA3684@atomide.com>
References: <20091116222517.GT3684@atomide.com>
 <200911170013.41260.jkrzyszt@tis.icnet.pl>
 <20091117001658.GZ3684@atomide.com>
 <200911170138.04915.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57815 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbZKQBYd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 20:24:33 -0500
Content-Disposition: inline
In-Reply-To: <200911170138.04915.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091116 16:38]:
> Tuesday 17 November 2009 01:16:58 Tony Lindgren napisa=C5=82(a):
> > * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091116 15:13]:
> > > The patch corrects the issue introduced with my previous patch:
> > >         "OMAP: DMA: Fix omapfb/lcdc on OMAP1510 broken when PM se=
t"
> > > as pointed out by OMAP subsystem maintainer.
> > >
> > > Created and tested against linux-omap for-next,
> > > commit 155a75d9725e66e5ec8a383822957dee52427057
> > >
> > > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> > >
> > > ---
> > >
> > > Monday 16 November 2009 23:25:18 Tony Lindgren wrote:
> > > > Oops, looks like this needs one more update. This breaks buildi=
ng
> > > > for mach-omap2 machines:
> > > >
> > > > arch/arm/plat-omap/dma.c: In function 'omap_dma_running':
> > > > arch/arm/plat-omap/dma.c:1132: error: 'OMAP_LCDC_CONTROL' undec=
lared
> > > > (first use in this function) arch/arm/plat-omap/dma.c:1132: err=
or:
> > > > (Each undeclared identifier is reported only once
> > > > arch/arm/plat-omap/dma.c:1132: error: for each function it appe=
ars in.)
> > > > arch/arm/plat-omap/dma.c:1132: error: 'OMAP_LCDC_CTRL_LCD_EN'
> > > > undeclared (first use in this function)
> > > >
> > > > So removing from omap for-next.
> > >
> > > This time, compile tested with omap_generic_2420_defconfig as wel=
l.
> > > Once again, sorry for that noise :(.
> > >
> > > Thanks,
> > > Janusz
> > >
> > > diff -uprN a/arch/arm/mach-omap1/include/mach/lcdc.h
> > > b/arch/arm/mach-omap1/include/mach/lcdc.h ---
> > > a/arch/arm/mach-omap1/include/mach/lcdc.h	1970-01-01 01:00:00.000=
000000
> > > +0100 +++ b/arch/arm/mach-omap1/include/mach/lcdc.h	2009-11-16
> > > 21:13:33.000000000 +0100 @@ -0,0 +1,59 @@
> > > +/*
> > > + * Heder file for OMAP1 internal LCD controller
> > > + *
> > > + * Extracted from drivers/video/omap/lcdc.c
> > > + *
> > > + * Copyright (C) 2004 Nokia Corporation
> > > + * Author: Imre Deak <imre.deak@nokia.com>
> > > + *
> > > + * This program is free software; you can redistribute it and/or=
 modify
> > > it + * under the terms of the GNU General Public License as publi=
shed by
> > > the + * Free Software Foundation; either version 2 of the License=
, or (at
> > > your + * option) any later version.
> > > + *
> > > + * This program is distributed in the hope that it will be usefu=
l, but
> > > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=
 GNU
> > > + * General Public License for more details.
> > > + *
> > > + * You should have received a copy of the GNU General Public Lic=
ense
> > > along + * with this program; if not, write to the Free Software
> > > Foundation, Inc., + * 59 Temple Place - Suite 330, Boston, MA=20
> > > 02111-1307, USA.
> > > + */
> > > +
> > > +#ifndef __ARCH_OMAP_LCDC_H__
> > > +#define __ARCH_OMAP_LCDC_H__
> > > +
> > > +#define OMAP_LCDC_BASE			0xfffec000
> > > +#define OMAP_LCDC_SIZE			256
> > > +#define OMAP_LCDC_IRQ			INT_LCD_CTRL
> > > +
> > > +#define OMAP_LCDC_CONTROL		(OMAP_LCDC_BASE + 0x00)
> > > +#define OMAP_LCDC_TIMING0		(OMAP_LCDC_BASE + 0x04)
> > > +#define OMAP_LCDC_TIMING1		(OMAP_LCDC_BASE + 0x08)
> > > +#define OMAP_LCDC_TIMING2		(OMAP_LCDC_BASE + 0x0c)
> > > +#define OMAP_LCDC_STATUS		(OMAP_LCDC_BASE + 0x10)
> > > +#define OMAP_LCDC_SUBPANEL		(OMAP_LCDC_BASE + 0x14)
> > > +#define OMAP_LCDC_LINE_INT		(OMAP_LCDC_BASE + 0x18)
> > > +#define OMAP_LCDC_DISPLAY_STATUS	(OMAP_LCDC_BASE + 0x1c)
> > > +
> > > +#define OMAP_LCDC_STAT_DONE		(1 << 0)
> > > +#define OMAP_LCDC_STAT_VSYNC		(1 << 1)
> > > +#define OMAP_LCDC_STAT_SYNC_LOST	(1 << 2)
> > > +#define OMAP_LCDC_STAT_ABC		(1 << 3)
> > > +#define OMAP_LCDC_STAT_LINE_INT		(1 << 4)
> > > +#define OMAP_LCDC_STAT_FUF		(1 << 5)
> > > +#define OMAP_LCDC_STAT_LOADED_PALETTE	(1 << 6)
> > > +
> > > +#define OMAP_LCDC_CTRL_LCD_EN		(1 << 0)
> > > +#define OMAP_LCDC_CTRL_LCD_TFT		(1 << 7)
> > > +#define OMAP_LCDC_CTRL_LINE_IRQ_CLR_SEL	(1 << 10)
> > > +
> > > +#define OMAP_LCDC_IRQ_VSYNC		(1 << 2)
> > > +#define OMAP_LCDC_IRQ_DONE		(1 << 3)
> > > +#define OMAP_LCDC_IRQ_LOADED_PALETTE	(1 << 4)
> > > +#define OMAP_LCDC_IRQ_LINE_NIRQ		(1 << 5)
> > > +#define OMAP_LCDC_IRQ_LINE		(1 << 6)
> > > +#define OMAP_LCDC_IRQ_MASK		(((1 << 5) - 1) << 2)
> > > +
> > > +#endif
> > > diff -uprN a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> > > --- a/arch/arm/plat-omap/dma.c	2009-11-14 23:48:41.000000000 +010=
0
> > > +++ b/arch/arm/plat-omap/dma.c	2009-11-16 23:49:30.000000000 +010=
0
> > > @@ -36,6 +36,10 @@
> > >
> > >  #include <plat/tc.h>
> > >
> > > +#ifdef CONFIG_ARCH_OMAP1
> > > +#include <mach/lcdc.h>
> > > +#endif
> > > +
> > >  #undef DEBUG
> > >
> > >  #ifndef CONFIG_ARCH_OMAP1
> > > @@ -1124,9 +1128,11 @@ int omap_dma_running(void)
> > >  	 * On OMAP1510, internal LCD controller will start the transfer
> > >  	 * when it gets enabled, so assume DMA running if LCD enabled.
> > >  	 */
> > > +#ifdef CONFIG_ARCH_OMAP1
> > >  	if (cpu_is_omap1510())
> > > -		if (omap_readw(0xfffec000 + 0x00) & (1 << 0))
> > > +		if (omap_readw(OMAP_LCDC_CONTROL) & OMAP_LCDC_CTRL_LCD_EN)
> > >  			return 1;
> > > +#endif
> > >
> > >  	/* Check if LCD DMA is running */
> > >  	if (cpu_is_omap16xx())
> >
> > Hmm, this is getting complicated... How about just add function to
> > drivers/video/omap/lcdc.c for something like omap_lcdc_get_status()
> > or similar?
>=20
> Good idea.
>=20
> > Then you can define that function in some header as:
> >
> > #if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_FB_OMAP)
> > extern int omap_lcdc_get_status(void);
> > #else
> > static inline int omap_lcdc_get_status(void)
> > {
> > 	return -ENODEV;
> > }
> > #endif
> >
> > That way the defines can stay where they are and you don't need the
> > ugly ifdefs.
>=20
> Sorry if my question seems stupid, but assuming the function can be a=
s simple=20
> as:
>=20
> int omap_lcdc_get_status(void)
> {
> 	return omap_readw(OMAP_LCDC_CONTROL) & OMAP_LCDC_CTRL_LCD_EN;
> }
>=20
> could't it be defined as static inline too and put inside lcdc.h?

Sure, but then you need to move the defines again, no?

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
