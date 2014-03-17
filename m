From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/5] OMAP IOMMU fixes and IOMMU architecture questions
Date: Mon, 17 Mar 2014 23:44:14 +0100
Message-ID: <5039151.0ixNYfsDVA@avalon>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com> <20140316215455.GA2108@valkosipuli.retiisi.org.uk> <532753E0.10605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:42497 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbaCQWmb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2014 18:42:31 -0400
In-Reply-To: <532753E0.10605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Sakari Ailus <sakari.ailus@iki.fi>, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org, Florian Vaussard <florian.vaussard@epfl.ch>, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>

Hi Suman and Sakari,

On Monday 17 March 2014 14:58:24 Suman Anna wrote:
> On 03/16/2014 04:54 PM, Sakari Ailus wrote:
> > On Fri, Mar 14, 2014 at 12:00:16PM +0100, Laurent Pinchart wrote:
> >> Hi Suman,
> >> 
> >> (CC'ing Joerg Roedel and Marek Szyprowski for the core IOMMU discussion)
> >> 
> >> On Thursday 13 March 2014 21:33:37 Suman Anna wrote:
> >>> On 03/07/2014 06:46 PM, Laurent Pinchart wrote:
> >>>> Hello,
> >>>> 
> >>>> This patch set fixes miscellaneous issues with the OMAP IOMMU driver,
> >>>> found when trying to port the OMAP3 ISP away from omap-iovmm to the ARM
> >>>> DMA API. The biggest issue is fixed by patch 5/5, while the other
> >>>> patches fix smaller problems that I've noticed when reading the code,
> >>>> without experiencing them at runtime.
> >>>> 
> >>>> I'd like to take this as an opportunity to discuss OMAP IOMMU
> >>>> integration with the ARM DMA mapping implementation. The idea is to
> >>>> hide the IOMMU completely behind the DMA mapping API, making it
> >>>> completely transparent to drivers.
> >>> 
> >>> Thanks for starting the discussion.
> >>> 
> >>>> A drivers will only need to allocate memory with dma_alloc_*, and
> >>>> behind the scene the ARM DMA mapping implementation will find out that
> >>>> the device is behind an IOMMU and will map the buffers through the
> >>>> IOMMU, returning an I/O VA address to the driver. No direct call to the
> >>>> OMAP IOMMU driver or to the IOMMU core should be necessary anymore.
> >>>> 
> >>>> To use the IOMMU the ARM DMA implementation requires a VA mapping to be
> >>>> created with a call to arm_iommu_create_mapping() and to then be
> >>>> attached to the device with arm_iommu_attach_device(). This is
> >>>> currently not performed by the OMAP IOMMU driver, I have thus added
> >>>> that code to the OMAP3 ISP driver for now. I believe this to still be
> >>>> an improvement compared to the current situation, as it allows getting
> >>>> rid of custom memory allocation code in the OMAP3 ISP driver and custom
> >>>> I/O VA space management in omap-iovmm. However, that code should
> >>>> ideally be removed from the driver. The question is, where should it be
> >>>> moved to ?
> >>>> 
> >>>> One possible solution would be to add the code to the OMAP IOMMU
> >>>> driver. However, this would require all OMAP IOMMU users to be
> >>>> converted to the ARM DMA API. I assume there would be issues that I
> >>>> don't foresee though.
> >>> 
> >>> Yeah, I think this will pose some problems for the other main user of
> >>> IOMMUs - the remoteproc devices (DSP, Dual-Cortex M3/M4 processors in
> >>> OMAP4 and beyond). A remoteproc device also needs to map memory at
> >>> specific addresses for its code and data sections, and not rely on a
> >>> I/O VA address being given to it. The firmware sections are already
> >>> linked at specific addresses, and so remoteproc needs to allocate
> >>> memory, load the firmware and map into appropriate device addresses. We
> >>> are doing this currently usage a combination of CMA memory to get
> >>> contiguous memory (there are some restrictions for certain sections) and
> >>> iommu_map/unmap API to program the MMU with these pages. This usage is
> >>> different from what is expected from exchanging buffers, which can be
> >>> allocated from a predefined mapping range. Even that one is tricky if we
> >>> need to support different cache properties/attributes as the cache
> >>> configuration is in general local to these processors.
> >> 
> >> Right, we indeed need two levels of API, one for drivers such as
> >> remoteproc that need direct control of the IOMMU, and one for drivers
> >> that only need to map buffers without any additional requirement. In the
> >> second case the drivers should ideally use the DMA mapping API not even
> >> be aware that an IOMMU is present. This would require moving the ARM
> >> mapping allocation out of the client driver.
> 
> Actually, I think there is one another use case, even with remoteprocs which
> is to runtime map buffers. This is different from the firmware management.
> The memory for buffers could have been allocated from other subsystems, but
> remoteproc would need just to manage the VA space and map.

Right, although you might not always have to manage the VA space in that case. 
Anyway, if your driver needs to manage the VA space for the firmware, it 
should be able to manage the VA space for the buffers using the same IOMMU 
API.

> >> The IOMMU core or the IOMMU driver will need to know whether the driver
> >> expects to control the IOMMU directly or to have it managed
> >> transparently. As this is a software configuration I don't think the
> >> information belongs to DT. The question is, how should this information
> >> be conveyed?
> 
> Can this be done through iommu_domain_set_attr? But that means the client
> driver has to dictate this. The iommu driver can be configured appropriately
> based on this.

The problem with that approach is that IOMMU client (bus master) drivers would 
need a pointer to the IOMMU domain. That's what we want to avoid in the first 
place :-)

> > The driver would need to know that, I think.

The IOMMU client driver would know that. Or, to be accurate, it should either 
know that it wants to manage the IOMMU directly, or should ignore the IOMMU 
completely.

> > Currently the DMA mapping API doesn't allow explicit addressing to IOVA
> > address space AFAIK. The IOMMU API does. It's a good question how to do
> > this as I don't think there's even a way for the driver to explicitly
> > obtain access to the IOMMU.

A driver can't access the IOMMU device directly, but the IOMMU API uses IOMMU 
domains, not IOMMU devices. Drivers can create domains and then access the 
IOMMU API. The association with a particular IOMMU instance is currently left 
to the IOMMU driver, that usually gets that information from platform data or 
DT in a driver-specific way. I think this should be standardized, especially 
in the DT case.

What drivers can't do at the moment is accessing the IOMMU API using a domain 
they haven't created themselves. A two drivers requiring direct access to an 
IOMMU sharing the same domain wouldn't be possible. That might not be a 
problem we need to solve now though.

> > The virtual address space allocation would need to take into account that
> > some of the address space is actually mapped outside it. The iova library
> > can do this already.

This only needs to be taken into account for drivers that require direct 
control of the IOMMU. Those drivers are currently expected to manage the whole 
VA space themselves. They can do so internally, or using a library such as 
iova, yes, but they won't use the DMA API IOMMU integration.

> >>>> I'm not even sure whether the OMAP IOMMU driver would be the best place
> >>>> to put that code. Ideally VA spaces should be created by the platform
> >>>> somehow, and mapping of devices to IOMMUs should be handled by the
> >>>> IOMMU core instead of the IOMMU drivers. We're not there yet, and the
> >>>> path might not be straightforward, hence this attempt to start a
> >>>> constructive discussion.
> >>>> 
> >>>> A second completely unrelated problem that I'd like to get feedback on
> >>>> is the suspend/resume support in the OMAP IOMMU driver, or rather the
> >>>> lack thereof. The driver exports omap_iommu_save_ctx() and
> >>>> omap_iommu_restore_ctx() functions and expects the IOMMU users to call
> >>>> them directly. This is really hackish to say the least. A proper
> >>>> suspend/resume implementation shouldn't be difficult to implement, and
> >>>> I'm wondering whether the lack of proper power management support comes
> >>>> from historical reasons only, or if there are problems I might not have
> >>>> considered.
> >>> 
> >>> Agreed, the current code definitely needs a cleanup and better
> >>> organization (like folding into runtime suspend ops). The main thing is
> >>> that we need the IOMMU to be activated as long as its parent device is
> >>> active (like the omap3isp or a remoteproc device). And this behaviour
> >>> needs separation from configuring it and programming for the first time.
> >>> Only a user can dictate when an IOMMU is not needed. So we either need
> >>> an API to activate or have access to the iommu's dev object somehow so
> >>> that we can use the pm_runtime_get/put API to hold a usage counter and
> >>> let the runtime suspend ops take care of save/restore without tearing
> >>> down the domain or detaching the device.
> >> 
> >> The OMAP IOMMU driver calls pm_runtime_get_sync() in iommu_enable(), and
> >> pm_runtime_put_sync() in iommu_disable(). The enable/disable functions
> >> are called in the attach and detach handlers (as well as in the fault
> >> handler for the disable function). As long as a device is attached the
> >> IOMMU will thus not be suspended by runtime PM, but could be suspended by
> >> system PM.
> 
> This would all need some rearranging of course. It is also not about just
> disabling the clocks, we may have to assert the resets as well, due to
> couple of issues on OMAP4 and beyond.

Right.
 
> >> This leads to two separate issues. The first one is that the IOMMU will
> >> be powered on as long as a device is attached, even if the device isn't
> >> in use. This consumes power needlessly. It would probably be better to
> >> more the enable/disable calls to the map/unmap handlers, as the IOMMU
> >> should be powered off when no mapping exists (or am I missing something
> >> ?).
> > 
> > In general, I wouldn't make the assumption that no mappings can exist if
> > the IOMMU is powered off. This would mean that just keeping buffers
> > around for later use would keep hardware powered. Memory allocation can
> > be a very time-consuming task which often is done when the entire system
> > is booted up (depending on the user space naturally), not when a
> > particular device node is opened.
> 
> Yeah, agreed. remoteproc firmware memory will stay mapped in even when we
> power off IOMMU, we just preserve the required IOMMU context. I expect the
> suspend/resume code to preserve any locked TLBs and the TTB address. The
> page table entries would be auto-preserved as long as we don't free the
> table.

I don't want to force the IOMMU to be powered on when a mapping exists, but at 
the moment the driver powers it on when a device is attached, which is even 
worse. Moving the pm_runtime_get/set calls to map/unmap would be an 
improvement compared to the current situation, but is obviously not the 
perfect solution.

> > That said, I don't have a good, obviously acceptable solution to propose
> > to this problem right now. I think the IOMMU power state should be rather
> > bound to the device's power state, but DMA mapping API doesn't know
> > anything about IOMMUs as such. I wonder what kind of a reception would
> > such an addition to the DMA mapping would receive. There are two things I
> > could think of: either make the potential IOMMU visible to the driver so
> > the driver can use runtime PM as usual, or add a function to the DMA
> > mapping API to allow whatever hardware used in the DMA accesses to power
> > down (and up again when needed).
> > 
> > The latter is hackish in my opinion but the former would also change the
> > DMA mapping API to a direction which not everyone would probably agree
> > on.

I don't like the first option, as drivers should not be aware of the IOMMU at 
all in the general case. The second option is pretty hackish as well.

As the IOMMU driver is notified when a device is attached and detached, I 
think the right solution would be to then ask the PM core to notify the IOMMU 
driver when the attached devices are suspended and resumed, and block suspend 
as long as a user is awake.

I'm not sure whether we have any PM notification mechanism though, and whether 
we can ask suspend to be deferred similarly to deferred probing.

> > I'm personally fine with the above limitation on OMAP3 but in general it'd
> > be better to get around it.
> 
> Once we add the iommus property to the client DT nodes, I think the drivers
> should be able to retrieve the iommu dev object. So that should allow both
> the IOMMU to be visible, as well as give access to invoke runtime_pm
> functions on the iommu device.

I'd like to avoid that. On one family of SoCs I work with several IOMMU 
instances serve dozens of devices each. I don't want to modify each device 
driver to take the IOMMU into account. If one driver needs to handle the IOMMU 
and IOMMU client power dependency, it should be the IOMMU driver.

> >> The second issue is that the IOMMU and IOMMU users system PM
> >> suspend/resume callbacks are not synchronized. We need a guarantee that
> >> the IOMMU will be suspended after its users, and resumed before them. One
> >> option to fix this could be to use the suspend_late and resume_early PM
> >> operations (although I haven't checked whether that would work), but it's
> >> probably a bit hackish.
> > 
> > I agree.
> > 
> > The IOMMUs would indeed need to be resumed first. Hiroshi had a aptchset
> > to initialise and associate IOMMUs to devices using DT but it seems it's
> > not exactly going somewhere right now. I just mention this since basically
> > the> same problem exists there.
> > 
> > <URL:http://lists.linuxfoundation.org/pipermail/iommu/2013-November/index.
> > html>
>
> Yeah, we haven't converted the current OMAP iommu users to DT yet, and I
> would expect some changes in the OMAP IOMMU code once that series is
> finalized.

-- 
Regards,

Laurent Pinchart

