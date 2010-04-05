From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: Re: [PATCH v2 1/3] OMAP: ZOOM: Introducing 'board-zoom-flash.c'
Date: Mon, 5 Apr 2010 11:15:57 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030D3C8C94@dbde02.ent.ti.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B030D3C8C1F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40104 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749Ab0DEFqI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Apr 2010 01:46:08 -0400
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030D3C8C1F@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Vimal Singh <vimal.newwork@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony,
I am looking on following patch series, now onwards. 
And please let me know your input against my input (inline with email).

[v2,1/3] OMAP: ZOOM: Introducing 'board-zoom-flash.c' https://patchwork.kernel.org/patch/78637/
[v2,2/3] OMAP3: Add support for NAND on ZOOM2 board
[v2,3/3] OMAP3: Add support for NAND on ZOOM3 board

Regards,
Ghorai 

> > On Fri, Feb 12, 2010 at 2:49 AM, Tony Lindgren <tony@atomide.com> wrote:
> > > * Tony Lindgren <tony@atomide.com> [100211 12:43]:
> > >> * Vimal Singh <vimal.newwork@gmail.com> [100210 21:16]:
> > >> > From: Vimal Singh <vimalsingh@ti.com>
> > >> >
> > >> > This patch adds 'board-zoom-flash.c', which could be utilized
> > >> > by boards similar to ZOOM2. (For ex: LDP, ZOOM2, ZOOM3).
> > >> >
> > >> > This does initialization for NAND device based on the 'cs' number
> > >> > and partition information passed from board file (ex: board-
> zoom2.c).
> > >> >
> > >> > Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> > >> > ---
> > >> >  arch/arm/mach-omap2/board-zoom-flash.c        |   85
> +++++++++++++++++++++++++
> > >> >  arch/arm/mach-omap2/include/mach/board-zoom.h |   11 +++
> > >> >  2 files changed, 96 insertions(+), 0 deletions(-)
> > >> >  create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c
> > >> >
> > >> > diff --git a/arch/arm/mach-omap2/board-zoom-flash.c
> > >> > b/arch/arm/mach-omap2/board-zoom-flash.c
> > >> > new file mode 100644
> > >> > index 0000000..f2328a4
> > >> > --- /dev/null
> > >> > +++ b/arch/arm/mach-omap2/board-zoom-flash.c
> > >> > @@ -0,0 +1,85 @@
> > >> > +/*
> > >> > + * board-zoom-flash.c
> > >> > + *
> > >> > + * Copyright (C) 2009 Texas Instruments Inc.
> > >> > + * Vimal Singh <vimalsingh@ti.com>
> > >> > + *
> > >> > + * This program is free software; you can redistribute it and/or
> modify
> > >> > + * it under the terms of the GNU General Public License version 2
> as
> > >> > + * published by the Free Software Foundation.
> > >> > + */
> > >> > +
> > >> > +#include <linux/kernel.h>
> > >> > +#include <linux/delay.h>
> > >> > +#include <linux/platform_device.h>
> > >> > +#include <linux/mtd/nand.h>
> > >> > +#include <linux/types.h>
> > >> > +#include <linux/io.h>
> > >> > +
> > >> > +#include <asm/mach/flash.h>
> > >> > +#include <plat/board.h>
> > >> > +#include <plat/gpmc.h>
> > >> > +#include <plat/nand.h>
> > >> > +
> > >> > +#include <mach/board-zoom.h>
> > >> > +
> > >> > +#if defined(CONFIG_MTD_NAND_OMAP2) || \
> > >> > +           defined(CONFIG_MTD_NAND_OMAP2_MODULE)
> > >> > +
> > >> > +/* Note that all values in this struct are in nanoseconds */
> > >> > +static struct gpmc_timings nand_timings = {
> > >> > +
> > >> > +   .sync_clk = 0,
> > >> > +
> > >> > +   .cs_on = 0,
> > >> > +   .cs_rd_off = 36,
> > >> > +   .cs_wr_off = 36,
> > >> > +
> > >> > +   .adv_on = 6,
> > >> > +   .adv_rd_off = 24,
> > >> > +   .adv_wr_off = 36,
> > >> > +
> > >> > +   .we_off = 30,
> > >> > +   .oe_off = 48,
> > >> > +
> > >> > +   .access = 54,
> > >> > +   .rd_cycle = 72,
> > >> > +   .wr_cycle = 72,
> > >> > +
> > >> > +   .wr_access = 30,
> > >> > +   .wr_data_mux_bus = 0,
> > >> > +};
> > >> > +
> > >> > +/* NAND chip access: 16 bit */
> > >> > +static struct omap_nand_platform_data zoom_nand_data = {
> > >> > +   .nand_setup     = NULL,
> > >> > +   .gpmc_t         = &nand_timings,
> > >> > +   .dma_channel    = -1,   /* disable DMA in OMAP NAND driver */
> > >> > +   .dev_ready      = NULL,
> > >> > +   .devsize        = 1,    /* '0' for 8-bit, '1' for 16-bit device
> */
> > >> > +};
> > >> > +
> > >> > +/**
> > >> > + * zoom_flash_init - Identify devices connected to GPMC and
> register.
> > >> > + *
> > >> > + * @return - void.
> > >> > + */
> > >> > +void __init zoom_flash_init(struct flash_partitions
> zoom_nand_parts[], int cs)
> > >> > +{
> > >> > +   u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
> > >> > +
> > >> > +   zoom_nand_data.cs               = cs;
> > >> > +   zoom_nand_data.parts            = zoom_nand_parts[0].parts;
> > >> > +   zoom_nand_data.nr_parts         = zoom_nand_parts[0].nr_parts;
> > >> > +   zoom_nand_data.gpmc_baseaddr    = (void *)(gpmc_base_add);
> > >> > +   zoom_nand_data.gpmc_cs_baseaddr = (void *)(gpmc_base_add +
> > >> > +                                           GPMC_CS0_BASE +
> > >> > +                                           cs * GPMC_CS_SIZE);
> > >>
> > >> The gpmc_baseaddr and gpmc_cs_baseaddr should no longer be
> > >> needed with gpmc-nand.c, right?
> >
> > As said earlier too these are needed by 'nand/omap2.c' driver not for
> > gpmc.-nand.c, we still need to pass these.
> 
> Right..
> 
> > >
> > > Yeah.. For now, I suggest you set the gpmc_baseaddr and
> > > gpmc_cs_baseaddr in gpmc_nand_init() based on the results from
> > > gpmc_cs_request.
> > >
> > > That will allow us to remove the insane hardcoded gpmc virtual
> > > addresses from all board-*.c files.
> >
> > OK
> 
> This change you can already make without changing the driver.
[Ghorai] gpmc_nand_init() is implemented arch/arm/mach-omap2/gpmc-nand.c. And this is a generic file. And OMAP34XX_GPMC_VIRT and following calculation is a platform specific value and better be in any on the board files. 
May be we could moved from board-zoom-flash.c to board-zoom2.c/ board-zoom3.c.
I can see OMAP34XX_GPMC_VIRT used in many arch/arm/mach-omap2/board-*.c files only, at present.
> 
> > >
> > > And then we can finally fix gpmc-nand.c driver not to go tinker
> > You mean omap2.c nand driver?
> >
> > > with the GPMC registers directly. All of that should be in
> > > gpmc-nand.c using gpmc.c. The driver should be just a generic
> > > NAND driver.
> >
> > Yes, but that will take complete clean-up of omap2.c nand driver by
> > moving all functions accessing GPMC registers from 'nand/omap2.c' to
> > 'gpmc-nand.c'. And we can take that work later.
> > Once everything is working fine and is at proper place, clean-up will
> > have more visibility.
> >
> > IMHO, you can still take patches for now. As, this is how already done
> > for sdp boards too.
> 
> I'd rather get things fixed rather than merge obviously broken stuff.
> 
> The thing is that unless it's fixed to start with, nobody bothers to
> fix it afterwards and then I need to deal with cleaning up the mess.

[Ghorai] 
1. This is same for NAND and oneNAND that to marge the following two files.
	drivers/mtd/nand/omap2.c & arch/arm/mach-omap2/gpmc-nand.c
	drivers/mtd/onenand/omap2.c & arch/arm/mach-omap2/gpmc-onenand.c
So I think this optimization could be taken as a separate patch. 

[Ghorai]
2. Mainly the discussion starts with how to pass OMAP34XX_GPMC_VIRT variable from board file or not. 

> 
> Regards,
> 
> Tony
