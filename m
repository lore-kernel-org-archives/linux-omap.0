From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 4/5] arm: omap2: support port power on lan95xx devices
Date: Wed, 5 Dec 2012 11:42:49 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1212051129140.1659-100000@iolanthe.rowland.org>
References: <50BEF8A4.5090506@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:51128 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752496Ab2LEQmu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Dec 2012 11:42:50 -0500
In-Reply-To: <50BEF8A4.5090506@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ming Lei <tom.leiming@gmail.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>, linux-omap@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

On Wed, 5 Dec 2012, Andy Green wrote:

> > The details of this aren't clear yet.  For instance, should the device
> > core try to match the port with the asset info, or should this be done
> > by the USB code when the port is created?
> 
> Currently what I have (this is before changing it to pm domain, but this 
> should be unchanged) lets the asset define a callback op which will 
> receive notifications for all added child devices that have the device 
> the asset is bound to as an ancestor.
> 
> So you would bind an asset to the host controller device...
> 
> static struct device_asset assets_ehci_omap0[] = {
> 	{
>                  .name = "-0:1.0/port1",
>                  .asset = assets_ehci_omap0_smsc_port,
>                  .ops = &device_descendant_attach_default_asset_ops,
> 	},
>          { }
> };
> 
> ...with this descendant filter callback pointing to a generic "end of 
> the device path" matcher.
> 
> when device_descendant_attach_default_asset_ops() sees the child that 
> was foretold has appeared (and it only hears about children of 
> ehci-omap.0 in this case), it binds the assets pointed to by .asset to 
> the new child before its probe.  assets_ehci_omap0_smsc_port is an array 
> of the actual regulator and clock that need switching by the child.  So 
> the effect is to magic the right assets to the child device just before 
> it gets added (and probe called etc).
> 
> This is working well and the matcher helper is small and simple.

Right.  The question is should it be done in this somewhat roundabout
way (you've got two separate assets for setting up this one thing), or
should the USB port code be responsible for explicitly checking if
there are any applicable assets when the port is created?

The advantange of the second approach is that it doesn't involve
checking all the ancestors every time a new device is added (and it
involves only one asset).  The disadvantage is that it works only for
USB ports.

To answer the question, we need to know how other subsystems might
want to use the asset-matching approach.  My guess is that only a small
number of device types would care about assets (in the same way that
assets matter to USB ports but not to other USB device types).  And it 
might not be necessary to check against every ancestor; we might know 
beforehand where to check (just as the USB port would know to look for 
an asset attached to the host controller device).

Alan Stern

