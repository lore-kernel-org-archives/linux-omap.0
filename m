From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 1/5] USB: MUSB: Switch to a_idle when micro/mini-a
	cable is attached
Date: Fri, 16 May 2008 10:38:43 -0700
Message-ID: <20080516173843.GK23002@atomide.com>
References: <1210681796-1984-1-git-send-email-felipe.balbi@nokia.com> <1210681796-1984-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:56539 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbYEPRim (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 13:38:42 -0400
Content-Disposition: inline
In-Reply-To: <1210681796-1984-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080513 05:33]:
> From: ext Felipe Balbi <felipe.balbi@nokia.com>
> 
> This is mostly cosmetic but can help us in the future
> making musb driver not insertion-based.
> 
> I mean, whenever we attach micro-/mini-A connector to
> musb-based devices, we instantaneously turn vbus on where
> we should wait until we need to use the bus.

This would break standard host behavious of basic USB devices that
don't support SRP?

Tony

> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/usb/musb/tusb6010.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
> index 1f3643b..9f92cef 100644
> --- a/drivers/usb/musb/tusb6010.c
> +++ b/drivers/usb/musb/tusb6010.c
> @@ -673,6 +673,8 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *tbase)
>  			default_a = is_host_enabled(musb);
>  		DBG(2, "Default-%c\n", default_a ? 'A' : 'B');
>  		musb->xceiv.default_a = default_a;
> +		musb->xceiv.state = default_a ? OTG_STATE_A_IDLE
> +			: OTG_STATE_B_IDLE;
>  		tusb_source_power(musb, default_a);
>  
>  		/* Don't allow idling immediately */
> -- 
> 1.5.5.1.125.gc697a
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
