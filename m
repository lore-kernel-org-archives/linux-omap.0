From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] usb: musb: ignore disconnect on suspend
Date: Mon, 23 Jun 2008 14:13:17 +0300
Message-ID: <20080623111317.GQ7741@atomide.com>
References: <1213182432-23952-1-git-send-email-felipe.balbi@nokia.com> <1213182432-23952-2-git-send-email-felipe.balbi@nokia.com> <1213182432-23952-3-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [63.208.196.179] ([63.208.196.179]:49551 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752377AbYFWLMv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jun 2008 07:12:51 -0400
Content-Disposition: inline
In-Reply-To: <1213182432-23952-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080611 14:09]:
> This still needed, otherwise tusb2.0 won't connect after
> a power cycle.

Pushing today.

Tony

> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/usb/musb/musb_core.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 019898a..5b92f21 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -659,7 +659,11 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
>  			switch (musb->xceiv.state) {
>  #ifdef CONFIG_USB_OTG
>  			case OTG_STATE_A_SUSPEND:
> -				musb->ignore_disconnect = 0;
> +				/* We need to ignore disconnect on suspend
> +				 * otherwise tusb 2.0 won't reconnect after a
> +				 * power cycle, which breaks otg compliance.
> +				 */
> +				musb->ignore_disconnect = 1;
>  				musb_g_reset(musb);
>  				/* FALLTHROUGH */
>  			case OTG_STATE_A_WAIT_BCON:	/* OPT TD.4.7-900ms */
> -- 
> 1.5.6.rc1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
