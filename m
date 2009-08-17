From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/13] OMAP2/3 clock: ensure each clock has a unique
	name
Date: Mon, 17 Aug 2009 13:24:37 +0300
Message-ID: <20090817102436.GP7278@atomide.com>
References: <20090815111704.7384.31564.stgit@localhost.localdomain> <20090815111944.7384.13541.stgit@localhost.localdomain> <20090817084704.GN7278@atomide.com> <alpine.DEB.2.00.0908170259250.18309@utopia.booyaka.com> <20090817092904.GA2752@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0908170339380.7023@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55396 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757527AbZHQKYo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 06:24:44 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0908170339380.7023@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-arm@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [090817 13:06]:
> Hello Russell,
> 
> On Mon, 17 Aug 2009, Russell King - ARM Linux wrote:
> 
> > On Mon, Aug 17, 2009 at 03:14:45AM -0600, Paul Walmsley wrote:
> > > What it does remove is the need for internal core code to fake up a struct 
> > > device simply to access a clock.  It also allows us to harmonize the 
> > > clock names, used internally in core code, with the hardware reality, 
> > > which uses unique names to identify clocks.
> > 
> > That problem is already solved.  clk_get_sys()
> 
> That solves the first problem, but not the second.  Is there some reason 
> that OMAP core code (aside from the clkdev mapping structures in 
> mach-omap2/clock*.c) should know, or care, whether a platform device name 
> is bound to that clock?
> 
> On OMAP, we have uniquely-named clock lines in the technical 
> documentation.  It is possible that other platforms don't have this.  But 
> for us, I'd submit that it makes more sense for internal core code to 
> fetch a clock documented as "MMC1_FCLK" with:
> 
>     c = omap_clk_get_by_name("mmc1_fck");
> 
> rather than: 
> 
>     c = clk_get_sys("mmci-omap-hs.0", "ick");
> 
> (* ideally, of course, we'd use "mmc1_fclk" rather than "mmc1_fck", this 
> is a legacy issue that has been left for a future patch.)
> 
> As a side benefit, it also makes our clock debugfs setup easier, so a 
> clock can be identified in the path as simply 
> /debugfs/clock/.../mmc1_fck/, rather than something like 
> /debugfs/clock/.../mmci-omap-hs.0-mmc1_fck/ or 
> /debugfs/clock/.../mmci-omap-hs.0/mmc1_fck.
> 
> Thoughts?

I guess if we wanted to do this in a generic way, we could have
clkdev_get_hw_name() in arch/arm/common/clkdev.c. Then we could
have struct omap_clk contain the hardware clock name.

But then we're wasting memory and duplicating parts of the names,
so I don't think that it would be any better solution compared to
renaming the clocks like you're doing.

Tony
