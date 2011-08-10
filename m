From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP3 kernels fail to build
Date: Wed, 10 Aug 2011 08:27:12 +0100
Message-ID: <20110810072712.GD14281@n2100.arm.linux.org.uk>
References: <20110808110056.GA15134@n2100.arm.linux.org.uk> <4E3FC3EC.2010909@ti.com> <20110808113039.GB15134@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1108092318180.12674@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:32993 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab1HJH1e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Aug 2011 03:27:34 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1108092318180.12674@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Santosh <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Felipe Balbi <balbi@ti.com>, Arnd Bergmann <arnd@arndb.de>

On Tue, Aug 09, 2011 at 11:26:16PM -0600, Paul Walmsley wrote:
> On Mon, 8 Aug 2011, Russell King - ARM Linux wrote:
> 
> > On Mon, Aug 08, 2011 at 04:39:32PM +0530, Santosh wrote:
> > > On Monday 08 August 2011 04:30 PM, Russell King - ARM Linux wrote:
> > >> With CONFIG_ARCH_OMAP3=y and CONFIG_ARCH_OMAP4=n, I'm getting this:
> > >>
> > >> arch/arm/mach-omap2/built-in.o:(.data+0xf99c): undefined reference to `omap4430_phy_init'
> > >> arch/arm/mach-omap2/built-in.o:(.data+0xf9a0): undefined reference to `omap4430_phy_exit'
> > >> arch/arm/mach-omap2/built-in.o:(.data+0xf9a4): undefined reference to `omap4430_phy_power'
> > >> arch/arm/mach-omap2/built-in.o:(.data+0xf9a8): undefined reference to `omap4430_phy_set_clk'
> > >> arch/arm/mach-omap2/built-in.o:(.data+0xf9ac): undefined reference to `omap4430_phy_suspend'
> > >>
> > > I thought below patch was suppose to fix it.
> > > https://patchwork.kernel.org/patch/963462/
> > 
> > So, the problem has been known about for around a month.  Yet the broken
> > patch still went upstream.
> 
> Which known "broken patch still went upstream" ?
> 
> The problem commits were 208466dc10083e734a8af71d10f923ee4bff950c ("usb: 
> otg: OMAP4430: Powerdown the internal PHY when USB is disabled") and 
> fb91cde49c327ff957c55d91805bc6abda59b311 ("usb: musb: OMAP4430: Power down 
> the PHY during board init").  The above link makes this clear.  

The fact that there are _build_ _errors_ indicate that a patch which
introduced this crap _was_ _broken_.  The fact that it was _reported_
as broken well before the merge window and still went in during the
merge window indicates that the OMAP workflow with regard to patches
is simply BROKEN.

And the fact that you can't recognise that makes _you_ part of the
problem.

There are no excuses for this.

And more - wtf those commit IDs you mention have to do with my build
error with twl-common.c I've no idea.  The breakage was not introduced
by either of the commits you mention, but b22f954 (OMAP4: Move common
twl6030 configuration to twl-common).

So please, stop this disinformation right now and get more of a clue.

Thanks.
