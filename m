From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 2/3] USB: musb: omap: Fix wrong xceivr passing to twl4030
Date: Tue, 8 Sep 2009 11:03:29 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436B014B8@dbde02.ent.ti.com>
References: <1252105499-19003-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44502 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbZIHFdk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Sep 2009 01:33:40 -0400
In-Reply-To: <1252105499-19003-1-git-send-email-vikram.pandita@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "david-b@pacbell.net" <david-b@pacbell.net>, "Gadiyar, Anand" <gadiyar@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

Vikram,

> -----Original Message-----
> From: Pandita, Vikram
> Sent: Saturday, September 05, 2009 4:35 AM
> To: linux-usb@vger.kernel.org
> Cc: linux-omap@vger.kernel.org; david-b@pacbell.net; Gupta, Ajay Kumar;
> Gadiyar, Anand; felipe.balbi@nokia.com; Pandita, Vikram
> Subject: [PATCH 2/3] USB: musb: omap: Fix wrong xceivr passing to twl4030
> 
> Wrong pointer was getting passed to twl4030 transceiver.
> 
> Call path is:
> otg_set_suspend -> twl4030_set_suspend
> 
> drivers/usb/otg/twl4030-usb.c: twl4030_set_suspend() uses:
> 	struct twl4030_usb *twl = xceiv_to_twl(x);
> 
> and xceiv_to_twl is container_of()
> 
> So the same pointer needs to be passed to otg_set_suspend() as has
> been used for otg_set_transceiver.
> 
> A crash is seen without this patch, as twl pointer access is worng
> 

musb->xceiv is also taken from otg_get_transceiver() in musb_platform_init(). So this patch is not required.

-Ajay

> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
>  drivers/usb/musb/omap2430.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index b957575..ea7a798 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -269,7 +269,7 @@ int musb_platform_suspend(struct musb *musb)
>  	l |= ENABLEWAKEUP;	/* enable wakeup */
>  	omap_writel(l, OTG_SYSCONFIG);
> 
> -	otg_set_suspend(musb->xceiv, 1);
> +	otg_set_suspend(otg_get_transceiver(), 1);
> 
>  	if (musb->set_clock)
>  		musb->set_clock(musb->clock, 0);
> @@ -286,7 +286,7 @@ int musb_platform_resume(struct musb *musb)
>  	if (!musb->clock)
>  		return 0;
> 
> -	otg_set_suspend(musb->xceiv, 0);
> +	otg_set_suspend(otg_get_transceiver(), 0);
> 
>  	if (musb->set_clock)
>  		musb->set_clock(musb->clock, 1);
> --
> 1.6.3.3.334.g916e1

