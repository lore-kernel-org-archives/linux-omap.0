From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/8] Flip on multiplatform support for omap2plus for v3.9
Date: Wed, 19 Dec 2012 11:26:11 -0800
Message-ID: <20121219192354.22098.33408.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:61771 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751521Ab2LST0O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 14:26:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

These patches enable multiplatform support for omap2plus.

To build and boot it against the current mainline kernel
you need the following:

[PATCH 1/2] ARM: l2x0: Only set .set_debug on PL310 r3p0 and earlier
[PATCH 2/2] ARM: disable errata work-arounds which access secure registers
[GIT PULL 1/2] omap fixes for v3.8 merge window
[GIT PULL 2/2] omap cleanup for v3.8 merge window
[GIT PULL] two trivial omap build error fixes for v3.8 merge window
cpts: Fix build error caused by include of plat/clock.h

Regards,

Tony

---

Tony Lindgren (8):
      ARM: OMAP2+: Limi omap initcalls to omap only on multiplatform kernels
      ARM: OMAP2+: Use omap initcalls
      ARM: OMAP: Fix i2c cmdline initcall for multiplatform
      ARM: OMAP: Fix dmaengine init for multiplatform
      ARM: OMAP2+: Add multiplatform debug_ll support
      ARM: OMAP2+: Disable code that currently does not work with multiplaform
      ARM: OMAP2+: Enable ARCH_MULTIPLATFORM support
      ARM: OMAP2+: Add minimal support for booting vexpress


 arch/arm/Kconfig                         |   13 ++
 arch/arm/Kconfig.debug                   |   56 +++++++++
 arch/arm/configs/omap2plus_defconfig     |    6 +
 arch/arm/include/debug/omap2plus.S       |  190 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap1/dma.c                |   18 +++
 arch/arm/mach-omap1/i2c.c                |    6 +
 arch/arm/mach-omap2/Kconfig              |   25 ++++
 arch/arm/mach-omap2/Makefile             |    3 
 arch/arm/mach-omap2/board-omap3beagle.c  |    2 
 arch/arm/mach-omap2/board-rx51-video.c   |    3 
 arch/arm/mach-omap2/clock2xxx.c          |    2 
 arch/arm/mach-omap2/clock3xxx.c          |    2 
 arch/arm/mach-omap2/devices.c            |    6 -
 arch/arm/mach-omap2/dma.c                |   23 +++-
 arch/arm/mach-omap2/drm.c                |    2 
 arch/arm/mach-omap2/emu.c                |    2 
 arch/arm/mach-omap2/fb.c                 |    4 -
 arch/arm/mach-omap2/gpio.c               |    5 -
 arch/arm/mach-omap2/gpmc.c               |    4 -
 arch/arm/mach-omap2/hdq1w.c              |    3 
 arch/arm/mach-omap2/hwspinlock.c         |    2 
 arch/arm/mach-omap2/i2c.c                |    5 +
 arch/arm/mach-omap2/mcbsp.c              |    3 
 arch/arm/mach-omap2/omap-iommu.c         |    2 
 arch/arm/mach-omap2/omap2-restart.c      |    3 
 arch/arm/mach-omap2/omap4-common.c       |    4 -
 arch/arm/mach-omap2/omap_device.c        |    5 -
 arch/arm/mach-omap2/omap_hwmod.c         |    2 
 arch/arm/mach-omap2/omap_phy_internal.c  |    2 
 arch/arm/mach-omap2/opp3xxx_data.c       |    2 
 arch/arm/mach-omap2/opp4xxx_data.c       |    2 
 arch/arm/mach-omap2/pm-debug.c           |    2 
 arch/arm/mach-omap2/pm.c                 |    2 
 arch/arm/mach-omap2/pmu.c                |    2 
 arch/arm/mach-omap2/prm3xxx.c            |    2 
 arch/arm/mach-omap2/prm44xx.c            |    2 
 arch/arm/mach-omap2/serial.c             |    2 
 arch/arm/mach-omap2/smartreflex-class3.c |    2 
 arch/arm/mach-omap2/soc.h                |   29 +++++
 arch/arm/mach-omap2/timer.c              |    2 
 arch/arm/mach-omap2/wd_timer.c           |    2 
 arch/arm/plat-omap/Kconfig               |   30 -----
 arch/arm/plat-omap/Makefile              |    2 
 arch/arm/plat-omap/i2c.c                 |    3 
 arch/arm/plat-omap/include/plat/i2c.h    |    6 +
 drivers/crypto/omap-sham.c               |    3 
 drivers/dma/omap-dma.c                   |   20 ---
 drivers/media/rc/Kconfig                 |    2 
 drivers/staging/tidspbridge/Kconfig      |    2 
 49 files changed, 422 insertions(+), 100 deletions(-)
 create mode 100644 arch/arm/include/debug/omap2plus.S

-- 
Signature
