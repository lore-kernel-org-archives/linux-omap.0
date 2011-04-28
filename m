From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v4 0/4] OMAP: DMA: mstandby mode and runtime pm support
Date: Thu, 28 Apr 2011 14:56:35 +0100
Message-ID: <20110428135635.GC19709@n2100.arm.linux.org.uk>
References: <1301322422-29886-1-git-send-email-manjugk@ti.com> <20110419110517.GG477@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50037 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760379Ab1D1N4u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Apr 2011 09:56:50 -0400
Content-Disposition: inline
In-Reply-To: <20110419110517.GG477@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, khilman@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Apr 19, 2011 at 04:05:17AM -0700, Tony Lindgren wrote:
> * G, Manjunath Kondaiah <manjugk@ti.com> [110328 07:29]:
> > 
> > G, Manjunath Kondaiah (4):
> >   OMAP2+: PM: omap device: API's for handling mstandby mode
> >   OMAP2+: DMA: prevent races while setting M idle mode to nostandby
> >   OMAP: PM: DMA: Enable runtime pm
> >   OMAP: DMA: Fix: context restore during off mode
> > 
> >  arch/arm/mach-omap1/dma.c                     |    1 +
> >  arch/arm/mach-omap2/dma.c                     |   16 ++
> >  arch/arm/mach-omap2/omap_hwmod.c              |   42 ++++++
> >  arch/arm/plat-omap/dma.c                      |  196 +++++++++++++++++++++----
> >  arch/arm/plat-omap/include/plat/dma.h         |    1 +
> >  arch/arm/plat-omap/include/plat/omap_device.h |    2 +
> >  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    4 +-
> >  arch/arm/plat-omap/omap_device.c              |   62 ++++++++
> >  8 files changed, 291 insertions(+), 33 deletions(-)
> 
> With the DMA code too we need to do the cleanup to move it
> to drivers/dma before adding new features.

It also needs to conform to the DMA engine API, which is not well
documented.  The points to watch out for are:

1. it passes lockdep.
2. drivers _can_ submit new slave transactions during a previous slave
   transaction callback.
3. callbacks must be made from tasklet context.
4. terminating a transaction dma dma_terminate_all() should not call any
   callbacks (as they may submit new transactions, causing DMA to restart.)

I think that's about it, but there may be more.
