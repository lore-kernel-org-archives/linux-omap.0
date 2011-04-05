From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arm: omap: introduce OMAP MCOP board file
Date: Tue, 5 Apr 2011 10:51:19 +0100
Message-ID: <20110405095119.GD4699@n2100.arm.linux.org.uk>
References: <1301995970-23699-1-git-send-email-balbi@ti.com> <20110405093656.GS2176@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45115 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920Ab1DEJva (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 05:51:30 -0400
Content-Disposition: inline
In-Reply-To: <20110405093656.GS2176@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Michael Fillinger <m-fillinger@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Tue, Apr 05, 2011 at 12:36:57PM +0300, Felipe Balbi wrote:
> On Tue, Apr 05, 2011 at 12:32:50PM +0300, Felipe Balbi wrote:
> > From: Michael Fillinger <m-fillinger@ti.com>
> > 
> > MCOP is an FPGA-based Silicon Validation platform
> > which is used to test particular IPs inside OMAP
> > before we have a real ASIC.
> > 
> > Signed-off-by: Michael Fillinger <m-fillinger@ti.com>
> > 
> > [ balbi@ti.com : few cleanups here an there and also
> > 	removal of some unnecessary code. ]
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> 
> I should have RFCed this one, but bear with me for a minute.
> 
> This is just the bare minimum board-file for MCOP, there's still a bunch
> of changes needed to get it actually booting. The attached diff shows
> many of them.
> 
> Now, we don't want to send that patch upstream for obvious reasons and
> we also don't want to add ifdefs to clock data files as that would break
> multi-omap. What do you guys suggest ? How should we handle detection of
> MCOP so that we choose correct HWMODs and clock data files for it ?
> 
> I don't think Linus will like if we add yet another hwmod + clk data
> file just for MCOP, so we need to re-use what's in tree.

I'd suggest holding fire on new stuff.

We *absolutely* *must* show that we're taking Linus' complaint seriously
and make headway towards consolidating some of the code.  I don't see that
activity as optional.

I've now made the decision (as I mentioned I may do in the thread) that
for the next merge window I'm only taking consolidations and bug fixes
through my tree, and I encourage everyone else to do the same.  At the
moment, I'm planning for this up until the next merge window, but if
sufficient progress hasn't been done, I'll extend it thereafter.

In other words, no new platform code and no new platform class code.

The longer it takes to get the consolidation effort producing results, the
longer we will have to keep the restriction in place, and the more painful
it'll be for people who want to have their platforms merged.

So I hope *no* one is thinking "this isn't my problem, someone else will
solve it" - if you're thinking that then we're doomed.
