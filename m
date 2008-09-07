From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] MUSB: Set INDEX register to 0 before accessing CONFIGDATA
Date: Sat, 6 Sep 2008 22:04:01 -0700
Message-ID: <200809062204.01492.david-b@pacbell.net>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02C418D1B1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02C418D1B1-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 04 September 2008, Gadiyar, Anand wrote:
> From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
> 
> The Index register needs to be zero to access CONFIGDATA.
> musb_ep_select()will not set the MUSB_INDEX register unless INDEXED
> mode addressing is used. This change will set the register correctly
> in INDEXED as well as FLAT mode.
> 
> Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
> CC: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

ACK.  I *know* it was originally written that way.  I think
the change was one of the Blackfin patches ... I hope this
isn't one of those cases where the Blackfin version of this
core acts differently.  (Like clearing that DMA IRQ status...)


> ---
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index b398776..6c4da2f 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1334,7 +1334,7 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
>  	int		i;
>  
>  	/* log core options (read using indexed model) */
> -	musb_ep_select(mbase, 0);
> +	musb_writeb(mbase, MUSB_INDEX, 0);
>  	reg = musb_readb(mbase, 0x10 + MUSB_CONFIGDATA);
>  
>  	strcpy(aInfo, (reg & MUSB_CONFIGDATA_UTMIDW) ? "UTMI-16" : "UTMI-8");--
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
