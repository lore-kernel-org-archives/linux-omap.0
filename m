From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4, for-next] OMAP: DMA: Use some define rather than a
 hexadecimal constant for LCD register
Date: Tue, 17 Nov 2009 08:10:58 -0800
Message-ID: <20091117161058.GA29266@atomide.com>
References: <20091116222517.GT3684@atomide.com>
 <200911170138.04915.jkrzyszt@tis.icnet.pl>
 <20091117012435.GA3684@atomide.com>
 <200911171145.55658.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58251 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbZKQQK4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 11:10:56 -0500
Content-Disposition: inline
In-Reply-To: <200911171145.55658.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091117 02:45]:
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
>=20
> ... for a function itself, but not for putting it there, since omapfb=
, that=20
> lcdc is a part of, can be build as a module :).
>=20
> > > > Then you can define that function in some header as:
> > > >
> > > > #if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_FB_OMAP)
> > > > extern int omap_lcdc_get_status(void);
> > > > #else
> > > > static inline int omap_lcdc_get_status(void)
> > > > {
> > > > 	return -ENODEV;
> > > > }
> > > > #endif
> > > >
> > > > That way the defines can stay where they are and you don't need=
 the
> > > > ugly ifdefs.
> > >
> > > Sorry if my question seems stupid, but assuming the function can =
be as
> > > simple as:
> > >
> > > int omap_lcdc_get_status(void)
> > > {
> > > 	return omap_readw(OMAP_LCDC_CONTROL) & OMAP_LCDC_CTRL_LCD_EN;
> > > }
> > >
> > > could't it be defined as static inline too and put inside lcdc.h?
> >
> > Sure, but then you need to move the defines again, no?
>=20
> I can see 3 options:
>=20
> 1. While keeping those hex constants as they are for now, solve the i=
ssue=20
> during refactoring arch/arm/plat-omap/dma.c for a separate=20
> arch/arm/mach-omap1/lcd_dma.c, as Paul suggested (may take some time)=
=2E Since=20
> the register test would be put there, some headers will have to be mo=
ved out=20
> of drivers/video/omap/lcdc.c anyway.

This sounds like the best way to go to me.
=20
> 2. Temporarily apply v2 of the patch. It compiles cleanly since defin=
es are=20
> put into <plat/omapfb.h> that exists for all OMAP classes. Then, clea=
n up=20
> things while doing #1. I'm not sure if that temporary solution could =
result=20
> in one more conflict with DSS2.

Yeah let's rather do the real fix at #1 above :)
=20
> 3. Based on v4 and your suggestion for a function, work out an interm=
ediate=20
> solution as soon as possible. I would appreciate any further suggesti=
ons on=20
> how that could be arranged.
>=20
> If there are no better options, please suggest which of those three y=
ou would=20
> like me to take.

I think #1 above is the way to go.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
