From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC][PATCH 1/9] usb: hcd: Introduce usb_start/stop_hcd()
Date: Wed, 18 Mar 2015 14:41:41 -0700
Message-ID: <20150318214140.GY31346@atomide.com>
References: <1426686963-11613-2-git-send-email-rogerq@ti.com>
 <Pine.LNX.4.44L0.1503181538170.1497-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1503181538170.1497-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> [150318 12:50]:
> On Wed, 18 Mar 2015, Roger Quadros wrote:
> 
> > To support OTG we want a mechanism to start and stop
> > the HCD from the OTG state machine. Add usb_start_hcd()
> > and usb_stop_hcd().
> > 
> > Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> 
> There are a few problems in this proposed patch.
> 
> > +int usb_start_hcd(struct usb_hcd *hcd)
> > +{
> > +	int retval;
> > +	struct usb_device *rhdev = hcd->self.root_hub;
> > +
> > +	if (hcd->state != HC_STATE_HALT) {
> > +		dev_err(hcd->self.controller, "not starting a running HCD\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	hcd->state = HC_STATE_RUNNING;
> > +	retval = hcd->driver->start(hcd);
> > +	if (retval < 0) {
> > +		dev_err(hcd->self.controller, "startup error %d\n", retval);
> > +		hcd->state = HC_STATE_HALT;
> > +		return retval;
> > +	}
> > +
> > +	/* starting here, usbcore will pay attention to this root hub */
> > +	if ((retval = register_root_hub(hcd)) != 0)
> > +		goto err_register_root_hub;
> 
> If the host controller is started more than once, you will end up
> unregistering and re-registering the root hub.  The device core does
> not allow this.  Once a device has been unregistered, you must not try
> to register it again -- you have to allocate a new device and register
> it instead.
> 
> Also, although you call the driver's ->start method multiple times, the
> ->reset method is called only once, when the controller is first 
> probed.  It's not clear that this will work in a situation where the HC 
> and the UDC share hardware state; after the UDC is stopped it may be 
> necessary to reset the HC before it can run again.
> 
> It might be possible to make this work, but I suspect quite a few 
> drivers would need rewriting first.  As another example of the problems 
> you face, consider how stopping a host controller will interact with 
> the driver's PM support (both system suspend and runtime suspend).
> 
> It would be a lot simpler to unbind the host controller driver
> completely when switching to device mode and rebind it when switching
> back.  I guess that is the sort of heavy-duty approach you want to
> avoid, but it may be the only practical way forward.

Hmm from memory I think the OTG spec assumes the USB devices are
suspended when attempting the role change? I could be totally wrong,
it's been a really long time since I've looked at the OTG spec, but
maybe that would make it easier to deal with thing?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
