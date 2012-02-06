From: Tero Kristo <t-kristo@ti.com>
Subject: Re: OMAP34xx
Date: Mon, 6 Feb 2012 11:05:10 +0200
Message-ID: <1328519110.4102.202.camel@sokoban>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
	 <20120204190109.GL20333@atomide.com>
	 <20120204203453.GD17309@n2100.arm.linux.org.uk>
	 <20120205172528.GA17029@n2100.arm.linux.org.uk>
	 <20120205174700.GU20333@atomide.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59227 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368Ab2BFJFX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Feb 2012 04:05:23 -0500
In-Reply-To: <20120205174700.GU20333@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Sun, 2012-02-05 at 09:47 -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120205 08:54]:
> > I'm also getting on the OMAP4430SDP:
> > 
> > Error setting wl12xx data
> > 
> > What a wonderfully descriptive error message.  Not.  What happened to
> > saying _why_ we couldn't set the data?  As for this:
> > 
> > 	platform_device_register(&omap_vwlan_device);
> > 
> > and not checking the return code, I really don't see why anyone bothered
> > even reporting that wl12xx_set_platform_data() failed... why not just
> > leave people in the dark over the error...
> > 
> > Right, so, this "error" is happening because the WL12xx driver is not
> > configured, and from what I can see, the WL12xx is something you'd plug
> > in to the board instead of the SD card.  So it makes no sense to report
> > an error for a driver for a bit of hardware which is optional.
> > 
> > So... my patch gets larger and gets this fixed for all platforms in
> > mach-omap2.
> 
> That sounds like a good clean-up for next merge window.
>  
> > PRCM: failed to allocate irq descs: -12
> > 
> > Does OMAP require sparse IRQ, or is NR_IRQS not set sufficiently high for
> > OMAP?  I can't work this one out, and it looks like things are missing for
> > this to even work (did something in plat/irqs.h get missed?)
> 
> Tero, can you please investigate this?

Sparse IRQ would be good, PRCM attempts to allocate either 32 or 64
descs based on PRM module revision (omap3 uses 32, omap4+ uses 64.)

Personally I have only seen this error on omap4, but omap4 support is
not fully integrated in mainline yet.

-Tero


