From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/5] OMAP IOMMU fixes and IOMMU architecture questions
Date: Wed, 12 Mar 2014 16:26:11 +0100
Message-ID: <2580372.d6ifzniBt8@avalon>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:32776 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942AbaCLPYf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2014 11:24:35 -0400
In-Reply-To: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>
Cc: linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org, sakari.ailus@iki.fi

Hello,

Suman, Florian, any opinion regarding this patch series ? Your opinion on the 
architecture-related question below would be appreciated as well, but I'd like 
to get this merged first (and especially patch 5/5) in the not too distant 
future to push OMAP3 ISP patches that depend on it.

On Saturday 08 March 2014 01:46:09 Laurent Pinchart wrote:
> Hello,
> 
> This patch set fixes miscellaneous issues with the OMAP IOMMU driver, found
> when trying to port the OMAP3 ISP away from omap-iovmm to the ARM DMA API.
> The biggest issue is fixed by patch 5/5, while the other patches fix
> smaller problems that I've noticed when reading the code, without
> experiencing them at runtime.
> 
> I'd like to take this as an opportunity to discuss OMAP IOMMU integration
> with the ARM DMA mapping implementation. The idea is to hide the IOMMU
> completely behind the DMA mapping API, making it completely transparent to
> drivers.
> 
> A drivers will only need to allocate memory with dma_alloc_*, and behind the
> scene the ARM DMA mapping implementation will find out that the device is
> behind an IOMMU and will map the buffers through the IOMMU, returning an
> I/O VA address to the driver. No direct call to the OMAP IOMMU driver or to
> the IOMMU core should be necessary anymore.
> 
> To use the IOMMU the ARM DMA implementation requires a VA mapping to be
> created with a call to arm_iommu_create_mapping() and to then be attached to
> the device with arm_iommu_attach_device(). This is currently not performed
> by the OMAP IOMMU driver, I have thus added that code to the OMAP3 ISP
> driver for now. I believe this to still be an improvement compared to the
> current situation, as it allows getting rid of custom memory allocation
> code in the OMAP3 ISP driver and custom I/O VA space management in
> omap-iovmm. However, that code should ideally be removed from the driver.
> The question is, where should it be moved to ?
> 
> One possible solution would be to add the code to the OMAP IOMMU driver.
> However, this would require all OMAP IOMMU users to be converted to the ARM
> DMA API. I assume there would be issues that I don't foresee though.
> 
> I'm not even sure whether the OMAP IOMMU driver would be the best place to
> put that code. Ideally VA spaces should be created by the platform somehow,
> and mapping of devices to IOMMUs should be handled by the IOMMU core
> instead of the IOMMU drivers. We're not there yet, and the path might not
> be straightforward, hence this attempt to start a constructive discussion.
> 
> A second completely unrelated problem that I'd like to get feedback on is
> the suspend/resume support in the OMAP IOMMU driver, or rather the lack
> thereof. The driver exports omap_iommu_save_ctx() and
> omap_iommu_restore_ctx() functions and expects the IOMMU users to call them
> directly. This is really hackish to say the least. A proper suspend/resume
> implementation shouldn't be difficult to implement, and I'm wondering
> whether the lack of proper power management support comes from historical
> reasons only, or if there are problems I might not have considered.
> 
> Last but not least, the patches are available at
> 
> 	git://linuxtv.org/pinchartl/media.git omap3isp/dma
> 
> along with a patch series that ports the OMAP3 ISP driver to the DMA API. I
> will submit that one for review once the IOMMU patches get accepted and
> after fixing a couple of remaining bugs (I'm aware that I have broken
> userspace PFNMAP buffers).
> 
> Laurent Pinchart (5):
>   iommu/omap: Use the cache cleaning API
>   iommu/omap: Fix 'no page for' debug message in flush_iotlb_page()
>   iommu/omap: Flush the TLB only after updating translation table
>     entries
>   iommu/omap: Remove comment about supporting single page mappings only
>   iommu/omap: Fix map protection value handling
> 
>  drivers/iommu/omap-iommu.c | 68 +++++++++++++++++--------------------------
>  1 file changed, 23 insertions(+), 45 deletions(-)

-- 
Regards,

Laurent Pinchart

