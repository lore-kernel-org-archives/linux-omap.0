From: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [RFC][PATCH 1/9] usb: hcd: Introduce usb_start/stop_hcd()
Date: Fri, 20 Mar 2015 14:32:50 +0800
Message-ID: <20150320063249.GE7537@shlinux2>
References: <Pine.LNX.4.44L0.1503181538170.1497-100000@iolanthe.rowland.org>
 <550AB538.7090806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <550AB538.7090806-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 19, 2015 at 01:38:32PM +0200, Roger Quadros wrote:
> On 18/03/15 21:49, Alan Stern wrote:
> > On Wed, 18 Mar 2015, Roger Quadros wrote:
> > 
> >> To support OTG we want a mechanism to start and stop
> >> the HCD from the OTG state machine. Add usb_start_hcd()
> >> and usb_stop_hcd().
> >>
> >> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> > 
> > There are a few problems in this proposed patch.
> > 
> >> +int usb_start_hcd(struct usb_hcd *hcd)
> >> +{
> >> +	int retval;
> >> +	struct usb_device *rhdev = hcd->self.root_hub;
> >> +
> >> +	if (hcd->state != HC_STATE_HALT) {
> >> +		dev_err(hcd->self.controller, "not starting a running HCD\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	hcd->state = HC_STATE_RUNNING;
> >> +	retval = hcd->driver->start(hcd);
> >> +	if (retval < 0) {
> >> +		dev_err(hcd->self.controller, "startup error %d\n", retval);
> >> +		hcd->state = HC_STATE_HALT;
> >> +		return retval;
> >> +	}
> >> +
> >> +	/* starting here, usbcore will pay attention to this root hub */
> >> +	if ((retval = register_root_hub(hcd)) != 0)
> >> +		goto err_register_root_hub;
> > 
> > If the host controller is started more than once, you will end up
> > unregistering and re-registering the root hub.  The device core does
> > not allow this.  Once a device has been unregistered, you must not try
> > to register it again -- you have to allocate a new device and register
> > it instead.
> 
> Understood.
> 
> > 
> > Also, although you call the driver's ->start method multiple times, the
> > ->reset method is called only once, when the controller is first 
> > probed.  It's not clear that this will work in a situation where the HC 
> > and the UDC share hardware state; after the UDC is stopped it may be 
> > necessary to reset the HC before it can run again.
> 
> Yes, good point.
> > 
> > It might be possible to make this work, but I suspect quite a few 
> > drivers would need rewriting first.  As another example of the problems 
> > you face, consider how stopping a host controller will interact with 
> > the driver's PM support (both system suspend and runtime suspend).
> 
> Right. This needs more work than I thought.
> > 
> > It would be a lot simpler to unbind the host controller driver
> > completely when switching to device mode and rebind it when switching
> > back.  I guess that is the sort of heavy-duty approach you want to
> > avoid, but it may be the only practical way forward.
> 
> So you mean directly calling usb_add/remove_hcd() from the OTG core?
> I don't see any issues with that other than it being a heavy-duty operation
> like you said and hope that it doesn't violate the OTG spec timing.
> 
> Looking at Figure 5-3: "HNP Sequence of Events (FS)" of the OTG 2.0 spec
> we have about 150ms (X10) to switch from B-Device detected A connect (b_wait_acon state)
> to driving bus reset (b_host state). I don't think this should be an issue in modern SoCs
> but I'm not very sure.
> 

It is not related toadd/remove hcd, it is the time from receiving PCD
to issue BUS_RESET, the Linux stack can't satisfy OTG spec (150ms) due
to there are some de-bounce waitings.

> In any case I can migrate to the add/remove hcd approach to simplify things.
> 

It should be no problem, we use it more than 1 years.

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
