From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Sun, 5 Feb 2012 18:08:12 +0000
Message-ID: <20120205180812.GH17309@n2100.arm.linux.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205172528.GA17029@n2100.arm.linux.org.uk> <20120205174700.GU20333@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51065 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab2BESIZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Feb 2012 13:08:25 -0500
Content-Disposition: inline
In-Reply-To: <20120205174700.GU20333@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Sun, Feb 05, 2012 at 09:47:00AM -0800, Tony Lindgren wrote:
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

So in the meantime, people should put up with the kernel reporting an
"Error" at error-message level at boot time because they didn't configure
something?

No, it needs fixing, because it doesn't justify being an error.  It's
wrong, plain and simple.  Again, if you don't want to send it during
-rc, I'll send it to Linus as a patch for him to decide whether he wants
to take it as -rc material.
