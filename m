From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 10/10] ARM: OMAP2+: board-generic: Remove i2c static
 init
Date: Wed, 4 Jan 2012 11:15:34 -0700
Message-ID: <20120104181534.GQ15503@ponder.secretlab.ca>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-11-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43766 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab2ADTGS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jan 2012 14:06:18 -0500
Received: by mail-vw0-f46.google.com with SMTP id fc26so13621965vbb.19
        for <linux-omap@vger.kernel.org>; Wed, 04 Jan 2012 11:06:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323439361-1647-11-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Dec 09, 2011 at 03:02:41PM +0100, Benoit Cousson wrote:
> This mainly reverts the commit that was adding the i2c static init.
> 
> Since the i2c and twl nodes are now present, there is no need
> for the static initialization anymore.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  arch/arm/mach-omap2/board-generic.c |   48 +---------------------------------
>  1 files changed, 2 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index 16c301e..63a2495 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -15,7 +15,6 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/irqdomain.h>
> -#include <linux/i2c/twl.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/hardware/gic.h>
> @@ -36,34 +35,6 @@ static void __init omap_init_irq(void)
>  	of_irq_init(irq_match);
>  }
>  
> -/*
> - * XXX: Still needed to boot until the i2c & twl driver is adapted to
> - * device-tree
> - */
> -#ifdef CONFIG_ARCH_OMAP4
> -static struct twl4030_platform_data sdp4430_twldata = {
> -	.irq_base	= TWL6030_IRQ_BASE,
> -	.irq_end	= TWL6030_IRQ_END,
> -};
> -
> -static void __init omap4_i2c_init(void)
> -{
> -	omap4_pmic_init("twl6030", &sdp4430_twldata);
> -}
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP3
> -static struct twl4030_platform_data beagle_twldata = {
> -	.irq_base	= TWL4030_IRQ_BASE,
> -	.irq_end	= TWL4030_IRQ_END,
> -};
> -
> -static void __init omap3_i2c_init(void)
> -{
> -	omap3_pmic_init("twl4030", &beagle_twldata);
> -}
> -#endif
> -
>  static struct of_device_id omap_dt_match_table[] __initdata = {
>  	{ .compatible = "simple-bus", },
>  	{ .compatible = "ti,omap-infra", },
> @@ -78,21 +49,6 @@ static void __init omap_generic_init(void)
>  	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
>  }
>  
> -#ifdef CONFIG_ARCH_OMAP4
> -static void __init omap4_init(void)
> -{
> -	omap4_i2c_init();
> -	omap_generic_init();
> -}
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP3
> -static void __init omap3_init(void)
> -{
> -	omap3_i2c_init();
> -	omap_generic_init();
> -}
> -#endif
>  
>  #ifdef CONFIG_SOC_OMAP2420
>  static const char *omap242x_boards_compat[] __initdata = {
> @@ -145,7 +101,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
>  	.init_early	= omap3430_init_early,
>  	.init_irq	= omap_init_irq,
>  	.handle_irq	= omap3_intc_handle_irq,
> -	.init_machine	= omap3_init,
> +	.init_machine	= omap_generic_init,
>  	.timer		= &omap3_timer,
>  	.dt_compat	= omap3_boards_compat,
>  MACHINE_END
> @@ -164,7 +120,7 @@ DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
>  	.init_early	= omap4430_init_early,
>  	.init_irq	= omap_init_irq,
>  	.handle_irq	= gic_handle_irq,
> -	.init_machine	= omap4_init,
> +	.init_machine	= omap_generic_init,
>  	.timer		= &omap4_timer,
>  	.dt_compat	= omap4_boards_compat,
>  MACHINE_END
> -- 
> 1.7.0.4
> 
