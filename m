From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V2 0/7] ARM: OMAP: Move plat/dma*.h,omap-secure.h headers as part of single zImage work
Date: Tue, 2 Oct 2012 00:16:59 +0530
Message-ID: <1349117226-4980-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37024 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab2JASrX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Oct 2012 14:47:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, lokeshvutla@ti.com

Patch 1:
	Dropping the file plat/dma44xx.h as none of the omap44xx
	dma channel definitions are used.
Patch 2:
	Moving OMAP1 DMA channel definitions to mach-omap1
Patch 3:
	Moving OMAP2+ DMA channel definitions to mach-omap2
Patch 4:
	Moving plat/dma.h to plat-omap/dma-omap.h
Patch 5:
	Removing omap_reserve() callback from all omap1 board files.
Patch 6:
	Defining omap_reserve() locally to mach-omap2.
Patch 7:
	Move plat/omap-secure.h locally to mach-omap2

Lokesh Vutla (7):
  ARM: OMAP: DMA: Removing plat/dma-44xx.h
  ARM: OMAP1: DMA: Moving OMAP1 DMA channel definitions to mach-omap1
  ARM: OMAP2+: DMA: Moving OMAP2 DMA channel definitions to mach-omap2
  ARM: OMAP: DMA: Move plat/dma.h to plat-omap/dma-omap.h
  ARM: OMAP1: Remove omap_reserve() callback for all omap1 boards
  ARM: OMAP2+: Move omap_reserve() locally to mach-omap2
  ARM: OMAP: Move plat/omap-secure.h locally to mach-omap2

 arch/arm/mach-omap1/board-ams-delta.c              |    1 -
 arch/arm/mach-omap1/board-fsample.c                |    1 -
 arch/arm/mach-omap1/board-generic.c                |    1 -
 arch/arm/mach-omap1/board-h2.c                     |    4 +-
 arch/arm/mach-omap1/board-h3.c                     |    3 +-
 arch/arm/mach-omap1/board-htcherald.c              |    1 -
 arch/arm/mach-omap1/board-innovator.c              |    1 -
 arch/arm/mach-omap1/board-nokia770.c               |    1 -
 arch/arm/mach-omap1/board-osk.c                    |    1 -
 arch/arm/mach-omap1/board-palmte.c                 |    4 +-
 arch/arm/mach-omap1/board-palmtt.c                 |    4 +-
 arch/arm/mach-omap1/board-palmz71.c                |    4 +-
 arch/arm/mach-omap1/board-perseus2.c               |    1 -
 arch/arm/mach-omap1/board-sx1.c                    |    4 +-
 arch/arm/mach-omap1/board-voiceblue.c              |    1 -
 arch/arm/mach-omap1/devices.c                      |    3 +-
 arch/arm/mach-omap1/dma.c                          |    4 +-
 arch/arm/mach-omap1/dma.h                          |   83 +++++++++
 arch/arm/mach-omap1/io.c                           |    2 +-
 arch/arm/mach-omap1/lcd_dma.c                      |    4 +-
 arch/arm/mach-omap1/mcbsp.c                        |    3 +-
 arch/arm/mach-omap1/pm.c                           |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-h4.c                     |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |    2 +-
 arch/arm/mach-omap2/board-rx51.c                   |    2 +-
 arch/arm/mach-omap2/common.c                       |   20 +++
 arch/arm/mach-omap2/common.h                       |    1 +
 arch/arm/mach-omap2/devices.c                      |    3 +-
 arch/arm/mach-omap2/dma.c                          |    2 +-
 arch/arm/mach-omap2/dma.h                          |  131 ++++++++++++++
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
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    3 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    2 +-
 arch/arm/mach-omap2/pm24xx.c                       |    2 +-
 arch/arm/mach-omap2/pm34xx.c                       |    2 +-
 arch/arm/mach-omap2/serial.c                       |    2 +-
 arch/arm/plat-omap/common.c                        |   23 +--
 arch/arm/plat-omap/dma.c                           |    2 +-
 .../include/{plat/dma.h => plat-omap/dma-omap.h}   |  181 +-------------------
 arch/arm/plat-omap/include/plat/common.h           |    1 -
 arch/arm/plat-omap/include/plat/dma-44xx.h         |  147 ----------------
 arch/arm/plat-omap/include/plat/omap-secure.h      |   14 --
 drivers/crypto/omap-aes.c                          |    2 +-
 drivers/crypto/omap-sham.c                         |    2 +-
 drivers/dma/omap-dma.c                             |    2 +-
 drivers/media/platform/omap/omap_vout.c            |    2 +-
 drivers/media/platform/omap/omap_vout_vrfb.c       |    4 +-
 drivers/media/platform/omap3isp/isphist.c          |    2 +
 drivers/media/platform/omap3isp/ispstat.h          |    2 +-
 drivers/media/platform/soc_camera/omap1_camera.c   |    4 +-
 drivers/mmc/host/omap.c                            |   12 +-
 drivers/mtd/nand/omap2.c                           |    4 +-
 drivers/mtd/onenand/omap2.c                        |    2 +-
 drivers/usb/gadget/omap_udc.c                      |    4 +-
 drivers/usb/musb/tusb6010_omap.c                   |    9 +-
 drivers/video/omap/lcdc.c                          |    2 +-
 drivers/video/omap/omapfb_main.c                   |    2 +-
 drivers/video/omap/sossi.c                         |    2 +-
 68 files changed, 331 insertions(+), 428 deletions(-)
 create mode 100644 arch/arm/mach-omap1/dma.h
 create mode 100644 arch/arm/mach-omap2/dma.h
 rename arch/arm/plat-omap/include/{plat/dma.h => plat-omap/dma-omap.h} (61%)
 delete mode 100644 arch/arm/plat-omap/include/plat/dma-44xx.h
 delete mode 100644 arch/arm/plat-omap/include/plat/omap-secure.h

-- 
1.7.10.4

