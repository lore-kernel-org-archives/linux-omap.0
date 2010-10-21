From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/5] arm: omap: counter-32k: convert to pm_runtime API
Date: Thu, 21 Oct 2010 10:46:11 -0700
Message-ID: <87k4lbzbfg.fsf@deeprootsystems.com>
References: <1287480136-2046-1-git-send-email-balbi@ti.com>
	<1287480136-2046-3-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35158 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485Ab0JURqN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Oct 2010 13:46:13 -0400
Received: by pvh1 with SMTP id 1so290101pvh.19
        for <linux-omap@vger.kernel.org>; Thu, 21 Oct 2010 10:46:13 -0700 (PDT)
In-Reply-To: <1287480136-2046-3-git-send-email-balbi@ti.com> (Felipe Balbi's
	message of "Tue, 19 Oct 2010 12:22:13 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Felipe Balbi <balbi@ti.com> writes:

> Trivial patch removing clock framework and adding
> pm_runtime API.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Minor nit: the runtime PM 'put' calls do not need to be the _sync
versions.  You can easily get by using the "normal" (async) versions
here.

Kevin


> ---
>  arch/arm/plat-omap/counter-32k.c |   48 ++++++++++---------------------------
>  1 files changed, 13 insertions(+), 35 deletions(-)
>
> diff --git a/arch/arm/plat-omap/counter-32k.c b/arch/arm/plat-omap/counter-32k.c
> index f3fcb38..7bfd67a 100644
> --- a/arch/arm/plat-omap/counter-32k.c
> +++ b/arch/arm/plat-omap/counter-32k.c
> @@ -27,7 +27,7 @@
>  #include <linux/time.h>
>  #include <linux/clocksource.h>
>  #include <linux/platform_device.h>
> -#include <linux/clk.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/err.h>
>  
>  struct omap_counter_32k_device {
> @@ -37,7 +37,6 @@ struct omap_counter_32k_device {
>  	cycles_t		last_cycles;
>  
>  	struct device		*dev;
> -	struct clk		*ick;
>  	void __iomem		*base;
>  
>  	/*
> @@ -117,7 +116,6 @@ static int __init omap_counter_32k_probe(struct platform_device *pdev)
>  {
>  	struct omap_counter_32k_device		*omap;
>  	struct resource			*res;
> -	struct clk			*ick;
>  
>  	int				ret;
>  
> @@ -130,11 +128,18 @@ static int __init omap_counter_32k_probe(struct platform_device *pdev)
>  		goto err0;
>  	}
>  
> +	pm_runtime_enable(&pdev->dev);
> +	ret = pm_runtime_get_sync(&pdev->dev);
> +	if (ret) {
> +		dev_dbg(&pdev->dev, "unable to enable runtime pm\n");
> +		goto err1;
> +	}
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
>  		dev_dbg(&pdev->dev, "couldn't get resource\n");
>  		ret = -ENODEV;
> -		goto err1;
> +		goto err2;
>  	}
>  
>  	base = ioremap(res->start, resource_size(res));
> @@ -144,22 +149,8 @@ static int __init omap_counter_32k_probe(struct platform_device *pdev)
>  		goto err2;
>  	}
>  
> -	ick = clk_get(&pdev->dev, "ick");
> -	if (IS_ERR(ick)) {
> -		dev_dbg(&pdev->dev, "couldn't get clock\n");
> -		ret = PTR_ERR(ick);
> -		goto err3;
> -	}
> -
> -	ret = clk_enable(ick);
> -	if (ret) {
> -		dev_dbg(&pdev->dev, "couldn't enable clock\n");
> -		goto err4;
> -	}
> -
>  	omap->base	= base;
>  	omap->dev	= &pdev->dev;
> -	omap->ick	= ick;
>  
>  	omap->cs.name	= "counter-32k";
>  	omap->cs.rating	= 250;
> @@ -174,7 +165,7 @@ static int __init omap_counter_32k_probe(struct platform_device *pdev)
>  	ret = clocksource_register(&omap->cs);
>  	if (ret) {
>  		dev_dbg(&pdev->dev, "failed to register clocksource\n");
> -		goto err5;
> +		goto err3;
>  	}
>  
>  	/* initialize our offset */
> @@ -190,16 +181,12 @@ static int __init omap_counter_32k_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> -err5:
> -	clk_disable(ick);
> -
> -err4:
> -	clk_put(ick);
> -
>  err3:
>  	iounmap(base);
>  
>  err2:
> +	pm_runtime_put_sync(&pdev->dev);
> +
>  err1:
>  	kfree(omap);
>  
> @@ -211,9 +198,8 @@ static int __exit omap_counter_32k_remove(struct platform_device *pdev)
>  {
>  	struct omap_counter_32k_device	*omap = platform_get_drvdata(pdev);
>  
> +	pm_runtime_put_sync(&pdev->dev);
>  	clocksource_unregister(&omap->cs);
> -	clk_disable(omap->ick);
> -	clk_put(omap->ick);
>  	iounmap(omap->base);
>  	kfree(omap);
>  	platform_set_drvdata(pdev, NULL);
> @@ -221,16 +207,8 @@ static int __exit omap_counter_32k_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static void omap_counter_32k_shutdown(struct platform_device *pdev)
> -{
> -	struct omap_counter_32k_device	*omap = platform_get_drvdata(pdev);
> -
> -	clk_disable(omap->ick);
> -}
> -
>  static struct platform_driver omap_counter_32k_driver = {
>  	.remove		= __exit_p(omap_counter_32k_remove),
> -	.shutdown	= omap_counter_32k_shutdown,
>  	.driver		= {
>  		.name	= "omap-counter-32k",
>  	},
