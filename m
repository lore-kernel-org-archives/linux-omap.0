From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v1 00/14] ARM: OMAP5: Add minimal OMAP5 SOC support
Date: Thu, 5 Jul 2012 17:38:38 +0530
Message-ID: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33877 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753655Ab2GEMKi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Jul 2012 08:10:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Tony,

The series adds minimal OMAP5 support. OMAP5430 has a dual core Cortex-A15
based MPU subsystem with 2MB L2 cache. The SOC has many compatible blocks
with OMAP4 SOCS and hence large part of the peripherals are re-used.

OMAP5432 is another variant of OMAP5430, with a memory controller supporting
DDR3 and SATA.

Series is generated against cleanup-part2 branch at commit 74dd9ec6.

BOOT tested:
- OMAP4430 SDP
- OMAP3430 SDP
- OMAP3430 SDP
- OMAP5430 EVM with OMAP5 hwmod/PRM?CM data files.

Build testd:
- OMAP1 only build, OMAP[2/3/4/5] Only builds.

The following changes since commit 74dd9ec627582bfd4477f01ceeaaa3f54e3748b8:

  ARM: OMAP: dmtimer: use devm_ API and do some cleanup in probe() (2012-07-05 02:15:55 -0700)

are available in the git repository at:

  git://github.com/SantoshShilimkar/linux.git for_3.6/omap5_minimal_support

for you to fetch changes up to c78c1186f5c88fe16070a6860d4843ce74200bcd:

  ARM: Kconfig update to support additional GPIOs in OMAP5 (2012-07-05 16:18:44 +0530)

----------------------------------------------------------------

R Sricharan (11):
  ARM: OMAP2+: Move stubbed secure_sram_reserve function to a common.c
    and call it __weak
  ARM: OMAP: counter-32k: Select the CR register offset using the IP
    scheme.
  ARM: OMAP5: id: Add cpu id for ES versions
  ARM: OMAP5: Add minimal support for OMAP5430 SOC
  ARM: OMAP5: timer: Add clocksource, clockevent support
  ARM: OMAP5: gpmc: Update gpmc_init()
  ARM: OMAP5: l3: Add l3 error handler support for omap5.
  ARM: omap2+: board-generic: clean up the irq data from board file.
  ARM: OMAP5: board-generic: Add device tree support.
  arm/dts: OMAP5: Add omap5 dts files
  ARM: OMAP5: Add the build support

Santosh Shilimkar (2):
  ARM: OMAP5: Add the WakeupGen IP updates
  ARM: OMAP5: Add SMP support.

Tarun Kanti DebBarma (1):
  ARM: Kconfig update to support additional GPIOs in OMAP5

 .../devicetree/bindings/arm/omap/omap.txt          |    3 +
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/omap5-evm.dts                    |   20 +++
 arch/arm/boot/dts/omap5.dtsi                       |  184 ++++++++++++++++++++
 arch/arm/configs/omap2plus_defconfig               |    1 +
 arch/arm/mach-omap2/Kconfig                        |    6 +
 arch/arm/mach-omap2/Makefile                       |   24 ++-
 arch/arm/mach-omap2/board-generic.c                |   42 +++--
 arch/arm/mach-omap2/common.c                       |   24 +++
 arch/arm/mach-omap2/common.h                       |   19 +-
 arch/arm/mach-omap2/control.h                      |    4 +
 arch/arm/mach-omap2/devices.c                      |    2 +-
 arch/arm/mach-omap2/gpmc.c                         |    3 +-
 arch/arm/mach-omap2/id.c                           |   42 ++++-
 arch/arm/mach-omap2/include/mach/debug-macro.S     |    8 +-
 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h  |    7 +
 arch/arm/mach-omap2/io.c                           |   44 +++++
 arch/arm/mach-omap2/iomap.h                        |   27 +++
 arch/arm/mach-omap2/irq.c                          |   13 +-
 arch/arm/mach-omap2/omap-headsmp.S                 |   21 +++
 arch/arm/mach-omap2/omap-hotplug.c                 |   24 ++-
 arch/arm/mach-omap2/omap-smp.c                     |   52 ++++--
 arch/arm/mach-omap2/omap-wakeupgen.c               |  114 +++++++++---
 arch/arm/mach-omap2/omap4-common.c                 |   14 ++
 arch/arm/mach-omap2/omap4-sar-layout.h             |   12 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |    2 +-
 arch/arm/mach-omap2/omap_l3_noc.h                  |   22 ++-
 arch/arm/mach-omap2/prcm-common.h                  |    2 +-
 arch/arm/mach-omap2/prcm.c                         |    2 +-
 arch/arm/mach-omap2/timer.c                        |    5 +
 arch/arm/plat-omap/Kconfig                         |    4 +-
 arch/arm/plat-omap/Makefile                        |    4 +-
 arch/arm/plat-omap/common.c                        |    9 +
 arch/arm/plat-omap/counter_32k.c                   |   16 +-
 arch/arm/plat-omap/include/plat/clkdev_omap.h      |    1 +
 arch/arm/plat-omap/include/plat/clock.h            |    1 +
 arch/arm/plat-omap/include/plat/cpu.h              |   22 ++-
 arch/arm/plat-omap/include/plat/hardware.h         |    1 +
 arch/arm/plat-omap/include/plat/multi.h            |    9 +
 arch/arm/plat-omap/include/plat/omap-secure.h      |    5 -
 arch/arm/plat-omap/include/plat/omap54xx.h         |   32 ++++
 arch/arm/plat-omap/include/plat/serial.h           |   10 ++
 arch/arm/plat-omap/include/plat/uncompress.h       |    6 +
 arch/arm/plat-omap/sram.c                          |   11 +-
 44 files changed, 775 insertions(+), 100 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap5-evm.dts
 create mode 100644 arch/arm/boot/dts/omap5.dtsi
 create mode 100644 arch/arm/plat-omap/include/plat/omap54xx.h

-- 
1.7.9.5

