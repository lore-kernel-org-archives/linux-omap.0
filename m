From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Sun, 5 Feb 2012 10:33:16 -0800
Message-ID: <20120205183316.GL1426@atomide.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120204190109.GL20333@atomide.com>
 <20120204203453.GD17309@n2100.arm.linux.org.uk>
 <20120205172528.GA17029@n2100.arm.linux.org.uk>
 <20120205174700.GU20333@atomide.com>
 <20120205180812.GH17309@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:14317 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201Ab2BESdV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Feb 2012 13:33:21 -0500
Content-Disposition: inline
In-Reply-To: <20120205180812.GH17309@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120205 09:37]:
> On Sun, Feb 05, 2012 at 09:47:00AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120205 08:54]:
> > > I'm also getting on the OMAP4430SDP:
> > > 
> > > Error setting wl12xx data
> > > 
> > > What a wonderfully descriptive error message.  Not.  What happened to
> > > saying _why_ we couldn't set the data?  As for this:
> > > 
> > > 	platform_device_register(&omap_vwlan_device);
> > > 
> > > and not checking the return code, I really don't see why anyone bothered
> > > even reporting that wl12xx_set_platform_data() failed... why not just
> > > leave people in the dark over the error...
> > > 
> > > Right, so, this "error" is happening because the WL12xx driver is not
> > > configured, and from what I can see, the WL12xx is something you'd plug
> > > in to the board instead of the SD card.  So it makes no sense to report
> > > an error for a driver for a bit of hardware which is optional.
> > > 
> > > So... my patch gets larger and gets this fixed for all platforms in
> > > mach-omap2.
> > 
> > That sounds like a good clean-up for next merge window.
> 
> So in the meantime, people should put up with the kernel reporting an
> "Error" at error-message level at boot time because they didn't configure
> something?
> 
> No, it needs fixing, because it doesn't justify being an error.  It's
> wrong, plain and simple.  Again, if you don't want to send it during
> -rc, I'll send it to Linus as a patch for him to decide whether he wants
> to take it as -rc material.

Hmm, maybe I misunderstood you.

Certainly fixing the "Error" makes sense for -rc, but are also thinking
about adding error checking to all platform_device_register() calls?

Regards,

Tony
