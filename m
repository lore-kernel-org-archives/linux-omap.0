From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Wed, 28 Nov 2012 11:43:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211281134240.2192-100000@iolanthe.rowland.org>
References: <50B5F1DB.8090502@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35512 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753964Ab2K1Qna (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Nov 2012 11:43:30 -0500
In-Reply-To: <50B5F1DB.8090502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Andy Green <andy.green@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, balbi@ti.com

On Wed, 28 Nov 2012, Roger Quadros wrote:

> > board file:
> > 
> >     static struct regulator myreg = {
> >         .name = "mydevice-regulator",
> >     };
> > 
> >     static struct device_asset mydevice_assets[] = {
> >         {
> >             .name = "mydevice-regulator",
> >             .handler = regulator_default_asset_handler,
> >         },
> >         { }
> >     };
> > 
> >     static struct platform_device mydevice = {
> >     ...
> >         .dev = {
> >             .assets = mydevice_assets,
> >         },
> >     ...
> >     };
> > 
> 
> From Pandaboard's point of view, is mydevice supposed to be referring to
> ehci-omap, LAN95xx or something else?

ehci-omap.0.

> Strictly speaking, the regulator doesn't belongs neither to ehci-omap
> nor LAN95xx. It belongs to a power domain on the board. And user should
> have control to switch it OFF when required without hampering operation
> of ehci-omap, so that the other USB ports are still usable.

That is the one disadvantage of the approach we are discussing.

But what API would you use to give the user this control?  Neither the
GPIO nor the regulator has a struct device, so you can't use sysfs
directly.  And even if you could, it would probably be a bad idea
because the user might turn off power to the LAN95xx while the chip was
being used.

The natural answer is to associate the regulator with the USB port that 
the LAN95xx is connected to, so that the new port-power mechanism could 
provide the control you want.  Then how should that association be set 
up?

Lei Ming provided a partial answer, but his suggestion is tied to USB.  
It would be better to have a more general approach.  So far nobody has 
come up with a suggestion that everybody approves of.

Alan Stern

