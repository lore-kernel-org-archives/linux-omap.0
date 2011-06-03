From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 1/2] omap3: iovmm: Work around sg_alloc_table size limitation in IOMMU
Date: Fri, 3 Jun 2011 02:12:47 +0200
Message-ID: <201106030212.48226.laurent.pinchart@ideasonboard.com>
References: <20110601131744.GH11352@atomide.com> <201106011550.50873.laurent.pinchart@ideasonboard.com> <20110601140306.GC6700@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:45976 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398Ab1FCAMs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 20:12:48 -0400
In-Reply-To: <20110601140306.GC6700@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Russell,

On Wednesday 01 June 2011 16:03:06 Russell King - ARM Linux wrote:
> On Wed, Jun 01, 2011 at 03:50:50PM +0200, Laurent Pinchart wrote:
> > In the specific iovmm case, the driver uses the sglist API to build a
> > list of page-size sg entries, and then process it in software. Is that
> > considered as an abuse of the sglist API, or valid usage ?
> > 
> > Anyway, sglist chaining is not needed by iovmm. As iovmm just walks the
> > sglist manually, it's easier to allocate it in one go rather than using
> > sglist chaining. This of course doesn't make your patch unneeded or
> > wrong.
> 
> Well, there's a two issues here:
> 1. Should iovmm use sg_phys(sg) with sg_dma_len(sg) ?
>    Probably not, because a scatterlist before DMA API mapping is defined
>    by sg_page(sg), sg->offset, sg->length and has N entries.  After DMA
>    API mapping (n = dma_map_sg(dev, sg, N, dir)), it has n entries where
>    n <= N, and the DMA address/lengths are sg_dma_address(sg) and
>    sg_dma_len(sg).  Both these are undefined for unmapped scatterlists.
> 
>    Getting this wrong means breakage when CONFIG_NEED_SG_DMA_LENGTH is
>    enabled.

iovmm abuses the sglist API, there's no doubt on that. It will break when 
CONFIG_NEED_SG_DMA_LENGTH is enabled. iovmm should probably not use the sglist 
API, and it should probably not even exist in the first place. I know that TI 
is working on moving the OMAP-specific iommu/iovmm implementation to the 
generic IOMMU API, but that will take time. In the meantime, I'd like to fix 
iovmm to avoid the userspace-triggerable BUG_ON().

> 2. What would be the effect of enabling SG list chaining on iovmm?
>    The code uses the correct SG list walking helpers (for_each_sg) so
>    it should be able to cope with chained SG lists.

Yes it should. It might be slightly less efficient, but I don't think we will 
notice.

> So, I think there's no problem here with chained SG lists, but there is
> an issue with using sg_dma_len().  I'd suggest converting stuff to use
> sg->length with sg_page(sg) rather than sg_dma_len(sg).

With sg_page(sg) ? I'm not sure to follow you there.

> As for whether SG chaining is required or not, if you're running up against
> the maximum SG table size, then you do have a requirement for SG chaining.

The SG table size limit makes sure that the SG list fits in a page, so that it 
can be passed to the hardware. This isn't needed by iovmm, as it processes the 
sglist in software. iovmm could use SG chaining, but we would then need to 
enable it for the SoCs on which iovmm is used. I don't know if they properly 
support that.

-- 
Regards,

Laurent Pinchart
