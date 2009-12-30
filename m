From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [patch-v2.6.34 7/9] usb: musb: use only clk framework for clk
 handling
Date: Wed, 30 Dec 2009 14:18:56 +0300
Message-ID: <4B3B3720.9070205@ru.mvista.com>
References: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com> <1262127567-15202-8-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1262127567-15202-8-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

Felipe Balbi wrote:

> get rid of the set_clock hackery.
>
> Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> ---
>
> Greg, I'll send this patch to you shortly, it's
> only here so that Tony can have it in linux-omap-2.6
> to avoid breaking any of his boards.
>   

   Er, I'm afraid I have to NAK this patch...

> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 5eb9318..37ca87d 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -977,10 +977,8 @@ static void musb_shutdown(struct platform_device *pdev)
>  	spin_lock_irqsave(&musb->lock, flags);
>  	musb_platform_disable(musb);
>  	musb_generic_disable(musb);
> -	if (musb->clock) {
> -		clk_put(musb->clock);
> -		musb->clock = NULL;
> -	}
> +	clk_put(musb->clock);
> +	musb->clock = NULL;
>  	spin_unlock_irqrestore(&musb->lock, flags);
>  
>  	/* FIXME power down */
> @@ -1864,10 +1862,8 @@ static void musb_free(struct musb *musb)
>  	musb_platform_exit(musb);
>  	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
>  
> -	if (musb->clock) {
> -		clk_disable(musb->clock);
> -		clk_put(musb->clock);
> -	}
> +	clk_disable(musb->clock);
> +	clk_put(musb->clock);
>  
>  #ifdef CONFIG_USB_MUSB_HDRC_HCD
>  	usb_put_hcd(musb_to_hcd(musb));
> @@ -1930,7 +1926,6 @@ bad_config:
>  	spin_lock_init(&musb->lock);
>  	musb->board_mode = plat->mode;
>  	musb->board_set_power = plat->set_power;
> -	musb->set_clock = plat->set_clock;
>  	musb->min_power = plat->min_power;
>  
>  	/* Clock usage is chip-specific ... functional clock (DaVinci,
> @@ -1938,15 +1933,17 @@ bad_config:
>  	 * code does is make sure a clock handle is available; platform
>  	 * code manages it during start/stop and suspend/resume.
>  	 */
> -	if (plat->clock) {
> -		musb->clock = clk_get(dev, plat->clock);
> -		if (IS_ERR(musb->clock)) {
> -			status = PTR_ERR(musb->clock);
> -			musb->clock = NULL;
> -			goto fail;
> -		}
> +	musb->clock = clk_get(dev, "ick");
>   

   Why always "ick"?! Do you think OMAPs are the only boards using MUSB 
out there?

WBR, Sergei


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
