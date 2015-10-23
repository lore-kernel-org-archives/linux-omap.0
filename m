From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: MUSB peripheral DMA regression caused by driver core runtime PM
 change
Date: Fri, 23 Oct 2015 14:27:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1510231406200.1644-100000@iolanthe.rowland.org>
References: <562A7549.3070400@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <562A7549.3070400-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 23 Oct 2015, Grygorii Strashko wrote:

> Reviewed-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> 
> It always fun when DD/PM core is updated to fix some driver/subsystem's
> specific PM issue :(
> 
> > 
> >> --- a/drivers/usb/musb/omap2430.c
> >> +++ b/drivers/usb/musb/omap2430.c
> >> @@ -391,9 +391,20 @@ static int omap2430_musb_init(struct musb *musb)
> >>   	}
> >>   	musb->isr = omap2430_musb_interrupt;
> >>   
> >> +	/*
> >> +	 * Enable runtime PM for musb parent (this driver). We can't
> >> +	 * do it earlier as struct musb is not yet allocated and we
> >> +	 * need to touch the musb registers for runtime PM.
> >> +	 */
> >> +	pm_runtime_enable(glue->dev);
> >> +	status = pm_runtime_get_sync(glue->dev);
> >> +	if (status < 0)
> >> +		goto err1;
> >> +
> >>   	status = pm_runtime_get_sync(dev);
> 
> Hm. My assumption was that *Parent* device (omap2430) will be enabled
> here :( But as I can see this will not happen:
> 
> static int rpm_resume(struct device *dev, int rpmflags)
> {...
> 	if (!parent && dev->parent) {
> 		/*
> 		 * Increment the parent's usage counter and resume it if
> 		 * necessary.  Not needed if dev is irq-safe; then the
> 		 * parent is permanently resumed.
> 		 */
> 		parent = dev->parent;
> 		if (dev->power.irq_safe)
> 			goto skip_parent;
> 
> ^^^ and musb device is irq_safe :( 

This way of doing things looks very strange.

If the omap2430 is the parent of the musb device, and
pm_runtime_irq_safe() has been called for the musb device, then after
that the omap2430 will never be runtime suspended.  Therefore it
doesn't matter whether you enable it for runtime PM or not.

It seems to me that the real problem must be that the musb device gets
runtime-enabled and marked irq_safe too early.  These things should 
happen before the musb device gets registered and exposed to userspace, 
but not before the omap2430 parent is runtime-enabled.

Thus the sequence of events should be:

	Allocate the musb device;
	Runtime-enable the omap2430 (since it is now safe to do so);
	Runtime-enable the musb and declare it irq_safe (this will
		automatically runtime-resume the omap2430);
	Register the musb.

If things are done this way, no special action needs to be taken.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
