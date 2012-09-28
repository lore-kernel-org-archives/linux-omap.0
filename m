From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 0/4] ARM: OMAP: Move plat/dma*.h,omap-secure.h headers as part of single zImage work
Date: Fri, 28 Sep 2012 19:10:05 +0530
Message-ID: <1348839609-10456-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59995 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757898Ab2I1NkW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 09:40:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, lokeshvutla@ti.com

Patch 1: 
	Dropping the file plat/dma44xx.h as none of the 
	dma channel definitions are used.
Patch 2:
	Moving plat/dma.h to platform_data/dma-omap.h
Patch 3:
	Move omap_reserve() locally to mach-omap1/2
	This helps in moving plat/omap-secure.h locally to mach-omap2
Patch 4:
	Move plat/omap-secure.h locally to mach-omap2

Lokesh Vutla (4):
  ARM: OMAP: DMA: Removing plat/dma-44xx.h
  ARM: OMAP: DMA: Move plat/dma hearder to platform_data/dma-omap
  ARM: OMAP: Move omap_reserve() locally to mach-omap1/2
  ARM: OMAP: Move plat/omap-secure.h locally to mach-omap2

 arch/arm/mach-omap1/board-h2.c                     |    2 +-
 arch/arm/mach-omap1/board-h3.c                     |    2 +-
 arch/arm/mach-omap1/board-palmte.c                 |    2 +-
 arch/arm/mach-omap1/board-palmtt.c                 |    2 +-
 arch/arm/mach-omap1/board-palmz71.c                |    2 +-
 arch/arm/mach-omap1/board-sx1.c                    |    2 +-
 arch/arm/mach-omap1/common.h                       |    3 +
 arch/arm/mach-omap1/devices.c                      |    2 +-
 arch/arm/mach-omap1/dma.c                          |    2 +-
 arch/arm/mach-omap1/io.c                           |    2 +-
 arch/arm/mach-omap1/lcd_dma.c                      |    3 +-
 arch/arm/mach-omap1/mcbsp.c                        |    2 +-
 arch/arm/mach-omap1/pm.c                           |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-h4.c                     |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |    2 +-
 arch/arm/mach-omap2/board-rx51.c                   |    2 +-
 arch/arm/mach-omap2/common.c                       |   20 +++
 arch/arm/mach-omap2/common.h                       |    1 +
 arch/arm/mach-omap2/devices.c                      |    2 +-
 arch/arm/mach-omap2/dma.c                          |    2 +-
 arch/arm/mach-omap2/io.c                           |    2 +-
 arch/arm/mach-omap2/mcbsp.c                        |    2 +-
 arch/arm/mach-omap2/omap-secure.c                  |    1 -
 arch/arm/mach-omap2/omap-secure.h                  |    7 +
 arch/arm/mach-omap2/omap4-common.c                 |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    2 +-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    3 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    2 +-
 arch/arm/mach-omap2/pm24xx.c                       |    2 +-
 arch/arm/mach-omap2/pm34xx.c                       |    2 +-
 arch/arm/mach-omap2/serial.c                       |    2 +-
 arch/arm/plat-omap/common.c                        |   21 +--
 arch/arm/plat-omap/dma.c                           |    2 +-
 arch/arm/plat-omap/include/plat/common.h           |    1 -
 arch/arm/plat-omap/include/plat/dma-44xx.h         |  147 --------------------
 arch/arm/plat-omap/include/plat/omap-secure.h      |   14 --
 drivers/crypto/omap-aes.c                          |    2 +-
 drivers/crypto/omap-sham.c                         |    3 +-
 drivers/dma/omap-dma.c                             |    2 +-
 drivers/media/platform/omap/omap_vout.c            |    2 +-
 drivers/media/platform/omap/omap_vout_vrfb.c       |    2 +-
 drivers/media/platform/omap3isp/ispstat.h          |    3 +-
 drivers/media/platform/soc_camera/omap1_camera.c   |    4 +-
 drivers/mmc/host/omap.c                            |    2 +-
 drivers/mtd/nand/omap2.c                           |    2 +-
 drivers/mtd/onenand/omap2.c                        |    2 +-
 drivers/usb/gadget/omap_udc.c                      |    3 +-
 drivers/usb/musb/tusb6010_omap.c                   |    2 +-
 drivers/video/omap/lcdc.c                          |    2 +-
 drivers/video/omap/omapfb_main.c                   |    3 +-
 drivers/video/omap/sossi.c                         |    3 +-
 .../linux/platform_data/dma-omap.h                 |    5 +-
 57 files changed, 83 insertions(+), 240 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/dma-44xx.h
 delete mode 100644 arch/arm/plat-omap/include/plat/omap-secure.h
 rename arch/arm/plat-omap/include/plat/dma.h => include/linux/platform_data/dma-omap.h (99%)

-- 
1.7.10.4

