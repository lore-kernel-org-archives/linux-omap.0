From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v11 7/8] OMAP: dmtimer: pm_runtime support
Date: Thu, 03 Mar 2011 17:22:44 -0800
Message-ID: <878vwvn0gr.fsf@ti.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
	<1298546811-27055-8-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:59910 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759016Ab1CDBYA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 20:24:00 -0500
Received: by ywl2 with SMTP id 2so931882ywl.40
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 17:23:58 -0800 (PST)
In-Reply-To: <1298546811-27055-8-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Thu, 24 Feb 2011 16:56:50 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Partha Basak <p-basak2@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Add pm_runtime support to dmtimer. Since dmtimer is used during
> early boot before pm_runtime is initialized completely there are
> provisions to enable/disable clocks directly in the code during
> early boot.

I'm still not crazy about the duplicate logic (both early & normal) in
all the enable/disable functions.

As I've suggested in the past, why not just do a clk_get, clk_enable in
when the early timers are initialized, then do a clk_disable, clk_put()
as soon as the "normal" device is ready and PM runtime is enabled.

That will greatly simplify the code and eliminate the unnecessary checks
for ->is_early_device which will always be false except for in early
boot (when these functions are not likely to be called anyways.)

> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> [p-basak2@ti.com: added pm_runtime logic in probe()]
> Signed-off-by: Partha Basak <p-basak2@ti.com>
> Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
> Acked-by: Cousson, Benoit <b-cousson@ti.com>
> ---
>  arch/arm/plat-omap/dmtimer.c |   63 ++++++++++++++++++++++++++++++++++++------
>  1 files changed, 54 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 53f5205..fcac422 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -39,6 +39,7 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/err.h>
>  #include <linux/platform_device.h>
>  #include <plat/dmtimer.h>
> @@ -211,13 +212,16 @@ static void omap_dm_timer_prepare(struct omap_dm_timer *timer)
>  {
>  	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
>  
> -	timer->fclk = clk_get(&timer->pdev->dev, "fck");
> -	if (WARN_ON_ONCE(IS_ERR_OR_NULL(timer->fclk))) {
> -		dev_err(&timer->pdev->dev, ": No fclk handle.\n");
> -		return;
> +	if (!pdata->is_omap16xx) {

Is this 'is_omap16xx' really needed here?  If the clk_get fails, set
timer->fclk to NULL, and any other users of fclk should just check the
validity of timer->fclk.

> +		timer->fclk = clk_get(&timer->pdev->dev, "fck");
> +		if (WARN_ON_ONCE(IS_ERR_OR_NULL(timer->fclk))) {
> +			dev_err(&timer->pdev->dev, ": No fclk handle.\n");
> +			return;
> +		}
>  	}
>  
> -	omap_dm_timer_enable(timer);
> +	if (!pdata->is_omap16xx)
> +		omap_dm_timer_enable(timer);

I don't think this if is needed, as runtime PM calls will essentially be
nops on OMAP1 anyways.

>  	if (pdata->dm_timer_reset)
>  		pdata->dm_timer_reset(timer);
> @@ -292,10 +296,22 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
>  
>  void omap_dm_timer_enable(struct omap_dm_timer *timer)
>  {
> +	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
> +
>  	if (timer->enabled)
>  		return;
>  
> -	clk_enable(timer->fclk);
> +	if (unlikely(pdata->is_early_init)) {
> +		clk_enable(timer->fclk);
> +		timer->enabled = 1;
> +		return;
> +	}
> +
> +	if (pm_runtime_get_sync(&timer->pdev->dev) < 0) {
> +		dev_err(&timer->pdev->dev, "%s: pm_runtime_get_sync() FAILED\n",
> +			__func__);
> +		return;
> +	}
>  
>  	timer->enabled = 1;
>  }

Taking my above suggestion, this can be simplified to:

void omap_dm_timer_enable(struct omap_dm_timer *timer)
{
	pm_runtime_get_sync(&timer->pdev->dev);
}

Note that with runtime PM, the ->enabled flag is no longer needed
either, as you can simply check pm_runtime_suspended(dev) instead.

> @@ -303,10 +319,22 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
>  
>  void omap_dm_timer_disable(struct omap_dm_timer *timer)
>  {
> +	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
> +
>  	if (!timer->enabled)
>  		return;
>  
> -	clk_disable(timer->fclk);
> +	if (unlikely(pdata->is_early_init)) {
> +		clk_disable(timer->fclk);
> +		timer->enabled = 0;
> +		return;
> +	}
> +
> +	if (pm_runtime_put_sync(&timer->pdev->dev) < 0) {
> +		dev_err(&timer->pdev->dev, "%s: pm_runtime_put_sync() FAILED\n",
> +			__func__);
> +		return;
> +	}
>  
>  	timer->enabled = 0;
>  }

Likewise, this becomes

void omap_dm_timer_disable(struct omap_dm_timer *timer)
{
	pm_runtime_put_sync(&timer->pdev->dev);
}

> @@ -425,10 +453,12 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
>  	if (source < 0 || source >= 3)
>  		return -EINVAL;
>  
> -	omap_dm_timer_disable(timer);
> +	if (!pdata->is_omap16xx)

drop the if

> +		omap_dm_timer_disable(timer);
>  	/* change the timer clock source */
>  	ret = pdata->set_timer_src(timer->pdev, source);
> -	omap_dm_timer_enable(timer);
> +	if (!pdata->is_omap16xx)

and this one,

and with that, there are no users of is_omap16xx in this patch.

Kevin


> +		omap_dm_timer_enable(timer);
>  
>  	/*
>  	 * When the functional clock disappears, too quick writes seem
> @@ -600,11 +630,26 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	/*
> +	 * OMAP2+
> +	 * Early timers are already registered and in list.
> +	 * What we need to do during second phase of probe
> +	 * is to assign the newly allocated/configured pdev
> +	 * to timer->pdev. We also call pm_runtime_enable()
> +	 * for each device because it could not be called
> +	 * during early boot because pm_runtime framework
> +	 * was not yet up and running.
> +	 */
>  	spin_lock_irqsave(&dm_timer_lock, flags);
>  	list_for_each_entry(timer, &omap_timer_list, node)
>  		if (!pdata->is_early_init && timer->id == pdev->id) {
>  			timer->pdev = pdev;
>  			spin_unlock_irqrestore(&dm_timer_lock, flags);
> +			pm_runtime_enable(&pdev->dev);
> +			/* update PM runtime for active early timers */
> +			if (timer->reserved)
> +				pm_runtime_get_sync(&pdev->dev);
> +
>  			dev_dbg(&pdev->dev, "Regular Probed\n");
>  			return 0;
>  		}
