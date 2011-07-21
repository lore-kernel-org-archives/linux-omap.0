From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/4] dt: omap3: add generic board file for dt support
Date: Thu, 21 Jul 2011 16:53:04 -0700
Message-ID: <87r55j5gyn.fsf@ti.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
	<1310592975-25773-4-git-send-email-manjugk@ti.com>
	<CACxGe6sELS=C==16TZ2pfrxJDDyqjS_qOwJUfwzwMO8hqo8Xag@mail.gmail.com>
	<CAC63_iSqN=rX6MbzFWM6z+zf1Eybg3MOD=qQVdeNg5cyENhPjw@mail.gmail.com>
	<CAC63_iTf696D6Q_EzFeUUp5R38pYNEJBkmKviEu6-yuF0y=bNA@mail.gmail.com>
	<CACxGe6uzyxf35WDg6COnPVt3dhQv1H80L1svALxp4naySx2BcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:36335 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752765Ab1GUXxH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 19:53:07 -0400
Received: by mail-iy0-f179.google.com with SMTP id 35so1327193iyn.10
        for <linux-omap@vger.kernel.org>; Thu, 21 Jul 2011 16:53:07 -0700 (PDT)
In-Reply-To: <CACxGe6uzyxf35WDg6COnPVt3dhQv1H80L1svALxp4naySx2BcA@mail.gmail.com>
	(Grant Likely's message of "Sat, 16 Jul 2011 23:13:17 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

Grant Likely <grant.likely@secretlab.ca> writes:

[...]

> The way I see it, you've got two options:
>
> 1) modify the of_platform_bus_create() to call some kind of
> of_platform_bus_create_omap() for devices that match "ti,omap3-device"
> or something.
>
> 2) Leave of_platform_bus_create(), and instead us a notifier to attach
> hwmod data to normal platform devices.  omap_device_build() is
> actually pretty simple.  It allocated a device, it attaches
> platform_data and hwmod pointers to the device and registers it.
> omap_device_register() is just a wrapper around
> platform_device_register().
>
> My preference is definitely #2, but there is a wrinkle in this
> approach.  Unfortunately omap_devices are not simply plain
> platform_devices with extra data attached, an omap_device actually
> embeds the platform_device inside it, which cannot be attached after
> the fact.  I think I had talked with Kevin (cc'd) about eliminating
> the embedding, but I cannot remember clearly on this point.  As long
> as platform_device remains embedded inside struct omap_device, #2
> won't work.

I agree with #2, and I think we need to go down this de-coupling route
also.

I just sent an RFC series that starts down this path to at least
demonstrate that it's possible.

Kevin

