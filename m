From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 5/5] ARM: OMAP: For all OMAP devices use clock framework
 to set dmtimer clock source
Date: Tue, 22 May 2012 19:13:20 -0500
Message-ID: <4FBC2BA0.6010906@ti.com>
References: <1337717876-20713-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40083 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756940Ab2EWANU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 May 2012 20:13:20 -0400
In-Reply-To: <1337717876-20713-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Tarun Kanti <tarun.kanti@ti.com>


On 05/22/2012 03:17 PM, Jon Hunter wrote:
> From: Jon Hunter <jon-hunter@ti.com>
> 
> OMAP1 and OMAP2+ devices had architecture specific functions for configuring
> the dmtimer clock source. This was simply because the OMAP1 devices did not
> support the clock framework for dynamically setting a clock's parent. Now OMAP1
> can use the clock framework to set the parent clock, remove the architecture
> specific functions and use a common function to set the parent clock for all
> OMAP devices. This common function is based upon the OMAP2+
> omap2_dm_timer_set_src() as this was using the clock framework.

One comment ...

For now, I have not removed the "timer_ip_version" test when attempting
to set the dmtimer to an external clock source (see below). I plan to
remove this in a follow-up series to clean-up the platform data for the
dmtimer. I could have also done it here, but I was thinking that this
should be in its own patch. Hence for now, I am also setting the
timer_ip_version for OMAP1 devices to OMAP_TIMER_IP_VERSION_1 so an
external clock source can be selected.

> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/mach-omap1/timer.c               |   15 +------
>  arch/arm/mach-omap2/timer.c               |   61 -----------------------------
>  arch/arm/plat-omap/dmtimer.c              |   43 +++++++++++++++++++-
>  arch/arm/plat-omap/include/plat/dmtimer.h |    1 -
>  4 files changed, 43 insertions(+), 77 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/timer.c b/arch/arm/mach-omap1/timer.c
> index 64c65bc..6ef4f6d 100644
> --- a/arch/arm/mach-omap1/timer.c
> +++ b/arch/arm/mach-omap1/timer.c
> @@ -41,19 +41,6 @@
>  
>  #define OMAP1_DM_TIMER_COUNT		8
>  
> -static int omap1_dm_timer_set_src(struct platform_device *pdev,
> -				int source)
> -{
> -	int n = (pdev->id - 1) << 1;
> -	u32 l;
> -
> -	l = omap_readl(MOD_CONF_CTRL_1) & ~(0x03 << n);
> -	l |= source << n;
> -	omap_writel(l, MOD_CONF_CTRL_1);
> -
> -	return 0;
> -}
> -
>  static int __init omap1_dm_timer_init(void)
>  {
>  	int i;
> @@ -139,7 +126,7 @@ static int __init omap1_dm_timer_init(void)
>  			goto err_free_pdata;
>  		}
>  
> -		pdata->set_timer_src = omap1_dm_timer_set_src;
> +		pdata->timer_ip_version = OMAP_TIMER_IP_VERSION_1;
>  		pdata->needs_manual_reset = 1;
>  
>  		ret = platform_device_add_data(pdev, pdata, sizeof(*pdata));
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index f1d8453..304a9c8 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -394,66 +394,6 @@ OMAP_SYS_TIMER(4)
>  #endif
>  
>  /**
> - * omap2_dm_timer_set_src - change the timer input clock source
> - * @pdev:	timer platform device pointer
> - * @source:	array index of parent clock source
> - */
> -static int omap2_dm_timer_set_src(struct platform_device *pdev, int source)
> -{
> -	int ret;
> -	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
> -	struct clk *fclk, *parent;
> -	char *parent_name = NULL;
> -
> -	fclk = clk_get(&pdev->dev, "fck");
> -	if (IS_ERR_OR_NULL(fclk)) {
> -		dev_err(&pdev->dev, "%s: %d: clk_get() FAILED\n",
> -				__func__, __LINE__);
> -		return -EINVAL;
> -	}
> -
> -	switch (source) {
> -	case OMAP_TIMER_SRC_SYS_CLK:
> -		parent_name = "timer_sys_ck";
> -		break;
> -
> -	case OMAP_TIMER_SRC_32_KHZ:
> -		parent_name = "timer_32k_ck";
> -		break;
> -
> -	case OMAP_TIMER_SRC_EXT_CLK:
> -		if (pdata->timer_ip_version == OMAP_TIMER_IP_VERSION_1) {
> -			parent_name = "timer_ext_ck";
> -			break;
> -		}
> -		dev_err(&pdev->dev, "%s: %d: invalid clk src.\n",
> -			__func__, __LINE__);
> -		clk_put(fclk);
> -		return -EINVAL;
> -	}
> -
> -	parent = clk_get(&pdev->dev, parent_name);
> -	if (IS_ERR_OR_NULL(parent)) {
> -		dev_err(&pdev->dev, "%s: %d: clk_get() %s FAILED\n",
> -			__func__, __LINE__, parent_name);
> -		clk_put(fclk);
> -		return -EINVAL;
> -	}
> -
> -	ret = clk_set_parent(fclk, parent);
> -	if (IS_ERR_VALUE(ret)) {
> -		dev_err(&pdev->dev, "%s: clk_set_parent() to %s FAILED\n",
> -			__func__, parent_name);
> -		ret = -EINVAL;
> -	}
> -
> -	clk_put(parent);
> -	clk_put(fclk);
> -
> -	return ret;
> -}
> -
> -/**
>   * omap_timer_init - build and register timer device with an
>   * associated timer hwmod
>   * @oh:	timer hwmod pointer to be used to build timer device
> @@ -501,7 +441,6 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
>  	 */
>  	sscanf(oh->name, "timer%2d", &id);
>  
> -	pdata->set_timer_src = omap2_dm_timer_set_src;
>  	pdata->timer_ip_version = oh->class->rev;
>  
>  	/* Mark clocksource and clockevent timers as reserved */
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 3b0cfeb..a344998 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -378,6 +378,8 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
>  int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
>  {
>  	int ret;
> +	char *parent_name = NULL;
> +	struct clk *fclk, *parent;
>  	struct dmtimer_platform_data *pdata;
>  
>  	if (unlikely(!timer))
> @@ -388,7 +390,46 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
>  	if (source < 0 || source >= 3)
>  		return -EINVAL;
>  
> -	ret = pdata->set_timer_src(timer->pdev, source);
> +	fclk = clk_get(&timer->pdev->dev, "fck");
> +	if (IS_ERR_OR_NULL(fclk)) {
> +		pr_err("%s: fck not found\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	switch (source) {
> +	case OMAP_TIMER_SRC_SYS_CLK:
> +		parent_name = "timer_sys_ck";
> +		break;
> +
> +	case OMAP_TIMER_SRC_32_KHZ:
> +		parent_name = "timer_32k_ck";
> +		break;
> +
> +	case OMAP_TIMER_SRC_EXT_CLK:
> +		if (pdata->timer_ip_version == OMAP_TIMER_IP_VERSION_1) {
> +			parent_name = "timer_ext_ck";
> +			break;
> +		}
> +		pr_err("%s: invalid clock source\n", __func__);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	parent = clk_get(&timer->pdev->dev, parent_name);
> +	if (IS_ERR_OR_NULL(parent)) {
> +		pr_err("%s: %s not found\n", __func__, parent_name);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = clk_set_parent(fclk, parent);
> +	if (IS_ERR_VALUE(ret))
> +		pr_err("%s: failed to set %s as parent\n", __func__,
> +			parent_name);
> +
> +	clk_put(parent);
> +out:
> +	clk_put(fclk);
>  
>  	return ret;
>  }
> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
> index 5da7356..4e82357 100644
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -96,7 +96,6 @@ struct timer_regs {
>  };
>  
>  struct dmtimer_platform_data {
> -	int (*set_timer_src)(struct platform_device *pdev, int source);
>  	int timer_ip_version;
>  	u32 needs_manual_reset:1;
>  	bool reserved;
