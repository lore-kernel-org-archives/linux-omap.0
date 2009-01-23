From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] usb: musb: fix bug in musb_free() w.r.t free_irq()
Date: Fri, 23 Jan 2009 12:16:16 +0200
Message-ID: <20090123101616.GM9233@scadufax.research.nokia.com>
References: <1231326829-22638-1-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1231326829-22638-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 07, 2009 at 04:43:49PM +0530, Ajay Kumar Gupta wrote:
> Fixes insert module failure as free_irq() was not
> done in previous rmmod.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

Acked-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/usb/musb/musb_core.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index f71fab6..2447e3a 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1824,8 +1824,9 @@ static void musb_free(struct musb *musb)
>  	musb_gadget_cleanup(musb);
>  #endif
>  
> -	if (musb->nIrq >= 0 && musb->irq_wake) {
> -		disable_irq_wake(musb->nIrq);
> +	if (musb->nIrq >= 0) {
> +		if (musb->irq_wake)
> +			disable_irq_wake(musb->nIrq);
>  		free_irq(musb->nIrq, musb);
>  	}
>  	if (is_dma_capable() && musb->dma_controller) {
> -- 
> 1.5.6

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
