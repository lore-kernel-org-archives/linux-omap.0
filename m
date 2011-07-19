From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/4] dt: omap3: add generic board file for dt support
Date: Tue, 19 Jul 2011 15:34:58 -0600
Message-ID: <20110719213458.GO6848@ponder.secretlab.ca>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
 <1310592975-25773-4-git-send-email-manjugk@ti.com>
 <CACxGe6sELS=C==16TZ2pfrxJDDyqjS_qOwJUfwzwMO8hqo8Xag@mail.gmail.com>
 <CAC63_iSqN=rX6MbzFWM6z+zf1Eybg3MOD=qQVdeNg5cyENhPjw@mail.gmail.com>
 <CAC63_iTf696D6Q_EzFeUUp5R38pYNEJBkmKviEu6-yuF0y=bNA@mail.gmail.com>
 <CACxGe6uzyxf35WDg6COnPVt3dhQv1H80L1svALxp4naySx2BcA@mail.gmail.com>
 <20110718090710.GZ5783@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34020 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab1GSVfC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jul 2011 17:35:02 -0400
Received: by pzk3 with SMTP id 3so5470964pzk.5
        for <linux-omap@vger.kernel.org>; Tue, 19 Jul 2011 14:35:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110718090710.GZ5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, Kevin Hilman <khilman@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

On Mon, Jul 18, 2011 at 02:07:10AM -0700, Tony Lindgren wrote:
> * Grant Likely <grant.likely@secretlab.ca> [110716 22:08]:
> > 
> > The way I see it, you've got two options:
> > 
> > 1) modify the of_platform_bus_create() to call some kind of
> > of_platform_bus_create_omap() for devices that match "ti,omap3-device"
> > or something.
> > 
> > 2) Leave of_platform_bus_create(), and instead us a notifier to attach
> > hwmod data to normal platform devices.  omap_device_build() is
> > actually pretty simple.  It allocated a device, it attaches
> > platform_data and hwmod pointers to the device and registers it.
> > omap_device_register() is just a wrapper around
> > platform_device_register().
> > 
> > My preference is definitely #2, but there is a wrinkle in this
> > approach.  Unfortunately omap_devices are not simply plain
> > platform_devices with extra data attached, an omap_device actually
> > embeds the platform_device inside it, which cannot be attached after
> > the fact.  I think I had talked with Kevin (cc'd) about eliminating
> > the embedding, but I cannot remember clearly on this point.  As long
> > as platform_device remains embedded inside struct omap_device, #2
> > won't work.
> > 
> > In either case, looking up the correct hwmod data should be easy for
> > any device provided the omap code maintains a lookup table of
> > compatible strings and base addresses of devices (much like auxdata).
> > In fact, I'd be okay with extending auxdata to include OMAP fields if
> > that would be easiest since the whole point of auxdata is to ease the
> > transition to DT support.  When a matching device is created, the
> > hwmod pointer can easily be attached.  This should work transparently
> > for all omap devices, not just the i2c bus.
> 
> Well we should be able to automgagically build the omap_device for
> each device tree entry.
> 
> And then the device driver probe and runtime PM should be able to take
> care of the rest for the driver. And then there's no more driver
> specific platform init code needed ;)

Right!  That's the solution I'd like to see.

> How about if we just have the hwmod code call omap_device_build for
> each device tree entry?

I think that is pretty much equivalent to suggestion #1 above, only
I'm suggesting to take advantage of the infrastructure already
available in driver/of/platform.c in the form of
of_platform_populate().  The "of_platform_bus_create_omap()" function
suggested above I assumed would directly call omap_device_build().

There are already hooks in the _populate call path to handle the
creation of amba_devices.  I have no problem doing the same thing for
omap devices.

g.
