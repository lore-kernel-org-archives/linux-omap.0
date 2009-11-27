From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC] [PATCH] OMAP: DMA: move LCD DMA related code from plat-omap
 to mach-omap1 (Re: [PATCH] OMAP1: PM: Fix omapfb/lcd on Amstrad Delta broken
 when PM set)
Date: Fri, 27 Nov 2009 00:01:24 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911270000020.984@utopia.booyaka.com>
References: <200910292339.48610.jkrzyszt@tis.icnet.pl> <200911252357.10812.jkrzyszt@tis.icnet.pl> <alpine.DEB.2.00.0911251905590.19371@utopia.booyaka.com> <200911261530.45612.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1017755281-1259305284=:984"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56263 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbZK0HBT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Nov 2009 02:01:19 -0500
In-Reply-To: <200911261530.45612.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1017755281-1259305284=:984
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 26 Nov 2009, Janusz Krzysztofik wrote:

> Thursday 26 November 2009 03:08:30 Paul Walmsley napisa=C5=82(a):
> > On Wed, 25 Nov 2009, Janusz Krzysztofik wrote:
> > > It turned out not that simple. Since arch/arm/mach-omap1/lcd_dma.c
> > > exports several functions that are called unconditionaly from
> > > drivers/video/omap/lcdc.c AND the latter is linked into the omapfb
> > > driver based on CONFIG_ARCH_OMAP1=3Dy, linking in the former can't be
> > > limited to selected OMAP1 subarchs unless at least
> > > drivers/video/omap/{Kconfig,Makefile}, if not drivers/video/omap/lcdc=
=2Ec
> > > itself either, are modified for that as well. Am I missing something?
> > >
> > > If not, I can see two options:
> > > 1. Keep arch/arm/mach-omap1/lcd_dma.c linked in for any OMAP1 subarch
> > > unless CONFIG_FB_OMAP is not set. That can be cleaned up further afte=
r
> > > the drivers/video/omap/* stuff is ever modified.
> > > 2. Include drivers/video/omap/* modifications into this series.
> > >
> > > What do you suggest?
> >
> > Let's take option 1 for right now.  Maybe one of the htcwizard people
> > might take that project up after the LCD DMA split is merged.
>=20
> I probably missed a third option: conditionally replacing declarations of=
=20
> those functions required by lcdc.c with coresponding fake static inline=
=20
> definitions inside an #ifdef block in lcd_dma.h. What do you think?

Just took a quick look at that lcdc.c file; I think we'd better leave=20
those functions in, since they are so tightly integrated to the code.=20
Hopefully one of the OMAP730/750/850 people can tease them out, since=20
they've got a platform to test on.  Sound reasonable?  Less work for us,=20
anyway :-)

- Paul
--155748971-1017755281-1259305284=:984--
