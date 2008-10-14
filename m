From: Tony Lindgren <tony@atomide.com>
Subject: Re: git pull request for minimal omap3 support one more time
Date: Tue, 14 Oct 2008 13:35:32 -0700
Message-ID: <20081014203530.GI8150@atomide.com>
References: <20081004070534.GB30190@muru.com> <20081009145436.GI435@flint.arm.linux.org.uk> <20081009151724.GK26230@atomide.com> <20081010073251.GN435@flint.arm.linux.org.uk> <20081010091557.GI3044@atomide.com> <20081010092520.GK3044@atomide.com> <20081010113533.GU3044@atomide.com> <20081013133256.GA3510@flint.arm.linux.org.uk> <20081014171907.GD8150@atomide.com> <20081014185100.GA20627@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55604 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbYJNUfr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 16:35:47 -0400
Content-Disposition: inline
In-Reply-To: <20081014185100.GA20627@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: twebb <taliaferro62@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [081014 12:39]:
> On Tue, Oct 14, 2008 at 10:19:08AM -0700, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [081013 09:15]:
> > > There's something wrong with one of the sets I've pulled from you:
> > > 
> > > arch/arm/mach-omap2/mcbsp.c:253: error: ???INT_24XX_MCBSP3_IRQ_RX??? undeclared here (not in a function)
> > > arch/arm/mach-omap2/mcbsp.c:254: error: ???INT_24XX_MCBSP3_IRQ_TX??? undeclared here (not in a function)
> > > arch/arm/mach-omap2/mcbsp.c:262: error: ???INT_24XX_MCBSP4_IRQ_RX??? undeclared here (not in a function)
> > > arch/arm/mach-omap2/mcbsp.c:263: error: ???INT_24XX_MCBSP4_IRQ_TX??? undeclared here (not in a function)
> > > arch/arm/mach-omap2/mcbsp.c:271: error: ???INT_24XX_MCBSP5_IRQ_RX??? undeclared here (not in a function)
> > > arch/arm/mach-omap2/mcbsp.c:272: error: ???INT_24XX_MCBSP5_IRQ_TX??? undeclared here (not in a function)
> > > 
> > > Please take a look and resolve ASAP.  Thanks.
> > 
> > Sorry for the delay, I was sitting in an airplane again.
> > 
> > Here's the fix, looks like the missing McBSP irqs should have been
> > merged into the recent McBSP patches.
> > 
> > This patch is also in your patch system as 5301/1.
> 
> Thanks, that solved that problem, but there's one more to come:
> 
> arch/arm/plat-omap/devices.c: In function 'omap_mcbsp_register_board_cfg':
> arch/arm/plat-omap/devices.c:163: error: 'OMAP_MAX_MCBSP_COUNT' undeclared (first use in this function)
> arch/arm/plat-omap/devices.c:163: error: (Each undeclared identifier is reported only once
> arch/arm/plat-omap/devices.c:163: error: for each function it appears in.)
> 
> The good news is that that seems to be the last error building for LDP.

Grrr, just few mins and I'll send a patch. Will also build test this
time :)

Tony
