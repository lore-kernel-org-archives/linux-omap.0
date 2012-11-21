From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] remaining omap multiplatform patches for v3.8 merge
 window
Date: Wed, 21 Nov 2012 09:42:19 -0800
Message-ID: <20121121174201.25576.61961.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:39403 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751821Ab2KURmV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Nov 2012 12:42:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are the remaining patches to be able to build omap2+
with multiplatform enabled. Booting requires disabling
ARM_ERRATA_751472 as discussed earlier. And then the
OMAP4_ERRATA_I688 can't be used currently.

These patches are based on a merge of the following branches
that are needed to keep things compiling:
     
- omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3
- omap-for-v3.8/clock
- omap-for-v3.8/cleanup-headers-iommu
- omap-for-v3.8/pm-part2
- Tomi's branch 3.8/vram-conversion
- Russell's branch omap-serial

There are few drivers still breaking because of their
use of plat/cpu.h and cpu_is_omap macros. The following
already have patches queued in linux next:

- drivers/staging/omapdrm/omap_drv.c
- drivers/staging/omapdrm/omap_dmm_tiler.h

The fixes to following have been already posted:

- drivers/crypto/omap-sham.c

And the following should have patches coming:

- drivers/mfd/omap-usb-host.c
- drivers/media/platform/omap/omap_voutlib.c
- drivers/media/platform/omap3isp/isp.c

But for now, the last patch in this series is for
testing only.

Regards,

Tony


---

Tony Lindgren (5):
      watchdog: OMAP: fixup for ARM multiplatform support
      ASoC: OMAP: mcbsp fixes for enabling ARM multiplatform support
      ARM: OMAP: Move plat/omap-serial.h to include/linux/platform_data/serial-omap.h
      ARM: OMAP: Move plat-omap/dma-omap.h to include/linux/omap-dma.h
      RFC: ARM: OMAP: Prepare Kconfig and Makefiles for enabling ARCH_MULTIPLATFORM


 arch/arm/Kconfig                                   |   13 +
 arch/arm/configs/omap2plus_defconfig               |    2 
 arch/arm/mach-omap1/board-h2.c                     |    2 
 arch/arm/mach-omap1/board-h3.c                     |    2 
 arch/arm/mach-omap1/board-palmte.c                 |    2 
 arch/arm/mach-omap1/board-palmtt.c                 |    2 
 arch/arm/mach-omap1/board-palmz71.c                |    2 
 arch/arm/mach-omap1/board-sx1.c                    |    2 
 arch/arm/mach-omap1/dma.c                          |    2 
 arch/arm/mach-omap1/io.c                           |    2 
 arch/arm/mach-omap1/lcd_dma.c                      |    2 
 arch/arm/mach-omap1/mcbsp.c                        |    2 
 arch/arm/mach-omap1/pm.c                           |    2 
 arch/arm/mach-omap2/Kconfig                        |   23 +
 arch/arm/mach-omap2/Makefile                       |    3 
 arch/arm/mach-omap2/board-3430sdp.c                |    2 
 arch/arm/mach-omap2/board-h4.c                     |    2 
 arch/arm/mach-omap2/board-rx51-peripherals.c       |    2 
 arch/arm/mach-omap2/board-rx51.c                   |    2 
 arch/arm/mach-omap2/devices.c                      |    2 
 arch/arm/mach-omap2/dma.c                          |    2 
 arch/arm/mach-omap2/io.c                           |    2 
 arch/arm/mach-omap2/mcbsp.c                        |    2 
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    2 
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    2 
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    3 
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    2 
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    2 
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    2 
 arch/arm/mach-omap2/pm24xx.c                       |    2 
 arch/arm/mach-omap2/pm34xx.c                       |    3 
 arch/arm/mach-omap2/serial.c                       |    4 
 arch/arm/plat-omap/Kconfig                         |   30 --
 arch/arm/plat-omap/Makefile                        |    2 
 arch/arm/plat-omap/dma.c                           |    2 
 arch/arm/plat-omap/include/plat-omap/dma-omap.h    |  377 --------------------
 drivers/crypto/omap-aes.c                          |    2 
 drivers/crypto/omap-sham.c                         |    2 
 drivers/dma/omap-dma.c                             |    2 
 drivers/media/platform/omap/omap_vout.c            |    2 
 drivers/media/platform/omap/omap_vout_vrfb.c       |    2 
 drivers/media/platform/omap3isp/ispstat.h          |    2 
 drivers/media/platform/soc_camera/omap1_camera.c   |    2 
 drivers/mtd/nand/omap2.c                           |    1 
 drivers/mtd/onenand/omap2.c                        |    2 
 drivers/tty/serial/omap-serial.c                   |    3 
 drivers/usb/gadget/omap_udc.c                      |    2 
 drivers/usb/musb/tusb6010_omap.c                   |    2 
 drivers/video/omap/lcdc.c                          |    2 
 drivers/video/omap/omapfb_main.c                   |    2 
 drivers/video/omap/sossi.c                         |    2 
 drivers/watchdog/omap_wdt.c                        |    2 
 include/linux/omap-dma.h                           |  366 +++++++++++++++++++
 include/linux/platform_data/serial-omap.h          |    0 
 sound/soc/omap/mcbsp.c                             |    4 
 sound/soc/omap/mcbsp.h                             |    6 
 sound/soc/omap/omap-mcbsp.c                        |    5 
 57 files changed, 457 insertions(+), 468 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat-omap/dma-omap.h
 rename arch/arm/plat-omap/include/plat/omap-serial.h => include/linux/platform_data/serial-omap.h (100%)

-- 
Signature
