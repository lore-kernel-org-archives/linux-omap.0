From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 5/7][RFC] OMAP4: Update common omap machine specific sources.
Date: Tue, 21 Apr 2009 09:23:09 -0700
Message-ID: <87tz4i6knm.fsf@deeprootsystems.com>
References: <1240319293-19662-1-git-send-email-santosh.shilimkar@ti.com>
	<1240319293-19662-2-git-send-email-santosh.shilimkar@ti.com>
	<1240319293-19662-3-git-send-email-santosh.shilimkar@ti.com>
	<1240319293-19662-4-git-send-email-santosh.shilimkar@ti.com>
	<1240319293-19662-5-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:54666 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbZDUQXP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Apr 2009 12:23:15 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2495277rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 21 Apr 2009 09:23:12 -0700 (PDT)
In-Reply-To: <1240319293-19662-5-git-send-email-santosh.shilimkar@ti.com> (Santosh Shilimkar's message of "Tue\, 21 Apr 2009 18\:38\:11 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> This patch updates the common machine spcific source files for OMAP4430.
> Few OMAP4 peripherals are common with OMAP3 architecture. Lot of code
> gets re-used because of this.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

[...]

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

Clock fw is not supported, but including these files should be harmless.

[...]

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

Rather than the #ifdef here, can you stub these out in the relevant
files instead.

>  	gpmc_init();
>  }
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

Put a FIXME here noting that this should be removed when clk fw is
implemented.

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

ditto

Kevin


