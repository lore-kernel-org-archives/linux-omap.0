From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V4 3/3] ARM: OMAP: Make OMAP clocksource source
 selection using kernel param
Date: Tue, 24 Apr 2012 09:20:16 -0700
Message-ID: <20120424162016.GK3739@atomide.com>
References: <1335260749-25877-1-git-send-email-hvaibhav@ti.com>
 <1335260749-25877-4-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:31918 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770Ab2DXQUU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 12:20:20 -0400
Content-Disposition: inline
In-Reply-To: <1335260749-25877-4-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Ming Lei <tom.leiming@gmail.com>

Hi,

* Vaibhav Hiremath <hvaibhav@ti.com> [120424 02:54]:
> Current OMAP code supports couple of clocksource options based
> on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz).
> So there can be 3 options -
> 
> 1. 32KHz sync-timer
> 2. Sys_clock based (e.g 13/19.2/26/38.4 MHz) gptimer
> 3. 32KHz based gptimer.
> 
> The optional gptimer based clocksource was added so that it can
> give the high precision than sync-timer, so expected usage was 2
> and not 3.
> Unfortunately option 2, clocksource doesn't meet the requirement of
> free-running clock as per clocksource need. It stops in low power states
> when sys_clock is cut. That makes gptimer based clocksource option
> useless for OMAP2/3/4 devices with sys_clock as a clock input.
> Option 3 will still work but it is no better than 32K sync-timer
> based clocksource.

For some cases sys clock based timer is still valid if you don't
care about PM. In that case deeper idle states need to be disabled,
not the timer as discussed earlier. Please update the comments accordingly.
 
> So ideally we can kill the gptimer based clocksource option but there
> are some OMAP based derivative SoCs like AM33XX which doesn't have
> 32K sync-timer hardware IP and need to fallback on 32KHz based gptimer
> clocksource.

Maybe just say: "We must support both sync timer and gptimer based
clocksource as some AM33XX hardware does not have the sync timer."

> Considering above, make sync-timer and gptimer clocksource runtime
> selectable so that both OMAP and AMXXXX continue to use the same code.
> 
> Also, in order to precisely configure/setup sched_clock for given
> clocksource, decision has to be made early enough in boot sequence.
> 
> So, the solution is,
> 
> Use kernel parameter ("clocksource=") to override

Maybe say: "Use standard kernel parameter ("clocksource=")..."

> --- a/arch/arm/mach-omap1/timer32k.c
> +++ b/arch/arm/mach-omap1/timer32k.c
> @@ -71,6 +71,7 @@
> 
>  /* 16xx specific defines */
>  #define OMAP1_32K_TIMER_BASE		0xfffb9000
> +#define OMAP1_32KSYNC_TIMER_BASE	0xfffbc400
>  #define OMAP1_32K_TIMER_CR		0x08
>  #define OMAP1_32K_TIMER_TVR		0x00
>  #define OMAP1_32K_TIMER_TCR		0x04
> @@ -184,7 +185,10 @@ static __init void omap_init_32k_timer(void)
>   */
>  bool __init omap_32k_timer_init(void)
>  {
> -	omap_init_clocksource_32k();
> +	u32 pbase;
> +
> +	pbase = cpu_is_omap16xx() ? OMAP1_32KSYNC_TIMER_BASE : NULL;
> +	omap_init_clocksource_32k(pbase, SZ_1K);
>  	omap_init_32k_timer();
> 
>  	return true;

Has this patch been tested on omap1?


> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -510,3 +540,28 @@ static int __init omap2_dm_timer_init(void)
>  	return 0;
>  }
>  arch_initcall(omap2_dm_timer_init);
> +
> +/**
> + * omap2_override_clocksource - clocksource override with user configuration
> + *
> + * Allows user to override default clocksource, using kernel parameter
> + *   clocksource="gp timer"
> + *
> + * Note that, here we are using same standard kernel parameter "clocksource=",
> + * and not introducing any OMAP specific interface.
> + */
> +static int __init omap2_override_clocksource(char *str)
> +{
> +	if (!str)
> +		return 0;
> +	/*
> +	 * For OMAP architecture, we only have two options
> +	 *    - sync_32k (default)
> +	 *    - gp timer
> +	 */
> +	if (!strcmp(str, "gp timer"))
> +		use_gptimer_clksrc = true;
> +
> +	return 0;
> +}
> +early_param("clocksource", omap2_override_clocksource);

Should say "For omap2plus architectures" and should say three options.
If the sys clock based timer is not currently supported, please mention
that in the comments.

Regards,

Tony
