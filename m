From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Mon, 26 Nov 2012 16:07:38 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211261555400.2168-100000@iolanthe.rowland.org>
References: <20121126192206.GB11239@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44150 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756054Ab2KZVHj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Nov 2012 16:07:39 -0500
In-Reply-To: <20121126192206.GB11239@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andy Green <andy.green@linaro.org>, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, balbi@ti.com, rogerq@ti.com

On Mon, 26 Nov 2012, Greg KH wrote:

> Ah, here's the root of your problem, right?  You need a way for your
> hardware to tell the kernel that you have a regulator attached to a
> specific device?  Using the device path and hard-coding it into the
> kernel is not the proper way to solve this, sorry.  Use some other
> unique way to describe the hardware, surely the hardware designers
> couldn't have been that foolish not to provide this [1]?

As far as I know, the kernel has no other way to describe devices.

What about using partial matches?  In this example, instead of doing a 
wildcard match against

	/platform/usbhs_omap/ehci-omap.0/usb*

(which would fail if the "platform" part of the path changes), suppose 
the string "ehci-omap.0/usb*" could be associated with the usbhs_omap 
component somehow.  Or even better, the string "usb*" could be 
associated with the ehci-omap.0 device.

Then the path-matching code could restrict its attention to that part
of the path and to devices below the specified one.  Naming changes
wouldn't be an issue, because the changes themselves would be made in
the same source file that contains the partial path string.


On the other hand, this may be way more general than we really need.  
For this particular case, all we need to do is take special action the
first time any device is registered below the ehci-omap.0 platform
device.  There ought to be a more direct way to accomplish this,
without using string pattern-matching or sysfs pathnames (and without 
adding overhead every time a device is added or deleted).

I don't know if such an approach would be sufficiently general for 
future requirements, but it would solve the problem at hand.

Alan Stern

