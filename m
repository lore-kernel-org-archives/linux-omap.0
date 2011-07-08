From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] usb: musb: restore INDEX register in resume path
Date: Fri, 8 Jul 2011 15:10:21 +0530
Message-ID: <ADF30F4D7BDE934D9B632CE7D5C7ACA4047B9A2577F9@dbde03.ent.ti.com>
References: <1310117773-31571-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1310117773-31571-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Gupta, Ajay Kumar wrote:
> Restoring the missing INDEX register value in musb_restore_context().
> Without this suspend resume functionality is broken with offmode
> enabled.
> 
> Cc: stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

FWIW,

Acked-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>

> ---
>  drivers/usb/musb/musb_core.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index c71b037..dce7182 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2329,6 +2329,7 @@ static void musb_restore_context(struct musb *musb)
>  				musb->context.index_regs[i].rxhubport);
>  		}
>  	}
> +	musb_writeb(musb_base, MUSB_INDEX, musb->context.index);
>  }
>  
>  static int musb_suspend(struct device *dev)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
