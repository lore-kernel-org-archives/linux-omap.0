From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: MUSB regression in linux next at least for pandboard
Date: Thu, 7 Feb 2013 09:56:27 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1302070954130.1534-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1302061056460.1893-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:47312 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758166Ab3BGO42 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Feb 2013 09:56:28 -0500
In-Reply-To: <Pine.LNX.4.44L0.1302061056460.1893-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Vivek Gautam <gautamvivek1987@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-usb@vger.kernel.org, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

On Wed, 6 Feb 2013, Alan Stern wrote:

> > > Is this issue fixed ?
> > > Actually we too are getting very similar issue with samsung exynos5250 hardware.
> > > With latest 'usb-next' kernel and supporting arch patches, when i use
> > > following test scenerio:
> > > Connect a USB 2.0 external hub to USB 2.0 port, and connect mice or
> > > keyboard enumeration and
> > > functionality is fine but once disconnecting the HID we get to see the
> > > error log:
> > > hid-generic 0003:04B3:3025.0002: can't reset device,
> > > s5p-ehci-1.3/input0, status -71
> > > 
> > > When i tried to enable CONFIG_USB_DEBUG, get the following log:
> > 
> > looks like it's not OMAP-specific. Alan any tips ?
> 
> It could be a problem with the hub the keyboard is plugged into.  Or 
> something going on with the hub driver.  I'll try doing the same thing 
> on my system.

I tried it.  This is on an Intel system, not OMAP or anything like 
that.  The result was as expected; there were a few "can't reset 
device" error messages but they stopped after a few hundred ms.  If 
they persist for several minutes then something else is wrong.

On the other hand, we could change the priority of those log messages.  
They don't have to be errors or warnings.

Alan Stern

