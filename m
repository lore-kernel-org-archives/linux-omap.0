From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Mon, 26 Nov 2012 14:12:14 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211261348310.2168-100000@iolanthe.rowland.org>
References: <20121126124534.18106.44137.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44064 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753713Ab2KZTMP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Nov 2012 14:12:15 -0500
In-Reply-To: <20121126124534.18106.44137.stgit@build.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: linux-omap@vger.kernel.org, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, balbi@ti.com, rogerq@ti.com

On Mon, 26 Nov 2012, Andy Green wrote:

> This adds a small optional API into drivers/base which deals with generating,
> matching and registration of wildcard device paths.
> 
> >From a struct device * you can generate a string like
> 
>  /platform/usbhs_omap/ehci-omap.0/usb1/1-1
> 
> which enapsulates the path of the device's connection to the board.
> 
> These can be used to match up other assets, for example struct regulators,
> that have been registed elsewhere with a device instance that is probed
> asynchronously from the other board assets.
> 
> If your device is on a bus, as it probably is, the device path will feature
> redundant bus indexes that do not contain information about the connectivity.
> 
> For example if more than one driver can generate devices on the same bus,
> then the ordering of device probing will change the path, despite the
> connectivity remains the same.
> 
> For that reason, to get a deterministic path for matching, wildcards are
> allowed.  If your target device has the path
> 
>  /platform/usbhs_omap/ehci-omap.0/usb1/1-1
> 
> generated, in the asset you wish to match with it you can instead use
> 
> /platform/usbhs_omap/ehci-omap.0/usb*/*-1
> 
> in order to only leave the useful, invariant parts of the path to match
> against.

Have you considered limiting these wildcards in various useful ways?  
In this example, the wildcard must match a string of decimal digits.  
(Furthermore the two wildcard strings will always match each other, 
although it's probably not necessary to add this sort of constraint.)

I don't know what sort of matches people will want in the future.  
Perhaps one for hex digits, or one for arbitrary text with the
exception of a few characters (such as '/' but perhaps others too).

To do what you want for now, the match should be restricted to digits.

> To avoid having to adapt every kind of "search by string" api to also use
> the wildcards, the api takes the approach you can register your wildcard,
> and if a matching path is generated for a device, the wildcard itself is
> handed back as the device path instead.
> 
> So if your board code or a (not yet done) DT binding registers this wildcard
> 
>  /platform/usbhs_omap/ehci-omap.0/usb*
> 
> and the usb hub driver asks to generate its device path
> 
> 	device_path_generate(dev, name, sizeof name);
> 
> that is actually
> 
>  /platform/usbhs_omap/ehci-omap.0/usb1
> 
> then what will be returned is
> 
>  /platform/usbhs_omap/ehci-omap.0/usb*
> 
> providing the same literal string for ehci-omap.0 hub no matter how many\
> usb buses have been registered before.
> 
> This wildcard string can then be matched to regulators or other string-
> searchable assets intended for the device on that hardware path.

That's not how I would do it, at least, not for this application.  I
would register tuples containing a name, a pointer, and two callback
routines.  For example,

	("/platform/usbhs_omap/ehci-omap.0/usb*", &omap_vhub_device,
		turn_on_regulator, turn_off_regulator)

The when a device is registered whose path matches the string in such a
tuple, the device core would know to invoke the first callback.  The
arguments would be a pointer to the device being registered and the
pointer in the tuple.  Similarly, the device core would invoke the
second callback when the device is unregistered.

There doesn't have to be anything in this scheme that's specific to 
hubs or even to USB.  In particular, no changes to the hub driver would 
be needed.

Alan Stern

