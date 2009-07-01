From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] usb: musb: Warn and check for OTG transceiver
 misconfiguration
Date: Wed, 1 Jul 2009 00:31:58 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0907010030030.6974@utopia.booyaka.com>
References: <1246266408-1467-1-git-send-email-ext-roger.quadros@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42035 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbZGAGb4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jul 2009 02:31:56 -0400
In-Reply-To: <1246266408-1467-1-git-send-email-ext-roger.quadros@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: tony@atomide.com, felipe.balbi@nokia.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Mon, 29 Jun 2009, Roger Quadros wrote:

> Warn if OTG is selected in Kconfig but not initialized by platform code.
> Add checks to prevent NULL pointer exception in case the
> OTG transceiver has not been initialized. i.e. musb->xceiv == NULL
> 
> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>

Tested-by: Paul Walmsley <paul@pwsan.com>

... on BeagleBoard Rev C2.  Without this patch, linux-omap at commit 
7c5cb7862d32cb344be7831d466535d5255e35ac (the current HEAD) crashes during
boot.

- Paul

> ---
>  drivers/usb/musb/musb_core.c |    7 ++++++-
>  drivers/usb/musb/omap2430.c  |    3 ++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 554a414..d0cfc22 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1861,7 +1861,8 @@ static void musb_free(struct musb *musb)
>  	}
>  
>  #ifdef CONFIG_USB_MUSB_OTG
> -	put_device(musb->xceiv->dev);
> +	if (musb->xceiv)
> +		put_device(musb->xceiv->dev);
>  #endif
>  
>  #ifdef CONFIG_USB_MUSB_HDRC_HCD
> @@ -1958,6 +1959,10 @@ bad_config:
>  	musb->isr = generic_interrupt;
>  	status = musb_platform_init(musb);
>  
> +#ifdef CONFIG_USB_MUSB_OTG
> +	if (!musb->xceiv)
> +		WARN(1, "MUSB: OTG transceiver not set up correctly\n");
> +#endif
>  	if (status < 0)
>  		goto fail;
>  	if (!musb->isr) {
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 3487520..8987d60 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -271,7 +271,8 @@ int musb_platform_suspend(struct musb *musb)
>  	l |= ENABLEWAKEUP;	/* enable wakeup */
>  	omap_writel(l, OTG_SYSCONFIG);
>  
> -	otg_set_suspend(musb->xceiv, 1);
> +	if (musb->xceiv)
> +		otg_set_suspend(musb->xceiv, 1);
>  
>  	if (musb->set_clock)
>  		musb->set_clock(musb->clock, 0);
> -- 
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

