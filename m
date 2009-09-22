From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/9] ehci: fix phy_reset init in ehci probe
Date: Mon, 21 Sep 2009 18:02:03 -0700
Message-ID: <20090922010203.GI27699@atomide.com>
References: <1249560460-16306-1-git-send-email-ajay.gupta@ti.com> <1249560460-16306-2-git-send-email-ajay.gupta@ti.com> <1249560460-16306-3-git-send-email-ajay.gupta@ti.com> <1249560460-16306-4-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54021 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbZIVBCH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Sep 2009 21:02:07 -0400
Content-Disposition: inline
In-Reply-To: <1249560460-16306-4-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, david-b@pacbell.net

* Ajay Kumar Gupta <ajay.gupta@ti.com> [090806 05:11]:
> phy_reset is not getting updated from platform_data.

Adding to ehci branch.

Tony
 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> ---
>  drivers/usb/host/ehci-omap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index 0058f03..55e5259 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -33,7 +33,6 @@
>   *	- add suspend/resume
>   *	- move workarounds to board-files
>   *	- differentiate between ES2.x and ES3.x
> - *	- make it enumerate devices
>   */
>  
>  #include <linux/platform_device.h>
> @@ -590,6 +589,7 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, omap);
>  	omap->dev		= &pdev->dev;
> +	omap->phy_reset		= pdata->phy_reset;
>  	omap->reset_gpio_port1	= pdata->reset_gpio_port1;
>  	omap->reset_gpio_port2	= pdata->reset_gpio_port2;
>  	omap->phy_mode		= pdata->phy_mode;
> -- 
> 1.6.2.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
