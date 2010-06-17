From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/8] musb: fix compilation warning in host only mode
Date: Thu, 17 Jun 2010 15:18:49 +0400
Message-ID: <4C1A0499.9020802@ru.mvista.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com> <1276771242-5201-2-git-send-email-ajay.gupta@ti.com> <1276771242-5201-3-git-send-email-ajay.gupta@ti.com> <1276771242-5201-4-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1276771242-5201-4-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

Ajay Kumar Gupta wrote:

> Fixes below compilation warning when host only configuration is
> selected.
> drivers/usb/musb/musb_core.c: In function 'musb_stage0_irq':
> drivers/usb/musb/musb_core.c:711: warning: unused variable 'mbase'

> Also removed definition of 'mbase' from multiple places to only
> at function top.

    AFAIR, it was intentionally removed from the function top and declared in 
the multiple plcase instead by the former Felipe's patch [1] to fix exactly 
the same issue, if I don't mistake. So, it hasn't worked out?

> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
[...]
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index f0ff893..7cc8398 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -455,6 +455,9 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
>  				u8 devctl, u8 power)
>  {
>  	irqreturn_t handled = IRQ_NONE;
> +#ifdef CONFIG_USB_MUSB_HDRC_HCD
> +	void __iomem	*mbase = musb->mregs;
> +#endif

    I'd rather see it declared multiple times...

> @@ -703,7 +700,6 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
>  
>  	if (int_usb & MUSB_INTR_CONNECT) {
>  		struct usb_hcd *hcd = musb_to_hcd(musb);
> -		void __iomem *mbase = musb->mregs;

    We could also move this into the #ifdef CONFIG_USB_MUSB_OTG block.

>  
>  		handled = IRQ_HANDLED;
>  		musb->is_active = 1;

[1] 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=aa4714560b4ea359bb7830188ebd06bce71bcdea

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
