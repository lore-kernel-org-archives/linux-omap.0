From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/11] Fix relative includes for omaps introduced by recent
 clean-up
Date: Tue, 30 Oct 2012 16:52:38 -0700
Message-ID: <20121030234852.25936.12482.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56188 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753291Ab2J3Xwk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 19:52:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

As discussed on this list, here are fixes to get rid of
the relative includes for omap that got introduced with
the recent clean-up.

This is based on what I have queued up in the
omap-for-v3.8/cleanup-headers branch at commit 986bfa5c.

Note that this series introduces few new plat/*.h files.
However, those files will not be used by the drivers:

sram.h
i2c.h
counter-32k.h
debug-devices.h

We still want to remove the remaining problem plat
headers as they are wrongly shared between drivers
and core omap code:

iommu2.h
iommu.h
iopgtable.h
iovmm.h
mailbox.h
omap-serial.h
prcm.h
vram.h

These headers will not work for omap2+ drivers when
we have CONFIG_MULTIPLATFORM set.

Regards,

Tony

---

Tony Lindgren (11):
      ARM: OMAP: Split sram.h to local headers and minimal shared header
      ARM: OMAP: Introduce common omap_map_sram() and omap_sram_reset()
      ARM: OMAP: Move omap1 specific code to local sram.c
      ARM: OMAP: Move omap2+ specific parts of sram.c to mach-omap2
      ARM: OMAP: Make plat-omap/i2c.c port checks local
      ARM: OMAP: Fix relative includes for shared i2c.h file
      ARM: OMAP: Move omap-pm-noop.c local to mach-omap2
      ARM: OMAP: Remove plat-omap/common.h
      ARM: OMAP: Fix relative includes for debug-devices.h
      ARM: OMAP: Remove cpu_is_omap usage from plat-omap/dma.c
      ARM: OMAP1: Remove relative includes


 arch/arm/mach-omap1/Makefile                       |    3 
 arch/arm/mach-omap1/clock.c                        |    3 
 arch/arm/mach-omap1/clock_data.c                   |    3 
 arch/arm/mach-omap1/common.h                       |    3 
 arch/arm/mach-omap1/devices.c                      |    3 
 arch/arm/mach-omap1/dma.c                          |    3 
 arch/arm/mach-omap1/i2c.c                          |    5 
 arch/arm/mach-omap1/include/mach/entry-macro.S     |    2 
 arch/arm/mach-omap1/include/mach/hardware.h        |    5 
 arch/arm/mach-omap1/include/mach/memory.h          |    2 
 arch/arm/mach-omap1/include/mach/soc.h             |  229 +++++++++++++
 arch/arm/mach-omap1/iomap.h                        |    3 
 arch/arm/mach-omap1/pm.c                           |    4 
 arch/arm/mach-omap1/sleep.S                        |    2 
 arch/arm/mach-omap1/soc.h                          |  229 -------------
 arch/arm/mach-omap1/sram-init.c                    |   76 ++++
 arch/arm/mach-omap1/sram.h                         |    7 
 arch/arm/mach-omap1/timer32k.c                     |    1 
 arch/arm/mach-omap2/Makefile                       |    3 
 arch/arm/mach-omap2/board-h4.c                     |    2 
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c            |    3 
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c       |    3 
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c             |    3 
 arch/arm/mach-omap2/cm33xx.c                       |    2 
 arch/arm/mach-omap2/common.h                       |    5 
 arch/arm/mach-omap2/dma.c                          |    3 
 arch/arm/mach-omap2/i2c.c                          |   16 +
 arch/arm/mach-omap2/i2c.h                          |    2 
 arch/arm/mach-omap2/io.c                           |    3 
 arch/arm/mach-omap2/omap-pm-noop.c                 |    4 
 arch/arm/mach-omap2/omap4-common.c                 |    2 
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    2 
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    2 
 arch/arm/mach-omap2/pm24xx.c                       |    5 
 arch/arm/mach-omap2/pm34xx.c                       |    4 
 arch/arm/mach-omap2/prm33xx.c                      |    2 
 arch/arm/mach-omap2/prm_common.c                   |    1 
 arch/arm/mach-omap2/sdrc.c                         |    2 
 arch/arm/mach-omap2/sdrc2xxx.c                     |    3 
 arch/arm/mach-omap2/sleep34xx.S                    |    3 
 arch/arm/mach-omap2/sram.c                         |  305 +++++++++++++++++
 arch/arm/mach-omap2/sram.h                         |   26 -
 arch/arm/mach-omap2/timer.c                        |    3 
 arch/arm/plat-omap/Makefile                        |    1 
 arch/arm/plat-omap/common.c                        |    1 
 arch/arm/plat-omap/common.h                        |   36 --
 arch/arm/plat-omap/counter_32k.c                   |    2 
 arch/arm/plat-omap/debug-devices.c                 |    2 
 arch/arm/plat-omap/dma.c                           |  108 +++---
 arch/arm/plat-omap/dmtimer.c                       |   17 +
 arch/arm/plat-omap/i2c.c                           |   30 --
 arch/arm/plat-omap/include/plat-omap/dma-omap.h    |   19 +
 arch/arm/plat-omap/include/plat/counter-32k.h      |    1 
 arch/arm/plat-omap/include/plat/debug-devices.h    |    7 
 arch/arm/plat-omap/include/plat/dmtimer.h          |    2 
 arch/arm/plat-omap/include/plat/i2c.h              |    0 
 arch/arm/plat-omap/include/plat/sram.h             |   16 +
 arch/arm/plat-omap/sram.c                          |  366 ++------------------
 drivers/dma/omap-dma.c                             |    6 
 59 files changed, 815 insertions(+), 791 deletions(-)
 create mode 100644 arch/arm/mach-omap1/include/mach/soc.h
 create mode 100644 arch/arm/mach-omap1/sram-init.c
 create mode 100644 arch/arm/mach-omap1/sram.h
 rename arch/arm/{plat-omap/omap-pm-noop.c => mach-omap2/omap-pm-noop.c} (99%)
 create mode 100644 arch/arm/mach-omap2/sram.c
 rename arch/arm/{plat-omap/sram.h => mach-omap2/sram.h} (79%)
 delete mode 100644 arch/arm/plat-omap/common.h
 create mode 100644 arch/arm/plat-omap/include/plat/counter-32k.h
 rename arch/arm/{mach-omap2/debug-devices.h => plat-omap/include/plat/debug-devices.h} (54%)
 rename arch/arm/plat-omap/{i2c.h => include/plat/i2c.h} (100%)
 create mode 100644 arch/arm/plat-omap/include/plat/sram.h

-- 
Signature
