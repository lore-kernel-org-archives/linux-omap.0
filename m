From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/7][RFC] OMAP4: Update common omap machine specific
	sources.
Date: Tue, 21 Apr 2009 11:36:45 -0700
Message-ID: <20090421183644.GL25864@atomide.com>
References: <1240319293-19662-1-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-2-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-3-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-4-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-5-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65401 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758129AbZDUSgs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Apr 2009 14:36:48 -0400
Content-Disposition: inline
In-Reply-To: <1240319293-19662-5-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [090421 06:08]:
> This patch updates the common machine spcific source files for OMAP4430.
> Few OMAP4 peripherals are common with OMAP3 architecture. Lot of code
> gets re-used because of this.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c     |    3 ++
>  arch/arm/mach-omap2/id.c       |    5 +++-
>  arch/arm/mach-omap2/io.c       |   48 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/timer-gp.c |    6 ++++-
>  4 files changed, 60 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 2249049..07aea04 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -424,6 +424,9 @@ void __init gpmc_init(void)
>  	} else if (cpu_is_omap34xx()) {
>  		ck = "gpmc_fck";
>  		l = OMAP34XX_GPMC_BASE;
> +	} else if (cpu_is_omap44xx()) {
> +		ck = "gpmc_fck";
> +		l = OMAP44XX_GPMC_BASE;
>  	}
>  
>  	gpmc_l3_clk = clk_get(NULL, ck);
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 34b5914..f69384d 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -196,7 +196,10 @@ void __init omap2_check_revision(void)
>  	 * At this point we have an idea about the processor revision set
>  	 * earlier with omap2_set_globals_tap().
>  	 */
> -	if (cpu_is_omap24xx())
> +	if (cpu_is_omap44xx()) {
> +		printk(KERN_INFO "CPU revision = OMAP4430\n"); /* Fix Me*/
> +		return;
> +	} else if (cpu_is_omap24xx())
>  		omap24xx_check_revision();
>  	else if (cpu_is_omap34xx())
>  		omap34xx_check_revision();
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 916fcd3..3f7a7f5 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -30,6 +30,7 @@
>  #include <mach/sdrc.h>
>  #include <mach/gpmc.h>
>  
> +#ifndef CONFIG_ARCH_OMAP4 /* Clock framework is still not supported for OMAP4*/
>  #include "clock.h"
>  
>  #include <mach/powerdomain.h>
> @@ -38,6 +39,7 @@
>  
>  #include <mach/clockdomain.h>
>  #include "clockdomains.h"
> +#endif
>  
>  /*
>   * The machine specific code may provide the extra mapping besides the
> @@ -166,6 +168,46 @@ static struct map_desc omap34xx_io_desc[] __initdata = {
>  	},
>  };
>  #endif
> +#ifdef	CONFIG_ARCH_OMAP44XX
> +static struct map_desc omap44xx_io_desc[] __initdata = {
> +	{
> +		.virtual	= L3_44XX_VIRT,
> +		.pfn		= __phys_to_pfn(L3_44XX_PHYS),
> +		.length		= L3_44XX_SIZE,
> +		.type		= MT_DEVICE
> +	},
> +	{
> +		.virtual	= L4_44XX_VIRT,
> +		.pfn		= __phys_to_pfn(L4_44XX_PHYS),
> +		.length		= L4_44XX_SIZE,
> +		.type		= MT_DEVICE
> +	},
> +	{
> +		.virtual	= L4_WK_44XX_VIRT,
> +		.pfn		= __phys_to_pfn(L4_WK_44XX_PHYS),
> +		.length		= L4_WK_44XX_SIZE,
> +		.type		= MT_DEVICE
> +	},
> +	{
> +		.virtual	= OMAP44XX_GPMC_VIRT,
> +		.pfn		= __phys_to_pfn(OMAP44XX_GPMC_PHYS),
> +		.length		= OMAP44XX_GPMC_SIZE,
> +		.type		= MT_DEVICE
> +	},
> +	{
> +		.virtual	= L4_PER_44XX_VIRT,
> +		.pfn		= __phys_to_pfn(L4_PER_44XX_PHYS),
> +		.length		= L4_PER_44XX_SIZE,
> +		.type		= MT_DEVICE
> +	},
> +	{
> +		.virtual	= L4_EMU_44XX_VIRT,
> +		.pfn		= __phys_to_pfn(L4_EMU_44XX_PHYS),
> +		.length		= L4_EMU_44XX_SIZE,
> +		.type		= MT_DEVICE
> +	},
> +};
> +#endif
>  
>  void __init omap2_map_common_io(void)
>  {
> @@ -183,6 +225,10 @@ void __init omap2_map_common_io(void)
>  	iotable_init(omap34xx_io_desc, ARRAY_SIZE(omap34xx_io_desc));
>  #endif
>  
> +#if defined(CONFIG_ARCH_OMAP44XX)
> +	iotable_init(omap44xx_io_desc, ARRAY_SIZE(omap44xx_io_desc));
> +#endif
> +

This will break multi-omap. The cpu_is_omap44xx() works very early
during the boot nowadays as the omap2_set_globals_44xx() initializes
that, so please use that instead.


>  	/* Normally devicemaps_init() would flush caches and tlb after
>  	 * mdesc->map_io(), but we must also do it here because of the CPU
>  	 * revision check below.
> @@ -198,9 +244,11 @@ void __init omap2_map_common_io(void)
>  void __init omap2_init_common_hw(struct omap_sdrc_params *sp)
>  {
>  	omap2_mux_init();
> +#ifndef CONFIG_ARCH_OMAP4 /* REVISIT: to avoid build errors */
>  	pwrdm_init(powerdomains_omap);
>  	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
>  	omap2_clk_init();
>  	omap2_sdrc_init(sp);
> +#endif
>  	gpmc_init();
>  }

Please use cpu_is_omap44xx() here too instead of the ifndef.


> diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
> index 9fc13a2..f9f41df 100644
> --- a/arch/arm/mach-omap2/timer-gp.c
> +++ b/arch/arm/mach-omap2/timer-gp.c
> @@ -75,7 +75,8 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
>  	case CLOCK_EVT_MODE_PERIODIC:
>  		period = clk_get_rate(omap_dm_timer_get_fclk(gptimer)) / HZ;
>  		period -= 1;
> -
> +		if (cpu_is_omap44xx())
> +			period = 0xFF;
>  		omap_dm_timer_set_load_start(gptimer, 1, 0xffffffff - period);
>  		break;
>  	case CLOCK_EVT_MODE_ONESHOT:
> @@ -108,6 +109,9 @@ static void __init omap2_gp_clockevent_init(void)
>  	omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_SYS_CLK);
>  #endif
>  	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer));
> +	if (cpu_is_omap44xx())
> +		/* Assuming 32kHz clk is driving GPT1 */
> +		tick_rate = 32768;
>  
>  	omap2_gp_timer_irq.dev_id = (void *)gptimer;
>  	setup_irq(omap_dm_timer_get_irq(gptimer), &omap2_gp_timer_irq);
> -- 
> 1.5.4.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
