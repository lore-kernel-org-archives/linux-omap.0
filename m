From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] musb: fix CONFIGDATA register read issue
Date: Mon, 27 Jul 2009 14:32:15 -0700
Message-ID: <200907271432.15406.david-b@pacbell.net>
References: <1246858408-24953-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1246858408-24953-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sunday 05 July 2009, Ajay Kumar Gupta wrote:
> INDEX register has to be set to '0' before reading
> CONFIGDATA register which is only present in TI musb
> platforms.
> 
> Currently the default register access mode is set to
> FLAT_MODE thus INDEX register is not getting set
> properly with musb_ep_select() which is just a nop
> operation in FLAT_MODE.This invalid register read is
> causing module reinset failure.
> 
> Fixing the issue by moving INDEX register write part to
> musb_read_configdata() function itself.
> 
> Signed-off-by: Vikram Pandita <vikram.pandita at ti.com>
> Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

This is the right fix, thanks.  With these two important
operations *next to each other* it'll be harder to repeat
the goof that cause this breakage.


> ---
> Based on a previous patch from Anand at,
> http://marc.info/?l=linux-omap&m=122051303604377&w=2
> 
> Another version of this fix by Vikram is at,
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-November/012084.html
> 
>  drivers/usb/musb/musb_core.c |    1 -
>  drivers/usb/musb/musb_regs.h |    1 +
>  2 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 554a414..3ec68a1 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1326,7 +1326,6 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
>  	int		i;
>  
>  	/* log core options (read using indexed model) */
> -	musb_ep_select(mbase, 0);
>  	reg = musb_read_configdata(mbase);
>  
>  	strcpy(aInfo, (reg & MUSB_CONFIGDATA_UTMIDW) ? "UTMI-16" : "UTMI-8");
> diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
> index de3b2f1..fbfd3fd 100644
> --- a/drivers/usb/musb/musb_regs.h
> +++ b/drivers/usb/musb/musb_regs.h
> @@ -323,6 +323,7 @@ static inline void  musb_write_rxfifoadd(void __iomem *mbase, u16 c_off)
>  
>  static inline u8 musb_read_configdata(void __iomem *mbase)
>  {
> +	musb_writeb(mbase, MUSB_INDEX, 0);
>  	return musb_readb(mbase, 0x10 + MUSB_CONFIGDATA);
>  }
>  
> -- 
> 1.6.2.4
> 
> 



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
