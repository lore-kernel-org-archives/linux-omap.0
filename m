From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v4, for-next] OMAP: DMA: Use some define rather than a hexadecimal constant for LCD register
Date: Tue, 17 Nov 2009 12:50:34 +0100
Message-ID: <200911171250.36333.jkrzyszt@tis.icnet.pl>
References: <20091116222517.GT3684@atomide.com> <20091117012435.GA3684@atomide.com> <200911171145.55658.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:50892 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754116AbZKQLvC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 06:51:02 -0500
In-Reply-To: <200911171145.55658.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Tuesday 17 November 2009 11:45:53 Janusz Krzysztofik napisa=C5=82(a):
> Tuesday 17 November 2009 02:24:35 Tony Lindgren napisa=C5=82(a):
> > * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091116 16:38]:
> > > Tuesday 17 November 2009 01:16:58 Tony Lindgren napisa=C5=82(a):
> > > > * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091116 15:13]:
> > > > > diff -uprN a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dm=
a.c
> > > > > --- a/arch/arm/plat-omap/dma.c	2009-11-14 23:48:41.000000000 =
+0100
> > > > > +++ b/arch/arm/plat-omap/dma.c	2009-11-16 23:49:30.000000000 =
+0100
> > > > > @@ -36,6 +36,10 @@
> > > > >
> > > > >  #include <plat/tc.h>
> > > > >
> > > > > +#ifdef CONFIG_ARCH_OMAP1
> > > > > +#include <mach/lcdc.h>
> > > > > +#endif
> > > > > +
> > > > >  #undef DEBUG
> > > > >
> > > > >  #ifndef CONFIG_ARCH_OMAP1
> > > > > @@ -1124,9 +1128,11 @@ int omap_dma_running(void)
> > > > >  	 * On OMAP1510, internal LCD controller will start the tran=
sfer
> > > > >  	 * when it gets enabled, so assume DMA running if LCD enabl=
ed.
> > > > >  	 */
> > > > > +#ifdef CONFIG_ARCH_OMAP1
> > > > >  	if (cpu_is_omap1510())
> > > > > -		if (omap_readw(0xfffec000 + 0x00) & (1 << 0))
> > > > > +		if (omap_readw(OMAP_LCDC_CONTROL) & OMAP_LCDC_CTRL_LCD_EN)
> > > > >  			return 1;
> > > > > +#endif
> > > > >
> > > > >  	/* Check if LCD DMA is running */
> > > > >  	if (cpu_is_omap16xx())
> > > >
> > > > Hmm, this is getting complicated... How about just add function=
 to
> > > > drivers/video/omap/lcdc.c for something like omap_lcdc_get_stat=
us()
> > > > or similar?
> > >
> > > Good idea.
>
> ... for a function itself, but not for putting it there, since omapfb=
, that
> lcdc is a part of, can be build as a module :).

Hmm, looks like building omapfb as a module is broken (Kconfig/Makefile=
 allow=20
for this), at least for OMAP1. Anyway, I don't like the idea of putting=
=20
something that depends on drivers into arch (even if it happened to be =
one of=20
my initial concepts).

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
