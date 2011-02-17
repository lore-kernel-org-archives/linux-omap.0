From: Felipe Balbi <balbi@ti.com>
Subject: Re: [patch v2.6.39 2/3] usb: musb: gadget: beautify
 usb_gadget_probe_driver()/usb_gadget_unregister_driver
Date: Thu, 17 Feb 2011 15:15:10 +0200
Message-ID: <20110217131510.GI22356@legolas.emea.dhcp.ti.com>
References: <1297942221-22995-1-git-send-email-balbi@ti.com>
 <1297942221-22995-3-git-send-email-balbi@ti.com>
 <4D5D1BEE.30704@ru.mvista.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:55818 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753898Ab1BQNQa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 08:16:30 -0500
Content-Disposition: inline
In-Reply-To: <4D5D1BEE.30704@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Greg KH <greg@kroah.com>, Anand Gadiyar <gadiyar@ti.com>, Hema Kalliguddi <hemahk@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi,

On Thu, Feb 17, 2011 at 04:00:30PM +0300, Sergei Shtylyov wrote:
> >diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> >index 2fe3046..86decba 100644
> >--- a/drivers/usb/musb/musb_gadget.c
> >+++ b/drivers/usb/musb/musb_gadget.c
> >@@ -1801,90 +1801,95 @@ void musb_gadget_cleanup(struct musb *musb)
> >  int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
> >  		int (*bind)(struct usb_gadget *))
> >  {
> >-	int retval;
> >-	unsigned long flags;
> >-	struct musb *musb = the_gadget;
> >+	struct musb		*musb = the_gadget;
> >+	unsigned long		flags;
> >+	int			retval = -EINVAL;
> >
> >  	if (!driver
> >  			|| driver->speed != USB_SPEED_HIGH
> >  			|| !bind || !driver->setup)
> >-		return -EINVAL;
> >+		goto err0;
> 
>    Not sure what this gains...
> 
> >
> >  	/* driver must be initialized to support peripheral mode */
> >  	if (!musb) {
> >  		DBG(1, "%s, no dev??\n", __func__);
> >-		return -ENODEV;
> >+		retval = -ENODEV;
> >+		goto err0;
> 
>    This too...

I don't like the way it is today, and IMO it looks cleaner to have a
error path with goto statements so that we have only one path for error
handling.

> >  	DBG(3, "registering driver %s\n", driver->function);
> >-	spin_lock_irqsave(&musb->lock, flags);
> 
>    Is it really correct to remove spinlocm protection here?

I'm guessing it won't have any problem. I'm only reading
musb->gadget_driver...

> 
> >  	if (musb->gadget_driver) {
> >  		DBG(1, "%s is already bound to %s\n",
> >  				musb_driver_name,
> >  				musb->gadget_driver->driver.name);
> >  		retval = -EBUSY;
> >-	} else {
> >-		musb->gadget_driver = driver;
> >-		musb->g.dev.driver =&driver->driver;
> >-		driver->driver.bus = NULL;
> >-		musb->softconnect = 1;
> >-		retval = 0;
> >+		goto err0;
> >  	}
> >
> >+	spin_lock_irqsave(&musb->lock, flags);
> >+	musb->gadget_driver = driver;
> >+	musb->g.dev.driver =&driver->driver;
> >+	driver->driver.bus = NULL;
> >+	musb->softconnect = 1;
> >  	spin_unlock_irqrestore(&musb->lock, flags);
> >
> >-	if (retval == 0) {
> 
>    Yeah, I have noticed this too and wanted to change it -- but forgot... :-)

tell me about it. Has been on my TODO list for ages :-p

> >-		if (is_otg_enabled(musb)) {
> >-			struct usb_hcd	*hcd = musb_to_hcd(musb);
> >+	if (is_otg_enabled(musb)) {
> >+		struct usb_hcd	*hcd = musb_to_hcd(musb);
> >
> >-			DBG(3, "OTG startup...\n");
> >+		DBG(3, "OTG startup...\n");
> >
> >-			/* REVISIT:  funcall to other code, which also
> >-			 * handles power budgeting ... this way also
> >-			 * ensures HdrcStart is indirectly called.
> >-			 */
> >-			retval = usb_add_hcd(musb_to_hcd(musb), -1, 0);
> >-			if (retval<  0) {
> >-				DBG(1, "add_hcd failed, %d\n", retval);
> >-				spin_lock_irqsave(&musb->lock, flags);
> >-				otg_set_peripheral(musb->xceiv, NULL);
> 
>    You're removing this call -- is it intentional?

Default state is already peripheral anyway, so there's no point in
having that.

> 
> >-				musb->gadget_driver = NULL;
> >-				musb->g.dev.driver = NULL;
> >-				spin_unlock_irqrestore(&musb->lock, flags);
> >-			} else {
> >-				hcd->self.uses_pio_for_control = 1;
> >-			}
> >+		/* REVISIT:  funcall to other code, which also
> >+		 * handles power budgeting ... this way also
> >+		 * ensures HdrcStart is indirectly called.
> >+		 */
> >+		retval = usb_add_hcd(musb_to_hcd(musb), -1, 0);
> >+		if (retval < 0) {
> >+			DBG(1, "add_hcd failed, %d\n", retval);
> >+			goto err2;
> >  		}
> >+
> >+		hcd->self.uses_pio_for_control = 1;
> >  	}
> >
> >+	return 0;
> >+
> >+err2:
> >+	if (!is_otg_enabled(musb))
> >+		musb_stop(musb);
> 
>    Hm, this wasn't called before -- you don't describe why it's needed.

I can update the commit log, but basically it's the counterpart of
musb_start(). See that we call:

if (!is_otg_enabled(musb))
	musb_start(musb);

so we need to undo that on the error path.

-- 
balbi
