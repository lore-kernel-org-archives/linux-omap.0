From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/9] OMAP2/3/4 : Dual mode timer device registration.
Date: Thu, 03 Jun 2010 16:18:37 -0700
Message-ID: <87y6evk8mq.fsf@deeprootsystems.com>
References: <1275143831-7629-1-git-send-email-thara@ti.com>
	<1275143831-7629-2-git-send-email-thara@ti.com>
	<1275143831-7629-3-git-send-email-thara@ti.com>
	<1275143831-7629-4-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63233 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756538Ab0FCXSl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 19:18:41 -0400
Received: by pvg16 with SMTP id 16so299445pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 16:18:40 -0700 (PDT)
In-Reply-To: <1275143831-7629-4-git-send-email-thara@ti.com> (Thara Gopinath's message of "Sat\, 29 May 2010 20\:07\:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch converts OMAP2/OMAP3/OMAP4 dual mode timers into
> platform devices using omap hwmod, omap device and runtime pm frameworks.
> This patch also allows GPTIMER1 and GPTIMER2 to be registered as
> early devices. This will allow GPTIMER1 to be registered as
> system timer very early on in the system boot up sequence.
> Later during normal plaform_device_register these are converted
> to normal platform device.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

First, a couple of general comments.

You're using the runtime PM API here in the device layer hooks.  This
should be in the driver.  It will be a noop for OMAP1 since there will
be no runtime PM implementation, but that is fine.  Moving this into
the driver should allow you to get rid of the enable/disable clock
hooks you currently have in platform_data as well (for early timers
you could leave them enabled until they are converted to "normal"
timers.)

Also, I suggested this to Charu as well for GPIO and WDT, but we
should leave out the handling of the #ifndef CONFIG_PM_RUNTIME from
this code.  I'd rather not have every driver handling that special
case.  Instead I propose we handle this in the omap_hwmod init sequence
by enabling all the hwmods if !CONFIG_PM_RUNTIME.

> ---
>  arch/arm/mach-omap2/Makefile   |    3 +-
>  arch/arm/mach-omap2/dmtimers.c |  296 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/dmtimers.h |   57 ++++++++
>  arch/arm/mach-omap2/timer-gp.c |    2 -
>  4 files changed, 355 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/dmtimers.c
>  create mode 100644 arch/arm/mach-omap2/dmtimers.h
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index dd3a24a..9299e4f 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -3,7 +3,8 @@
>  #
>  
>  # Common support
> -obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
> +obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o \
> +	dmtimers.o
>  
>  omap-2-3-common				= irq.o sdrc.o
>  hwmod-common				= omap_hwmod.o \
> diff --git a/arch/arm/mach-omap2/dmtimers.c b/arch/arm/mach-omap2/dmtimers.c
> new file mode 100644
> index 0000000..6a2caf3
> --- /dev/null
> +++ b/arch/arm/mach-omap2/dmtimers.c
> @@ -0,0 +1,296 @@
> +/**
> + * OMAP2 Dual-Mode Timers
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + * Thara Gopinath <thara@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/pm_runtime.h>
> +
> +#include <mach/irqs.h>
> +#include <plat/dmtimer.h>
> +#include <plat/omap_hwmod.h>
> +#include <plat/omap_device.h>
> +
> +#include "dmtimers.h"
> +
> +#define NO_EARLY_TIMERS			2

Please use NR_EARLY_TIMERS

> +#define OMAP2_DM_TIMER_COUNT		12
> +#define OMAP3PLUS_DM_TIMER_COUNT	11

and these you should get rid of as Benoit pointed out.  More on this
below.

> +static char *omap2_dm_source_names[] __initdata = {
> +	"sys_ck",
> +	"func_32k_ck",
> +	"alt_ck",
> +	NULL
> +};
> +static struct clk *omap2_dm_source_clocks[3];
> +
> +static char *omap3_dm_source_names[] __initdata = {
> +	"sys_ck",
> +	"omap_32k_fck",
> +	NULL
> +};
> +static struct clk *omap3_dm_source_clocks[2];
> +
> +static char *omap4_dm_source_names[] __initdata = {
> +	"sys_ck",
> +	"sys_32k_ck",
> +	NULL
> +};
> +static struct clk *omap4_dm_source_clocks[2];
> +
> +static struct clk **omap_dm_source_clocks;
> +
> +static void omap2_dm_timer_enable(struct platform_device *pdev)
> +{
> +
> +	if (pm_runtime_get_sync(&pdev->dev))
> +		dev_warn(&pdev->dev, "%s: Unable to enable the timer\n",
> +			__func__);
> +#ifndef CONFIG_PM_RUNTIME
> +	if (omap_device_enable(pdev))
> +		dev_warn(&pdev->dev, "%s: Unable to enable the timer\n",
> +			__func__);
> +#endif
> +}
> +
> +static void omap2_dm_timer_disable(struct platform_device *pdev)
> +{
> +
> +	if (pm_runtime_put_sync(&pdev->dev))
> +		dev_warn(&pdev->dev, "%s: Unable to disable the timer\n",
> +			__func__);
> +#ifndef CONFIG_PM_RUNTIME
> +	if (omap_device_idle(pdev))
> +		dev_warn(&pdev->dev, "%s: Unable to disable the timer\n",
> +			__func__);
> +#endif
> +}
> +
> +static int omap2_dm_timer_set_src(struct platform_device *pdev,
> +					struct clk *timer_clk, int source)
> +{
> +	int ret;
> +
> +	if (IS_ERR(timer_clk)) {
> +		dev_warn(&pdev->dev, "%s: Not able get the clock pointer\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	clk_disable(timer_clk);
> +	ret = clk_set_parent(timer_clk, omap_dm_source_clocks[source]);
> +	if (ret)
> +		dev_warn(&pdev->dev, "%s: Not able to change the"
> +			"fclk source\n", __func__);
> +
> +	clk_enable(timer_clk);
> +	/*
> +	 * When the functional clock disappears, too quick writes seem
> +	 * to cause an abort. XXX Is this still necessary?
> +	 */
> +	__delay(150000);
> +	return ret;
> +}
> +
> +static int omap2_dm_timer_set_clk(struct platform_device *pdev, int source)
> +{
> +	struct clk *timer_clk = clk_get(&pdev->dev, "fck");
> +
> +	return omap2_dm_timer_set_src(pdev, timer_clk, source);

Missing a clk_put() here.

> +}
> +
> +static struct clk *omap2_dm_timer_get_fclk(struct platform_device *pdev)
> +{
> +	return clk_get(&pdev->dev, "fck");
> +}
> +
> +/* API's to be used by early timer devices */
> +static void __init omap2_dm_early_timer_enable(struct platform_device *pdev)
> +{
> +	if (omap_device_enable(pdev))
> +		dev_warn(&pdev->dev, "%s: Unable to enable the timer\n",
> +			__func__);
> +}
> +
> +static void __init omap2_dm_early_timer_disable(struct platform_device *pdev)
> +{
> +	if (omap_device_idle(pdev))
> +		dev_warn(&pdev->dev, "%s: Unable to disable the timer\n",
> +			__func__);
> +}

I suggest just dropping the early enable/disable hooks and leaving
them enabled.  Once the "normal" probe runs, they can be disabled if
unused.  That will avoid having to havea special set of hooks for
early devices.

> +static int __init omap2_dm_early_timer_set_clk(struct platform_device *pdev,
> +					int source)
> +{
> +	struct omap_device *odev = to_omap_device(pdev);
> +
> +	return omap2_dm_timer_set_src(pdev, odev->hwmods[0]->_clk, source);
> +}

As Benoit mentioned, I think we may need an omap_hwmod_get_clk() or something
to avoid touching hwmod internals and make this cleaner.

That being said, why do you need a special "early" version of the
set_clk.  You could use this version for both.

> +static struct clk __init *omap2_dm_early_timer_get_fclk
> +				(struct platform_device *pdev)
> +{
> +	struct omap_device *odev = to_omap_device(pdev);
> +
> +	return odev->hwmods[0]->_clk;
> +}

Likewise, this could use a new function omap_hwmod_get_clk() and could
be used for both early and normal versions.

> +/* One time initializations */
> +static void __init omap2_dm_timer_setup(void)
> +{
> +	static int is_initialized;
> +	char **src_clk_name;
> +	int i;
> +
> +	/*
> +	 * Check if setup has already been done as part of early init.
> +	 * If yes avoid doing it again.
> +	 */
> +	if (is_initialized)
> +		return;
> +
> +	if (cpu_is_omap24xx()) {
> +		src_clk_name = omap2_dm_source_names;
> +		omap_dm_source_clocks = omap2_dm_source_clocks;
> +	} else if (cpu_is_omap34xx()) {
> +		src_clk_name = omap3_dm_source_names;
> +		omap_dm_source_clocks = omap3_dm_source_clocks;
> +	} else if (cpu_is_omap44xx()) {
> +		src_clk_name = omap4_dm_source_names;
> +		omap_dm_source_clocks = omap4_dm_source_clocks;
> +	} else {
> +		pr_err("%s: Chip support not yet added\n", __func__);
> +		return;
> +	}
> +
> +	/* Initialize the dmtimer src clocks */
> +	for (i = 0; src_clk_name[i] != NULL; i++)
> +			omap_dm_source_clocks[i] =
> +				clk_get(NULL, src_clk_name[i]);
> +
> +	/* Number of dmtimers in the system */
> +	if (cpu_is_omap24xx())
> +		omap_dm_timer_count = OMAP2_DM_TIMER_COUNT;
> +	else
> +		omap_dm_timer_count = OMAP3PLUS_DM_TIMER_COUNT;

This shouldn't be necessary.  You should have a count after iterating
through the hwmods in this class.

> +	is_initialized = 1;
> +}
> +
> +struct omap_device_pm_latency omap2_dmtimer_latency[] = {
> +	{
> +	.deactivate_func = omap_device_idle_hwmods,
> +	.activate_func   = omap_device_enable_hwmods,
> +	.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,

indentation

> +	},
> +};
> +
> +int __init omap2_get_early_timer_count(void)
> +{
> +	return NO_EARLY_TIMERS;
> +}
> +
> +void __init omap2_dm_timer_early_init(void)
> +{
> +	int i = 0;
> +	char *name = "dmtimer";

insert blank line

> +	do {

minor nit, but this would be clearer if it were a for loop.  If someone
wanted to set NR_EARLY_TIMERS = 0, this loop would still execute once, and would
not be the intended behavior.

> +		struct omap_device *od;
> +		struct omap_hwmod *oh;
> +		int hw_mod_name_len = 16;
> +		char oh_name[hw_mod_name_len];

s/hw_mod/hwmod/

> +		struct omap_dm_timer_plat_info *pdata;
> +
> +		snprintf(oh_name, hw_mod_name_len, "timer%d", i + 1);
> +		oh = omap_hwmod_lookup(oh_name);
> +		if (!oh)
> +			break;
> +
> +		pdata = kzalloc(sizeof(struct omap_dm_timer_plat_info),
> +				GFP_KERNEL);
> +		if (!pdata) {
> +			pr_err("%s: Unable to allocate pdata for %s:%s\n",
> +				__func__, name, oh->name);
> +			return;
> +		}
> +
> +		pdata->omap_dm_clk_enable = omap2_dm_early_timer_enable;
> +		pdata->omap_dm_clk_disable = omap2_dm_early_timer_disable;
> +		pdata->omap_dm_set_source_clk = omap2_dm_early_timer_set_clk;
> +		pdata->omap_dm_get_timer_clk = omap2_dm_early_timer_get_fclk;
> +
> +		od = omap_device_build(name, i, oh, pdata, sizeof(*pdata),
> +				omap2_dmtimer_latency,
> +				ARRAY_SIZE(omap2_dmtimer_latency), 1);
> +		if (IS_ERR(od)) {
> +			pr_err("%s: Cant build omap_device for %s:%s.\n",
> +				__func__, name, oh->name);
> +			kfree(pdata);
> +		}
> +		i++;
> +	} while (i < NO_EARLY_TIMERS);
> +
> +	omap2_dm_timer_setup();
> +	return;
> +}

Kevin
