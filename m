From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: omap3: ehci: trivial fix of a debug print
Date: Tue, 13 Oct 2009 10:32:04 +0300
Message-ID: <20091013073204.GE24738@nokia.com>
References: <1255368020-23659-1-git-send-email-gadiyar@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37097 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933697AbZJMHgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 03:36:10 -0400
Content-Disposition: inline
In-Reply-To: <1255368020-23659-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Anand Gadiyar <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Oct 12, 2009 at 07:20:20PM +0200, ext Anand Gadiyar wrote:
> omap3: ehci: trivial fix of a debug print
> 
> We're interested in uhh_hostconfig, not uhh_base. While we
> are actually printing the former, we're calling it the latter.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

> ---
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index 45b8a7c..73f0b3b 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -363,7 +363,7 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
>  
>  	}
>  	ehci_omap_writel(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
> -	dev_dbg(omap->dev, "UHH setup done, uhh_base=%x\n", reg);
> +	dev_dbg(omap->dev, "UHH setup done, uhh_hostconfig=%x\n", reg);
>  
>  
>  	if ((omap->port_mode[0] == EHCI_HCD_OMAP_MODE_TLL) ||
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
