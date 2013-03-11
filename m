From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: musb: log VBUS error
Date: Mon, 11 Mar 2013 09:24:09 -0700
Message-ID: <20130311162409.GH26093@atomide.com>
References: <1362876568-7082-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1362876568-7082-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [130309 16:53]:
> VBUS_ERROR is a serious error that the driver often doesn't recover from
> in my tests, so we should at least inform the user about it.

Patch makes sens to me, just a related question..

Do you get this when trying to enable the host mode, right? Or have you seen
this in other situations too?

If the error happens when enabling the host mode, my experience is that
the VBUS_ERROR is caused by the musb trying to be too smart and doing the
timeouts automatically. If the VBUS on the hardware does not raise fast
enough to the right range for whatever reason, musb can produce this
error.

Regards,

Tony
 
> Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/musb/musb_core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index f95404e..df6a54e 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -602,7 +602,8 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
>  			break;
>  		}
>  
> -		dev_dbg(musb->controller, "VBUS_ERROR in %s (%02x, %s), retry #%d, port1 %08x\n",
> +		dev_printk(ignore ? KERN_DEBUG : KERN_ERR, musb->controller,
> +			   "VBUS_ERROR in %s (%02x, %s), retry #%d, port1 %08x\n",
>  				otg_state_string(musb->xceiv->state),
>  				devctl,
>  				({ char *s;
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
