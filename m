From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH v2 06/13] usb: hcd: Add hcd add/remove functions
 for OTG use
Date: Mon, 20 Apr 2015 09:56:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1504200948280.1321-100000@iolanthe.rowland.org>
References: <5534A414.4070401@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5534A414.4070401@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Peter Chen <peter.chen@freescale.com>, gregkh@linuxfoundation.org, balbi@ti.com, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 20 Apr 2015, Roger Quadros wrote:

> > I don't understand this.  Why do you want to defer the add/remove if 
> > the device is OTG?  Don't host controller drivers expect these things 
> > to execute synchronously?
> 
> Sorry for the wrong information. We actually defer only the add as the
> OTG state machine might not yet be in Host ready mode.
> The remove is always synchronous and we ensure that the HCD is removed
> when usb_otg_unregister_hcd() returns.

That's okay then, but it does leave one potential hole.  What happens 
if usb_add_hcd() is deferred for so long that usb_remove_hcd() gets 
called before the add can complete?

Alan Stern
