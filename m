From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: OMAP VRAM patch set intro
Date: Thu, 27 Nov 2008 12:36:52 +0200
Message-ID: <1227782215-9325-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:21862 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754924AbYK0KhW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2008 05:37:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org


Hi,

This patch set is a prototype video ram allocator for OMAP for review.

The reasons I made this are:

- The DMA_CONSISTENT memory area is only 14M, and that may not be enough.
  1280*1024*4 framebuffer takes more than 5M. Three of those, and perhaps
  double buffering, and we are easily over the 14M limit.

- dma_alloc doesn't let you allocate big areas (I think the limit is ~4M).

- You can't specify the physical memory address where you want to alloc the
  memory. This is needed if the bootloader sets up the display and the kernel
  continues using that same memory area.

- dma_alloc doesn't support SRAM

At boot time memory areas (SDRAM or SRAM) defined in board file are reserved
with reserve_bootmem() or alloc_bootmem(). These areas are added to the VRAM
memory pool. Later on the OMAPFB or V4L2 devices can allocate needed memory
from the VRAM manager. If there's no VRAM left, the VRAM manager will fall back
to dma_alloc. The VRAM manager automatically mmaps the memory areas with
ioremap_wc() when the driver allocates VRAM.

The OMAPFB patch removes the old memory manager from dispc.c, which did mostly
the same thing as this one, and replaces it with this one.

Now some questions as I'm not too familiar with memory management:

Is it ok to use ioremap() to map SRAM/SDRAM? If not, how should the mapping be
done?

What actually are the types that should be used with physical and virtual
addresses here? dma_alloc() returns dma_addr_t and void * for physical and
virtual addresses. ioremap() takes unsigned long as physical address and
returns void __iomem *. What does __iomem mean? "This is pointer to memory that
is not RAM"?

How do other platforms implement video ram that is in the main memory?

Is it better to ioremap the whole VRAM area at boot time, or is it better to
ioremap the smaller pieces when the driver allocates memory?

Is it possible to not ioremap at all (in SDRAM case), but use the direct SDRAM
mapping that already exists? This would need modification of that mapping so
that the memory is not cached.

 Tomi Valkeinen

--

 arch/arm/mach-omap2/board-3430sdp.c      |   10 +
 arch/arm/plat-omap/Makefile              |    2 +-
 arch/arm/plat-omap/fb-vram.c             |  439 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/fb.c                  |   22 ++-
 arch/arm/plat-omap/include/mach/omapfb.h |    8 +
 drivers/video/omap/dispc.c               |  281 ++-----------------
 drivers/video/omap/omapfb_main.c         |   11 +-
 7 files changed, 504 insertions(+), 269 deletions(-)

