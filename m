From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: generic: add call to of_clk_init()
Date: Wed, 23 Jul 2014 01:54:45 -0700
Message-ID: <20140723085444.GC22006@atomide.com>
References: <1405162508-9835-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:39575 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757227AbaGWI4N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jul 2014 04:56:13 -0400
Content-Disposition: inline
In-Reply-To: <1405162508-9835-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>

* Daniel Mack <zonque@gmail.com> [140712 03:57]:
> This is needed to instanciate fixed clocks in the DT.

Makes sense to me. Does this fix some regression or hang
that's needed for the -rc series?

Also would like to get an ack from Tero on this as the other
clocks are initialized elsewhere.

Regards,

Tony
 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  arch/arm/mach-omap2/board-generic.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index 5606fa2..39f154a 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/irqdomain.h>
> +#include <linux/clk-provider.h>
>  
>  #include <asm/mach/arch.h>
>  
> @@ -33,6 +34,11 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
>  	{ }
>  };
>  
> +static struct of_device_id clk_match[] __initdata = {
> +	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
> +	{ }
> +};
> +
>  static void __init omap_generic_init(void)
>  {
>  	omapdss_early_init_of();
> @@ -40,6 +46,8 @@ static void __init omap_generic_init(void)
>  	pdata_quirks_init(omap_dt_match_table);
>  
>  	omapdss_init_of();
> +
> +	of_clk_init(clk_match);
>  }
>  
>  #ifdef CONFIG_SOC_OMAP2420
> -- 
> 1.9.3
> 
