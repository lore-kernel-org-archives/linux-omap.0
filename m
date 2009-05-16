From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RESUBMIT][PATCH 4/7] OMAP4: Update common omap platform
	common sources.
Date: Sat, 16 May 2009 10:53:32 +0100
Message-ID: <20090516095332.GH15328@n2100.arm.linux.org.uk>
References: <1241677756-28756-1-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-2-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-3-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-4-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43000 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755472AbZEPJxl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 05:53:41 -0400
Content-Disposition: inline
In-Reply-To: <1241677756-28756-4-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Thu, May 07, 2009 at 11:59:13AM +0530, Santosh Shilimkar wrote:
> @@ -309,3 +313,26 @@ void __init omap2_set_globals_343x(void)
>  }
>  #endif
>  
> +#if defined(CONFIG_ARCH_OMAP4)
> +static struct omap_globals *omap4_globals;
> +
> +static void __init __omap4_set_globals(void)
> +{
> +	omap2_set_globals_tap(omap4_globals);
> +	omap2_set_globals_control(omap4_globals);
> +}
> +static struct omap_globals omap443x_globals = {
> +	.class	= OMAP443X_CLASS,
> +	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
> +	.ctrl	= OMAP2_IO_ADDRESS(OMAP443X_CTRL_BASE),
> +	.prm	= OMAP2_IO_ADDRESS(OMAP4430_PRM_BASE),
> +	.cm	= OMAP2_IO_ADDRESS(OMAP4430_CM_BASE),
> +};
> +
> +void __init omap2_set_globals_443x(void)
> +{
> +	omap4_globals = &omap443x_globals;
> +	__omap4_set_globals();

Hmm, confused.  omap4_globals is a static variable, and __omap4_set_globals
is a static function.  The only user of omap4_globals is __omap4_set_globals.
It looks to me like the only purpose of omap4_globals is to pass a
structure to __omap4_set_globals.  Why not use a function argument instead?

> diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
> index 87fb7ff..a016c6c 100644
> --- a/arch/arm/plat-omap/devices.c
> +++ b/arch/arm/plat-omap/devices.c
> @@ -311,6 +311,8 @@ static void omap_init_wdt(void)
>  		wdt_resources[0].start = 0x49016000; /* WDT2 */
>  	else if (cpu_is_omap343x())
>  		wdt_resources[0].start = 0x48314000; /* WDT2 */
> +	else if (cpu_is_omap44xx())
> +		wdt_resources[0].start = 0x4A314000;

Normally lower case characters for hex.

> -	if (cpu_class_is_omap2())
> -		setup_irq(INT_24XX_SDMA_IRQ0, &omap24xx_dma_irq);
> +	if (cpu_class_is_omap2()) {
> +		if (cpu_is_omap44xx())
> +			setup_irq(INT_44XX_SDMA_IRQ0, &omap24xx_dma_irq);
> +		else
> +			setup_irq(INT_24XX_SDMA_IRQ0, &omap24xx_dma_irq);
> +	}

	if (cpu_class_is_omap2()) {
		int irq;
		if (cpu_is_omap44xx())
			irq = INT_44XX_SDMA_IRQ0;
		else
			irq = INT_24XX_SDMA_IRQ0;
		setup_irq(irq, &omap24xx_dma_irq);
	}

would be a cleaner approach.

> +static struct omap_dm_timer omap4_dm_timers[] = {
> +	{ .phys_base = 0x4A318000, .irq = INT_44XX_GPTIMER1 },
> +	{ .phys_base = 0x48032000, .irq = INT_44XX_GPTIMER2 },
> +	{ .phys_base = 0x48034000, .irq = INT_44XX_GPTIMER3 },
> +	{ .phys_base = 0x48036000, .irq = INT_44XX_GPTIMER4 },
> +	{ .phys_base = 0x40138000, .irq = INT_44XX_GPTIMER5 },
> +	{ .phys_base = 0x4013A000, .irq = INT_44XX_GPTIMER6 },
> +	{ .phys_base = 0x4013C000, .irq = INT_44XX_GPTIMER7 },
> +	{ .phys_base = 0x4013E000, .irq = INT_44XX_GPTIMER8 },
> +	{ .phys_base = 0x4803E000, .irq = INT_44XX_GPTIMER9 },
> +	{ .phys_base = 0x48086000, .irq = INT_44XX_GPTIMER10 },
> +	{ .phys_base = 0x48088000, .irq = INT_44XX_GPTIMER11 },
> +	{ .phys_base = 0x4A320000, .irq = INT_44XX_GPTIMER12 },

Lower case for hex.

> +};
> +static const char *omap4_dm_source_names[] __initdata = {
> +	"sys_ck",
> +	"omap_32k_fck",
> +	NULL
> +};
> +static struct clk **omap4_dm_source_clocks[2];

Umm.  struct clk **[2].

> +static const int dm_timer_count = ARRAY_SIZE(omap4_dm_timers);
> +
>  #else
>  
>  #error OMAP architecture not supported!
> @@ -461,7 +508,8 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
>  }
>  EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
>  
> -#elif defined(CONFIG_ARCH_OMAP2) || defined (CONFIG_ARCH_OMAP3)
> +#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
> +				defined(CONFIG_ARCH_OMAP4)
>  
>  struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
>  {
> @@ -705,6 +753,10 @@ int __init omap_dm_timer_init(void)
>  		dm_timers = omap3_dm_timers;
>  		dm_source_names = (char **)omap3_dm_source_names;
>  		dm_source_clocks = (struct clk **)omap3_dm_source_clocks;
> +	} else if (cpu_is_omap44xx()) {
> +		dm_timers = omap4_dm_timers;
> +		dm_source_names = (char **)omap4_dm_source_names;
> +		dm_source_clocks = (struct clk **)omap4_dm_source_clocks;

which then gets casted to a struct clk **.  These are two different
objects.  I don't think someone quite understood what they were
doing here and threw a cast in to shut up the compiler warning:

	warning: assignment from incompatible pointer type

This is *very* wrong and is a prime example of why casts are _bad_
news.  This cast is saying "THERE IS A BUG HERE" in 100ft high letters.

What you want is:

static struct clk *omap4_dm_source_clocks[2];
...

		dm_source_clocks = omap4_dm_source_clocks;

This is because struct clk *[] is equivalent to struct clk **.
(remember that arrays are handled in C as a pointer to the first
array element.)

As for the pointer to the array of names, why can't this be declared
const and therefore that cast be removed?

TTOTD: Casts are bad news.  It's far better to have stuff correctly
typed in the first place.

> diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
> index af326ef..fbd7b3c 100644
> --- a/arch/arm/plat-omap/io.c
> +++ b/arch/arm/plat-omap/io.c
> @@ -1,3 +1,15 @@
> +/*
> + * Common io.c file
> + *
> + * Copyright (C) 2009 Texas Instruments
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
> + *
> + * Based on mach-omap2/board-3430sdp.c

Err, this is a rubbish header.  It is not based upon board-3430sdp.c.
The majority of the file is also my own work and unfortunately the
above addition of TI's copyright makes it look like 100% TIs own
work.  See commit 690b5a13b27ba3bb2c9d61c1f4018c5074b591e6.

> @@ -242,10 +261,12 @@ void * omap_sram_push(void * start, unsigned long size)
>  	return (void *)omap_sram_ceil;
>  }
>  
> +#ifndef CONFIG_ARCH_OMAP4 /* to remove compile time warning */
>  static void omap_sram_error(void)
>  {
>  	panic("Uninitialized SRAM function\n");
>  }
> +#endif

I'm not sure why we have this either - doing:

	if (!something_which_were_going_to_call)
		panic();

is even more extreme than:

	BUG_ON(!something_which_were_going_to_call);

So I suggest someone very quickly gets around to removing this silly
omap_sram_error() and replaces it with a BUG_ON.  This will also remove
the need for your above ifndef.
