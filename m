From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [RFC 0/3] Add cyclic DMA support to OMAP DMA engine driver
Date: Mon, 25 Jun 2012 22:08:13 +0530
Message-ID: <1340642293.1562.59.camel@vkoul-udesk3>
References: <20120622085911.GA19026@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60949 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755420Ab2FYQrS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 12:47:18 -0400
In-Reply-To: <20120622085911.GA19026@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Dan Williams <dan.j.williams@intel.com>, Liam Girdwood <lrg@ti.com>

Hi Russell,

What is the status of the virtual dma and the series you have posted
previously. Is it ready for merge?

I would be away for 10days starting coming Thursday. So please let me
know

On Fri, 2012-06-22 at 09:59 +0100, Russell King - ARM Linux wrote:
> These three patches add support for returning the residue and cyclic DMA
> support to the OMAP DMA engine driver.
> 
> As v3.5-rc is horribly broken on my OMAP platforms, I've had to back out
> all the sound/soc/omap changes from the last merge window to test this,
> inspite of Peter Ujfalusi maintaining that there is nothing wrong.  I
> can't get working audio support on the OMAP4430SDP any other way.
> 
> I am planning no further work on this until OMAP ASoC support gets fixed;
> due to Peter and my plans this summer, this is likely to be late July/
> August time.
> 
> This does not implement all of the weird and wonderfully different DMA
> setups which the OMAP ASoC driver appears to support (do we need soo much
> flexibility?) but it does support whatever is required for my OMAP4430SDP
> board.
> 
> These patches apply on top of the previously posted series of DMA patches.
> 
> I will be merging at least some of these down into the "dmaengine: add
> OMAP DMA engine driver" commit at some point.
> 
>  drivers/dma/omap-dma.c |  167 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 156 insertions(+), 11 deletions(-)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
~Vinod

