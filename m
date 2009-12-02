From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/5] ARM: OMAP4: PM: Basic OMAP4 clock framework
Date: Wed, 2 Dec 2009 12:31:43 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BBF30E92@dbde02.ent.ti.com>
References: <1259670448-19840-1-git-send-email-rnayak@ti.com>
 <1259670448-19840-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50530 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752523AbZLBHBu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 02:01:50 -0500
In-Reply-To: <1259670448-19840-2-git-send-email-rnayak@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>

Rajendra,

Some minor comments / queries

<snip>
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Rajendra Nayak
> Sent: Tuesday, December 01, 2009 5:57 PM
> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: Nayak, Rajendra; Paul Walmsley; Cousson, Benoit
> Subject: [PATCH 2/5] ARM: OMAP4: PM: Basic OMAP4 clock framework
> 
> This patch registers the OMAP4430 clock
> nodes with the CLKDEV framework.
> Enables CLKDEV for OMAP4.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile            |    8 +-
>  arch/arm/mach-omap2/clock.c             |    8 +
>  arch/arm/mach-omap2/clock44xx.c         |  331
> +++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/cm.h                |    4 +
>  arch/arm/mach-omap2/gpmc.c              |    2 +-
>  arch/arm/mach-omap2/io.c                |    4 +-
>  arch/arm/plat-omap/Kconfig              |    1 +
>  arch/arm/plat-omap/clock.c              |   26 ---
>  arch/arm/plat-omap/include/mach/clock.h |    3 +
>  9 files changed, 354 insertions(+), 33 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/clock44xx.c
> 
> +#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is
> in place */
Commenting style. This is at multiple places.

>  		if (clk->clkdm)
>  			omap2_clkdm_clk_disable(clk->clkdm, clk);
> +#endif
> 
>  	}
>  }
> @@ -448,8 +452,10 @@ int omap2_clk_enable(struct clk *clk)
>  	int ret = 0;
> 
.....

> diff --git a/arch/arm/mach-omap2/clock44xx.c b/arch/arm/mach-
> omap2/clock44xx.c
> new file mode 100644
> index 0000000..e015200
> --- /dev/null
> +++ b/arch/arm/mach-omap2/clock44xx.c
> @@ -0,0 +1,331 @@
> +/*
> + * OMAP4-specific clock framework functions
> + *
> + * Copyright (C) 2009 Texas Instruments, Inc.
> + *
> + * Rajendra Nayak (rnayak@ti.com)
> + *
> + * This program is free software; you can redistribute it and/or
> modify
> + * it under the terms of the GNU General Public License version 2
> as
> + * published by the Free Software Foundation.
> + */
> +#undef DEBUG
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/list.h>
> +#include <linux/errno.h>
> +#include <linux/delay.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/limits.h>
> +#include <linux/bitops.h>
> +
> +#include <mach/clock.h>
> +#include <mach/sram.h>
> +#include <asm/div64.h>
> +#include <asm/clkdev.h>
> +
> +#include <mach/sdrc.h>
> +#include "clock.h"
> +#include "prm.h"
> +#include "prm-regbits-44xx.h"
> +#include "cm.h"
> +#include "cm-regbits-44xx.h"
> +
> +
> +static const struct clkops clkops_noncore_dpll_ops;
> +
> +#include "clock44xx.h"
> +
> +struct omap_clk {
> +	u32		cpu;
> +	struct clk_lookup lk;
> +};
> +
> +#define CLK(dev, con, ck, cp) 		\
> +	{				\
> +		 .cpu = cp,		\
> +		.lk = {			\
> +			.dev_id = dev,	\
> +			.con_id = con,	\
> +			.clk = ck,	\
> +		},			\
> +	}
> +
> +#define CK_443X		(1 << 0)
> +
> +static struct omap_clk omap44xx_clks[] = {
> +	CLK(NULL,	"extalt_clkin_ck",		&extalt_clkin_ck,
> 	CK_443X),
Are we still keeping these 'dev" as NULL ? This is applicable to most of the table. May be a follow up patch on this needed. Also lines are exceeding 80 char's in the table.

> +	CLK(NULL,	"pad_clks_ck",			&pad_clks_ck,
> 	CK_443X),
> +	CLK(NULL,	"pad_slimbus_core_clks_ck",
> 	&pad_slimbus_core_clks_ck,	CK_443X),
> +	CLK(NULL,	"secure_32k_clk_src_ck",
> 	&secure_32k_clk_src_ck,	CK_443X),

.....

> +static struct clk_functions omap2_clk_functions = {
> +	.clk_enable		= omap2_clk_enable,
> +	.clk_disable		= omap2_clk_disable,
> +	.clk_round_rate		= omap2_clk_round_rate,
> +	.clk_set_rate		= omap2_clk_set_rate,
> +	.clk_set_parent		= omap2_clk_set_parent,
> +	.clk_disable_unused	= omap2_clk_disable_unused,
> +};
> +
> +/*
> + * Dummy functions for DPLL control. Plan is to re-use
> + * existing OMAP3 dpll control functions.
> + */
> +
> +static unsigned long omap3_dpll_recalc(struct clk *clk)
> +{
> +	return 0;
> +}
> +
> +static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned
> long rate)
> +{
> +	return 0;
> +}
> +
> +static int omap3_noncore_dpll_enable(struct clk *clk)
> +{
> +	return 0;
> +}
> +
> +static void omap3_noncore_dpll_disable(struct clk *clk)
> +{
> +	return;
> +}
> +
> +static const struct clkops clkops_noncore_dpll_ops = {
> +	.enable		= &omap3_noncore_dpll_enable,
> +	.disable	= &omap3_noncore_dpll_disable,
> +};
> +
> +void omap2_clk_prepare_for_reboot(void)
> +{
> +	return;
> +}
> +
> +static int __init omap2_clk_arch_init(void)
> +{
> +	if (!mpurate)
> +		return -EINVAL;
> +
> +	recalculate_root_clocks();
> +	return 0;
> +}
> +arch_initcall(omap2_clk_arch_init);
> +
> +int __init omap2_clk_init(void)
> +{
> +	/* struct prcm_config *prcm; */
> +	struct omap_clk *c;
> +	/* u32 clkrate; */
> +	u32 cpu_clkflg;
> +
> +	if (cpu_is_omap44xx()) {
> +		cpu_mask = RATE_IN_4430;
> +		cpu_clkflg = CK_443X;
> +	}
> +
> +	clk_init(&omap2_clk_functions);
> +
> +	for (c = omap44xx_clks; c < omap44xx_clks +
> ARRAY_SIZE(omap44xx_clks);
May be adding next line "/" would be better here.
> +									  c++)
> +		clk_preinit(c->lk.clk);
> +
> +	for (c = omap44xx_clks; c < omap44xx_clks +
> ARRAY_SIZE(omap44xx_clks);
> +									  c++)
> +		if (c->cpu & cpu_clkflg) {
> +			clkdev_add(&c->lk);
> +			clk_register(c->lk.clk);
> +			/* TODO
> +			omap2_init_clk_clkdm(c->lk.clk);
> +			*/
> +		}
> +
> +	recalculate_root_clocks();
> +
> +	/*
> +	 * Only enable those clocks we will need, let the drivers
> +	 * enable other clocks as necessary
> +	 */
> +	clk_enable_init_clocks();
> +
> +	return 0;
> +}
.....

> diff --git a/arch/arm/plat-omap/include/mach/clock.h
> b/arch/arm/plat-omap/include/mach/clock.h
> index 4b8b0d6..e9472c9 100644
> --- a/arch/arm/plat-omap/include/mach/clock.h
> +++ b/arch/arm/plat-omap/include/mach/clock.h
> @@ -148,6 +148,8 @@ extern const struct clkops clkops_null;
>  #define CONFIG_PARTICIPANT	(1 << 10)	/* Fundamental clock */
>  #define ENABLE_ON_INIT		(1 << 11)	/* Enable upon framework
> init */
>  #define INVERT_ENABLE           (1 << 12)       /* 0 enables, 1
> disables */
> +#define CLOCK_IN_OMAP4430	(1 << 13)
> +#define ALWAYS_ENABLED		(1 << 14)
>  /* bits 13-31 are currently free */
> 
>  /* Clksel_rate flags */
> @@ -156,6 +158,7 @@ extern const struct clkops clkops_null;
>  #define RATE_IN_243X		(1 << 2)
>  #define RATE_IN_343X		(1 << 3)	/* rates common to all
> 343X */
>  #define RATE_IN_3430ES2		(1 << 4)	/* 3430ES2 rates
> only */
> +#define RATE_IN_4430            (1 << 5)
> 
>  #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
> 

Regards,
Santosh
