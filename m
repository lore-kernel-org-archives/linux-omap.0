From: Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH] usb: otg: Resolving a config conflict between
 omap4030_usb/omap6030 and usb_musb_omap2plus
Date: Mon, 1 Oct 2012 11:31:11 +0200 (CEST)
Message-ID: <alpine.DEB.2.01.1210011122540.3150@pmeerw.net>
References: <1349082638-6380-1-git-send-email-jrm.kurtz@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1349082638-6380-1-git-send-email-jrm.kurtz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jerome Kurtz <jrm.kurtz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, anisse-fwwRqrJYcP2HXe+LvDLADg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello,

> From: Jerome Kurtz <jrm.kurtz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> When I try to compile with TWL6030_USB=y, TWL4030_USB=y and
> USB_MUSB_OMAP2PLUS=m, I get the following error:

there is an earlier patch here: 
https://patchwork.kernel.org/patch/1370291/

and an alternative fix here: 
https://patchwork.kernel.org/patch/1409671/

regards, p.


> drivers/built-in.o: In function `twl4030_usb_irq':
> /home/xxx/kernel/linux/drivers/usb/otg/twl4030-usb.c:518: undefined
> reference to `omap_musb_mailbox'
> drivers/built-in.o: In function `twl6030_usb_irq':
> /home/xxx/kernel/linux/drivers/usb/otg/twl6030-usb.c:272: undefined
> reference to `omap_musb_mailbox'
> /home/xxx/kernel/linux/drivers/usb/otg/twl6030-usb.c:277: undefined
> reference to `omap_musb_mailbox'
> drivers/built-in.o: In function `twl6030_usbotg_irq':
> /home/xxx/kernel/linux/drivers/usb/otg/twl6030-usb.c:306: undefined
> reference to `omap_musb_mailbox'
> drivers/built-in.o: In function `twl4030_usb_phy_init':
> /home/xxx/kernel/linux/drivers/usb/otg/twl4030-usb.c:540: undefined
> reference to `omap_musb_mailbox'
> make: *** [vmlinux] Error 1
> 
> To solve this we must add to depends of TWL4030_USB and TWL6030_USB
> the option : USB_MUSB_OMAP2PLUS as done here.
> 
> Signed-off-by: Jerome Kurtz <jrm.kurtz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/otg/Kconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
> index 13fd1ddf..62ea57b 100644
> --- a/drivers/usb/otg/Kconfig
> +++ b/drivers/usb/otg/Kconfig
> @@ -58,7 +58,7 @@ config USB_ULPI_VIEWPORT
>  
>  config TWL4030_USB
>  	tristate "TWL4030 USB Transceiver Driver"
> -	depends on TWL4030_CORE && REGULATOR_TWL4030
> +	depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
>  	select USB_OTG_UTILS
>  	help
>  	  Enable this to support the USB OTG transceiver on TWL4030
> @@ -68,7 +68,7 @@ config TWL4030_USB
>  
>  config TWL6030_USB
>  	tristate "TWL6030 USB Transceiver Driver"
> -	depends on TWL4030_CORE
> +	depends on TWL4030_CORE &&  USB_MUSB_OMAP2PLUS
>  	select USB_OTG_UTILS
>  	help
>  	  Enable this to support the USB OTG transceiver on TWL6030
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
