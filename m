From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 5/5 v6] usb: musb: Using runtime pm APIs for musb.
Date: Thu, 10 Feb 2011 16:26:06 +0200
Message-ID: <20110210142605.GR3580@legolas.emea.dhcp.ti.com>
References: <1297346881-13438-1-git-send-email-hemahk@ti.com>
 <1297346881-13438-6-git-send-email-hemahk@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:33316 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756483Ab1BJO0K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 09:26:10 -0500
Content-Disposition: inline
In-Reply-To: <1297346881-13438-6-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi,

On Thu, Feb 10, 2011 at 07:38:01PM +0530, Hema HK wrote:
> Calling runtime pm APIs pm_runtime_put_sync() and pm_runtime_get_sync()
> for enabling/disabling the clocks, sysconfig settings.
> 
> Enable clock, configure no-idle/standby when active and configure force idle/standby
> and disable clock when idled. This is taken care by the runtime framework when
> driver calls the pm_runtime_get_sync and pm_runtime_put_sync APIs.

does it have to be the _sync() ??

> Index: linux-2.6/drivers/usb/musb/omap2430.c
> ===================================================================
> --- linux-2.6.orig/drivers/usb/musb/omap2430.c
> +++ linux-2.6/drivers/usb/musb/omap2430.c
> @@ -33,6 +33,8 @@
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/err.h>
>  
>  #include "musb_core.h"
>  #include "omap2430.h"
> @@ -40,7 +42,6 @@
>  struct omap2430_glue {
>  	struct device		*dev;
>  	struct platform_device	*musb;
> -	struct clk		*clk;
>  };
>  #define glue_to_musb(g)		platform_get_drvdata(g->musb)
>  
> @@ -216,20 +217,12 @@ static inline void omap2430_low_level_ex
>  	l = musb_readl(musb->mregs, OTG_FORCESTDBY);
>  	l |= ENABLEFORCE;	/* enable MSTANDBY */
>  	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
> -
> -	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
> -	l |= ENABLEWAKEUP;	/* enable wakeup */
> -	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
>  }
>  
>  static inline void omap2430_low_level_init(struct musb *musb)
>  {
>  	u32 l;
>  
> -	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
> -	l &= ~ENABLEWAKEUP;	/* disable wakeup */
> -	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
> -
>  	l = musb_readl(musb->mregs, OTG_FORCESTDBY);
>  	l &= ~ENABLEFORCE;	/* disable MSTANDBY */
>  	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
> @@ -309,21 +302,6 @@ static int omap2430_musb_init(struct mus
>  
>  	omap2430_low_level_init(musb);
>  
> -	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
> -	l &= ~ENABLEWAKEUP;	/* disable wakeup */
> -	l &= ~NOSTDBY;		/* remove possible nostdby */
> -	l |= SMARTSTDBY;	/* enable smart standby */
> -	l &= ~AUTOIDLE;		/* disable auto idle */
> -	l &= ~NOIDLE;		/* remove possible noidle */
> -	l |= SMARTIDLE;		/* enable smart idle */
> -	/*
> -	 * MUSB AUTOIDLE don't work in 3430.
> -	 * Workaround by Richard Woodruff/TI
> -	 */
> -	if (!cpu_is_omap3430())
> -		l |= AUTOIDLE;		/* enable auto idle */

is this taken care somewhere else ?

> @@ -431,28 +395,30 @@ static int __init omap2430_probe(struct 
>  			pdev->num_resources);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to add resources\n");
> -		goto err4;
> +		goto err2;
>  	}
>  
>  	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to add platform_data\n");
> -		goto err4;
> +		goto err2;
>  	}
>  
>  	ret = platform_device_add(musb);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to register musb device\n");
> -		goto err4;
> +		goto err2;
>  	}
>  
> -	return 0;
> +	pm_runtime_enable(&pdev->dev);
> +	if (pm_runtime_get_sync(&pdev->dev) < 0) {

you have the status variable, so how about:

status = pm_runtime_get_sync(&pdev->dev);
if (status < 0) {

??

> +		dev_err(&pdev->dev, "pm_runtime_get_sync FAILED");
> +		pm_runtime_disable(&pdev->dev);

move the pm_runtime_disable() to err3, maybe. Then just call goto err3
here.

-- 
balbi
