From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 5/6 v3] arm: omap: usb: Runtime PM support
Date: Fri, 8 Jul 2011 10:45:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107081044460.2208-100000@iolanthe.rowland.org>
References: <1310122965-23612-6-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1310122965-23612-6-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 8 Jul 2011, Keshava Munegowda wrote:

> The usbhs core driver does not enable/disable the intefrace and
> fucntional clocks; These clocks are handled by hwmod and runtime pm,
> hence insted of the clock enable/disable, the runtime pm APIS are
> used. however,the port clocks and tll clocks are handled
> by the usbhs core.
> In this architecture, the usbhs is core driver and it is parent of
> ehci and ohci drivers.The earlier APIs omap_usbhs_enable and
> omap_usbhs_disable of usbhs core driver are removed;
> The ehci and ohci drivers call the pm_runtime_get_sync and
> pm_runtime_put_sync of parent device usbhs core.
> In fact, the runtime framework takes care the get sync and
> put sync of the child in turn call the get sync and put sync
> of parent too; but calling get sync and put sync of parent is
> by ASYNC mode; This mode queues the work item in runtime pm
> work queue, which not getting scheduled in case of global suspend path.
> so, here ehci and ohci runtim pm is not required, these
> drivers will pass the parent usbhs dev pointer in runtime pm APIs.

> --- a/drivers/usb/host/ohci-omap3.c
> +++ b/drivers/usb/host/ohci-omap3.c
> @@ -31,6 +31,7 @@
>  
>  #include <linux/platform_device.h>
>  #include <plat/usb.h>
> +#include <linux/pm_runtime.h>
>  
>  /*-------------------------------------------------------------------------*/
>  
> @@ -172,11 +173,7 @@ static int __devinit ohci_hcd_omap3_probe(struct platform_device *pdev)
>  	hcd->rsrc_len = resource_size(res);
>  	hcd->regs =  regs;
>  
> -	ret = omap_usbhs_enable(dev);
> -	if (ret) {
> -		dev_dbg(dev, "failed to start ohci\n");
> -		goto err_end;
> -	}
> +	pm_runtime_get_sync(dev->parent);
>  
>  	ohci_hcd_init(hcd_to_ohci(hcd));
>  
> @@ -189,7 +186,7 @@ static int __devinit ohci_hcd_omap3_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_add_hcd:
> -	omap_usbhs_disable(dev);
> +	pm_runtime_get_sync(dev->parent);

Looks like a typo; this should be _put_sync().

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
