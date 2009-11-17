From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v4, for-next] OMAP: DMA: Use some define rather than a hexadecimal constant for LCD register
Date: Tue, 17 Nov 2009 11:45:53 +0100
Message-ID: <200911171145.55658.jkrzyszt@tis.icnet.pl>
References: <20091116222517.GT3684@atomide.com> <200911170138.04915.jkrzyszt@tis.icnet.pl> <20091117012435.GA3684@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:54971 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226AbZKQKqV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 05:46:21 -0500
In-Reply-To: <20091117012435.GA3684@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Tuesday 17 November 2009 02:24:35 Tony Lindgren napisa=C5=82(a):
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091116 16:38]:
> > Tuesday 17 November 2009 01:16:58 Tony Lindgren napisa=C5=82(a):
> > > * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091116 15:13]:
> > > > diff -uprN a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.=
c
> > > > --- a/arch/arm/plat-omap/dma.c	2009-11-14 23:48:41.000000000 +0=
100
> > > > +++ b/arch/arm/plat-omap/dma.c	2009-11-16 23:49:30.000000000 +0=
100
> > > > @@ -36,6 +36,10 @@
> > > >
> > > >  #include <plat/tc.h>
> > > >
> > > > +#ifdef CONFIG_ARCH_OMAP1
> > > > +#include <mach/lcdc.h>
> > > > +#endif
> > > > +
> > > >  #undef DEBUG
> > > >
> > > >  #ifndef CONFIG_ARCH_OMAP1
> > > > @@ -1124,9 +1128,11 @@ int omap_dma_running(void)
> > > >  	 * On OMAP1510, internal LCD controller will start the transf=
er
> > > >  	 * when it gets enabled, so assume DMA running if LCD enabled=
=2E
> > > >  	 */
> > > > +#ifdef CONFIG_ARCH_OMAP1
> > > >  	if (cpu_is_omap1510())
> > > > -		if (omap_readw(0xfffec000 + 0x00) & (1 << 0))
> > > > +		if (omap_readw(OMAP_LCDC_CONTROL) & OMAP_LCDC_CTRL_LCD_EN)
> > > >  			return 1;
> > > > +#endif
> > > >
> > > >  	/* Check if LCD DMA is running */
> > > >  	if (cpu_is_omap16xx())
> > >
> > > Hmm, this is getting complicated... How about just add function t=
o
> > > drivers/video/omap/lcdc.c for something like omap_lcdc_get_status=
()
> > > or similar?
> >
> > Good idea.

=2E.. for a function itself, but not for putting it there, since omapfb=
, that=20
lcdc is a part of, can be build as a module :).

> > > Then you can define that function in some header as:
> > >
> > > #if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_FB_OMAP)
> > > extern int omap_lcdc_get_status(void);
> > > #else
> > > static inline int omap_lcdc_get_status(void)
> > > {
> > > 	return -ENODEV;
> > > }
> > > #endif
> > >
> > > That way the defines can stay where they are and you don't need t=
he
> > > ugly ifdefs.
> >
> > Sorry if my question seems stupid, but assuming the function can be=
 as
> > simple as:
> >
> > int omap_lcdc_get_status(void)
> > {
> > 	return omap_readw(OMAP_LCDC_CONTROL) & OMAP_LCDC_CTRL_LCD_EN;
> > }
> >
> > could't it be defined as static inline too and put inside lcdc.h?
>
> Sure, but then you need to move the defines again, no?

I can see 3 options:

1. While keeping those hex constants as they are for now, solve the iss=
ue=20
during refactoring arch/arm/plat-omap/dma.c for a separate=20
arch/arm/mach-omap1/lcd_dma.c, as Paul suggested (may take some time). =
Since=20
the register test would be put there, some headers will have to be move=
d out=20
of drivers/video/omap/lcdc.c anyway.

2. Temporarily apply v2 of the patch. It compiles cleanly since defines=
 are=20
put into <plat/omapfb.h> that exists for all OMAP classes. Then, clean =
up=20
things while doing #1. I'm not sure if that temporary solution could re=
sult=20
in one more conflict with DSS2.

3. Based on v4 and your suggestion for a function, work out an intermed=
iate=20
solution as soon as possible. I would appreciate any further suggestion=
s on=20
how that could be arranged.

If there are no better options, please suggest which of those three you=
 would=20
like me to take.

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
