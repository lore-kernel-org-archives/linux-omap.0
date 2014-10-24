From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH V3 1/3] rtc: omap: use module_platform_driver
Date: Fri, 24 Oct 2014 09:33:46 +0200
Message-ID: <20141024073346.GC28808@localhost>
References: <1414126425-13198-1-git-send-email-lokeshvutla@ti.com>
 <1414126425-13198-2-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:41619 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbaJXHgu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Oct 2014 03:36:50 -0400
Content-Disposition: inline
In-Reply-To: <1414126425-13198-2-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, a.zummo@towertech.it, johan@kernel.org, tony@atomide.com, bcousson@baylibre.com, balbi@ti.com, akpm@linux-foundation.org, linux@roeck-us.net, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Fri, Oct 24, 2014 at 10:23:43AM +0530, Lokesh Vutla wrote:
> module_platform_driver_probe() prevents driver from requesting probe deferral.
> So using module_platform_drive() to support probe deferral.
> And also removing .owner field which is set by module_platform_driver.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Reviewed-by: Johan Hovold <johan@kernel.org>

> ---
>  drivers/rtc/rtc-omap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index e74750f..d9bb5e7 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -477,7 +477,7 @@ static const struct of_device_id omap_rtc_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, omap_rtc_of_match);
>  
> -static int __init omap_rtc_probe(struct platform_device *pdev)
> +static int omap_rtc_probe(struct platform_device *pdev)
>  {
>  	struct omap_rtc	*rtc;
>  	struct resource	*res;
> @@ -708,18 +708,18 @@ static void omap_rtc_shutdown(struct platform_device *pdev)
>  }
>  
>  static struct platform_driver omap_rtc_driver = {
> +	.probe		= omap_rtc_probe,
>  	.remove		= __exit_p(omap_rtc_remove),
>  	.shutdown	= omap_rtc_shutdown,
>  	.driver		= {
>  		.name	= "omap_rtc",
> -		.owner	= THIS_MODULE,
>  		.pm	= &omap_rtc_pm_ops,
>  		.of_match_table = omap_rtc_of_match,
>  	},
>  	.id_table	= omap_rtc_id_table,
>  };
>  
> -module_platform_driver_probe(omap_rtc_driver, omap_rtc_probe);
> +module_platform_driver(omap_rtc_driver);
>  
>  MODULE_ALIAS("platform:omap_rtc");
>  MODULE_AUTHOR("George G. Davis (and others)");
