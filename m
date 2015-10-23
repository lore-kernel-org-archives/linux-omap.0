From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: MUSB peripheral DMA regression caused by driver core runtime PM
 change
Date: Fri, 23 Oct 2015 16:33:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1510231629430.1644-100000@iolanthe.rowland.org>
References: <20151023192044.GX3078@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20151023192044.GX3078@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Felipe Balbi <balbi@ti.com>, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Bin Liu <b-liu@ti.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 23 Oct 2015, Tony Lindgren wrote:

> > Thus the sequence of events should be:
> > 
> > 	Allocate the musb device;
> > 	Runtime-enable the omap2430 (since it is now safe to do so);
> > 	Runtime-enable the musb and declare it irq_safe (this will
> > 		automatically runtime-resume the omap2430);
> > 	Register the musb.
> > 
> > If things are done this way, no special action needs to be taken.
> 
> Yes good point, that requires changing the init for the whole
> drivers/musb though.

This will have to be done anyway, since the way it is now (if I 
understand correctly), the musb is registered and made available to 
userspace before its parent is operational (i.e., at full power).

> Also, we should reorganize the whole musb and make
> the platform glue and musb core drivers completely separate using a
> shared interrupt where needed.
> 
> For the regression for the -rc series? Do you see any better
> alternatives to what I posted?

No.

Alan Stern

