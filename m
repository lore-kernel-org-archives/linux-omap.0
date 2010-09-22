From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [GIT PULL] omap2 sparse fixes
Date: Wed, 22 Sep 2010 14:26:12 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402785A390E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50351 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab0IVI41 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 04:56:27 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,
 
Please pull omap2 sparse fixes from:
 
  git://dev.omapzoom.org/pub/scm/manju/kernel-omap3-dev.git sparse_fixes
 
Regards,
Manjunath
 
 
The following changes since commit 8b15575cae7a93a784c3005c42b069edd9ba64dd:
  Sage Weil (1):
        fs: {lock,unlock}_flocks() stubs to prepare for BKL removal
 
are available in the git repository at:
 
  git://dev.omapzoom.org/pub/scm/manju/kernel-omap3-dev.git sparse_fixes
 
G, Manjunath Kondaiah (10):
      OMAP: mach-omap2: Fix incorrect assignment warnings
      OMAP: mach-omap2: Fix static declaration warnings
      OMAP: mach-omap2: Fix static function warnings
      OMAP: mach-omap2: Fix miscellaneous sparse warnings
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