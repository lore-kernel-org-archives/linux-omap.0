From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH] OMAP: DMA: move LCD DMA related code from plat-omap to mach-omap1 (Re: [PATCH] OMAP1: PM: Fix omapfb/lcd on Amstrad Delta broken when PM set)
Date: Thu, 26 Nov 2009 15:30:43 +0100
Message-ID: <200911261530.45612.jkrzyszt@tis.icnet.pl>
References: <200910292339.48610.jkrzyszt@tis.icnet.pl> <200911252357.10812.jkrzyszt@tis.icnet.pl> <alpine.DEB.2.00.0911251905590.19371@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:49826 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754872AbZKZOa5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 09:30:57 -0500
In-Reply-To: <alpine.DEB.2.00.0911251905590.19371@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thursday 26 November 2009 03:08:30 Paul Walmsley napisa=C5=82(a):
> On Wed, 25 Nov 2009, Janusz Krzysztofik wrote:
> > It turned out not that simple. Since arch/arm/mach-omap1/lcd_dma.c
> > exports several functions that are called unconditionaly from
> > drivers/video/omap/lcdc.c AND the latter is linked into the omapfb
> > driver based on CONFIG_ARCH_OMAP1=3Dy, linking in the former can't =
be
> > limited to selected OMAP1 subarchs unless at least
> > drivers/video/omap/{Kconfig,Makefile}, if not drivers/video/omap/lc=
dc.c
> > itself either, are modified for that as well. Am I missing somethin=
g?
> >
> > If not, I can see two options:
> > 1. Keep arch/arm/mach-omap1/lcd_dma.c linked in for any OMAP1 subar=
ch
> > unless CONFIG_FB_OMAP is not set. That can be cleaned up further af=
ter
> > the drivers/video/omap/* stuff is ever modified.
> > 2. Include drivers/video/omap/* modifications into this series.
> >
> > What do you suggest?
>
> Let's take option 1 for right now.  Maybe one of the htcwizard people
> might take that project up after the LCD DMA split is merged.

Paul,

I probably missed a third option: conditionally replacing declarations =
of=20
those functions required by lcdc.c with coresponding fake static inline=
=20
definitions inside an #ifdef block in lcd_dma.h. What do you think?

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
