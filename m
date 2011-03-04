From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v11 4/8] OMAP2+: dmtimer: convert to platform devices
Date: Thu, 03 Mar 2011 17:01:38 -0800
Message-ID: <87vczzn1fx.fsf@ti.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
	<1298546811-27055-5-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:54121 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758891Ab1CDBBn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 20:01:43 -0500
Received: by yxk8 with SMTP id 8so674813yxk.32
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 17:01:42 -0800 (PST)
In-Reply-To: <1298546811-27055-5-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Thu, 24 Feb 2011 16:56:47 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Add routines to converts dmtimers to platform devices. The device data
> is obtained from hwmod database of respective platform and is registered
> to device model after successful binding to driver. It also provides
> provision to access timers during early boot when pm_runtime framework
> is not completely up and running.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Acked-by: Cousson, Benoit <b-cousson@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile  |    2 +-
>  arch/arm/mach-omap2/dmtimer.c |  199 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 200 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/dmtimer.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 1c3635d..7e5014b 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -4,7 +4,7 @@
>  
>  # Common support
>  obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o \
> -	 common.o gpio.o dma.o wd_timer.o
> +	 common.o gpio.o dma.o wd_timer.o dmtimer.o
>  
>  omap-2-3-common				= irq.o sdrc.o
>  hwmod-common				= omap_hwmod.o \
> diff --git a/arch/arm/mach-omap2/dmtimer.c b/arch/arm/mach-omap2/dmtimer.c
> new file mode 100644
> index 0000000..00cebe9
> --- /dev/null
> +++ b/arch/arm/mach-omap2/dmtimer.c
> @@ -0,0 +1,199 @@
> +/**
> + * OMAP2+ Dual-Mode Timers - platform device registration
> + *
> + * Contains first level initialization routines which extracts timers
> + * information from hwmod database and registers with linux device model.
> + * It also has low level function to change the timer input clock source.
> + *
> + * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
> + * Tarun Kanti DebBarma <tarun.kanti@ti.com>
> + * Thara Gopinath <thara@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +
> +#include <plat/dmtimer.h>
> +#include <plat/omap_device.h>
> +#include <plat/cpu.h>
> +
> +/*
> + * OMAP4 IP revision has different register offsets
> + * for interrupt registers and functional registers.
> + */
> +#define VERSION2_TIMER_WAKEUP_EN_REG_OFFSET	0x14
> +#define VERSION2_TIMER_STAT_REG_OFFSET		0x10

These should be in the driver along with all the other register offsets.

This device code is already setting the IP rev type, the driver can
handle the rest.

> +static int early_timer_count __initdata = 1;

dumb question: why does this start at 1?

> +struct dm_timer_data {
> +	struct omap_device *od;
> +	struct dmtimer_platform_data *pdata;
> +	struct list_head node;
> +};
> +
> +static __initdata LIST_HEAD(dm_timer_data_list);
> +
> +/**
> + * omap2_dm_timer_set_src - change the timer input clock source
> + * @pdev:	timer platform device pointer
> + * @timer_clk:	current clock source
> + * @source:	array index of parent clock source
> + */
> +static int omap2_dm_timer_set_src(struct platform_device *pdev, int source)
> +{
> +	int ret;
> +	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
> +	struct clk *fclk = clk_get(&pdev->dev, "fck");
> +	struct clk *new_fclk;
> +	char *fclk_name = "32k_ck"; /* default name */
> +
> +	switch (source) {
> +	case OMAP_TIMER_SRC_SYS_CLK:
> +		fclk_name = "sys_ck";
> +		break;
> +
> +	case OMAP_TIMER_SRC_32_KHZ:
> +		fclk_name = "32k_ck";
> +		break;
> +
> +	case OMAP_TIMER_SRC_EXT_CLK:
> +		if (pdata->timer_ip_type == OMAP_TIMER_IP_VERSION_1) {
> +			fclk_name = "alt_ck";
> +			break;
> +		}
> +		dev_err(&pdev->dev, "%s: %d: invalid clk src.\n",
> +			__func__, __LINE__);
> +		return -EINVAL;
> +	}
> +
> +	if (IS_ERR_OR_NULL(fclk)) {
> +		dev_err(&pdev->dev, "%s: %d: clk_get() FAILED\n",
> +			__func__, __LINE__);
> +		return -EINVAL;
> +	}
> +
> +	new_fclk = clk_get(&pdev->dev, fclk_name);
> +	if (IS_ERR_OR_NULL(new_fclk)) {
> +		dev_err(&pdev->dev, "%s: %d: clk_get() %s FAILED\n",
> +			__func__, __LINE__, fclk_name);
> +		clk_put(fclk);
> +		return -EINVAL;
> +	}
> +
> +	ret = clk_set_parent(fclk, new_fclk);
> +	if (IS_ERR_VALUE(ret)) {
> +		dev_err(&pdev->dev, "%s: clk_set_parent() to %s FAILED\n",
> +			__func__, fclk_name);
> +		ret = -EINVAL;
> +	}
> +
> +	clk_put(new_fclk);
> +	clk_put(fclk);
> +
> +	return ret;
> +}
> +
> +struct omap_device_pm_latency omap2_dmtimer_latency[] = {
> +	{
> +		.deactivate_func = omap_device_idle_hwmods,
> +		.activate_func   = omap_device_enable_hwmods,
> +		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> +	},
> +};
> +
> +/**
> + * omap_timer_init - build and register timer device with an
> + * associated timer hwmod
> + * @oh:	timer hwmod pointer to be used to build timer device
> + * @user:	parameter that can be passed from calling hwmod API
> + *
> + * Called by omap_hwmod_for_each_by_class to register each of the timer
> + * devices present in the system. The number of timer devices is known
> + * by parsing through the hwmod database for a given class name. At the
> + * end of function call memory is allocated for timer device and it is
> + * registered to the framework ready to be proved by the driver.
> + */
> +static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
> +{
> +	int id;
> +	int ret = 0;
> +	char *name = "omap_timer";
> +	struct dmtimer_platform_data *pdata;
> +	struct omap_device *od;
> +	struct dm_timer_data *timer_data = NULL;
> +
> +	pr_debug("%s: %s\n", __func__, oh->name);
> +
> +	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);

Memory leak.

This needs to be free'd after omap_device_build().  The platform_device
core makes a copy of the pdata (via kmemdup.)

> +	if (!pdata) {
> +		pr_err("%s: No memory for [%s]\n", __func__, oh->name);
> +		return -ENOMEM;
> +	}
> +
> +	pdata->is_early_init = 1;
> +	pdata->is_omap16xx = 0;
> +	pdata->dm_timer_reset = NULL;
> +	pdata->set_timer_src = omap2_dm_timer_set_src;
> +
> +	pdata->timer_ip_type = oh->class->rev;
> +	if (pdata->timer_ip_type == OMAP_TIMER_IP_VERSION_2) {
> +		pdata->func_offset = VERSION2_TIMER_WAKEUP_EN_REG_OFFSET;
> +		pdata->intr_offset = VERSION2_TIMER_STAT_REG_OFFSET;
> +	} else {
> +		pdata->func_offset = 0;
> +		pdata->intr_offset = 0;
> +	}
> +
> +	/*
> +	 * Extract the IDs from name field in hwmod database
> +	 * and use the same for constructing ids' for the
> +	 * timer devices. In a way, we are avoiding usage of
> +	 * static variable witin the function to do the same.
> +	 * CAUTION: We have to be careful and make sure the
> +	 * name in hwmod database does not change in which case
> +	 * we might either make corresponding change here or
> +	 * switch back static variable mechanism.
> +	 */
> +	sscanf(oh->name, "timer%2d", &id);
> +
> +	/* do registration of timer12 on GP device only */
> +	if (id == 12 && omap_type() != OMAP2_DEVICE_TYPE_GP)
> +		return ret;

hmm, grumble

Is this true on OMAP4?  I thought GPT12 was not accessible on OMAP4 even
on GP devices.

As I've said a few times before, what we need here is some sort of
"capabilities" flag for each timer in the hwmod.  In addition to this
"secure-mode only" feature, there are other capabilities such as 1ms
timers, PWM capable, etc.

> +	od = omap_device_build(name, id, oh, pdata, sizeof(*pdata),
> +			omap2_dmtimer_latency,
> +			ARRAY_SIZE(omap2_dmtimer_latency),
> +			pdata->is_early_init);
> +
> +	if (IS_ERR(od)) {
> +		pr_err("%s: Can't build omap_device for %s: %s.\n",
> +			__func__, name, oh->name);
> +		ret = -EINVAL;
> +	} else if (pdata->is_early_init)
> +		early_timer_count++;
> +
> +	timer_data = kzalloc(sizeof(*timer_data), GFP_KERNEL);
> +	if (!timer_data) {
> +		pr_debug("%s: no memory for dm_timer_data\n",
> +				__func__);
> +		return -ENOMEM;
> +	}
> +
> +	/* store od and pdata to be used later during normal initialization */
> +	timer_data->od = od;
> +	timer_data->pdata = pdata;
> +	list_add_tail(&timer_data->node, &dm_timer_data_list);
> +
> +	return ret;
> +}

Kevin
