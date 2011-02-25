From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/5 v2] usb: musb: Idle path retention and offmode
 support for OMAP3
Date: Fri, 25 Feb 2011 15:34:31 +0200
Message-ID: <20110225133431.GL4190@legolas.emea.dhcp.ti.com>
References: <1298640246-21181-1-git-send-email-hemahk@ti.com>
 <1298640246-21181-4-git-send-email-hemahk@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1298640246-21181-4-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

minor comment.

On Fri, Feb 25, 2011 at 06:54:04PM +0530, Hema HK wrote:
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index b6dcc7e..43c69a9 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -244,6 +244,7 @@ static int musb_otg_notifications(struct notifier_block *nb,
>  		if (is_otg_enabled(musb)) {
>  #ifdef CONFIG_USB_GADGET_MUSB_HDRC
>  			if (musb->gadget_driver) {
> +				pm_runtime_get_sync(musb->controller);
>  				otg_init(musb->xceiv);
>  
>  				if (data->interface_type ==
> @@ -253,6 +254,7 @@ static int musb_otg_notifications(struct notifier_block *nb,
>  			}
>  #endif
>  		} else {
> +			pm_runtime_get_sync(musb->controller);
>  			otg_init(musb->xceiv);
>  			if (data->interface_type ==
>  					MUSB_INTERFACE_UTMI)
> @@ -263,12 +265,24 @@ static int musb_otg_notifications(struct notifier_block *nb,
>  	case USB_EVENT_VBUS:
>  		DBG(4, "VBUS Connect\n");
>  
> +		if (musb->gadget_driver)
> +			pm_runtime_get_sync(musb->controller);
> +
>  		otg_init(musb->xceiv);
>  		break;
>  
>  	case USB_EVENT_NONE:
>  		DBG(4, "VBUS Disconnect\n");
>  
> +#ifdef CONFIG_USB_GADGET_MUSB_HDRC
> +		if (is_otg_enabled(musb))
> +			if (musb->gadget_driver)
> +#endif
> +			{
> +				pm_runtime_mark_last_busy(musb->controller);
> +				pm_runtime_put_autosuspend(musb->controller);
> +			}
> +
>  		if (data->interface_type == MUSB_INTERFACE_UTMI) {
>  			if (musb->xceiv->set_vbus)
>  				otg_set_vbus(musb->xceiv, 0);
> @@ -300,7 +314,12 @@ static int omap2430_musb_init(struct musb *musb)
>  		return -ENODEV;
>  	}
>  
> -	omap2430_low_level_init(musb);
> +	status = pm_runtime_get_sync(dev);
> +	if (status < 0) {
> +		dev_err(dev, "pm_runtime_get_sync FAILED");
> +		pm_runtime_disable(dev);
> +		return -EINVAL;
> +	}

instead, you should use a goto here and update the error handling below
if you need.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
