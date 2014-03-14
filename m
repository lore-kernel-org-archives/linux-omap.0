From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/5] OMAP IOMMU fixes and IOMMU architecture questions
Date: Fri, 14 Mar 2014 12:00:16 +0100
Message-ID: <1523736.5PrLY3OqT5@avalon>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com> <53226A81.3090501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:46030 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbaCNK6h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Mar 2014 06:58:37 -0400
In-Reply-To: <53226A81.3090501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org, Florian Vaussard <florian.vaussard@epfl.ch>, sakari.ailus@iki.fi, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>

Hi Suman,

(CC'ing Joerg Roedel and Marek Szyprowski for the core IOMMU discussion)

On Thursday 13 March 2014 21:33:37 Suman Anna wrote:
> On 03/07/2014 06:46 PM, Laurent Pinchart wrote:
> > Hello,
> > 
> > This patch set fixes miscellaneous issues with the OMAP IOMMU driver,
> > found when trying to port the OMAP3 ISP away from omap-iovmm to the ARM
> > DMA API. The biggest issue is fixed by patch 5/5, while the other patches
> > fix smaller problems that I've noticed when reading the code, without
> > experiencing them at runtime.
> > 
> > I'd like to take this as an opportunity to discuss OMAP IOMMU integration
> > with the ARM DMA mapping implementation. The idea is to hide the IOMMU
> > completely behind the DMA mapping API, making it completely transparent
> > to drivers.
>
> Thanks for starting the discussion.
> 
> > A drivers will only need to allocate memory with dma_alloc_*, and behind
> > the scene the ARM DMA mapping implementation will find out that the
> > device is behind an IOMMU and will map the buffers through the IOMMU,
> > returning an I/O VA address to the driver. No direct call to the OMAP
> > IOMMU driver or to the IOMMU core should be necessary anymore.
> > 
> > To use the IOMMU the ARM DMA implementation requires a VA mapping to be
> > created with a call to arm_iommu_create_mapping() and to then be attached
> > to the device with arm_iommu_attach_device(). This is currently not
> > performed by the OMAP IOMMU driver, I have thus added that code to the
> > OMAP3 ISP driver for now. I believe this to still be an improvement
> > compared to the current situation, as it allows getting rid of custom
> > memory allocation code in the OMAP3 ISP driver and custom I/O VA space
> > management in omap-iovmm. However, that code should ideally be removed
> > from the driver. The question is, where should it be moved to ?
> > 
> > One possible solution would be to add the code to the OMAP IOMMU driver.
> > However, this would require all OMAP IOMMU users to be converted to the
> > ARM DMA API. I assume there would be issues that I don't foresee though.
> 
> Yeah, I think this will pose some problems for the other main user of IOMMUs
> - the remoteproc devices (DSP, Dual-Cortex M3/M4 processors in OMAP4 and
> beyond). A remoteproc device also needs to map memory at specific addresses
> for its code and data sections, and not rely on a I/O VA address being given
> to it. The firmware sections are already linked at specific addresses, and
> so remoteproc needs to allocate memory, load the firmware and map into
> appropriate device addresses. We are doing this currently usage a
> combination of CMA memory to get contiguous memory (there are some
> restrictions for certain sections) and iommu_map/unmap API to program the
> MMU with these pages. This usage is different from what is expected from
> exchanging buffers, which can be allocated from a predefined mapping range.
> Even that one is tricky if we need to support different cache
> properties/attributes as the cache configuration is in general local to
> these processors.

Right, we indeed need two levels of API, one for drivers such as remoteproc 
that need direct control of the IOMMU, and one for drivers that only need to 
map buffers without any additional requirement. In the second case the drivers 
should ideally use the DMA mapping API not even be aware that an IOMMU is 
present. This would require moving the ARM mapping allocation out of the 
client driver.

The IOMMU core or the IOMMU driver will need to know whether the driver 
expects to control the IOMMU directly or to have it managed transparently. As 
this is a software configuration I don't think the information belongs to DT. 
The question is, how should this information be conveyed ?

> > I'm not even sure whether the OMAP IOMMU driver would be the best place to
> > put that code. Ideally VA spaces should be created by the platform
> > somehow, and mapping of devices to IOMMUs should be handled by the IOMMU
> > core instead of the IOMMU drivers. We're not there yet, and the path
> > might not be straightforward, hence this attempt to start a constructive
> > discussion.
> > 
> > A second completely unrelated problem that I'd like to get feedback on is
> > the suspend/resume support in the OMAP IOMMU driver, or rather the lack
> > thereof. The driver exports omap_iommu_save_ctx() and
> > omap_iommu_restore_ctx() functions and expects the IOMMU users to call
> > them directly. This is really hackish to say the least. A proper
> > suspend/resume implementation shouldn't be difficult to implement, and
> > I'm wondering whether the lack of proper power management support comes
> > from historical reasons only, or if there are problems I might not have
> > considered.
> 
> Agreed, the current code definitely needs a cleanup and better organization
> (like folding into runtime suspend ops). The main thing is that we need the
> IOMMU to be activated as long as its parent device is active (like the
> omap3isp or a remoteproc device). And this behaviour needs separation from
> configuring it and programming for the first time. Only a user can dictate
> when an IOMMU is not needed. So we either need an API to activate or have
> access to the iommu's dev object somehow so that we can use the
> pm_runtime_get/put API to hold a usage counter and let the runtime suspend
> ops take care of save/restore without tearing down the domain or detaching
> the device.

The OMAP IOMMU driver calls pm_runtime_get_sync() in iommu_enable(), and 
pm_runtime_put_sync() in iommu_disable(). The enable/disable functions are 
called in the attach and detach handlers (as well as in the fault handler for 
the disable function). As long as a device is attached the IOMMU will thus not 
be suspended by runtime PM, but could be suspended by system PM.

This leads to two separate issues. The first one is that the IOMMU will be 
powered on as long as a device is attached, even if the device isn't in use. 
This consumes power needlessly. It would probably be better to more the 
enable/disable calls to the map/unmap handlers, as the IOMMU should be powered 
off when no mapping exists (or am I missing something ?).

The second issue is that the IOMMU and IOMMU users system PM suspend/resume 
callbacks are not synchronized. We need a guarantee that the IOMMU will be 
suspended after its users, and resumed before them. One option to fix this 
could be to use the suspend_late and resume_early PM operations (although I 
haven't checked whether that would work), but it's probably a bit hackish.

> > Last but not least, the patches are available at
> > 
> > 	git://linuxtv.org/pinchartl/media.git omap3isp/dma
> > 
> > along with a patch series that ports the OMAP3 ISP driver to the DMA API.
> > I will submit that one for review once the IOMMU patches get accepted and
> > after fixing a couple of remaining bugs (I'm aware that I have broken
> > userspace PFNMAP buffers).
> 
> I have looked at your tree, and as you already stated, it seems to be
> right intermediate solution for now to get rid of omap-iovmm.

OK, thank you. I'll push those patches upstream as soon as this series gets 
merged.

-- 
Regards,

Laurent Pinchart

