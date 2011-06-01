From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 1/2] omap3: iovmm: Work around sg_alloc_table size
	limitation in IOMMU
Date: Wed, 1 Jun 2011 15:03:06 +0100
Message-ID: <20110601140306.GC6700@n2100.arm.linux.org.uk>
References: <20110601131744.GH11352@atomide.com> <1306935012-12406-1-git-send-email-laurent.pinchart@ideasonboard.com> <20110601134338.GB6700@n2100.arm.linux.org.uk> <201106011550.50873.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35014 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab1FAODN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 10:03:13 -0400
Content-Disposition: inline
In-Reply-To: <201106011550.50873.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jun 01, 2011 at 03:50:50PM +0200, Laurent Pinchart wrote:
> In the specific iovmm case, the driver uses the sglist API to build a list of 
> page-size sg entries, and then process it in software. Is that considered as 
> an abuse of the sglist API, or valid usage ?
> 
> Anyway, sglist chaining is not needed by iovmm. As iovmm just walks the sglist 
> manually, it's easier to allocate it in one go rather than using sglist 
> chaining. This of course doesn't make your patch unneeded or wrong.

Well, there's a two issues here:
1. Should iovmm use sg_phys(sg) with sg_dma_len(sg) ?
   Probably not, because a scatterlist before DMA API mapping is defined
   by sg_page(sg), sg->offset, sg->length and has N entries.  After DMA
   API mapping (n = dma_map_sg(dev, sg, N, dir)), it has n entries where
   n <= N, and the DMA address/lengths are sg_dma_address(sg) and
   sg_dma_len(sg).  Both these are undefined for unmapped scatterlists.

   Getting this wrong means breakage when CONFIG_NEED_SG_DMA_LENGTH is
   enabled.

2. What would be the effect of enabling SG list chaining on iovmm?
   The code uses the correct SG list walking helpers (for_each_sg) so
   it should be able to cope with chained SG lists.

So, I think there's no problem here with chained SG lists, but there is
an issue with using sg_dma_len().  I'd suggest converting stuff to use
sg->length with sg_page(sg) rather than sg_dma_len(sg).

As for whether SG chaining is required or not, if you're running up
against the maximum SG table size, then you do have a requirement for
SG chaining.
