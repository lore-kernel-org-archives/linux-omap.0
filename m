From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/5] omap: mux: Add new style pin multiplexing data for
 34xx
Date: Mon, 2 Nov 2009 11:10:19 -0800
Message-ID: <20091102191018.GD6692@atomide.com>
References: <20091029203124.11843.89983.stgit@localhost>
 <20091029203631.11843.1364.stgit@localhost>
 <4AED6330.8020007@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63075 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756259AbZKBTKR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 14:10:17 -0500
Content-Disposition: inline
In-Reply-To: <4AED6330.8020007@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-omap@vger.kernel.org, mike.rapoport@gmail.com

* Mike Rapoport <mike@compulab.co.il> [091101 02:30]:
> 
> 
> Tony Lindgren wrote:
> > Add new style mux data for 34xx. This should also
> > work with 3630 easily by adding the processor subset
> > and ball data.
> > 
> > Note that this data is __initdata, and gets optimized
> > out if CONFIG_OMAP_MUX is not set. Also, the debug data
> > gets optimized out if CONFIG_DEBUG_FS is not set.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap2/Makefile  |    4 
> >  arch/arm/mach-omap2/mux.h     |    2 
> >  arch/arm/mach-omap2/mux34xx.c | 1552 +++++++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/mux34xx.h |  352 +++++++++
> >  4 files changed, 1910 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-omap2/mux34xx.c
> >  create mode 100644 arch/arm/mach-omap2/mux34xx.h
> > 
> > diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> > index 03cb4fc..4b6d7b9 100644
> > --- a/arch/arm/mach-omap2/Makefile
> > +++ b/arch/arm/mach-omap2/Makefile
> > @@ -23,6 +23,10 @@ obj-$(CONFIG_ARCH_OMAP2420)		+= sram242x.o
> >  obj-$(CONFIG_ARCH_OMAP2430)		+= sram243x.o
> >  obj-$(CONFIG_ARCH_OMAP3)		+= sram34xx.o
> >  
> > +ifeq ($(CONFIG_OMAP_MUX),y)
> > +obj-$(CONFIG_ARCH_OMAP3)		+= mux34xx.o
> > +endif
> > +
> >  # SMS/SDRC
> >  obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
> >  # obj-$(CONFIG_ARCH_OMAP3)		+= sdrc3xxx.o
> > diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
> > index a8453f5..0d52318 100644
> > --- a/arch/arm/mach-omap2/mux.h
> > +++ b/arch/arm/mach-omap2/mux.h
> > @@ -7,6 +7,8 @@
> >   * published by the Free Software Foundation.
> >   */
> >  
> > +#include "mux34xx.h"
> > +
> >  #define OMAP_MUX_TERMINATOR	0xffff
> >  
> >  /* 34xx mux mode options for each pin. See TRM for options */
> > diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c
> > new file mode 100644
> > index 0000000..62c2b6a
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/mux34xx.c
> > @@ -0,0 +1,1552 @@
> > +/*
> > + * Copyright (C) 2009 Nokia
> > + * Copyright (C) 2009 Texas Instruments
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +
> > +#include "mux.h"
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +
> > +#define _OMAP3_MUXENTRY(M0, g, m0, m1, m2, m3, m4, m5, m6, m7)		\
> > +{									\
> > +	.reg_offset	= (OMAP3_CONTROL_PADCONF_##M0##_OFFSET),	\
> > +	.gpio		= (g),						\
> > +	.muxnames	= { m0, m1, m2, m3, m4, m5, m6, m7 },		\
> > +}
> > +
> > +#else
> > +
> > +#define _OMAP3_MUXENTRY(M0, g, m0, m1, m2, m3, m4, m5, m6, m7)		\
> > +{									\
> > +	.reg_offset	= (OMAP3_CONTROL_PADCONF_##M0##_OFFSET),	\
> > +	.gpio		= (g),						\
> > +}
> > +
> > +#endif
> > +
> > +#define _OMAP3_BALLENTRY(M0, bb, bt)					\
> > +{									\
> > +	.reg_offset	= (OMAP3_CONTROL_PADCONF_##M0##_OFFSET),	\
> > +	.balls		= { bb, bt },					\
> > +}
> > +
> > +/*
> > + * Superset of all mux modes, same as the CBC package
> > + */
> > +static struct omap_mux __initdata omap3_muxmodes[] = {
> 
> Is the CBS package for sure will be superset of all possible OMAP3
> variants/packages?

Not necessarily, but a single superset works for all omap3.
I'll remove the CBC comment, as with 3630 it will be the superset.
 
> > +	_OMAP3_MUXENTRY(CAM_D0, 99,
> > +		"cam_d0", NULL, NULL, NULL,
> > +		"gpio_99", NULL, NULL, "safe_mode"),
> 
> [ snip ]
> 
> > +	{ .reg_offset = OMAP_MUX_TERMINATOR },
> > +};
> > +
> > +/*
> > + * Pins different on CBC package comapared to CBC package
> > + */
> > +struct omap_mux __initdata omap3_cbc_subset[] = {
> > +	{ .reg_offset = OMAP_MUX_TERMINATOR },
> > +};
> > +
> > +/*
> > + * Balls for CBC package
> > + * 515-pin s-PBGA Package, 0.65mm Ball Pitch (Top), 0.50mm Ball Pitch (Bottom)
> > + *
> > + * FIXME: What's up with the outdated TI documentation? See:
> > + *
> > + * http://wiki.davincidsp.com/index.php/Datasheet_Errata_for_OMAP35x_CBC_Package
> > + * http://community.ti.com/forums/t/10982.aspx
> > + */
> > +#ifdef CONFIG_DEBUG_FS
> > +struct omap_ball __initdata omap3_cbc_ball[] = {
> > +	_OMAP3_BALLENTRY(CAM_D0, "ae16", NULL),
> 
> [ snip ]
> 
> > +	{ .reg_offset = OMAP_MUX_TERMINATOR },
> > +};
> > +#else
> > +#define omap3_cbc_ball	 NULL
> > +#endif
> > +
> > +/*
> > + * Pins different on CUS package comapared to CBC package
> > + */
> 
> Maybe we'll just add the entire package rather than its difference to the CBC
> package?

IMHO it makes maintenance harder because of duplicating the data
like I commented earlier. Currently the duplicate data would be
for the 3 existing packages + whatever 36xx packages will be
introduces.

<snip>
 
> > +
> > +#define OMAP3_CONTROL_PADCONF_MUX_SIZE				\
> > +		(OMAP3_CONTROL_PADCONF_JTAG_TDO_OFFSET + 0x2)
> 
> What about adding defines for each possible mode configuration, except, perhaps,
> GPIO?

Yeah it would be nice to make it easy. How about someting like:

int __init omap_mux_init_by_name(char *name, int flags);
...

omap_mux_init_by_name("i2c1_scl", OMAP_PIN_INPUT_PULLUP);
 
> #define OMAP3_PIN_CAM_D0 OMAP3_MUX(CAM_D0, OMAP_PIN_MODE0 | OMAP_PIN_INPUT, 0)
> #define OMAP3_PIN_CAM_D0_CSI2_DX2 OMAP3_MUX(CAM_D0, OMAP_PIN_MODE2 | \
> 				            OMAP_PIN_INPUT, 0)
> 
> And, I'm for adding OMAP_MUX_GPIO_{OUT,IN,IN_PU,IN_PD}(x) as well.

And we could have also:

int __init omap_mux_init_by_gpio(int gpio, int flags);
...

omap_mux_init_by_gpio(99, OMAP_PIN_INPUT);

As the only thing we currently have for flags is the OMAP_MUX_DYNAMIC,
we could mask that too into flags and make it int instead of u16.

Regards,

Tony
