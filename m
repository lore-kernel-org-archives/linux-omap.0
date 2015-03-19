From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC][PATCH 1/9] usb: hcd: Introduce usb_start/stop_hcd()
Date: Wed, 18 Mar 2015 19:38:07 -0700
Message-ID: <20150319023807.GB31346@atomide.com>
References: <20150318214140.GY31346@atomide.com>
 <Pine.LNX.4.44L0.1503182147410.32267-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1503182147410.32267-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> [150318 18:51]:
> On Wed, 18 Mar 2015, Tony Lindgren wrote:
> 
> > > If the host controller is started more than once, you will end up
> > > unregistering and re-registering the root hub.  The device core does
> > > not allow this.  Once a device has been unregistered, you must not try
> > > to register it again -- you have to allocate a new device and register
> > > it instead.
> > > 
> > > Also, although you call the driver's ->start method multiple times, the
> > > ->reset method is called only once, when the controller is first 
> > > probed.  It's not clear that this will work in a situation where the HC 
> > > and the UDC share hardware state; after the UDC is stopped it may be 
> > > necessary to reset the HC before it can run again.
> > > 
> > > It might be possible to make this work, but I suspect quite a few 
> > > drivers would need rewriting first.  As another example of the problems 
> > > you face, consider how stopping a host controller will interact with 
> > > the driver's PM support (both system suspend and runtime suspend).
> > > 
> > > It would be a lot simpler to unbind the host controller driver
> > > completely when switching to device mode and rebind it when switching
> > > back.  I guess that is the sort of heavy-duty approach you want to
> > > avoid, but it may be the only practical way forward.
> > 
> > Hmm from memory I think the OTG spec assumes the USB devices are
> > suspended when attempting the role change? I could be totally wrong,
> > it's been a really long time since I've looked at the OTG spec, but
> > maybe that would make it easier to deal with thing?
> 
> This patch deals with the host side, not the device side.  The fact
> that the device is suspended is not relevant to the issues above.

OK, got it.
 
> Besides, the problems I outlined are more connected with the way 
> Linux's host-side USB stack is organized, and not so much with the 
> details of the OTG spec.

Yes thanks for the explanation.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
