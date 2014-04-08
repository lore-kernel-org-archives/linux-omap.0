From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/5] OMAP IOMMU fixes and IOMMU architecture questions
Date: Tue, 08 Apr 2014 17:02:37 +0200
Message-ID: <9980327.f1Bry2ysvR@avalon>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com> <1907788.6W1haHecHa@avalon> <20140408134322.GT13491@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:57488 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757183AbaDHPA2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Apr 2014 11:00:28 -0400
In-Reply-To: <20140408134322.GT13491@8bytes.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Suman Anna <s-anna@ti.com>, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org, Florian Vaussard <florian.vaussard@epfl.ch>, sakari.ailus@iki.fi, Marek Szyprowski <m.szyprowski@samsung.com>

Hi Joerg,

On Tuesday 08 April 2014 15:43:22 Joerg Roedel wrote:
> On Tue, Apr 08, 2014 at 02:50:38PM +0200, Laurent Pinchart wrote:
> > I agree with you, the two levels are already present, but there's still
> > rough edges that we need to soften.
> > 
> > The ARM DMA API implementation requires someone to create the VA space
> > mapping by calling arm_iommu_create_mapping() and attach devices to
> > mappings by calling arm_iommu_attach_device().
> 
> Who is "someone" in this case?

That's exactly the problem :-) The ARM DMA API implementation doesn't care who 
that "someone" is. Existing implementations call those functions either from 
the bus masters device drivers (in which case the drivers need to be IOMMU-
aware, even if they use the DMA API and don't need to handle the IOMMU 
directly) or from the IOMMU drivers (in which case the bus masters device 
drivers don't have to care about the IOMMU, but without a way for drivers to 
handle the IOMMU directly when they need to). Possible other candidates are 
core IOMMU code or bus code.

> > This must only be performed for devices that use the DMA API, devices
> > that manage their IOMMU directly will call to the IOMMU API directly.
> > 
> > One obvious possibility is to call those functions in the IOMMU bus
> > masters device drivers. This is pretty easy, but makes the drivers IOMMU-
> > aware (which I'd like to avoid) and doesn't allow multiple bus masters to
> > share a VA space mapping. Another possibility is to place the calls in the
> > IOMMU drivers. This has the advantage of removing any IOMMU knowledge
> > from bus masters device drivers and allowing multiple bus masters per
> > IOMMU, but makes IOMMU management by the DMA API unconditional.
> 
> Why does that make IOMMU management by the DMA API unconditional? On x86 it
> works this way: The IOMMU drivers create DMA-API mappings for the devices by
> default. So any driver can use the DMA-API just out-of-the-box without being
> aware of an IOMMU. If the driver wants to deal with the IOMMU directly, it
> creates its own iommu-domain and attaches the device to it. The device uses
> the drivers domain then and not the DMA-API domain setup by the IOMMU
> driver. On iommu-detach the device is assigned back to its DMA-API domain.

If we call arm_iommu_attach_device() from the IOMMU driver to get default 
transparent IOMMU handling, the function will then attach the device to the 
default domain with a call to iommu_attach_device(). If a driver needs to 
handle the IOMMU directly, should it start by detaching the device from the 
ARM IOMMU domain ? We would need to be very careful with the assumptions made 
by the different layers, as they might not support a driver attaching a new 
domain to a device that already has a domain attached. I'd feel more 
comfortable with avoiding to attach the default domain to the device in the 
first place, but that might not be easily doable.

> > > The way this works on x86 is that a device driver can use the DMA-API
> > > per default. If it wants to use the IOMMU-API it has to allocate a
> > > domain and add the device it handles to this domain (it can't use DMA-
> > > API anymore then).
> > 
> > Are drivers supposed to reimplement the DMA API internally in that case?
> 
> Usually not, but possible. Device drivers use the IOMMU-API when they want
> to control the io-addresses themselves. This is the case for VFIO for
> example, where a given range from a process address space is mapped into a
> device address space. In those cases the device driver usally does not need
> to implement its own address allocator.

-- 
Regards,

Laurent Pinchart

