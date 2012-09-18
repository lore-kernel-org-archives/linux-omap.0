From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V6 2/2] dmaengine: add helper function to request a
	slave DMA channel
Date: Tue, 18 Sep 2012 19:10:39 +0100
Message-ID: <20120918181039.GF12445@n2100.arm.linux.org.uk>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com> <1347938035.1943.162.camel@vkoul-udesk3> <20120918132113.GT27758@beef> <201209181520.08845.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35278 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab2IRSLc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 14:11:32 -0400
Content-Disposition: inline
In-Reply-To: <201209181520.08845.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Matt Porter <mporter@ti.com>, Vinod Koul <vinod.koul@linux.intel.com>, Jon Hunter <jon-hunter@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Dan Williams <djbw@fb.com>

On Tue, Sep 18, 2012 at 03:20:08PM +0000, Arnd Bergmann wrote:
> On Tuesday 18 September 2012, Matt Porter wrote:
> > FWIW, I'm already basing the EDMA dmaengine support for OMAP (specifically
> > for AM335x) on using these helpers since AM335x only boots from DT.
> 
> I suspect the same thing will be happening for a lot of platforms
> after 3.7-rc1: ux500, lpc32xx, integrator, imx, mxs and probably
> others are all waiting for this so they can complete the move
> to DT-only booting.

Integrator won't be, because no integrator platforms have DMA support.
That only came in with the Versatile range, of which it's extremely
dodgy and unreliable to use.  So in general, ARMs platforms do not have
working DMA support.

(I actually carry a private patch set which does enable full support on
Versatile platforms, but given the general brokenness of the platform I
see no reason to merge it and cause people issues with the platform when
they find out that DMA is broken in weird and wonderful ways depending
on the FPGA build they've happened to end up with...)
