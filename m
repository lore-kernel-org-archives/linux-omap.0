From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 1/2] omap3: iovmm: Work around sg_alloc_table size limitation in IOMMU
Date: Mon, 6 Jun 2011 18:54:10 +0200
Message-ID: <201106061854.10450.laurent.pinchart@ideasonboard.com>
References: <20110601131744.GH11352@atomide.com> <201106061823.18767.laurent.pinchart@ideasonboard.com> <20110606164400.GA9456@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:43136 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab1FFQx4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 12:53:56 -0400
In-Reply-To: <20110606164400.GA9456@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Russell,

On Monday 06 June 2011 18:44:00 Russell King - ARM Linux wrote:
> On Mon, Jun 06, 2011 at 06:23:18PM +0200, Laurent Pinchart wrote:
> > Hi Russell,
> > 
> > On Friday 03 June 2011 08:32:12 Russell King - ARM Linux wrote:
> > > SG chaining has _nothing_ to do with hardware.  It's all to do with
> > > software and hitting the SG table limit.
> > 
> > What's the reason for limiting the SG table size to one page then ?
> 
> As I say, it's got nothing to do with them ending up being passed to
> hardware.  Take a look at their definition:
> 
> struct scatterlist {
> #ifdef CONFIG_DEBUG_SG
>         unsigned long   sg_magic;
> #endif
>         unsigned long   page_link;
>         unsigned int    offset;
>         unsigned int    length;
>         dma_addr_t      dma_address;
> #ifdef CONFIG_NEED_SG_DMA_LENGTH
>         unsigned int    dma_length;
> #endif
> };
> 
> That clearly isn't hardware specific - hardware won't cope with
> CONFIG_DEBUG_SG being enabled or disabled, or whether the architecture
> supports the dma_length field, or that this structure has developed from
> being:
> 
> 	void *addr;
> 	unsigend int length;
> 	unsigned long dma_address;
> 
> to the above over the evolution of the kernel.  Or that we use the bottom
> two bits of page_link as our own flag bits?
> 
> So no, this struct goes nowhere near hardware of any kind.  It's merely
> used as a container to pass a list of scatter-gather locations in memory
> internally around within the kernel, especially to dma_map_sg()/
> dma_unmap_sg().
> 
> If you look at IDE or ATA code, or even SCSI code, you'll find the same
> pattern.  They're passed a scatterlist.  They map it for dma using
> dma_map_sg().  They then walk the scatterlist and extract the dma
> address and length using sg_dma_address() and sg_dma_length() and create
> the _hardware_ table from that information - and the hardware table very
> much depends on the hardware itself.  Once DMA is complete, they unmap
> the DMA region using dma_unmap_sg().
> 
> One very good reason that its limited to one page is because allocations
> larger than one page are prone to failure.  Would you want your company
> server failing to read/write data to its storage just because it couldn't
> get a contiguous 8K page for a 5K long scatterlist?  I think if Linux
> did that, it wouldn't have a future in the enterprise marketplace.

Of course not, but if the scatterlist is only touched by kernel code, it 
doesn't need to be contiguous in memory. It could be allocated with vmalloc().

-- 
Regards,

Laurent Pinchart
