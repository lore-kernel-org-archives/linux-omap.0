From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP3 kernels fail to build
Date: Tue, 9 Aug 2011 06:16:22 -0700
Message-ID: <20110809131622.GS1866@atomide.com>
References: <20110808110056.GA15134@n2100.arm.linux.org.uk>
 <4E3FC3EC.2010909@ti.com>
 <20110808113039.GB15134@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21606 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751051Ab1HINQ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 09:16:29 -0400
Content-Disposition: inline
In-Reply-To: <20110808113039.GB15134@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Felipe Balbi <balbi@ti.com>, Arnd Bergmann <arnd@arndb.de>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110808 04:25]:
> On Mon, Aug 08, 2011 at 04:39:32PM +0530, Santosh wrote:
> > + Felipe,
> >
> > On Monday 08 August 2011 04:30 PM, Russell King - ARM Linux wrote:
> >> With CONFIG_ARCH_OMAP3=y and CONFIG_ARCH_OMAP4=n, I'm getting this:
> >>
> >> arch/arm/mach-omap2/built-in.o:(.data+0xf99c): undefined reference to `omap4430_phy_init'
> >> arch/arm/mach-omap2/built-in.o:(.data+0xf9a0): undefined reference to `omap4430_phy_exit'
> >> arch/arm/mach-omap2/built-in.o:(.data+0xf9a4): undefined reference to `omap4430_phy_power'
> >> arch/arm/mach-omap2/built-in.o:(.data+0xf9a8): undefined reference to `omap4430_phy_set_clk'
> >> arch/arm/mach-omap2/built-in.o:(.data+0xf9ac): undefined reference to `omap4430_phy_suspend'
> >>
> > I thought below patch was suppose to fix it.
> > https://patchwork.kernel.org/patch/963462/
> 
> So, the problem has been known about for around a month.  Yet the broken
> patch still went upstream.
> 
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
> IF IT IS KNOWN THAT A PATCH IS BROKEN IT MUST NOT BE SUBMITTED TO MAINLINE
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> We've seen other instances of that during this merge window, and Linus
> has responded thusly to these incidents:

Sorry I guess I just went into vacation mode and stopped applying patches.

Regards,

Tony
