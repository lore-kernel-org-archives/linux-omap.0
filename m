From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Sat, 24 Nov 2012 10:38:23 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211241032490.4291-100000@netrider.rowland.org>
References: <50AFDE74.6030805@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:38077 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751038Ab2KXPiY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Nov 2012 10:38:24 -0500
In-Reply-To: <50AFDE74.6030805@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>, Roger Quadros <rogerq@ti.com>, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Sat, 24 Nov 2012, Andy Green wrote:

> If we're just looking at fixing the current "magic regulator name" 
> scheme of "hsusb0" so that it can work with abstract devices like any 
> hub / port, we could invert what my original "device path" scheme did.
> 
> So instead of having a parser (which boiled down quite small, but is 
> complicated by usb%d being the same for different usb drivers), we could 
> just add a helper function that walks the device parents to generate a 
> string representing the device instance.  Like
> 
> int device_path_generate(struct device *device, char *name, int len);
> 
> if you called it from the hub driver's probe function (or anything 
> else's probe function) with the new hub device pointer, it might fill 
> name with "ehci1/usbhub1-1/1-1.1" or somesuch.

It's not that simple.  In your example, the very same device might show 
up, after rebooting, as "ehci2/usbhub2-1/2-1.1".  Even if a more or 
less stable name for the controller is used, the bus-number parts of 
the name (the '2's in this example) are always subject to change.  The 
device_path_generate routine would have to possess special knowledge 
about the USB subsystem's naming scheme to generate a truly stable 
name.

Presumably the same would hold for other subsystems too.

Alan Stern

