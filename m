From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v5 2/2] watchdog:OMAP3:Enable support for IVA2 and SECURE
Date: Fri, 26 Jun 2009 14:24:00 -0700
Message-ID: <87fxdmbsen.fsf@deeprootsystems.com>
References: <1246050428-29817-1-git-send-email-ubh@ti.com>
	<1246050428-29817-2-git-send-email-ubh@ti.com>
	<1246050428-29817-3-git-send-email-ubh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f202.google.com ([209.85.222.202]:65514 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbZFZVYA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Jun 2009 17:24:00 -0400
Received: by pzk40 with SMTP id 40so81588pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 26 Jun 2009 14:24:02 -0700 (PDT)
In-Reply-To: <1246050428-29817-3-git-send-email-ubh@ti.com> (Ulrik Bech Hald's message of "Fri\, 26 Jun 2009 16\:07\:08 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ulrik Bech Hald <ubh@ti.com>
Cc: linux-omap@vger.kernel.org

Ulrik Bech Hald <ubh@ti.com> writes:

> This patch adds support for IVA2 and SECURE WDTs in the omap_wdt
> driver for omap34xx family. SECURE will be available as
> /dev/watchdog_secure on HS/EMU devices and IVA2 will be available
> as /dev/watchdog_iva2. MPU will still be available as /dev/watchdog
>
> Tested on Zoom1 OMAP3 platform
>
> Signed-off-by: Ulrik Bech Hald <ubh@ti.com>

OK, I think this is ready to go upstream.  They may have some comments
about the /dev node names an inode matching, but lest find out.

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>


> ---
> runtime dependency: [PATCH 1/1] watchdog: OMAP fixes: enable clock in probe, trigger timer reload 
>
>  drivers/watchdog/omap_wdt.c |   34 ++++++++++++++++++++++++++--------
>  1 files changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index f271385..9965f64 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -47,7 +47,9 @@
>  
>  #include "omap_wdt.h"
>  
> -static struct platform_device *omap_wdt_dev;
> +#define NUM_WDTS	3
> +
> +static struct platform_device *omap_wdt_dev[NUM_WDTS];
>  
>  static unsigned timer_margin;
>  module_param(timer_margin, uint, 0);
> @@ -139,8 +141,23 @@ static void omap_wdt_set_timeout(struct omap_wdt_dev *wdev)
>   */
>  static int omap_wdt_open(struct inode *inode, struct file *file)
>  {
> -	struct omap_wdt_dev *wdev = platform_get_drvdata(omap_wdt_dev);
> -	void __iomem *base = wdev->base;
> +	struct omap_wdt_dev *wdev = NULL;
> +	void __iomem *base;
> +
> +	/* Find match between device node and wdt device */
> +	int i;
> +	for (i = 0; i < NUM_WDTS; i++) {
> +		if (omap_wdt_dev[i]) {
> +			wdev = platform_get_drvdata(omap_wdt_dev[i]);
> +			if (iminor(inode) == wdev->omap_wdt_miscdev.minor)
> +				break;
> +		}
> +	}
> +
> +	if (!wdev)
> +		return -ENODEV;
> +
> +	base = wdev->base;
>  
>  	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
>  		return -EBUSY;
> @@ -271,7 +288,7 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
>  		goto err_get_resource;
>  	}
>  
> -	if (omap_wdt_dev) {
> +	if (omap_wdt_dev[pdev->id]) {
>  		ret = -EBUSY;
>  		goto err_busy;
>  	}
> @@ -317,9 +334,9 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
>  	omap_wdt_adjust_timeout(timer_margin);
>  
>  	wdev->omap_wdt_miscdev.parent = &pdev->dev;
> -	wdev->omap_wdt_miscdev.minor = WATCHDOG_MINOR;
> -	wdev->omap_wdt_miscdev.name = "watchdog";
> +	wdev->omap_wdt_miscdev.minor = MISC_DYNAMIC_MINOR;
>  	wdev->omap_wdt_miscdev.fops = &omap_wdt_fops;
> +	wdev->omap_wdt_miscdev.name = (char *) pdev->dev.platform_data;
>  
>  	ret = misc_register(&(wdev->omap_wdt_miscdev));
>  	if (ret)
> @@ -332,7 +349,8 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
>  	/* autogate OCP interface clock */
>  	__raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
>  
> -	omap_wdt_dev = pdev;
> +	/* keep track of the wdt platform devices in local device array */
> +	omap_wdt_dev[pdev->id] = pdev;
>  
>  	return 0;
>  
> @@ -384,7 +402,7 @@ static int __devexit omap_wdt_remove(struct platform_device *pdev)
>  	iounmap(wdev->base);
>  
>  	kfree(wdev);
> -	omap_wdt_dev = NULL;
> +	omap_wdt_dev[pdev->id] = NULL;
>  
>  	return 0;
>  }
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
