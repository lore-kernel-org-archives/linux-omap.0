From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Sun, 5 Feb 2012 09:47:00 -0800
Message-ID: <20120205174700.GU20333@atomide.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120204190109.GL20333@atomide.com>
 <20120204203453.GD17309@n2100.arm.linux.org.uk>
 <20120205172528.GA17029@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33818 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631Ab2BERrE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Feb 2012 12:47:04 -0500
Content-Disposition: inline
In-Reply-To: <20120205172528.GA17029@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120205 08:54]:
> I'm also getting on the OMAP4430SDP:
> 
> Error setting wl12xx data
> 
> What a wonderfully descriptive error message.  Not.  What happened to
> saying _why_ we couldn't set the data?  As for this:
> 
> 	platform_device_register(&omap_vwlan_device);
> 
> and not checking the return code, I really don't see why anyone bothered
> even reporting that wl12xx_set_platform_data() failed... why not just
> leave people in the dark over the error...
> 
> Right, so, this "error" is happening because the WL12xx driver is not
> configured, and from what I can see, the WL12xx is something you'd plug
> in to the board instead of the SD card.  So it makes no sense to report
> an error for a driver for a bit of hardware which is optional.
> 
> So... my patch gets larger and gets this fixed for all platforms in
> mach-omap2.

That sounds like a good clean-up for next merge window.
 
> PRCM: failed to allocate irq descs: -12
> 
> Does OMAP require sparse IRQ, or is NR_IRQS not set sufficiently high for
> OMAP?  I can't work this one out, and it looks like things are missing for
> this to even work (did something in plat/irqs.h get missed?)

Tero, can you please investigate this?

Regards,

Tony
