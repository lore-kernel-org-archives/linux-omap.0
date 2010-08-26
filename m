From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH 00/11] OMAP2/TWL: Fix Sparse warnings
Date: Fri, 27 Aug 2010 02:26:38 +0530
Message-ID: <1282856209-15645-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41770 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752251Ab0HZU5q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Aug 2010 16:57:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

This patch series fixes sparse warnings for OMAP and TWL code.
For better readabilty the patches are categorised based on type of
sparse warnigns.

The sparse warning logs are embedded with each patch followed
by fix.

Build and boot tested on omap3 with omap3_defconfig.

Manjunatha GK (11):
  OMAP: mach-omap2: Fix incorrect assignment warnings
  OMAP: mach-omap2: Fix static declaration warnings
  OMAP: mach-omap2: Fix static function warnings
  OMAP: mach-omap2: Fix miscellaneous sparse warnings
  OMAP: plat-omap: Fix static function warnings
  OMAP: McBSP: Fix static function warning
  OMAP: HSMMC: Fix unused variable warning
  OMAP: NAND: Fix static declaration warning
  TWL CORE: Fix sparse warning
  TWL IRQ: Fix fucntion declaration warnings
  TWL4030: Codec: Fix fucntion declaration error

 arch/arm/mach-omap2/board-am3517evm.c          |    5 +--
 arch/arm/mach-omap2/board-igep0020.c           |    4 +-
 arch/arm/mach-omap2/board-n8x0.c               |   16 +------------
 arch/arm/mach-omap2/board-omap3evm.c           |    4 +-
 arch/arm/mach-omap2/board-omap3stalker.c       |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c     |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c   |    2 +
 arch/arm/mach-omap2/board-rx51-sdram.c         |    2 +-
 arch/arm/mach-omap2/board-rx51-video.c         |    2 +
 arch/arm/mach-omap2/board-zoom-debugboard.c    |    2 +
 arch/arm/mach-omap2/board-zoom-peripherals.c   |    2 +
 arch/arm/mach-omap2/control.c                  |    5 ++-
 arch/arm/mach-omap2/include/mach/board-flash.h |    2 +
 arch/arm/mach-omap2/include/mach/board-rx51.h  |   11 +++++++++
 arch/arm/mach-omap2/irq.c                      |    2 +-
 arch/arm/mach-omap2/mux2420.c                  |    2 +-
 arch/arm/mach-omap2/mux2430.c                  |    2 +-
 arch/arm/mach-omap2/mux34xx.c                  |   12 +++++-----
 arch/arm/mach-omap2/pm-debug.c                 |    2 +-
 arch/arm/mach-omap2/pm34xx.c                   |    2 +-
 arch/arm/mach-omap2/powerdomain.c              |   28 ------------------------
 arch/arm/mach-omap2/prcm.c                     |    2 +-
 arch/arm/mach-omap2/timer-gp.c                 |    1 +
 arch/arm/plat-omap/cpu-omap.c                  |    4 +-
 arch/arm/plat-omap/fb.c                        |    1 +
 arch/arm/plat-omap/include/plat/dmtimer.h      |    4 ++-
 arch/arm/plat-omap/include/plat/sdrc.h         |    1 +
 arch/arm/plat-omap/mcbsp.c                     |   10 ++++----
 arch/arm/plat-omap/sram.c                      |   13 ++++++-----
 drivers/mfd/twl-core.c                         |    2 +-
 drivers/mmc/host/omap_hsmmc.c                  |    1 -
 drivers/mtd/nand/omap2.c                       |    4 +-
 include/linux/i2c/twl.h                        |    5 ++++
 include/linux/mfd/twl4030-codec.h              |    2 +-
 include/linux/omapfb.h                         |    5 ++++
 sound/soc/omap/omap-mcbsp.c                    |    2 +-
 36 files changed, 81 insertions(+), 87 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/board-rx51.h

Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
