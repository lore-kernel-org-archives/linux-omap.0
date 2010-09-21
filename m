From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v2 00/10] OMAP2/TWL: Fix Sparse warnings
Date: Tue, 21 Sep 2010 15:31:10 +0530
Message-ID: <1285063280-4057-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43422 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755497Ab0IUKBo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 06:01:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

This v2 version of sparse fixes series has review comments incorporated
which are archived at:
http://www.spinics.net/lists/linux-omap/msg35427.html

Out of total 11 patches in v1 series, three patches are dropped from this version
since two patches are accepted and already applied in other mailing lists.
The remaining one patch requires clarification on API usage in audio driver.

With 2.6.36-rc5, some more sparse warnings are introduced. For fixing these
new warnings, two new patches added into this series.

As per tony's suggestion, 
http://www.spinics.net/lists/linux-omap/msg36474.html

I have cc'ed respective maintainers and mailing lists for the patches and also
I will setup git branch for these patches for pull request if there are no 
further review comments.

Testing:
========
Patch series tested and verified with omap3_defconfig build and boot tested
on omap zoom3.

G, Manjunath Kondaiah (10):
  OMAP: mach-omap2: Fix miscellaneous sparse warnings
  OMAP: mach-omap2: Fix incorrect assignment warnings
  OMAP: mach-omap2: Fix static declaration warnings
  OMAP: mach-omap2: Fix static function warnings
  OMAP: plat-omap: Fix static function warnings
  OMAP: NAND: Fix static declaration warning
  TWL CORE: Fix sparse warning
  TWL IRQ: Fix fucntion declaration warnings
  OMAP2/3: Convert write/read functions to raw read/write
  OMAP3: Keypad: Fix incorrect type initializer

 arch/arm/mach-omap2/board-3430sdp.c            |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c          |    5 +--
 arch/arm/mach-omap2/board-cm-t35.c             |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c         |    2 +-
 arch/arm/mach-omap2/board-igep0020.c           |    4 +-
 arch/arm/mach-omap2/board-ldp.c                |    2 +-
 arch/arm/mach-omap2/board-n8x0.c               |   16 +------------
 arch/arm/mach-omap2/board-omap3evm.c           |    8 +++---
 arch/arm/mach-omap2/board-omap3stalker.c       |    4 +-
 arch/arm/mach-omap2/board-omap3touchbook.c     |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c   |    4 ++-
 arch/arm/mach-omap2/board-rx51-sdram.c         |    2 +-
 arch/arm/mach-omap2/board-rx51-video.c         |    2 +
 arch/arm/mach-omap2/board-zoom-debugboard.c    |    2 +
 arch/arm/mach-omap2/board-zoom-peripherals.c   |    4 ++-
 arch/arm/mach-omap2/control.c                  |    5 ++-
 arch/arm/mach-omap2/gpmc-onenand.c             |    8 +++---
 arch/arm/mach-omap2/include/mach/board-flash.h |    2 +
 arch/arm/mach-omap2/include/mach/board-rx51.h  |   11 +++++++++
 arch/arm/mach-omap2/irq.c                      |    1 -
 arch/arm/mach-omap2/mux2420.c                  |    2 +-
 arch/arm/mach-omap2/mux2430.c                  |    2 +-
 arch/arm/mach-omap2/mux34xx.c                  |   12 +++++-----
 arch/arm/mach-omap2/pm-debug.c                 |    2 +-
 arch/arm/mach-omap2/pm34xx.c                   |    2 +-
 arch/arm/mach-omap2/powerdomain.c              |   28 ------------------------
 arch/arm/mach-omap2/prcm.c                     |    2 +-
 arch/arm/mach-omap2/timer-gp.c                 |    1 +
 arch/arm/plat-omap/cpu-omap.c                  |    4 +-
 arch/arm/plat-omap/dmtimer.c                   |    6 ++--
 arch/arm/plat-omap/fb.c                        |    1 +
 arch/arm/plat-omap/include/plat/dmtimer.h      |    4 ++-
 arch/arm/plat-omap/include/plat/sdrc.h         |    1 +
 arch/arm/plat-omap/mcbsp.c                     |   10 ++++----
 arch/arm/plat-omap/sram.c                      |   13 ++++++-----
 drivers/mfd/twl-core.c                         |    2 +-
 drivers/mtd/nand/omap2.c                       |    6 ++--
 drivers/mtd/onenand/omap2.c                    |    2 +-
 include/linux/i2c/twl.h                        |    5 ++++
 include/linux/omapfb.h                         |    5 ++++
 40 files changed, 96 insertions(+), 102 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/board-rx51.h

Cc: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
