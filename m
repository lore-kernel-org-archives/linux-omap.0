From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] OMAP_LDP: Support LCD display as a FB device on ZOOM
	MDK (Re: LDP support)
Date: Thu, 7 May 2009 17:34:05 +0100
Message-ID: <20090507163405.GB26106@n2100.arm.linux.org.uk>
References: <20090428220712.GF29277@n2100.arm.linux.org.uk> <20090428224237.GT22457@atomide.com> <20090505195231.GB8004@n2100.arm.linux.org.uk> <20090506040015.GM5593@atomide.com> <20090506224917.GS5593@atomide.com> <4A02F7CF.1050803@windriver.com> <20090507161936.GA26106@n2100.arm.linux.org.uk> <20090507162833.GZ5593@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54311 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399AbZEGQeR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 12:34:17 -0400
Content-Disposition: inline
In-Reply-To: <20090507162833.GZ5593@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "stanley.miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

On Thu, May 07, 2009 at 09:28:34AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090507 09:19]:
> > On Thu, May 07, 2009 at 11:01:35PM +0800, stanley.miao wrote:
> > > Hi, Tony,
> > >
> > > Now the kernel can't boot on LDP. The attached file is the boot log.
> > 
> > No boot log found.
> > 
> > My master branch, based upon 2.6.29-rc3 boots fine on the LDP.
> > 
> > Uncompressing Linux.............................................................
> > ............................................ done, booting the kernel.
> > Linux version 2.6.29-rc3 (rmk@dyn-67.arm.linux.org.uk) (gcc version 4.3.2 (GCC)) #125 Mon Feb 2 22:22:54 GMT 2009
> 
> <snip snip>
> 
> > omapfb: configured for panel ldp
> > omapfb: DISPC version 3.0 initialized
> > omapfb: Framebuffer initialized. Total vram 614400 planes 1
> > omapfb: Pixclock 32000 kHz hfreq 60.3 kHz vfreq 93.7 Hz
> 
> Can you see the penguin?

Interestingly, CONFIG_FB is not set, so I'm not sure why we have a
framebuffer driver.

Ah, hmm.  Oh sod it, what kernel am I booting.  Oh, it's an ages
old one.  Fucking $#^"$#^%$^#"^^"%#%^5268903284769065983 UBOOT.
