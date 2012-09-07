From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: Converting OMAP's custom vram allocator
Date: Fri, 07 Sep 2012 07:55:47 +0200
Message-ID: <019b01cd8cbd$6fef8c50$4fcea4f0$%szyprowski@samsung.com>
References: <1346839733.32747.1.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:40620 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab2IGFz7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 01:55:59 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M9Y00C7WTTABI80@mailout4.samsung.com> for
 linux-omap@vger.kernel.org; Fri, 07 Sep 2012 14:55:58 +0900 (KST)
Received: from AMDC159 ([106.116.147.30])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M9Y006VPTT02460@mmp1.samsung.com> for
 linux-omap@vger.kernel.org; Fri, 07 Sep 2012 14:55:58 +0900 (KST)
In-reply-to: <1346839733.32747.1.camel@deskari>
Content-language: pl
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org, 'linux-omap' <linux-omap@vger.kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>

Hello,

On Wednesday, September 05, 2012 12:09 PM Tomi Valkeinen wrote:

> OMAP has a custom video ram allocator, which I'd like to remove and use
> the standard dma allocation functions.
> 
> There are two problems for which I'd like to hear suggestions or
> comments:
> 
> First one is that the dma_alloc_* functions map the allocated memory for
> cpu use. In many cases with OMAP DSS (display subsystem) this is not
> needed: the memory may be written only by the SGX or the DSP, and it's
> only read by the DSS, so it's never touched by the CPU.
> 
> This is even more true when using VRFB on omap3 (and probably TILER on
> omap4) for rotation, as VRFB hides the actual memory and offers rotated
> views. In this case the backend memory is never accessed by anyone else
> than VRFB.
> 
> Is there a way to allocate the memory without creating a mapping? While
> it won't break anything as such, the allocated areas can be quite large
> thus causing large areas of the kernel's memory space to be needlessly
> reserved.

Please check commits d5724f172fd1 and 955c757e090 merged to v3.6-rc1. 
Support for this attribute is now only available in IOMMU-aware 
dma-mapping implementation, but I plan to add it also to standard linear
ARM dma-mapping implementation based on alloc_pages_exact().

Some not-well-documented example can be found here: 
https://patchwork.kernel.org/patch/1323591/ (at the bottom).

You probably might need to add your own custom dma_map_ops set of functions
for TILER device, but I'm not really sure if I get right what does that 
device do and what will be the use cases for it.

 
> The second case is passing a framebuffer address from the bootloader to
> the kernel. Often with mobile devices the bootloader will initialize the
> display hardware, showing a company logo or such. To keep the image on
> the screen when kernel starts we need to reserve the same physical
> memory area early at boot, and use that for the framebuffer.
> 
> I'm not sure if there's any actual problem with this one, presuming
> there is a solution for the first case. Somehow the memory is reserved
> at early boot time, and this is passed to the fb driver. But can the
> memory be managed the same way as in normal case (for example freeing
> it), or does it need to be handled as a special case?

The only solution I see here is to use custom coherent memory pool for the
framebuffer device and setup it starting from the physical address of the
framebuffer configured by bootloader. See dma_declare_coherent() function.
Some usage example on ARM architecture can be found in 
arch/arm/plat-samsung/s5p-dev-mfc.c

The other possibility is to enable Contiguous Memory Allocator and define
a custom contiguous memory area for framebuffer device at the same 
physical address as configured by bootloader:
http://git.linaro.org/gitweb?p=people/mszyprowski/linux-archive.git;a=commitdiff;h=f8ff4f99cfa4f67e09a3c948e007e82a0c21434a

Feel free to comment both possibilities, maybe we can work out something
better for solving this quite common use case.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center


