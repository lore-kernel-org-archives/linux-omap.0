From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch v2.6.39 2/3] usb: musb: gadget: beautify usb_gadget_probe_driver()/usb_gadget_unregister_driver
Date: Thu, 17 Feb 2011 16:00:30 +0300
Message-ID: <4D5D1BEE.30704@ru.mvista.com>
References: <1297942221-22995-1-git-send-email-balbi@ti.com> <1297942221-22995-3-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297942221-22995-3-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Hema Kalliguddi <hemahk-l0cyMroinI0@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

On 17-02-2011 14:30, Felipe Balbi wrote:

> Just a few cosmetic fixes to usb_gadget_probe_driver()
> and usb_gadget_unregister_driver().

> Decreased a few indentation levels with goto statements.

> Signed-off-by: Felipe Balbi<balbi-l0cyMroinI0@public.gmane.org>
[...]

> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index 2fe3046..86decba 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -1801,90 +1801,95 @@ void musb_gadget_cleanup(struct musb *musb)
>   int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
>   		int (*bind)(struct usb_gadget *))
>   {
> -	int retval;
> -	unsigned long flags;
> -	struct musb *musb = the_gadget;
> +	struct musb		*musb = the_gadget;
> +	unsigned long		flags;
> +	int			retval = -EINVAL;
>
>   	if (!driver
>   			|| driver->speed != USB_SPEED_HIGH
>   			|| !bind || !driver->setup)
> -		return -EINVAL;
> +		goto err0;

    Not sure what this gains...

>
>   	/* driver must be initialized to support peripheral mode */
>   	if (!musb) {
>   		DBG(1, "%s, no dev??\n", __func__);
> -		return -ENODEV;
> +		retval = -ENODEV;
> +		goto err0;

    This too...

>   	}
>
>   	DBG(3, "registering driver %s\n", driver->function);
> -	spin_lock_irqsave(&musb->lock, flags);

    Is it really correct to remove spinlocm protection here?

>   	if (musb->gadget_driver) {
>   		DBG(1, "%s is already bound to %s\n",
>   				musb_driver_name,
>   				musb->gadget_driver->driver.name);
>   		retval = -EBUSY;
> -	} else {
> -		musb->gadget_driver = driver;
> -		musb->g.dev.driver =&driver->driver;
> -		driver->driver.bus = NULL;
> -		musb->softconnect = 1;
> -		retval = 0;
> +		goto err0;
>   	}
>
> +	spin_lock_irqsave(&musb->lock, flags);
> +	musb->gadget_driver = driver;
> +	musb->g.dev.driver =&driver->driver;
> +	driver->driver.bus = NULL;
> +	musb->softconnect = 1;
>   	spin_unlock_irqrestore(&musb->lock, flags);
>
> -	if (retval == 0) {

    Yeah, I have noticed this too and wanted to change it -- but forgot... :-)

[...]

> -		if (is_otg_enabled(musb)) {
> -			struct usb_hcd	*hcd = musb_to_hcd(musb);
> +	if (is_otg_enabled(musb)) {
> +		struct usb_hcd	*hcd = musb_to_hcd(musb);
>
> -			DBG(3, "OTG startup...\n");
> +		DBG(3, "OTG startup...\n");
>
> -			/* REVISIT:  funcall to other code, which also
> -			 * handles power budgeting ... this way also
> -			 * ensures HdrcStart is indirectly called.
> -			 */
> -			retval = usb_add_hcd(musb_to_hcd(musb), -1, 0);
> -			if (retval<  0) {
> -				DBG(1, "add_hcd failed, %d\n", retval);
> -				spin_lock_irqsave(&musb->lock, flags);
> -				otg_set_peripheral(musb->xceiv, NULL);

    You're removing this call -- is it intentional?

> -				musb->gadget_driver = NULL;
> -				musb->g.dev.driver = NULL;
> -				spin_unlock_irqrestore(&musb->lock, flags);
> -			} else {
> -				hcd->self.uses_pio_for_control = 1;
> -			}
> +		/* REVISIT:  funcall to other code, which also
> +		 * handles power budgeting ... this way also
> +		 * ensures HdrcStart is indirectly called.
> +		 */
> +		retval = usb_add_hcd(musb_to_hcd(musb), -1, 0);
> +		if (retval < 0) {
> +			DBG(1, "add_hcd failed, %d\n", retval);
> +			goto err2;
>   		}
> +
> +		hcd->self.uses_pio_for_control = 1;
>   	}
>
> +	return 0;
> +
> +err2:
> +	if (!is_otg_enabled(musb))
> +		musb_stop(musb);

    Hm, this wasn't called before -- you don't describe why it's needed.

> +
> +err1:
> +	musb->gadget_driver = NULL;
> +	musb->g.dev.driver = NULL;
> +
> +err0:
>   	return retval;
>   }
>   EXPORT_SYMBOL(usb_gadget_probe_driver);
> @@ -1939,14 +1944,17 @@ static void stop_activity(struct musb *musb, struct usb_gadget_driver *driver)
>    */
>   int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
>   {
> -	unsigned long	flags;
> -	int		retval = 0;
>   	struct musb	*musb = the_gadget;
> +	unsigned long	flags;
>
>   	if (!driver || !driver->unbind || !musb)
>   		return -EINVAL;
>
> -	/* REVISIT always use otg_set_peripheral() here too;
> +	if (!musb->gadget_driver)
> +		return -EINVAL;
> +
> +	/*
> +	 * REVISIT always use otg_set_peripheral() here too;
>   	 * this needs to shut down the OTG engine.
>   	 */
>
> @@ -1956,29 +1964,26 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
>   	musb_hnp_stop(musb);
>   #endif
>
> -	if (musb->gadget_driver == driver) {
> +	(void) musb_gadget_vbus_draw(&musb->g, 0);
>
> -		(void) musb_gadget_vbus_draw(&musb->g, 0);
> +	musb->xceiv->state = OTG_STATE_UNDEFINED;
> +	stop_activity(musb, driver);
> +	otg_set_peripheral(musb->xceiv, NULL);
>
> -		musb->xceiv->state = OTG_STATE_UNDEFINED;
> -		stop_activity(musb, driver);
> -		otg_set_peripheral(musb->xceiv, NULL);
> +	DBG(3, "unregistering driver %s\n", driver->function);
>
> -		DBG(3, "unregistering driver %s\n", driver->function);
> -		spin_unlock_irqrestore(&musb->lock, flags);
> -		driver->unbind(&musb->g);
> -		spin_lock_irqsave(&musb->lock, flags);
> +	spin_unlock_irqrestore(&musb->lock, flags);
> +	driver->unbind(&musb->g);
> +	spin_lock_irqsave(&musb->lock, flags);
>
> -		musb->gadget_driver = NULL;
> -		musb->g.dev.driver = NULL;
> +	musb->gadget_driver = NULL;
> +	musb->g.dev.driver = NULL;
>
> -		musb->is_active = 0;
> -		musb_platform_try_idle(musb, 0);
> -	} else
> -		retval = -EINVAL;
> +	musb->is_active = 0;
> +	musb_platform_try_idle(musb, 0);
>   	spin_unlock_irqrestore(&musb->lock, flags);
>
> -	if (is_otg_enabled(musb)&&  retval == 0) {
> +	if (is_otg_enabled(musb)) {
>   		usb_remove_hcd(musb_to_hcd(musb));
>   		/* FIXME we need to be able to register another
>   		 * gadget driver here and have everything work;
> @@ -1986,7 +1991,10 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
>   		 */
>   	}
>
> -	return retval;
> +	if (!is_otg_enabled(musb))
> +		musb_stop(musb);

    Wasn't called before either -- you don't describe why it's needed...

> +
> +	return 0;
>   }
>   EXPORT_SYMBOL(usb_gadget_unregister_driver);

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
