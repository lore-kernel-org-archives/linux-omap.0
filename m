From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 3/5] USB: MUSB: Do not turn vbus on immediately
Date: Fri, 16 May 2008 10:39:22 -0700
Message-ID: <20080516173922.GL23002@atomide.com>
References: <1210681796-1984-1-git-send-email-felipe.balbi@nokia.com> <1210681796-1984-2-git-send-email-felipe.balbi@nokia.com> <1210681796-1984-3-git-send-email-felipe.balbi@nokia.com> <1210681796-1984-4-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:57022 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbYEPRjV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 13:39:21 -0400
Content-Disposition: inline
In-Reply-To: <1210681796-1984-4-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080513 05:35]:
> From: ext Felipe Balbi <felipe.balbi@nokia.com>
> 
> Wait for user interaction to turn vbus on.
> On end user products, this behavior could be
> masked under some application with permission to
> write to /sys/devices/platform/musb_hdrc/session.

Again, this breaks USB host support for basic USB devices.

Tony

> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/usb/musb/tusb6010.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
> index 9f92cef..14220d9 100644
> --- a/drivers/usb/musb/tusb6010.c
> +++ b/drivers/usb/musb/tusb6010.c
> @@ -675,11 +675,6 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *tbase)
>  		musb->xceiv.default_a = default_a;
>  		musb->xceiv.state = default_a ? OTG_STATE_A_IDLE
>  			: OTG_STATE_B_IDLE;
> -		tusb_source_power(musb, default_a);
> -
> -		/* Don't allow idling immediately */
> -		if (default_a)
> -			idle_timeout = jiffies + (HZ * 3);
>  	}
>  
>  	/* VBUS state change */
> -- 
> 1.5.5.1.125.gc697a
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
