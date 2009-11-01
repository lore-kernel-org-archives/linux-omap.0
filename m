From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 3/5] omap: mux: Add new style pin multiplexing data for
 34xx
Date: Sun, 01 Nov 2009 12:30:08 +0200
Message-ID: <4AED6330.8020007@compulab.co.il>
References: <20091029203124.11843.89983.stgit@localhost> <20091029203631.11843.1364.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:55550 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939AbZKAKaX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 1 Nov 2009 05:30:23 -0500
In-Reply-To: <20091029203631.11843.1364.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, mike.rapoport@gmail.com



Tony Lindgren wrote:
> Add new style mux data for 34xx. This should also
> work with 3630 easily by adding the processor subset
> and ball data.
> 
> Note that this data is __initdata, and gets optimized
> out if CONFIG_OMAP_MUX is not set. Also, the debug data
> gets optimized out if CONFIG_DEBUG_FS is not set.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/Makefile  |    4 
>  arch/arm/mach-omap2/mux.h     |    2 
>  arch/arm/mach-omap2/mux34xx.c | 1552 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/mux34xx.h |  352 +++++++++
>  4 files changed, 1910 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/mux34xx.c
>  create mode 100644 arch/arm/mach-omap2/mux34xx.h
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 03cb4fc..4b6d7b9 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -23,6 +23,10 @@ obj-$(CONFIG_ARCH_OMAP2420)		+= sram242x.o
>  obj-$(CONFIG_ARCH_OMAP2430)		+= sram243x.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= sram34xx.o
>  
> +ifeq ($(CONFIG_OMAP_MUX),y)
> +obj-$(CONFIG_ARCH_OMAP3)		+= mux34xx.o
> +endif
> +
>  # SMS/SDRC
>  obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
>  # obj-$(CONFIG_ARCH_OMAP3)		+= sdrc3xxx.o
> diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
> index a8453f5..0d52318 100644
> --- a/arch/arm/mach-omap2/mux.h
> +++ b/arch/arm/mach-omap2/mux.h
> @@ -7,6 +7,8 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include "mux34xx.h"
> +
>  #define OMAP_MUX_TERMINATOR	0xffff
>  
>  /* 34xx mux mode options for each pin. See TRM for options */
> diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c
> new file mode 100644
> index 0000000..62c2b6a
> --- /dev/null
> +++ b/arch/arm/mach-omap2/mux34xx.c
> @@ -0,0 +1,1552 @@
> +/*
> + * Copyright (C) 2009 Nokia
> + * Copyright (C) 2009 Texas Instruments
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +
> +#include "mux.h"
> +
> +#ifdef CONFIG_DEBUG_FS
> +
> +#define _OMAP3_MUXENTRY(M0, g, m0, m1, m2, m3, m4, m5, m6, m7)		\
> +{									\
> +	.reg_offset	= (OMAP3_CONTROL_PADCONF_##M0##_OFFSET),	\
> +	.gpio		= (g),						\
> +	.muxnames	= { m0, m1, m2, m3, m4, m5, m6, m7 },		\
> +}
> +
> +#else
> +
> +#define _OMAP3_MUXENTRY(M0, g, m0, m1, m2, m3, m4, m5, m6, m7)		\
> +{									\
> +	.reg_offset	= (OMAP3_CONTROL_PADCONF_##M0##_OFFSET),	\
> +	.gpio		= (g),						\
> +}
> +
> +#endif
> +
> +#define _OMAP3_BALLENTRY(M0, bb, bt)					\
> +{									\
> +	.reg_offset	= (OMAP3_CONTROL_PADCONF_##M0##_OFFSET),	\
> +	.balls		= { bb, bt },					\
> +}
> +
> +/*
> + * Superset of all mux modes, same as the CBC package
> + */
> +static struct omap_mux __initdata omap3_muxmodes[] = {

Is the CBS package for sure will be superset of all possible OMAP3
variants/packages?

> +	_OMAP3_MUXENTRY(CAM_D0, 99,
> +		"cam_d0", NULL, NULL, NULL,
> +		"gpio_99", NULL, NULL, "safe_mode"),

[ snip ]

> +	{ .reg_offset = OMAP_MUX_TERMINATOR },
> +};
> +
> +/*
> + * Pins different on CBC package comapared to CBC package
> + */
> +struct omap_mux __initdata omap3_cbc_subset[] = {
> +	{ .reg_offset = OMAP_MUX_TERMINATOR },
> +};
> +
> +/*
> + * Balls for CBC package
> + * 515-pin s-PBGA Package, 0.65mm Ball Pitch (Top), 0.50mm Ball Pitch (Bottom)
> + *
> + * FIXME: What's up with the outdated TI documentation? See:
> + *
> + * http://wiki.davincidsp.com/index.php/Datasheet_Errata_for_OMAP35x_CBC_Package
> + * http://community.ti.com/forums/t/10982.aspx
> + */
> +#ifdef CONFIG_DEBUG_FS
> +struct omap_ball __initdata omap3_cbc_ball[] = {
> +	_OMAP3_BALLENTRY(CAM_D0, "ae16", NULL),

[ snip ]

> +	{ .reg_offset = OMAP_MUX_TERMINATOR },
> +};
> +#else
> +#define omap3_cbc_ball	 NULL
> +#endif
> +
> +/*
> + * Pins different on CUS package comapared to CBC package
> + */

Maybe we'll just add the entire package rather than its difference to the CBC
package?

> +struct omap_mux __initdata omap3_cus_subset[] = {
> +	_OMAP3_MUXENTRY(CAM_D10, 109,
> +		"cam_d10", NULL, NULL, NULL,
> +		"gpio_109", NULL, NULL, "safe_mode"),

[ snip ]

> +	{ .reg_offset = OMAP_MUX_TERMINATOR },
> +};
> +
> +/*
> + * Balls for CUS package
> + * 423-pin s-PBGA Package, 0.65mm Ball Pitch (Bottom)
> + */
> +#ifdef CONFIG_DEBUG_FS
> +struct omap_ball __initdata omap3_cus_ball[] = {
> +	_OMAP3_BALLENTRY(CAM_D0, "ab18", NULL),

[ snip ]

> +	{ .reg_offset = OMAP_MUX_TERMINATOR },
> +};
> +#else
> +#define omap3_cus_ball	 NULL
> +#endif
> +
> +/*
> + * Pins different on CBB package comapared to CBC package
> + */

ditto

> +struct omap_mux __initdata omap3_cbb_subset[] = {
> +	_OMAP3_MUXENTRY(CAM_D10, 109,
> +		"cam_d10", NULL, NULL, NULL,
> +		"gpio_109", NULL, NULL, "safe_mode"),

[ snip ]

> +	{ .reg_offset = OMAP_MUX_TERMINATOR },
> +};
> +
> +/*
> + * Balls for CBB package
> + * 515-pin s-PBGA Package, 0.50mm Ball Pitch (Top), 0.40mm Ball Pitch (Bottom)
> + */
> +#ifdef CONFIG_DEBUG_FS
> +struct omap_ball __initdata omap3_cbb_ball[] = {
> +	_OMAP3_BALLENTRY(CAM_D0, "ag17", NULL),

[ snip ]

> +	{ .reg_offset = OMAP_MUX_TERMINATOR },
> +};
> +#else
> +#define omap3_cbb_ball	 NULL
> +#endif
> +
> +int __init omap3_mux_init(struct omap_board_mux *board_subset, int flags)
> +{
> +	struct omap_mux *package_subset;
> +	struct omap_ball *package_balls;
> +
> +	switch (flags & OMAP_PACKAGE_MASK) {
> +	case (OMAP_PACKAGE_CBC):
> +		package_subset = omap3_cbc_subset;
> +		package_balls = omap3_cbc_ball;
> +		break;
> +	case (OMAP_PACKAGE_CBB):
> +		package_subset = omap3_cbb_subset;
> +		package_balls = omap3_cbb_ball;
> +		break;
> +	case (OMAP_PACKAGE_CUS):
> +		package_subset = omap3_cus_subset;
> +		package_balls = omap3_cus_ball;
> +		break;
> +	default:
> +		printk(KERN_ERR "mux: Unknown omap package, mux disabled\n");
> +		return -EINVAL;
> +	}
> +
> +	return omap_mux_init(OMAP3_CONTROL_PADCONF_MUX_PBASE,
> +			     OMAP3_CONTROL_PADCONF_MUX_SIZE,
> +				omap3_muxmodes, package_subset, board_subset,
> +				package_balls, flags);
> +}
> diff --git a/arch/arm/mach-omap2/mux34xx.h b/arch/arm/mach-omap2/mux34xx.h
> new file mode 100644
> index 0000000..8c5f261
> --- /dev/null
> +++ b/arch/arm/mach-omap2/mux34xx.h
> @@ -0,0 +1,352 @@
> +/*
> + * Copyright (C) 2009 Nokia
> + * Copyright (C) 2009 Texas Instruments
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +

[ snip ]

> +
> +#define OMAP3_CONTROL_PADCONF_MUX_SIZE				\
> +		(OMAP3_CONTROL_PADCONF_JTAG_TDO_OFFSET + 0x2)

What about adding defines for each possible mode configuration, except, perhaps,
GPIO?

#define OMAP3_PIN_CAM_D0 OMAP3_MUX(CAM_D0, OMAP_PIN_MODE0 | OMAP_PIN_INPUT, 0)
#define OMAP3_PIN_CAM_D0_CSI2_DX2 OMAP3_MUX(CAM_D0, OMAP_PIN_MODE2 | \
				            OMAP_PIN_INPUT, 0)

And, I'm for adding OMAP_MUX_GPIO_{OUT,IN,IN_PU,IN_PD}(x) as well.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Sincerely yours,
Mike.


