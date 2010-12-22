From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH 2/7] omap3: nand: configurable transfer type per board
Date: Wed, 22 Dec 2010 13:22:12 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036A3B03A5@dbde02.ent.ti.com>
References: <1290785677-16005-1-git-send-email-s-ghorai@ti.com>
 <1290785677-16005-3-git-send-email-s-ghorai@ti.com>
 <20101218000845.GW5941@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42741 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752396Ab0LVHwZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 02:52:25 -0500
In-Reply-To: <20101218000845.GW5941@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Saturday, December 18, 2010 5:39 AM
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH 2/7] omap3: nand: configurable transfer type per board
> 
> * Sukumar Ghorai <s-ghorai@ti.com> [101126 07:25]:
> > nand transfer type (sDMA, Polled, prefetch) can be select from board
> file,
> > enabling all transfer type in driver, by default.
> >
> > this helps in multi-omap build and to select different transfer type for
> > different board.
> >
> > Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> > ---
> >  arch/arm/plat-omap/include/plat/nand.h |    7 +++
> >  drivers/mtd/nand/Kconfig               |   17 ------
> >  drivers/mtd/nand/omap2.c               |   92 +++++++++++--------------
> ------
> >  3 files changed, 40 insertions(+), 76 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/include/plat/nand.h b/arch/arm/plat-
> omap/include/plat/nand.h
> > index 6562cd0..78c0bdb 100644
> > --- a/arch/arm/plat-omap/include/plat/nand.h
> > +++ b/arch/arm/plat-omap/include/plat/nand.h
> > @@ -10,6 +10,12 @@
> >
> >  #include <linux/mtd/partitions.h>
> >
> > +enum nand_io {
> > +	NAND_OMAP_PREFETCH_POLLED = 0,	/* prefetch polled mode, default
> */
> > +	NAND_OMAP_POLLED,		/* polled mode, without prefetch */
> > +	NAND_OMAP_PREFETCH_DMA		/* prefetch enabled sDMA mode */
> > +};
> > +
> >  struct omap_nand_platform_data {
> >  	unsigned int		options;
> >  	int			cs;
> > @@ -20,6 +26,7 @@ struct omap_nand_platform_data {
> >  	int			(*nand_setup)(void);
> >  	int			(*dev_ready)(struct omap_nand_platform_data *);
> >  	int			dma_channel;
> > +	enum nand_io		xfer_type;
> >  	unsigned long		phys_base;
> >  	int			devsize;
> >  };
> 
> So maybe the devsize in patch 1/7 should be handled with this too?

[Ghorai] patch 1/7 [1] is to select the NAND type i.e. x8 or x16 NAND; 
So I am keeping as separate patch. And let me know if I am missing anything.
 
[1] https://patchwork.kernel.org/patch/359092/

