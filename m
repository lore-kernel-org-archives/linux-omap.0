From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/3] OMAP: ZOOM: Introducing 'board-zoom-flash.c'
Date: Thu, 11 Feb 2010 13:19:14 -0800
Message-ID: <20100211211914.GJ21755@atomide.com>
References: <ce9ab5791002102119k6eb32e97gfac21762a71843f3@mail.gmail.com>
 <20100211204703.GI21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63195 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757111Ab0BKVSi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 16:18:38 -0500
Content-Disposition: inline
In-Reply-To: <20100211204703.GI21755@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [100211 12:43]:
> * Vimal Singh <vimal.newwork@gmail.com> [100210 21:16]:
> > From: Vimal Singh <vimalsingh@ti.com>
> > 
> > This patch adds 'board-zoom-flash.c', which could be utilized
> > by boards similar to ZOOM2. (For ex: LDP, ZOOM2, ZOOM3).
> > 
> > This does initialization for NAND device based on the 'cs' number
> > and partition information passed from board file (ex: board-zoom2.c).
> > 
> > Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-zoom-flash.c        |   85 +++++++++++++++++++++++++
> >  arch/arm/mach-omap2/include/mach/board-zoom.h |   11 +++
> >  2 files changed, 96 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c
> > 
> > diff --git a/arch/arm/mach-omap2/board-zoom-flash.c
> > b/arch/arm/mach-omap2/board-zoom-flash.c
> > new file mode 100644
> > index 0000000..f2328a4
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/board-zoom-flash.c
> > @@ -0,0 +1,85 @@
> > +/*
> > + * board-zoom-flash.c
> > + *
> > + * Copyright (C) 2009 Texas Instruments Inc.
> > + * Vimal Singh <vimalsingh@ti.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/delay.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/mtd/nand.h>
> > +#include <linux/types.h>
> > +#include <linux/io.h>
> > +
> > +#include <asm/mach/flash.h>
> > +#include <plat/board.h>
> > +#include <plat/gpmc.h>
> > +#include <plat/nand.h>
> > +
> > +#include <mach/board-zoom.h>
> > +
> > +#if defined(CONFIG_MTD_NAND_OMAP2) || \
> > +		defined(CONFIG_MTD_NAND_OMAP2_MODULE)
> > +
> > +/* Note that all values in this struct are in nanoseconds */
> > +static struct gpmc_timings nand_timings = {
> > +
> > +	.sync_clk = 0,
> > +
> > +	.cs_on = 0,
> > +	.cs_rd_off = 36,
> > +	.cs_wr_off = 36,
> > +
> > +	.adv_on = 6,
> > +	.adv_rd_off = 24,
> > +	.adv_wr_off = 36,
> > +
> > +	.we_off = 30,
> > +	.oe_off = 48,
> > +
> > +	.access = 54,
> > +	.rd_cycle = 72,
> > +	.wr_cycle = 72,
> > +
> > +	.wr_access = 30,
> > +	.wr_data_mux_bus = 0,
> > +};
> > +
> > +/* NAND chip access: 16 bit */
> > +static struct omap_nand_platform_data zoom_nand_data = {
> > +	.nand_setup	= NULL,
> > +	.gpmc_t		= &nand_timings,
> > +	.dma_channel	= -1,	/* disable DMA in OMAP NAND driver */
> > +	.dev_ready	= NULL,
> > +	.devsize	= 1,	/* '0' for 8-bit, '1' for 16-bit device */
> > +};
> > +
> > +/**
> > + * zoom_flash_init - Identify devices connected to GPMC and register.
> > + *
> > + * @return - void.
> > + */
> > +void __init zoom_flash_init(struct flash_partitions zoom_nand_parts[], int cs)
> > +{
> > +	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
> > +
> > +	zoom_nand_data.cs		= cs;
> > +	zoom_nand_data.parts		= zoom_nand_parts[0].parts;
> > +	zoom_nand_data.nr_parts		= zoom_nand_parts[0].nr_parts;
> > +	zoom_nand_data.gpmc_baseaddr	= (void *)(gpmc_base_add);
> > +	zoom_nand_data.gpmc_cs_baseaddr	= (void *)(gpmc_base_add +
> > +						GPMC_CS0_BASE +
> > +						cs * GPMC_CS_SIZE);
> 
> The gpmc_baseaddr and gpmc_cs_baseaddr should no longer be
> needed with gpmc-nand.c, right?

Yeah.. For now, I suggest you set the gpmc_baseaddr and
gpmc_cs_baseaddr in gpmc_nand_init() based on the results from
gpmc_cs_request.

That will allow us to remove the insane hardcoded gpmc virtual
addresses from all board-*.c files.

And then we can finally fix gpmc-nand.c driver not to go tinker
with the GPMC registers directly. All of that should be in
gpmc-nand.c using gpmc.c. The driver should be just a generic
NAND driver.

Regards,

Tony
