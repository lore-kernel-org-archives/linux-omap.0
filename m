From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: Converting OMAP's custom vram allocator
Date: Fri, 14 Sep 2012 16:10:29 +0200
Message-ID: <00ec01cd9282$b4c84540$1e58cfc0$%szyprowski@samsung.com>
References: <1346839733.32747.1.camel@deskari>
 <019b01cd8cbd$6fef8c50$4fcea4f0$%szyprowski@samsung.com>
 <1347015292.2646.23.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:57665 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab2INOKm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Sep 2012 10:10:42 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MAC003JWFD3FV30@mailout2.samsung.com> for
 linux-omap@vger.kernel.org; Fri, 14 Sep 2012 23:10:40 +0900 (KST)
Received: from AMDC159 ([106.116.147.30])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MAC00K52FDJ5ZD0@mmp2.samsung.com> for
 linux-omap@vger.kernel.org; Fri, 14 Sep 2012 23:10:40 +0900 (KST)
In-reply-to: <1347015292.2646.23.camel@deskari>
Content-language: pl
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Rob Clark' <rob@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, 'linux-omap' <linux-omap@vger.kernel.org>

Hello,

On Friday, September 07, 2012 12:55 PM Tomi Valkeinen wrote:

> On Fri, 2012-09-07 at 07:55 +0200, Marek Szyprowski wrote:
> > Hello,
> >
> > On Wednesday, September 05, 2012 12:09 PM Tomi Valkeinen wrote:
> >
> > > OMAP has a custom video ram allocator, which I'd like to remove and use
> > > the standard dma allocation functions.
> > >
> > > There are two problems for which I'd like to hear suggestions or
> > > comments:
> > >
> > > First one is that the dma_alloc_* functions map the allocated memory for
> > > cpu use. In many cases with OMAP DSS (display subsystem) this is not
> > > needed: the memory may be written only by the SGX or the DSP, and it's
> > > only read by the DSS, so it's never touched by the CPU.
> > >
> > > This is even more true when using VRFB on omap3 (and probably TILER on
> > > omap4) for rotation, as VRFB hides the actual memory and offers rotated
> > > views. In this case the backend memory is never accessed by anyone else
> > > than VRFB.
> > >
> > > Is there a way to allocate the memory without creating a mapping? While
> > > it won't break anything as such, the allocated areas can be quite large
> > > thus causing large areas of the kernel's memory space to be needlessly
> > > reserved.
> >
> > Please check commits d5724f172fd1 and 955c757e090 merged to v3.6-rc1.
> > Support for this attribute is now only available in IOMMU-aware
> > dma-mapping implementation, but I plan to add it also to standard linear
> > ARM dma-mapping implementation based on alloc_pages_exact().
> 
> Ok, good to know. Do you have any guestimate when the non-iommu version
> could end up in the mainline? Any chance for 3.7? I volunteer for
> testing if needed =).

Well, I'm not sure if I manage to have it ready for 3.7. I was very busy this
week and now I'm just leaving the office for my vacations and I wonder if I
manage to work on it just after getting back... Feel free to provide a patch 
which add such feature, then I will schedule it for inclusion to mainline.

> > Some not-well-documented example can be found here:
> > https://patchwork.kernel.org/patch/1323591/ (at the bottom).
> >
> > You probably might need to add your own custom dma_map_ops set of functions
> > for TILER device, but I'm not really sure if I get right what does that
> > device do and what will be the use cases for it.
> 
> I think we have three different cases how we need to manage the memory
> used for video on OMAP.
> 
> 1) Conventional case, without VRFB/TILER. We need large contiguous
> areas. I think we usually want both normal kernel and userspace mapping
> in this case, although some use cases could not need those.
> 
> 2) VRFB (omap3). In this case we need large contigous area, which is
> given to the VRFB hardware to be used as a storage. This area is never
> mapped. VRFB offers four rotated "views" (i.e. memory areas), which give
> a 0/90/180/270 degree view of the same image, and we will create mapping
> of these views with ioremap. The actual data is stored in the memory by
> VRFB in a proprietary format.
> 
> 3) TILER (omap4). I'm not too familiar with TILER, but afaik it's kinda
> like a better version of VRFB. In this case we don't need contiguous
> memory, but like VRFB, we never create mapping for the memory. (Rob,
> correct me if I'm wrong).
> 
> I think we can manage all of those with dma_alloc_attrs(), even though
> contiguous area is not really needed for TILER.

dma_alloc_attrs()/dma_alloc_coherent() plays with memory which is 
contiguous in the dma (io) address space. It doesn't need to be contiguous 
in physical memory if device has iommu (or iommu-like physical memory
interface).

> So, if I define DMA_ATTR_NO_KERNEL_MAPPING, there's no point in defining
> DMA_ATTR_WRITE_COMBINE at the same time, right?

Yes and no. It might be useful for creating userspace mappings on systems
which support write-combining. Please note that attributes which are not
supported by some systems are simply ignored. So if driver specifies both,
some systems might benefit from using NO_KERNEL_MAPPING, the other will 
benefit from WRITE_COMBINE mappings. Both can coexist without a single 
change to the device driver.

> Can I still create the kernel mapping for the allocated memory later,
> yielding the same result as if I would've omitted
> DMA_ATTR_NO_KERNEL_MAPPING?

Well, this will probably work, but it is not yet officially supported by the 
dma-mapping, but I'm aware of such use cases and specifying how to do it right
is also on my todo list.

> > > The second case is passing a framebuffer address from the bootloader to
> > > the kernel. Often with mobile devices the bootloader will initialize the
> > > display hardware, showing a company logo or such. To keep the image on
> > > the screen when kernel starts we need to reserve the same physical
> > > memory area early at boot, and use that for the framebuffer.
> > >
> > > I'm not sure if there's any actual problem with this one, presuming
> > > there is a solution for the first case. Somehow the memory is reserved
> > > at early boot time, and this is passed to the fb driver. But can the
> > > memory be managed the same way as in normal case (for example freeing
> > > it), or does it need to be handled as a special case?
> >
> > The only solution I see here is to use custom coherent memory pool for the
> > framebuffer device and setup it starting from the physical address of the
> > framebuffer configured by bootloader. See dma_declare_coherent() function.
> > Some usage example on ARM architecture can be found in
> > arch/arm/plat-samsung/s5p-dev-mfc.c
> >
> > The other possibility is to enable Contiguous Memory Allocator and define
> > a custom contiguous memory area for framebuffer device at the same
> > physical address as configured by bootloader:
> > http://git.linaro.org/gitweb?p=people/mszyprowski/linux-
> archive.git;a=commitdiff;h=f8ff4f99cfa4f67e09a3c948e007e82a0c21434a
> >
> > Feel free to comment both possibilities, maybe we can work out something
> > better for solving this quite common use case.
> 
> I think CMA is definitely the way to go.
> 
> But I'm not quite sure how it should be used in this case. I understand
> how to reserve the memory area at boot time, as the patch in your link
> shows, but how should the driver get the memory?

The driver allocates in a standard way - dma_alloc_{coherent,writecombine,attrs}().
It is up to dma-mapping framework to use the right memory regions basing on 
the passed device pointer. Exactly the same driver interface is used for 
dma_declare_coherent() memory regions which are not shared with the system.

> Normally the driver would just use dma_alloc_*, and the reserved CMA
> area would be used automatically, right?

Right.

> But in this case we want to get
> the allocation from a particular physical address of the private area.

The idea was to start the reserved area exactly at the address which is used
by bootloader to set the initial framebuffer. This way the first allocation 
will come from the beginning of such region fitting exactly into the initial 
framebuffer set by bootloader. I know that this is hacky, but right now I 
haven't found anything better, what might fit into the existing dma-mapping
api.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center


