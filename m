From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 2/4] rtc: omap: Adopt driver to support probe deferral
Date: Wed, 8 Oct 2014 19:38:00 +0200
Message-ID: <20141008173800.GG1990@localhost>
References: <1411637529-18289-1-git-send-email-lokeshvutla@ti.com>
 <1411637529-18289-3-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:38986 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176AbaJHRku (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2014 13:40:50 -0400
Content-Disposition: inline
In-Reply-To: <1411637529-18289-3-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: rtc-linux@googlegroups.com, a.zummo@towertech.it, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, balbi@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Thu, Sep 25, 2014 at 03:02:07PM +0530, Lokesh Vutla wrote:

Perhaps the subject should simply be "use module_platform_driver", then
you can explain your motive for the change in the body as you already do.

> module_platform_driver_probe() prevents driver from requesting probe deferral.
> So using module_platform_drive() to support probe deferral.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Changes since V1:
> 	- New patch, seperated from patch 4/4.
>  drivers/rtc/rtc-omap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 4e90b50..93c5424 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -397,7 +397,7 @@ static const struct of_device_id omap_rtc_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, omap_rtc_of_match);
>  
> -static int __init omap_rtc_probe(struct platform_device *pdev)
> +static int omap_rtc_probe(struct platform_device *pdev)
>  {
>  	struct resource		*res;
>  	struct rtc_omap_dev	*rtc_omap;
> @@ -601,6 +601,7 @@ static void omap_rtc_shutdown(struct platform_device *pdev)
>  }
>  
>  static struct platform_driver omap_rtc_driver = {
> +	.probe		= omap_rtc_probe,
>  	.remove		= __exit_p(omap_rtc_remove),
>  	.shutdown	= omap_rtc_shutdown,
>  	.driver		= {

You should also drop the .owner field of .driver, which is set by the
module_platform_driver macro.

> @@ -612,7 +613,7 @@ static struct platform_driver omap_rtc_driver = {
>  	.id_table	= omap_rtc_devtype,
>  };
>  
> -module_platform_driver_probe(omap_rtc_driver, omap_rtc_probe);
> +module_platform_driver(omap_rtc_driver);
>  
>  MODULE_ALIAS("platform:omap_rtc");
>  MODULE_AUTHOR("George G. Davis (and others)");

Johan
