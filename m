From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 6/6] OMAP2PLUS: WDT: Conversion to runtime PM
Date: Thu, 03 Jun 2010 12:17:02 -0700
Message-ID: <87fx14orip.fsf@deeprootsystems.com>
References: <1274532966-19916-1-git-send-email-charu@ti.com>
	<1274532966-19916-2-git-send-email-charu@ti.com>
	<1274532966-19916-3-git-send-email-charu@ti.com>
	<1274532966-19916-4-git-send-email-charu@ti.com>
	<1274532966-19916-5-git-send-email-charu@ti.com>
	<1274532966-19916-6-git-send-email-charu@ti.com>
	<1274532966-19916-7-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55018 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967Ab0FCTRG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 15:17:06 -0400
Received: by pvg16 with SMTP id 16so215521pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 12:17:04 -0700 (PDT)
In-Reply-To: <1274532966-19916-7-git-send-email-charu@ti.com> (Charulatha V.'s message of "Sat\, 22 May 2010 18\:26\:06 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, wim@iguana.be, rnayak@ti.com, paul@pwsan.com

Charulatha V <charu@ti.com> writes:

> This patch converts the OMAP2/3 Watchdog timer driver to
> get adapted to HWMOD FW and to use the runtime PM APIs.
>
> This patch is tested on SDP3430, SDP3630 and SDP4430.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  arch/arm/plat-omap/devices.c |   52 ++++++++++++++++++++++++----------
>  drivers/watchdog/omap_wdt.c  |   63 ++++++++++++++---------------------------
>  2 files changed, 58 insertions(+), 57 deletions(-)
>

[...]

> @@ -142,12 +143,13 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
>  {
>  	struct omap_wdt_dev *wdev = platform_get_drvdata(omap_wdt_dev);
>  	void __iomem *base = wdev->base;
> -
>  	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
>  		return -EBUSY;
>  
> -	clk_enable(wdev->ick);    /* Enable the interface clock */
> -	clk_enable(wdev->fck);    /* Enable the functional clock */
> +	if (!wdt_runtime_state) {
> +		pm_runtime_get_sync(wdev->dev);
> +		wdt_runtime_state = 1;
> +	}

I don't follow the need (or usage) of wdt_runtime_state.  You seem to
be using it as a rudimentary form of usage counting for multiple calls
to _open()?  The runtime PM API will handle all the usage counting, so
this shouldn't be necessary.

>  
>  	/* initialize prescaler */
>  	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
> @@ -177,8 +179,8 @@ static int omap_wdt_release(struct inode *inode, struct file *file)
>  
>  	omap_wdt_disable(wdev);
>  
> -	clk_disable(wdev->ick);
> -	clk_disable(wdev->fck);
> +	pm_runtime_put_sync(wdev->dev);
> +	wdt_runtime_state = 0;
>  #else
>  	printk(KERN_CRIT "omap_wdt: Unexpected close, not stopping!\n");
>  #endif
> @@ -290,32 +292,24 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
>  		goto err_kzalloc;
>  	}
>  
> -	wdev->omap_wdt_users = 0;
> -	wdev->mem = mem;
> -
> -	wdev->ick = clk_get(&pdev->dev, "ick");
> -	if (IS_ERR(wdev->ick)) {
> -		ret = PTR_ERR(wdev->ick);
> -		wdev->ick = NULL;
> -		goto err_clk;
> -	}
> -	wdev->fck = clk_get(&pdev->dev, "fck");
> -	if (IS_ERR(wdev->fck)) {
> -		ret = PTR_ERR(wdev->fck);
> -		wdev->fck = NULL;
> -		goto err_clk;
> -	}
> -
> -	wdev->base = ioremap(res->start, resource_size(res));
> +	wdev->base = ioremap(res->start, SZ_4K);

Why switch from resource_size() to SZ_4K?   Yes, the region
mapped is small and will round up to PAGE_SIZE, but no need to
hard-code that assumption here.

>  	if (!wdev->base) {
>  		ret = -ENOMEM;
>  		goto err_ioremap;
>  	}
>  
> +	wdev->omap_wdt_users = 0;
> +	wdev->mem = mem;
> +	wdev->dev = &pdev->dev;
> +
>  	platform_set_drvdata(pdev, wdev);
>  
> -	clk_enable(wdev->ick);
> -	clk_enable(wdev->fck);
> +	pm_runtime_enable(wdev->dev);
> +	pm_runtime_get_sync(wdev->dev);
> +#ifndef CONFIG_PM_RUNTIME
> +	/* If runtime PM is not enabled, ensure clocks are always enabled */
> +	omap_device_enable(pdev);
> +#endif

As with my comment on GPIO, lets drop the handling of #ifndef
CONFIG_PM_RUNTIME from the drivers and handle that in common code.

Kevin
