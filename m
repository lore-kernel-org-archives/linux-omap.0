From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: MUSB regression in linux next at least for pandboard
Date: Wed, 6 Feb 2013 10:43:11 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1302061038310.1893-100000@iolanthe.rowland.org>
References: <20130206152909.GE6773@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:41193 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754896Ab3BFPnM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Feb 2013 10:43:12 -0500
In-Reply-To: <20130206152909.GE6773@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, Vivek Gautam <gautamvivek1987@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-usb@vger.kernel.org, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, linux-omap@vger.kernel.org

On Wed, 6 Feb 2013, Felipe Balbi wrote:

> > I can't reproduce the problem on Panda, but I can on Beagle with a slightly
> > different behaviour.
> > 
> > 1) connecting/disconnecting device directly to the beagleboard's USB port works fine.
> > 
> > 2) If I connect a USB Hub to the port and connect a device to it after the hub has
> > autosuspended, the device is never detected.
> > doing lsusb after that triggers the detection and produces a lot of transaction errors.
> > Beagle log is below, before and after 'lsusb'
> > 
> > I suppose this doesn't affect Panda because it has a hub connected immediately below the
> > root hub that never suspends (as ethernet is hardwired to it).
> 
> Roger, try changing hub's autosuspend delay to something greater than
> 30ms and see if it helps. There was a discussion lately about that.

There also were some patches to address this problem recently merged by
Greg KH (they are in Linus's current git, added after 3.8-rc6 was 
released):

da0aa7169b97d90f4af39a9dc84d58bbe19d7e78 USB: add usb_hcd_{start,end}_port_resume
f292e7f9fb0e4bec68bbd83443407d6bb7922d36 USB: EHCI: notify usbcore about port resumes
ee74290b7853db9d5fd64db70e5c175241c59fba USB: EHCI: fix timer bug affecting port resume

Alan Stern

