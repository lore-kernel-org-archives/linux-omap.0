From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/7] OMAP3: board-dt: Add generic board file for DT
 support
Date: Fri, 2 Sep 2011 11:09:44 +0300
Message-ID: <20110902080944.GP3548@atomide.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
 <1314897912-18178-7-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:39133 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758136Ab1IBIJu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 04:09:50 -0400
Content-Disposition: inline
In-Reply-To: <1314897912-18178-7-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: grant.likely@secretlab.ca, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, manjugk@ti.com

Hi,

* Benoit Cousson <b-cousson@ti.com> [110901 19:52]:
> Create an OMAP3 generic board to start the DT migration.

I don't think this needs to be SoC specific, we can add multiple
DT_MACHINE_START entries into a single file. So it should be
just board-omap-dt.c.
 
> +#include "mux.h"
> +#include "common-board-devices.h"
> +#include "sdram-micron-mt46h32m32lf-6.h"
> +
> +
> +static void __init omap3_init_early(void)
> +{
> +	omap2_init_common_infrastructure();
> +	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
> +				  mt46h32m32lf6_sdrc_params);
> +}

This has changed, see the cleanup branch. Also, let's just leave
out the sdram timings for now as we can work with bootloader
timings until those come from DT too.

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

Most likely we just need SoC specific init functions in this file
now until the mux data comes from DT also.

> +DT_MACHINE_START(OMAP3_DT, "TI OMAP3 (Flattened Device Tree)")
> +	.reserve	= omap_reserve,
> +	.map_io		= omap3_map_io,
> +	.init_early	= omap3_init_early,
> +	.init_irq	= omap3_init_irq,
> +	.init_machine	= omap3_init,
> +	.timer		= &omap3_timer,
> +	.dt_compat	= omap3_dt_match,
> +MACHINE_END

Here omap3_init_early is now generic in the cleanup branch.

Regards,

Tony
