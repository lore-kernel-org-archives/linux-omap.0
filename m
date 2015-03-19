From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 1/9] usb: hcd: Introduce usb_start/stop_hcd()
Date: Wed, 18 Mar 2015 21:51:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1503182147410.32267-100000@netrider.rowland.org>
References: <20150318214140.GY31346@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150318214140.GY31346@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Roger Quadros <rogerq@ti.com>, gregkh@linuxfoundation.org, balbi@ti.com, dan.j.williams@intel.com, peter.chen@freescale.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 18 Mar 2015, Tony Lindgren wrote:

> > If the host controller is started more than once, you will end up
> > unregistering and re-registering the root hub.  The device core does
> > not allow this.  Once a device has been unregistered, you must not try
> > to register it again -- you have to allocate a new device and register
> > it instead.
> > 
> > Also, although you call the driver's ->start method multiple times, the
> > ->reset method is called only once, when the controller is first 
> > probed.  It's not clear that this will work in a situation where the HC 
> > and the UDC share hardware state; after the UDC is stopped it may be 
> > necessary to reset the HC before it can run again.
> > 
> > It might be possible to make this work, but I suspect quite a few 
> > drivers would need rewriting first.  As another example of the problems 
> > you face, consider how stopping a host controller will interact with 
> > the driver's PM support (both system suspend and runtime suspend).
> > 
> > It would be a lot simpler to unbind the host controller driver
> > completely when switching to device mode and rebind it when switching
> > back.  I guess that is the sort of heavy-duty approach you want to
> > avoid, but it may be the only practical way forward.
> 
> Hmm from memory I think the OTG spec assumes the USB devices are
> suspended when attempting the role change? I could be totally wrong,
> it's been a really long time since I've looked at the OTG spec, but
> maybe that would make it easier to deal with thing?

This patch deals with the host side, not the device side.  The fact
that the device is suspended is not relevant to the issues above.

Besides, the problems I outlined are more connected with the way 
Linux's host-side USB stack is organized, and not so much with the 
details of the OTG spec.

Alan Stern
