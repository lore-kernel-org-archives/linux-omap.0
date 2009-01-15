From: Tony Lindgren <tony@atomide.com>
Subject: Re: git-pull request for omap-fixes for 2.6.29-rc1 (Re: [PATCH
	00/10] Omap fixes for 2.6.29-rc1)
Date: Thu, 15 Jan 2009 13:26:12 +0200
Message-ID: <20090115112611.GX29324@atomide.com>
References: <20090112143405.24205.52151.stgit@localhost> <20090113143528.GP7344@atomide.com> <20090115103716.GL2162@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55423 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303AbZAOL0S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 06:26:18 -0500
Content-Disposition: inline
In-Reply-To: <20090115103716.GL2162@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090115 12:37]:
> On Tue, Jan 13, 2009 at 04:35:29PM +0200, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [090112 16:37]:
> > > Hi,
> > > 
> > > Here are some omap fixes for review. Some of these patches
> > > were posted earlier.
> > 
> > If no other comments, here's the pull request:
> 
> Unfortunately, this breaks stuff.  Whereas before pulling this I get:
> 
>   CC      drivers/usb/core/hub.o
> drivers/usb/core/hub.c: In function `usb_configure_device_otg':
> drivers/usb/core/hub.c:1557: error: too few arguments to function `usb_port_suspend'
> 
> while building my omap config, I now get this much earlier in the build:
> 
>   CC      arch/arm/mach-omap1/board-h2.o
> arch/arm/mach-omap1/board-h2.c:259: error: `OMAP_DMA_UART3_RX' undeclared here (not in a function)
> arch/arm/mach-omap1/board-h2.c:259: error: initializer element is not constant
> arch/arm/mach-omap1/board-h2.c:259: error: (near initialization for `h2_irda_data.rx_channel')
> arch/arm/mach-omap1/board-h2.c:260: error: `OMAP_DMA_UART3_TX' undeclared here (not in a function)
> arch/arm/mach-omap1/board-h2.c:260: error: initializer element is not constant
> arch/arm/mach-omap1/board-h2.c:260: error: (near initialization for `h2_irda_data.tx_channel')
> arch/arm/mach-omap1/board-h2.c:375: warning: 'h2_nand_dev_ready' defined but not used
> 
> This has appeared because in 9f94ad8ab33417f98b363491d4730a67f4d92831,
> the include of mach/omap-alsa.h was removed, which includes mach/dma.h,
> and mach/dma.h is needed for these definitions.
> 
> It would be far better to omit mach/dma.h from mach/omap-alsa.h since
> mach/dma.h isn't strictly required for mach/omap-alsa.h (the file seems
> to contain nothing that requires anything from mach/dma.h) and then these
> kinds of accidents can be avoided.
> 
> With that fixed, that then brings us on to:
> 
>   CC      arch/arm/plat-omap/mcbsp.o
> arch/arm/plat-omap/mcbsp.c: In function `omap_mcbsp_config':
> arch/arm/plat-omap/mcbsp.c:177: error: `OMAP_MCBSP_REG_XCCR' undeclared (first use in this function)
> arch/arm/plat-omap/mcbsp.c:177: error: (Each undeclared identifier is reported only once
> arch/arm/plat-omap/mcbsp.c:177: error: for each function it appears in.)
> arch/arm/plat-omap/mcbsp.c:178: error: `OMAP_MCBSP_REG_RCCR' undeclared (first use in this function)
> 
> which is caused by 82b30192282d9b3da37d98af4b308d989ed6b92e.
> 
> Not pulling.

Hmm, I thought I build all the defconfigs before posting the series.
Will update in just few mins.

Tony
