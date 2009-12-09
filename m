From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] OMAP: use physmap-flash
Date: Wed, 9 Dec 2009 08:26:01 -0800
Message-ID: <20091209162600.GL24013@atomide.com>
References: <20091208192111.GA32268@localhost.localdomain>
 <20091208183320.GV24013@atomide.com>
 <1260353237.19669.1258.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52869 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbZLIQ0B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 11:26:01 -0500
Content-Disposition: inline
In-Reply-To: <1260353237.19669.1258.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, 'David Woodhouse' <dwmw2@infradead.org>

* Artem Bityutskiy <dedekind1@gmail.com> [091209 02:06]:
> On Tue, 2009-12-08 at 10:33 -0800, Tony Lindgren wrote:
> > * Ladislav Michl <Ladislav.Michl@seznam.cz> [091208 10:20]:
> > > There is nothing special on omapflash driver, so it can be replaced with
> > > physmap-flash. First patch in serie does exactly this and second one removes
> > > drivers/mtd/maps/omap_nor.c and associated Kconfig option. I'd like to have
> > > either ack or merge into mtd git tree by mtd maintainers for that second part.
> > 
> > Nice work! Ack from me to merge all this via the MTD tree.
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> >  
> > >  arch/arm/mach-omap1/flash.c                          |   33 ++
> > >  arch/arm/plat-omap/include/plat/flash.h              |   16 +
> > >  arch/arm/mach-omap1/Makefile                         |    2 
> > >  arch/arm/mach-omap1/board-fsample.c                  |    9 
> > >  arch/arm/mach-omap1/board-h2.c                       |    9 
> > >  arch/arm/mach-omap1/board-h3.c                       |    9 
> > >  arch/arm/mach-omap1/board-innovator.c                |    9 
> > >  arch/arm/mach-omap1/board-osk.c                      |    9 
> > >  arch/arm/mach-omap1/board-palmte.c                   |    9 
> > >  arch/arm/mach-omap1/board-palmtt.c                   |    9 
> > >  arch/arm/mach-omap1/board-palmz71.c                  |   10 
> > >  arch/arm/mach-omap1/board-perseus2.c                 |    9 
> > >  arch/arm/mach-omap1/board-sx1.c                      |   11 
> > >  arch/arm/mach-omap1/board-voiceblue.c                |    9 
> > >  arch/arm/mach-omap2/board-2430sdp.c                  |    7 
> > >  arch/arm/mach-omap2/board-h4.c                       |    7 
> > >  drivers/mtd/maps/Kconfig                             |    9 
> > >  drivers/mtd/maps/Makefile                            |    1 
> > >  drivers/mtd/maps/omap_nor.c                          |  188 -----------------
> > >  19 files changed, 112 insertions(+), 253 deletions(-)
> 
> I think this should be merged via the omap tree, not mtd (CCed dwmw2).

OK will queue then.

Tony
