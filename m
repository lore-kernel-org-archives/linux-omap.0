From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [rtc-linux] [PATCH 3/3] rtc: omap: use module_platform_driver
Date: Wed, 1 Apr 2015 17:53:57 +0200
Message-ID: <20150401155357.GE20669@piout.net>
References: <1427867698-1326-1-git-send-email-lokeshvutla@ti.com>
 <1427867698-1326-4-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:60308 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751136AbbDAPx7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2015 11:53:59 -0400
Content-Disposition: inline
In-Reply-To: <1427867698-1326-4-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rtc-linux@googlegroups.com
Cc: a.zummo@towertech.it, t-kristo@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, lokeshvutla@ti.com

On 01/04/2015 at 11:24:58 +0530, Lokesh Vutla wrote :
> module_platform_driver_probe() prevents driver from requesting probe deferral.
> So using module_platform_drive() to support probe deferral.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  drivers/rtc/rtc-omap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 96cc613..a4965a0 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -510,7 +510,7 @@ static const struct of_device_id omap_rtc_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, omap_rtc_of_match);
>  
> -static int __init omap_rtc_probe(struct platform_device *pdev)
> +static int omap_rtc_probe(struct platform_device *pdev)
>  {
>  	struct omap_rtc	*rtc;
>  	struct resource	*res;
> @@ -745,6 +745,7 @@ static void omap_rtc_shutdown(struct platform_device *pdev)
>  }
>  
>  static struct platform_driver omap_rtc_driver = {
> +	.probe		= omap_rtc_probe,
>  	.remove		= __exit_p(omap_rtc_remove),
>  	.shutdown	= omap_rtc_shutdown,
>  	.driver		= {
> @@ -755,7 +756,7 @@ static struct platform_driver omap_rtc_driver = {
>  	.id_table	= omap_rtc_id_table,
>  };
>  
> -module_platform_driver_probe(omap_rtc_driver, omap_rtc_probe);
> +module_platform_driver(omap_rtc_driver);
>  
>  MODULE_ALIAS("platform:omap_rtc");
>  MODULE_AUTHOR("George G. Davis (and others)");
> -- 
> 1.9.1
> 
> -- 
> -- 
> You received this message because you are subscribed to "rtc-linux".
> Membership options at http://groups.google.com/group/rtc-linux .
> Please read http://groups.google.com/group/rtc-linux/web/checklist
> before submitting a driver.
> --- 
> You received this message because you are subscribed to the Google Groups "rtc-linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
