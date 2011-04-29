From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v13 04/11] OMAP2+: dmtimer: convert to platform devices
Date: Fri, 29 Apr 2011 16:15:04 +0530
Message-ID: <4DBA96B0.9060308@ti.com>
References: <1302969063-8231-1-git-send-email-tarun.kanti@ti.com> <1302969063-8231-5-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:54100 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758101Ab1D2Kpf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Apr 2011 06:45:35 -0400
Received: by mail-yi0-f42.google.com with SMTP id 12so1623177yib.29
        for <linux-omap@vger.kernel.org>; Fri, 29 Apr 2011 03:45:33 -0700 (PDT)
In-Reply-To: <1302969063-8231-5-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

On 4/16/2011 9:20 PM, Tarun Kanti DebBarma wrote:
> Add routines to converts dmtimers to platform devices. The device data
> is obtained from hwmod database of respective platform and is registered
> to device model after successful binding to driver.
> In addition, capability attribute of each of the timers is added in
> hwmod database.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Signed-off-by: Thara Gopinath<thara@ti.com>
> Acked-by: Cousson, Benoit<b-cousson@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_2420_data.c |   22 ++++
>   arch/arm/mach-omap2/omap_hwmod_2430_data.c |   22 ++++
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   27 +++++
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   25 +++++
>   arch/arm/mach-omap2/timer.c                |  158 +++++++++++++++++++++++++++-
>   arch/arm/plat-omap/dmtimer.c               |   17 ---
>   arch/arm/plat-omap/include/plat/dmtimer.h  |   13 ++-
>   7 files changed, 265 insertions(+), 19 deletions(-)
>
[...]

> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index 2edeb1a..1c80337 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -1,5 +1,5 @@
>   /*
> - * linux/arch/arm/mach-omap2/timer-gp.c
> + * linux/arch/arm/mach-omap2/timer.c
>    *
>    * OMAP2 GP timer support.
>    *
> @@ -35,6 +35,7 @@
>   #include<linux/irq.h>
>   #include<linux/clocksource.h>
>   #include<linux/clockchips.h>
> +#include<linux/slab.h>
>
>   #include<asm/mach/time.h>
>   #include<plat/dmtimer.h>
> @@ -42,6 +43,7 @@
>   #include<asm/sched_clock.h>
>   #include<plat/common.h>
>   #include<plat/omap_hwmod.h>
> +#include<plat/omap_device.h>
>
>   /* Parent clocks, eventually these will come from the clock framework */
>
> @@ -129,6 +131,23 @@ static struct clock_event_device clockevent_gpt = {
>   	.set_mode	= omap2_gp_timer_set_mode,
>   };
>
> +int __omap_dm_timer_set_source(struct clk *timer_fck, struct clk *parent)
> +{
> +	int ret;
> +
> +	clk_disable(timer_fck);
> +	ret = clk_set_parent(timer_fck, parent);
> +	clk_enable(timer_fck);
> +
> +	/*
> +	 * When the functional clock disappears, too quick writes seem
> +	 * to cause an abort. XXX Is this still necessary?
> +	 */
> +	__delay(300000);
> +
> +	return ret;
> +}
> +
>   static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
>   						int gptimer_id,
>   						const char *fck_source)
> @@ -359,3 +378,140 @@ struct sys_timer omap4_timer = {
>   	.init	= omap4_timer_init,
>   };
>   #endif
> +
> +/**
> + * omap2_dm_timer_set_src - change the timer input clock source
> + * @pdev:	timer platform device pointer
> + * @source:	array index of parent clock source
> + */
> +static int omap2_dm_timer_set_src(struct platform_device *pdev, int source)
> +{
> +	int ret;
> +	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
> +	struct clk *fclk, *new_fclk;
> +	char *new_fclk_name = NULL;
> +
> +	fclk = clk_get(&pdev->dev, "fck");
> +	if (IS_ERR_OR_NULL(fclk)) {
> +		dev_err(&pdev->dev, "%s: %d: clk_get() FAILED\n",
> +				__func__, __LINE__);
> +		return -EINVAL;
> +	}
> +
> +	switch (source) {
> +	case OMAP_TIMER_SRC_SYS_CLK:
> +		new_fclk_name = "sys_ck";
> +		break;
> +
> +	case OMAP_TIMER_SRC_32_KHZ:
> +		if (unlikely(cpu_is_omap2420()))
> +			new_fclk_name = "func_32k_ck";
> +		else
> +			new_fclk_name = "32k_ck";
> +		break;
> +
> +	case OMAP_TIMER_SRC_EXT_CLK:
> +		if (pdata->timer_ip_type == OMAP_TIMER_IP_VERSION_1) {
> +			new_fclk_name = "alt_ck";
> +			break;
> +		}
> +		dev_err(&pdev->dev, "%s: %d: invalid clk src.\n",
> +			__func__, __LINE__);
> +		return -EINVAL;
> +	}
> +
> +	new_fclk = clk_get(&pdev->dev, new_fclk_name);
> +	if (IS_ERR_OR_NULL(new_fclk)) {
> +		dev_err(&pdev->dev, "%s: %d: clk_get() %s FAILED\n",
> +			__func__, __LINE__, new_fclk_name);
> +		clk_put(fclk);
> +		return -EINVAL;
> +	}
> +
> +	ret = clk_set_parent(fclk, new_fclk);
> +	if (IS_ERR_VALUE(ret)) {
> +		dev_err(&pdev->dev, "%s: clk_set_parent() to %s FAILED\n",
> +			__func__, new_fclk_name);
> +		ret = -EINVAL;
> +	}
> +
> +	clk_put(new_fclk);
> +	clk_put(fclk);
> +
> +	return ret;
> +}

I see two functions doing same job of switching timer
clock-source between 32 K and sysclock. This should
be fixed.

Regards
Santosh



