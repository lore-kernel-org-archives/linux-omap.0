From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] [PATCH v2] OMAP: DMA: Fix omapfb/lcdc on Amstrad Delta
 broken when PM set
Date: Tue, 3 Nov 2009 12:10:48 -0800
Message-ID: <20091103201048.GP8981@atomide.com>
References: <200911032024.47741.jkrzyszt@tis.icnet.pl>
 <200911032104.33049.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63738 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbZKCUKu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 15:10:50 -0500
Content-Disposition: inline
In-Reply-To: <200911032104.33049.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091103 12:05]:
> Tuesday 03 November 2009 20:24:38 Janusz Krzysztofik napisa=C5=82(a):
> > If there are still no comments, especially on the bug possible impa=
ct on
> > other OMAP1510 boards (or even OMAP1610 with internal LCD controlle=
r), then
> > Tony, please apply it as is. Until it is accepted, I am stuck with =
new
> > ams_delta_defconfig.
>=20
> Tony,
> Sorry, I've not checked for new mail before posting this one and miss=
ed your=20
> acceptance for my idea of fixing all omap1510, not only ams_delta. If=
 there=20
> are no more comments, I'll submit v3 with cpu_is_omap1510() replacing=
=20
> machine_is_ams_delta().

Sounds good to me.

Tony
=20
> Thanks,
> Janusz
>=20
> > --- linux-2.6.32-rc5/arch/arm/plat-omap/dma.c.orig	2009-10-16
> > 02:41:50.000000000 +0200 +++
> > linux-2.6.32-rc5/arch/arm/plat-omap/dma.c	2009-11-03 20:15:35.00000=
0000
> > +0100 @@ -30,6 +30,7 @@
> >  #include <linux/irq.h>
> >  #include <linux/io.h>
> >
> > +#include <asm/mach-types.h>
> >  #include <asm/system.h>
> >  #include <mach/hardware.h>
> >  #include <mach/dma.h>
> > @@ -1110,6 +1111,14 @@ int omap_dma_running(void)
> >  {
> >  	int lch;
> >
> > +	/*
> > +	 * On Amstrad Delta, the OMAP internal LCD controller will start =
the
> > +	 * transfer when it gets enabled, so assume DMA running if LCD en=
abled.
> > +	 */
> > +	if (machine_is_ams_delta())
> > +		if (omap_readw(0xfffec000 + 0x00) & (1 << 0))
> > +			return 1;
> > +
> >  	/* Check if LCD DMA is running */
> >  	if (cpu_is_omap16xx())
> >  		if (omap_readw(OMAP1610_DMA_LCD_CCR) & OMAP_DMA_CCR_EN)
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
