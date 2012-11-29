From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Thu, 29 Nov 2012 12:05:05 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211291152290.1535-100000@iolanthe.rowland.org>
References: <CACVXFVN6Dh5pwB_Pg2f0_N2iDU4oyCDusFWLMHRJmajnhDOpKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:48867 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751100Ab2K2RFH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Nov 2012 12:05:07 -0500
In-Reply-To: <CACVXFVN6Dh5pwB_Pg2f0_N2iDU4oyCDusFWLMHRJmajnhDOpKQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Roger Quadros <rogerq@ti.com>, Andy Green <andy.green@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, balbi@ti.com

On Thu, 29 Nov 2012, Ming Lei wrote:

> If we want to set up the association between usb port and power domain,
> usb knowledge is required, at least bus info and port topology are needed.
> 
> One difficulty is the fact that the device(such as usb port) is independent
> with the 'power domain', for example, the device isn't created(ports of the
> root hub is created after ehci-omap probe, and port device of non-root
> hub may depend on powering on the power domain) when defining the regulator
> things, so could we figure out one general way in theory to describe the
> associated device with the 'power domain'? Andy has tried the wildcard dev
> path, and port topology string is introduced in my suggestion, looks both
> are not general.

The device path approach probably could be made to work, but it does
have the problem that it depends on device names which may change in
the future.  However, I can't think of any other general-purpose
approach.  And most especially, I can't think of any approach that
doesn't require extra overhead _every_ time a new device is registered.

The port topology string is, of course, specific to USB.

> I admit the suggestion is partial because we still have not a general abstract
> on 'power domain' in this problem, and once it is ready, the solution might be
> in a shape at least for USB. In PC world, ACPI might do sort of something of
> the 'power domain'

I'm not worried about the "power domain" part.  For now, a regulator is 
all we need.  It should be easy enough to expand that later on.

> Maybe we need to create a new thread on this discussion and make more
> guys involved(PM/USB/driver core/OMAP/....). I will study the problem further,
> and hope I can post something for starting the discussion later.
> 
> > It would be better to have a more general approach.  So far nobody has
> 
> Yes, I agree. IMO, my suggestion is still in the direction to being general,
> because a general 'power domain' concept is introduced in it, for example
> the 'struct power_domain' is associated with 'struct port_power_domain'.

It's general, but in the wrong direction.  The hard part isn't the 
power domain aspect; it is setting up the match between the power 
domain and the dynamically created device.

> I understand the same 'power domain' concept should be applied to other
> device or bus too, and the power associated with this device can be switched off
> sometimes too for saving power consumption. But still looks specific
> device/subsystem knowledge is required to set up the association.
> 
> Alan, so could the above be your concern on a more general approach?
> Or you hope a more general way(such as, do it in driver core or dev PM core)
> to associate the 'power domain' with one device(for example, usb port in
> the LAN95xx problem) too? Or other things?

Right now we don't have _any_ general (i.e., not bus-specific) way to 
identify individual devices except for the device name strings.

I don't know -- maybe this shouldn't have a general solution at all.  
Maybe we just need a platform-specific way to associate a regulator or
clock with a USB port, something that the port driver would know about
explicitly.

Alan Stern

