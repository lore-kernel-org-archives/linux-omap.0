From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH]PM: Initialization of SDRC params for DVFS on Zoom2
Date: Tue, 08 Sep 2009 15:17:42 -0700
Message-ID: <87ljkpm67t.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A007938@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f201.google.com ([209.85.222.201]:38392 "EHLO
	mail-pz0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbZIHWRn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Sep 2009 18:17:43 -0400
Received: by pzk39 with SMTP id 39so3532535pzk.15
        for <linux-omap@vger.kernel.org>; Tue, 08 Sep 2009 15:17:46 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A007938@dbde02.ent.ti.com> (Teerth Reddy's message of "Mon\, 7 Sep 2009 19\:19\:26 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Reddy, Teerth" <teerth@ti.com> writes:

> This patch initializes the SDRC params for DVFS on Zoom2.
>
> Signed-off-by: Teerth Reddy <teerth@ti.com>
> ---
>  arch/arm/mach-omap2/board-zoom2.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> Index: linux-omap-pm/arch/arm/mach-omap2/board-zoom2.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/board-zoom2.c
> +++ linux-omap-pm/arch/arm/mach-omap2/board-zoom2.c
> @@ -23,6 +23,7 @@
>  
>  #include "mmc-twl4030.h"
>  #include "omap3-opp.h"
> +#include "sdram-micron-mt46h32m32lf-6.h"
>  
>  static struct omap_uart_config zoom2_uart_config __initdata = {
>  	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
> @@ -36,8 +37,9 @@ static void __init omap_zoom2_init_irq(v
>  {
>  	omap_board_config = zoom2_config;
>  	omap_board_config_size = ARRAY_SIZE(zoom2_config);
> -	omap2_init_common_hw(NULL, NULL, omap3_mpu_rate_table,
> -	                     omap3_dsp_rate_table, omap3_l3_rate_table);
> +	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL,
> +		omap3_mpu_rate_table, omap3_dsp_rate_table,
> +					omap3_l3_rate_table);

Not having looked at the Zoom2 schematics, are you sure this is only
using a single chip select?  The other boards using the same part
(beagle, overo) are interfacing to this part using both CSes.

Have you tested DVFS on Zoom2 using the full 256Mb?

Kevin

>  	omap_init_irq();
>  	omap_gpio_init();
>  }
