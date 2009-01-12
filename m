From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH 3/3] usb: musb: fix null pointer check in
	musb_platform_init()
Date: Tue, 13 Jan 2009 00:31:55 +0200
Message-ID: <20090112223154.GO25493@frodo>
References: <1231326860-22727-1-git-send-email-ajay.gupta@ti.com>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1231326860-22727-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 07, 2009 at 04:44:20PM +0530, Ajay Kumar Gupta wrote:
> Fixes kernel panic when musb is selected for OMAP35x EVM but twl4030 is not
> selected as in this case otg_get_transceiver() returns null.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

Ajay, can you update this patch so we dev_err() the absence of a
transceiver driver ???

Thanks, besides that, you can put my s-o-b or ack

> ---
>  drivers/usb/musb/omap2430.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 3f99536..6ddc986 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -232,6 +232,8 @@ int __init musb_platform_init(struct musb *musb)
>  #if defined(CONFIG_ARCH_OMAP2430)
>  	omap_cfg_reg(AE5_2430_USB0HS_STP);
>  #endif
> +	if (!x)
> +		return -ENODEV;
>  
>  	musb->xceiv = *x;
>  	musb_platform_resume(musb);
> -- 
> 1.5.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
