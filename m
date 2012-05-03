From: R Sricharan <r.sricharan@ti.com>
Subject: [PATCH 00/13] ARM: OMAP5: Add minimal OMAP5 SOC support
Date: Thu, 3 May 2012 12:56:09 +0530
Message-ID: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39614 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755817Ab2ECH0r (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 03:26:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, b-cousson@ti.com, r.sricharan@ti.com

The series adds minimal OMAP5 support.
OMAP5430 has a dual core Cortex-A15 based MPU subsystem with 2MB
L2 cache. The SOC has many compatible blocks with OMAP4 SOCS and
hence large part of the peripherals are re-used.

OMAP5432 is another variant of OMAP5430, with a
memory controller supporting DDR3 and SATA.

Series is generated against the 3.4-rc5. This has been rebased on
top of the OMAP2+ cleanup series [1]

To get the boot working with omap2plus_defconfig,
OMAP5 hwmod/clock/prm/cm database needs to be added.
The data and the integrated tree are available in the
below git repository

OMAP5_DATA:
git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
 omap5_data

OMAP5_INTEGRATED:
git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
 omap5_dt_integrated

The series is boot tested on OMAP5430 ES1.0.
OMAP2/3/4 build and boot is tested as well to avoid any breakage
because of the series.

Patch "TEMP: ARM: OMAP5: Add cpu_is_omap54xx() checks" is temporary and
can be dropped once rebased against [2]

Patch "TEMP: ARM: OMAP5: Update the base address of the 32k-counter" is
temporary and can be dropped once rebased against [3]


[1] http://www.spinics.net/lists/linux-omap/msg69233.html
[2] http://www.spinics.net/lists/linux-omap/msg69013.html
[3] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67166.html

R Sricharan (10):
  ARM: OMAP5: id: Add cpu id for ES versions
  ARM: OMAP5: Add minimal support for OMAP5430 SOC
  TEMP: ARM: OMAP5: Add cpu_is_omap54xx() checks.
  ARM: OMAP5: timer: Add clocksource, clockevent support
  TEMP: ARM: OMAP5: Update the base address of the 32k-counter.
  ARM: OMAP5: gpmc: Update gpmc_init()
  ARM: OMAP5: l3: Add l3 error handler support for omap5.
  ARM: OMAP5: board-generic: Add device tree support.
  arm/dts: OMAP5: Add omap5 dts files
  ARM: OMAP5: Add the build support

Santosh Shilimkar (2):
  ARM: OMAP5: Add the WakeupGen IP updates.
  ARM: OMAP5: Add SMP support.

Tarun Kanti DebBarma (1):
  ARM: Kconfig update to support additional GPIOs in OMAP5

 .../devicetree/bindings/arm/omap/omap.txt          |    3 +
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/omap5-evm.dts                    |   20 ++
 arch/arm/boot/dts/omap5.dtsi                       |  201 ++++++++++++++++++++
 arch/arm/configs/omap2plus_defconfig               |    2 +
 arch/arm/mach-omap2/Kconfig                        |   13 ++-
 arch/arm/mach-omap2/Makefile                       |   27 ++-
 arch/arm/mach-omap2/board-generic.c                |   39 +++--
 arch/arm/mach-omap2/clock.c                        |    3 +-
 arch/arm/mach-omap2/cminst44xx.h                   |    2 +-
 arch/arm/mach-omap2/common.c                       |   24 +++
 arch/arm/mach-omap2/common.h                       |   15 ++
 arch/arm/mach-omap2/control.h                      |    4 +
 arch/arm/mach-omap2/devices.c                      |    2 +-
 arch/arm/mach-omap2/gpmc.c                         |    3 +-
 arch/arm/mach-omap2/id.c                           |   47 +++++
 arch/arm/mach-omap2/include/mach/debug-macro.S     |    8 +-
 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h  |    6 +
 arch/arm/mach-omap2/io.c                           |   44 +++++
 arch/arm/mach-omap2/iomap.h                        |   27 +++
 arch/arm/mach-omap2/irq.c                          |   11 +
 arch/arm/mach-omap2/omap-headsmp.S                 |   21 ++
 arch/arm/mach-omap2/omap-hotplug.c                 |   24 ++-
 arch/arm/mach-omap2/omap-smp.c                     |   58 +++++--
 arch/arm/mach-omap2/omap-wakeupgen.c               |  110 ++++++++---
 arch/arm/mach-omap2/omap4-common.c                 |   14 ++
 arch/arm/mach-omap2/omap4-sar-layout.h             |   12 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |   15 +-
 arch/arm/mach-omap2/omap_l3_noc.h                  |   22 ++-
 arch/arm/mach-omap2/prcm.c                         |    2 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.h                 |    5 +-
 arch/arm/mach-omap2/timer.c                        |    5 +
 arch/arm/plat-omap/Kconfig                         |    4 +-
 arch/arm/plat-omap/Makefile                        |    4 +-
 arch/arm/plat-omap/counter_32k.c                   |    2 +
 arch/arm/plat-omap/include/plat/clkdev_omap.h      |    1 +
 arch/arm/plat-omap/include/plat/clock.h            |    4 +-
 arch/arm/plat-omap/include/plat/cpu.h              |   23 ++-
 arch/arm/plat-omap/include/plat/hardware.h         |    1 +
 arch/arm/plat-omap/include/plat/multi.h            |    9 +
 arch/arm/plat-omap/include/plat/omap54xx.h         |   32 +++
 arch/arm/plat-omap/include/plat/serial.h           |   10 +
 arch/arm/plat-omap/include/plat/uncompress.h       |    6 +
 arch/arm/plat-omap/sram.c                          |   11 +-
 44 files changed, 796 insertions(+), 101 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap5-evm.dts
 create mode 100644 arch/arm/boot/dts/omap5.dtsi
 create mode 100644 arch/arm/plat-omap/include/plat/omap54xx.h

