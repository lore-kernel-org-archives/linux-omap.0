From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH 6/7] OMAP3: board-dt: Add generic board file for DT
 support
Date: Mon, 5 Sep 2011 17:39:14 +0530
Message-ID: <20110905120914.GA25418@manju-desktop>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
 <1314897912-18178-7-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:57573 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752489Ab1IEMJf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 08:09:35 -0400
Received: by pzk34 with SMTP id 34so7866946pzk.21
        for <linux-omap@vger.kernel.org>; Mon, 05 Sep 2011 05:09:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1314897912-18178-7-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: grant.likely@secretlab.ca, tony@atomide.com, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Minor comments:

On Thu, Sep 01, 2011 at 07:25:11PM +0200, Benoit Cousson wrote:
> Create an OMAP3 generic board to start the DT migration.
> 
> This file is doing the minimal initialization needed to boot
> properly on a RAMDISK filesystem.
> 
> As soon as the OMAP3 specifics will be removed, that board will
> be converted to an even more generic board-dt.c that will support
> every OMAP2+ platforms.
> 
> Based on original patch from Manju:
> http://www.spinics.net/lists/linux-omap/msg55832.html
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig          |   10 +++++
>  arch/arm/mach-omap2/Makefile         |    1 +
>  arch/arm/mach-omap2/board-omap3-dt.c |   74 ++++++++++++++++++++++++++++++++++
>  3 files changed, 85 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-omap3-dt.c
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 5d501d2..82f0df2 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -305,6 +305,16 @@ config MACH_OMAP_3630SDP
>  	default y
>  	select OMAP_PACKAGE_CBP
>  
> +config MACH_OMAP3_DT
> +	bool "Generic OMAP3 board (FDT support)"
> +	depends on ARCH_OMAP3
> +	select OMAP_PACKAGE_CBB
> +	select USE_OF
> +	help
> +	  Support for generic TI OMAP3 boards using Flattened Device Tree.
> +	  Say Y here to enable OMAP3 device tree support
> +	  More information at Documentation/devicetree
> +
>  config MACH_TI8168EVM
>  	bool "TI8168 Evaluation Module"
>  	depends on SOC_OMAPTI816X
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 6ab9116..5144c17 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -197,6 +197,7 @@ obj-$(CONFIG_MACH_OVERO)		+= board-overo.o
>  obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
>  obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o
>  obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o
> +obj-$(CONFIG_MACH_OMAP3_DT)		+= board-omap3-dt.o
>  obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
>  obj-$(CONFIG_MACH_NOKIA_RM680)		+= board-rm680.o \
>  					   sdram-nokia.o
> diff --git a/arch/arm/mach-omap2/board-omap3-dt.c b/arch/arm/mach-omap2/board-omap3-dt.c
> new file mode 100644
> index 0000000..6eb56c6
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-omap3-dt.c
> @@ -0,0 +1,74 @@
> +/*
> + * OMAP3 Device tree boards support
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/irqdomain.h>
> +#include <linux/of_platform.h>
> +#include <linux/i2c/twl.h>
this header is redundant
> +
> +#include <asm/mach/arch.h>
> +#include <plat/common.h>
> +
> +#include "mux.h"
> +#include "common-board-devices.h"
> +#include "sdram-micron-mt46h32m32lf-6.h"
> +
> +
extra blank line

-M
> +static void __init omap3_init_early(void)
> +{
> +	omap2_init_common_infrastructure();
> +	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
> +				  mt46h32m32lf6_sdrc_params);
> +}
> +
> +#ifdef CONFIG_OMAP_MUX
> +static struct omap_board_mux board_mux[] __initdata = {
> +	{ .reg_offset = OMAP_MUX_TERMINATOR },
> +};
> +#endif
> +
> +static struct of_device_id omap_dt_match_table[] __initdata = {
> +	{ .compatible = "simple-bus", },
> +	{ .compatible = "ti,omap-infra", },
> +	{}
> +};
> +
> +static struct of_device_id omap_dt_intc_match[] __initdata = {
> +	{ .compatible = "ti,omap3-intc", },
> +	{}
> +};
> +
> +static void __init omap3_init(void)
> +{
> +	struct device_node *node;
> +
> +	node = of_find_matching_node(NULL, omap_dt_intc_match);
> +	if (node)
> +		irq_domain_add_simple(node, 0);
> +
> +	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> +	omap_serial_init();
> +
> +	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
> +}
> +
> +static const char *omap3_dt_match[] __initdata = {
> +	"ti,omap3",
> +	NULL
> +};
> +
> +DT_MACHINE_START(OMAP3_DT, "TI OMAP3 (Flattened Device Tree)")
> +	.reserve	= omap_reserve,
> +	.map_io		= omap3_map_io,
> +	.init_early	= omap3_init_early,
> +	.init_irq	= omap3_init_irq,
> +	.init_machine	= omap3_init,
> +	.timer		= &omap3_timer,
> +	.dt_compat	= omap3_dt_match,
> +MACHINE_END
> -- 
> 1.7.0.4
> 
