From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/2] OMAP3: add AMBA devices for ETM and ETB
Date: Thu, 22 Oct 2009 10:01:38 -0700
Message-ID: <20091022170138.GN16230@atomide.com>
References: <1256230315-22340-1-git-send-email-virtuoso@slind.org> <1256230315-22340-2-git-send-email-virtuoso@slind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53194 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756252AbZJVRBq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 13:01:46 -0400
Content-Disposition: inline
In-Reply-To: <1256230315-22340-2-git-send-email-virtuoso@slind.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Shishkin <virtuoso@slind.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Alexander Shishkin <virtuoso@slind.org> [091022 09:52]:
> This enables on-chip tracing components found in omap3xxx.
> 
> Signed-off-by: Alexander Shishkin <virtuoso@slind.org>

This should not cause any merge issues with the pending
omap header changes, so let's merge this via Russell's
queue along with the other ETM patches.

Acked-by: Tony Lindgren <tony@atomide.com>


> ---
>  arch/arm/mach-omap2/Kconfig     |    8 +++++
>  arch/arm/mach-omap2/Makefile    |    3 ++
>  arch/arm/mach-omap2/clock34xx.c |    8 ++--
>  arch/arm/mach-omap2/emu.c       |   66 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 81 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/emu.c
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 15cb529..f50d5bc 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -96,3 +96,11 @@ config MACH_OMAP_ZOOM2
>  config MACH_OMAP_4430SDP
>  	bool "OMAP 4430 SDP board"
>  	depends on ARCH_OMAP4
> +
> +config OMAP3_EMU
> +	bool "OMAP3 tracing peripherals"
> +	depends on ARCH_OMAP3
> +	select OC_ETM
> +	help
> +	  Say Y here to enable tracing hardware of omap3
> +
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 954693c..c0ceb8c 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -46,6 +46,9 @@ obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
>  obj-$(CONFIG_OMAP_PM_SRF)		+=  resource34xx.o
>  
> +# EMU peripherals
> +obj-$(CONFIG_OMAP3_EMU)		+= emu.o
> +
>  iommu-y					+= iommu2.o
>  iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
>  
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> index da5bc1f..59d4320 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -123,7 +123,7 @@ static struct omap_clk omap34xx_clks[] = {
>  	CLK(NULL,	"dpll3_m2x2_ck", &dpll3_m2x2_ck, CK_343X),
>  	CLK(NULL,	"dpll3_m3_ck",	&dpll3_m3_ck,	CK_343X),
>  	CLK(NULL,	"dpll3_m3x2_ck", &dpll3_m3x2_ck, CK_343X),
> -	CLK(NULL,	"emu_core_alwon_ck", &emu_core_alwon_ck, CK_343X),
> +	CLK("etb",	"emu_core_alwon_ck", &emu_core_alwon_ck, CK_343X),
>  	CLK(NULL,	"dpll4_ck",	&dpll4_ck,	CK_343X),
>  	CLK(NULL,	"dpll4_x2_ck",	&dpll4_x2_ck,	CK_343X),
>  	CLK(NULL,	"omap_96m_alwon_fck", &omap_96m_alwon_fck, CK_343X),
> @@ -142,7 +142,7 @@ static struct omap_clk omap34xx_clks[] = {
>  	CLK(NULL,	"dpll4_m5x2_ck", &dpll4_m5x2_ck, CK_343X),
>  	CLK(NULL,	"dpll4_m6_ck",	&dpll4_m6_ck,	CK_343X),
>  	CLK(NULL,	"dpll4_m6x2_ck", &dpll4_m6x2_ck, CK_343X),
> -	CLK(NULL,	"emu_per_alwon_ck", &emu_per_alwon_ck, CK_343X),
> +	CLK("etb",	"emu_per_alwon_ck", &emu_per_alwon_ck, CK_343X),
>  	CLK(NULL,	"dpll5_ck",	&dpll5_ck,	CK_3430ES2),
>  	CLK(NULL,	"dpll5_m2_ck",	&dpll5_m2_ck,	CK_3430ES2),
>  	CLK(NULL,	"clkout2_src_ck", &clkout2_src_ck, CK_343X),
> @@ -151,7 +151,7 @@ static struct omap_clk omap34xx_clks[] = {
>  	CLK(NULL,	"dpll1_fck",	&dpll1_fck,	CK_343X),
>  	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_343X),
>  	CLK(NULL,	"arm_fck",	&arm_fck,	CK_343X),
> -	CLK(NULL,	"emu_mpu_alwon_ck", &emu_mpu_alwon_ck, CK_343X),
> +	CLK("etb",	"emu_mpu_alwon_ck", &emu_mpu_alwon_ck, CK_343X),
>  	CLK(NULL,	"dpll2_fck",	&dpll2_fck,	CK_343X),
>  	CLK(NULL,	"iva2_ck",	&iva2_ck,	CK_343X),
>  	CLK(NULL,	"l3_ick",	&l3_ick,	CK_343X),
> @@ -306,7 +306,7 @@ static struct omap_clk omap34xx_clks[] = {
>  	CLK("omap-mcbsp.2", "fck",	&mcbsp2_fck,	CK_343X),
>  	CLK("omap-mcbsp.3", "fck",	&mcbsp3_fck,	CK_343X),
>  	CLK("omap-mcbsp.4", "fck",	&mcbsp4_fck,	CK_343X),
> -	CLK(NULL,	"emu_src_ck",	&emu_src_ck,	CK_343X),
> +	CLK("etb",	"emu_src_ck",	&emu_src_ck,	CK_343X),
>  	CLK(NULL,	"pclk_fck",	&pclk_fck,	CK_343X),
>  	CLK(NULL,	"pclkx2_fck",	&pclkx2_fck,	CK_343X),
>  	CLK(NULL,	"atclk_fck",	&atclk_fck,	CK_343X),
> diff --git a/arch/arm/mach-omap2/emu.c b/arch/arm/mach-omap2/emu.c
> new file mode 100644
> index 0000000..ec0d984
> --- /dev/null
> +++ b/arch/arm/mach-omap2/emu.c
> @@ -0,0 +1,66 @@
> +/*
> + * emu.c
> + *
> + * ETM and ETB CoreSight components' resources as found in OMAP3xxx.
> + *
> + * Copyright (C) 2009 Nokia Corporation.
> + * Alexander Shishkin
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/amba/bus.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Alexander Shishkin");
> +
> +/* Cortex CoreSight components within omap3xxx EMU */
> +#define ETM_BASE	(L4_EMU_34XX_PHYS + 0x10000)
> +#define DBG_BASE	(L4_EMU_34XX_PHYS + 0x11000)
> +#define ETB_BASE	(L4_EMU_34XX_PHYS + 0x1b000)
> +#define DAPCTL		(L4_EMU_34XX_PHYS + 0x1d000)
> +
> +static struct amba_device omap3_etb_device = {
> +	.dev		= {
> +		.init_name = "etb",
> +	},
> +	.res		= {
> +		.start	= ETB_BASE,
> +		.end	= ETB_BASE + SZ_4K - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	.periphid	= 0x000bb907,
> +};
> +
> +static struct amba_device omap3_etm_device = {
> +	.dev		= {
> +		.init_name = "etm",
> +	},
> +	.res		= {
> +		.start	= ETM_BASE,
> +		.end	= ETM_BASE + SZ_4K - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	.periphid	= 0x102bb921,
> +};
> +
> +static int __init emu_init(void)
> +{
> +	amba_device_register(&omap3_etb_device, &iomem_resource);
> +	amba_device_register(&omap3_etm_device, &iomem_resource);
> +
> +	return 0;
> +}
> +
> +subsys_initcall(emu_init);
> +
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
