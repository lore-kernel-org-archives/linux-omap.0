From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP_LDP: Support LCD display as a FB device on ZOOM
	MDK (Re: LDP support)
Date: Thu, 7 May 2009 09:41:47 -0700
Message-ID: <20090507164144.GA5593@atomide.com>
References: <20090428220712.GF29277@n2100.arm.linux.org.uk> <20090428224237.GT22457@atomide.com> <20090505195231.GB8004@n2100.arm.linux.org.uk> <20090506040015.GM5593@atomide.com> <20090506224917.GS5593@atomide.com> <4A02F7CF.1050803@windriver.com> <20090507161936.GA26106@n2100.arm.linux.org.uk> <20090507162833.GZ5593@atomide.com> <20090507163405.GB26106@n2100.arm.linux.org.uk> <20090507163703.GA28538@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56936 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbZEGQl7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 12:41:59 -0400
Content-Disposition: inline
In-Reply-To: <20090507163703.GA28538@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "stanley.miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090507 09:37]:
> On Thu, May 07, 2009 at 05:34:05PM +0100, Russell King - ARM Linux wrote:
> > On Thu, May 07, 2009 at 09:28:34AM -0700, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090507 09:19]:
> > > > On Thu, May 07, 2009 at 11:01:35PM +0800, stanley.miao wrote:
> > > > > Hi, Tony,
> > > > >
> > > > > Now the kernel can't boot on LDP. The attached file is the boot log.
> > > > 
> > > > No boot log found.
> > > > 
> > > > My master branch, based upon 2.6.29-rc3 boots fine on the LDP.
> > > > 
> > > > Uncompressing Linux.............................................................
> > > > ............................................ done, booting the kernel.
> > > > Linux version 2.6.29-rc3 (rmk@dyn-67.arm.linux.org.uk) (gcc version 4.3.2 (GCC)) #125 Mon Feb 2 22:22:54 GMT 2009
> > > 
> > > <snip snip>
> > > 
> > > > omapfb: configured for panel ldp
> > > > omapfb: DISPC version 3.0 initialized
> > > > omapfb: Framebuffer initialized. Total vram 614400 planes 1
> > > > omapfb: Pixclock 32000 kHz hfreq 60.3 kHz vfreq 93.7 Hz
> > > 
> > > Can you see the penguin?
> > 
> > Interestingly, CONFIG_FB is not set, so I'm not sure why we have a
> > framebuffer driver.
> > 
> > Ah, hmm.  Oh sod it, what kernel am I booting.  Oh, it's an ages
> > old one.  Fucking $#^"$#^%$^#"^^"%#%^5268903284769065983 UBOOT.
> 
> Sod it, I'm not going to bother with this crap with its stupidly long
> build times because of bloated gcc4 requirements this side of my holiday.
> I've better things to be doing like washing the car.
> 
> So you're on your own with LDP support for the next 9 days.  So this
> email marks the end of my pre-holiday Linux involvement.

Happy holidays :) We'll get the LDP patches ready by the time you're back.

Tony
