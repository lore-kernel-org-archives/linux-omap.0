From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/5] OMAPFB: use dma_alloc instead of omap's vram
Date: Mon, 12 Nov 2012 12:25:01 +0200
Message-ID: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35775 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851Ab2KLKZQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Nov 2012 05:25:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

This series changes omapfb to use standard dma_alloc funcs instead of omap
specific vram allocator. This let's us remove the omap vram allocator, making
omapfb platform independent.

However, note that using standard dma funcs causes the following downsides:

1) dma_alloc_attrs doesn't let us allocate at certain physical address.
However, this should not be a problem as this feature of vram allocator
is only used when reserving the framebuffer that was initialized by the
bootloader, and we don't currently support "passing" a framebuffer from
the bootloader to the kernel anyway.

2) dma_alloc_attrs, as of now, always ioremaps the allocated area, and
we don't need the ioremap when using VRFB. This patch uses
DMA_ATTR_NO_KERNEL_MAPPING for the allocation, but the flag is currently
not operational.

3) OMAPFB_GET_VRAM_INFO ioctl cannot return real values anymore. I
changed the ioctl to return 64M for all the values, which, I hope, the
applications will interpret as "there's enough vram".

4) "vram" kernel parameter to define how much ram to reserve for video use no
longer works. The user needs to enable CMA and use "cma" parameter.

 Tomi

Tomi Valkeinen (5):
  OMAP: FB: use DMA_BIT_MASK() for fb's coherent_dma_mask
  OMAPFB: use dma_alloc_attrs to allocate memory
  OMAP: RX51: remove use of vram
  OMAP: common.c: remove init call to vram
  OMAP: remove vram allocator

 arch/arm/mach-omap2/board-rx51-video.c    |   14 -
 arch/arm/mach-omap2/board-rx51.c          |    3 -
 arch/arm/plat-omap/common.c               |    2 -
 arch/arm/plat-omap/fb.c                   |    5 +-
 arch/arm/plat-omap/include/plat/vram.h    |   43 ---
 drivers/video/omap2/Kconfig               |    3 -
 drivers/video/omap2/Makefile              |    1 -
 drivers/video/omap2/dss/Kconfig           |   12 -
 drivers/video/omap2/omapfb/Kconfig        |    1 -
 drivers/video/omap2/omapfb/omapfb-ioctl.c |   14 +-
 drivers/video/omap2/omapfb/omapfb-main.c  |   69 ++--
 drivers/video/omap2/omapfb/omapfb.h       |    5 +
 drivers/video/omap2/vram.c                |  514 -----------------------------
 13 files changed, 51 insertions(+), 635 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/vram.h
 delete mode 100644 drivers/video/omap2/vram.c

-- 
1.7.10.4

