From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ehci: fix missing kfree in remove path also
Date: Mon, 28 Dec 2009 15:42:18 -0800
Message-ID: <20091228234218.GS3512@atomide.com>
References: <1260970570-28536-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52398 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbZL1XmW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Dec 2009 18:42:22 -0500
Content-Disposition: inline
In-Reply-To: <1260970570-28536-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com

* Ajay Kumar Gupta <ajay.gupta@ti.com> [091216 05:35]:
> Added missing kfree() in ehci_hcd_omap_remove().

This should get merged via linux-usb list.

Regards,

Tony
 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> ---
>  drivers/usb/host/ehci-omap.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index 74d07f4..2460f0d 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -681,6 +681,7 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
>  	iounmap(omap->tll_base);
>  	iounmap(omap->uhh_base);
>  	usb_put_hcd(hcd);
> +	kfree(omap);
>  
>  	return 0;
>  }
> -- 
> 1.6.2.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
