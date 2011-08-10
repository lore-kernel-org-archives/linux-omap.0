From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP3 kernels fail to build
Date: Tue, 9 Aug 2011 23:26:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108092318180.12674@utopia.booyaka.com>
References: <20110808110056.GA15134@n2100.arm.linux.org.uk> <4E3FC3EC.2010909@ti.com> <20110808113039.GB15134@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45482 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab1HJF0R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Aug 2011 01:26:17 -0400
In-Reply-To: <20110808113039.GB15134@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Felipe Balbi <balbi@ti.com>, Arnd Bergmann <arnd@arndb.de>

On Mon, 8 Aug 2011, Russell King - ARM Linux wrote:

> On Mon, Aug 08, 2011 at 04:39:32PM +0530, Santosh wrote:
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

Which known "broken patch still went upstream" ?

The problem commits were 208466dc10083e734a8af71d10f923ee4bff950c ("usb: 
otg: OMAP4430: Powerdown the internal PHY when USB is disabled") and 
fb91cde49c327ff957c55d91805bc6abda59b311 ("usb: musb: OMAP4430: Power down 
the PHY during board init").  The above link makes this clear.  

> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
> IF IT IS KNOWN THAT A PATCH IS BROKEN IT MUST NOT BE SUBMITTED TO MAINLINE
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is certainly good advice when it's relevant.


- Paul
