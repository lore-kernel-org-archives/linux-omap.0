From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/6] OMAP: omap_wdt: Remove armwdt_ck field from
	omap_wdt_dev structure.
Date: Wed, 11 Mar 2009 09:02:25 -0700
Message-ID: <20090311160223.GH19229@atomide.com>
References: <1236785378-14640-1-git-send-email-ext-atal.shargorodsky@nokia.com> <cbbca1e42421e2ada459f0c0881f087977e34eed.1236609434.git.ext-atal.shargorodsky@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60532 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbZCKQC2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 12:02:28 -0400
Content-Disposition: inline
In-Reply-To: <cbbca1e42421e2ada459f0c0881f087977e34eed.1236609434.git.ext-atal.shargorodsky@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Hi,

* Atal Shargorodsky <ext-atal.shargorodsky@nokia.com> [090311 08:31]:
> No need to hold three clocks, when for each paricular platform only
> two are used - finctional and interface.
> 
> Signed-off-by: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
> ---
>  drivers/watchdog/omap_wdt.c |   51 ++++++++++++------------------------------
>  1 files changed, 15 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index b04f650..5b72c7c 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -60,7 +60,6 @@ struct omap_wdt_dev {
>  	void __iomem    *base;          /* physical */
>  	struct device   *dev;
>  	int             omap_wdt_users;
> -	struct clk      *armwdt_ck;
>  	struct clk      *mpu_wdt_ick;
>  	struct clk      *mpu_wdt_fck;
>  	struct resource *mem;
> @@ -146,13 +145,10 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
>  	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
>  		return -EBUSY;
>  
> -	if (cpu_is_omap16xx())
> -		clk_enable(wdev->armwdt_ck);	/* Enable the clock */
> -
> -	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
>  		clk_enable(wdev->mpu_wdt_ick);    /* Enable the interface clock */
> -		clk_enable(wdev->mpu_wdt_fck);    /* Enable the functional clock */
> -	}
> +
> +	clk_enable(wdev->mpu_wdt_fck);    /* Enable the functional clock */
>  
>  	/* initialize prescaler */
>  	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)

Some extra work required.. You will need to rebase at least this patch as
the big pile of clock changes by Paul and Russell will go in this coming
merge window.

Basically the code above will be cleaner with no need for cpu_is_ stuff:

clk_enable(wdev->ick);    /* Enable the interface clock */
clk_enable(wdev->fck);    /* Enable the functional clock */

I'm mirroring Russell's omap-clks3 branch in the linux-omap tree as
clks-testing branch, so please take a look at that branch.

Then see the MAINTAINERS file for "WATCHDOG DEVICE DRIVERS", so you
can find the address for Wim. Please send the series to Wim with
LKML, LAKML, and linux-omap mailing lists Cc'd. Please also mention
that these patches depend on some pending clock changes.

Or even better, maybe you can leave out the clock part from your patch
so your series applies to both the mainline kernel and clks-testing
branch with some offset warnings ;)

Regards,

Tony



> @@ -181,13 +177,10 @@ static int omap_wdt_release(struct inode *inode, struct file *file)
>  
>  	omap_wdt_disable(wdev);
>  
> -	if (cpu_is_omap16xx())
> -		clk_disable(wdev->armwdt_ck);	/* Disable the clock */
> -
> -	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
>  		clk_disable(wdev->mpu_wdt_ick);	/* Disable the clock */
> -		clk_disable(wdev->mpu_wdt_fck);	/* Disable the clock */
> -	}
> +
> +	clk_disable(wdev->mpu_wdt_fck);	/* Disable the clock */
>  #else
>  	printk(KERN_CRIT "omap_wdt: Unexpected close, not stopping!\n");
>  #endif
> @@ -304,10 +297,10 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
>  	wdev->mem = mem;
>  
>  	if (cpu_is_omap16xx()) {
> -		wdev->armwdt_ck = clk_get(&pdev->dev, "armwdt_ck");
> -		if (IS_ERR(wdev->armwdt_ck)) {
> -			ret = PTR_ERR(wdev->armwdt_ck);
> -			wdev->armwdt_ck = NULL;
> +		wdev->mpu_wdt_fck = clk_get(&pdev->dev, "armwdt_ck");
> +		if (IS_ERR(wdev->mpu_wdt_fck)) {
> +			ret = PTR_ERR(wdev->mpu_wdt_fck);
> +			wdev->mpu_wdt_fck = NULL;
>  			goto err_clk;
>  		}
>  	}
> @@ -351,13 +344,10 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, wdev);
>  
>  	/* enable clocks for register access */
> -	if (cpu_is_omap16xx())
> -		clk_enable(wdev->armwdt_ck);	/* Enable the clock */
> -
> -	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
>  		clk_enable(wdev->mpu_wdt_ick);    /* Enable the interface clock */
> -		clk_enable(wdev->mpu_wdt_fck);    /* Enable the functional clock */
> -	}
> +
> +	clk_enable(wdev->mpu_wdt_fck);    /* Enable the functional clock */
>  
>  	omap_wdt_disable(wdev);
>  	omap_wdt_adjust_timeout(timer_margin);
> @@ -379,13 +369,9 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
>  	__raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
>  
>  	/* disable clocks since we don't need them now */
> -	if (cpu_is_omap16xx())
> -		clk_disable(wdev->armwdt_ck);	/* Disable the clock */
> -
> -	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
>  		clk_disable(wdev->mpu_wdt_ick);	/* Disable the clock */
> -		clk_disable(wdev->mpu_wdt_fck);	/* Disable the clock */
> -	}
> +	clk_disable(wdev->mpu_wdt_fck);	/* Disable the clock */
>  
>  	omap_wdt_dev = pdev;
>  
> @@ -399,8 +385,6 @@ err_ioremap:
>  	wdev->base = NULL;
>  
>  err_clk:
> -	if (wdev->armwdt_ck)
> -		clk_put(wdev->armwdt_ck);
>  	if (wdev->mpu_wdt_ick)
>  		clk_put(wdev->mpu_wdt_ick);
>  	if (wdev->mpu_wdt_fck)
> @@ -436,11 +420,6 @@ static int omap_wdt_remove(struct platform_device *pdev)
>  	release_mem_region(res->start, res->end - res->start + 1);
>  	platform_set_drvdata(pdev, NULL);
>  
> -	if (wdev->armwdt_ck) {
> -		clk_put(wdev->armwdt_ck);
> -		wdev->armwdt_ck = NULL;
> -	}
> -
>  	if (wdev->mpu_wdt_ick) {
>  		clk_put(wdev->mpu_wdt_ick);
>  		wdev->mpu_wdt_ick = NULL;
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
