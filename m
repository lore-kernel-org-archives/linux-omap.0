From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v5 8/12] OMAP2+: dmtimer: convert to platform devices
Date: Mon, 6 Dec 2010 23:56:33 +0530
Message-ID: <20101206182633.GE4924@manju-desktop>
References: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
 <1291679059-13419-9-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:35926 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752515Ab0LFS0r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 13:26:47 -0500
Received: by gxk28 with SMTP id 28so5975750gxk.3
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 10:26:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291679059-13419-9-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

On Tue, Dec 07, 2010 at 05:14:15AM +0530, Tarun Kanti DebBarma wrote:
> Add routines to converts dmtimers to platform devices. The device data
s/converts/convert
> is obtained from hwmod database of respective platform and is registered
> to device model after successful binding to driver. It also provides
> provision to access timers during early boot when pm_runtime framework
> is not completely up and running.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Reviewed-by: Cousson, Benoit <b-cousson@ti.com>
> Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile  |    2 +-
>  arch/arm/mach-omap2/dmtimer.c |  174 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 175 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/dmtimer.c
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 60e51bc..7700ccd 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -4,7 +4,7 @@
>  
>  # Common support
>  obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o \
> -	 common.o
> +	 common.o dmtimer.o
>  
>  omap-2-3-common				= irq.o sdrc.o prm2xxx_3xxx.o
>  hwmod-common				= omap_hwmod.o \
> diff --git a/arch/arm/mach-omap2/dmtimer.c b/arch/arm/mach-omap2/dmtimer.c
> new file mode 100644
> index 0000000..b639082
> --- /dev/null
> +++ b/arch/arm/mach-omap2/dmtimer.c
> @@ -0,0 +1,174 @@
> +/**
> + * OMAP2PLUS Dual-Mode Timers - platform device registration
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
> +#include <linux/io.h>
not required
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +
> +#include <plat/dmtimer.h>
> +#include <plat/omap_hwmod.h>
not required
> +#include <plat/omap_device.h>
> +
> +static int early_timer_count __initdata = 1;
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
> +		dev_dbg(&pdev->dev, "%s: %d: invalid clk src.\n",
> +			__func__, __LINE__);
> +		return -EINVAL;
> +	}
> +
> +	if (IS_ERR_OR_NULL(fclk)) {
> +		dev_dbg(&pdev->dev, "%s: %d: clk_get() FAILED\n",
> +			__func__, __LINE__);
> +		return -EINVAL;
> +	}
> +
> +	new_fclk = clk_get(&pdev->dev, fclk_name);
> +	if (IS_ERR_OR_NULL(new_fclk)) {
> +		dev_dbg(&pdev->dev, "%s: %d: clk_get() %s FAILED\n",
> +			__func__, __LINE__, fclk_name);
> +		clk_put(fclk);
> +		return -EINVAL;
> +	}
> +
> +	ret = clk_set_parent(fclk, new_fclk);
> +	if (IS_ERR_VALUE(ret)) {
> +		dev_dbg(&pdev->dev, "%s: clk_set_parent() to %s FAILED\n",
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
> +static int __init omap_timer_init(struct omap_hwmod *oh, void *user)
> +{
> +	int id;
> +	int ret = 0;
> +	char *name = "omap_timer";
> +	struct dmtimer_platform_data *pdata;
> +	struct omap_device *od;
> +
> +	pr_debug("%s: %s\n", __func__, oh->name);
> +
> +	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata) {
> +		pr_err("%s: No memory for [%s]\n", __func__, oh->name);
> +		return -ENOMEM;
> +	}
> +
> +	if (user)
> +		pdata->is_early_init = 1;
> +	else
> +		pdata->is_early_init = 0;
> +
> +	/* hook clock set/get functions */
> +	pdata->set_timer_src = omap2_dm_timer_set_src;
> +
> +	/* read timer ip version */

redundant. mentioning VERSION2 is omap4 will be helpful.

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
> +	 * Extract the id from name field in hwmod database
> +	 * and use the same for constructing ids' for the
id's

-Manjunath
