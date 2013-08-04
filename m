From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v3 0/9] DRA7xx core support
Date: Sun, 4 Aug 2013 21:57:28 +0530
Message-ID: <1375633657-6835-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40745 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753519Ab3HDQ2R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 4 Aug 2013 12:28:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, sourav.poddar@ti.com, santosh.shilimkar@ti.com, nm@ti.com, balbi@ti.com, Rajendra Nayak <rnayak@ti.com>

Changes in v3:
-1- Dropped some clock/dpll framework builds for dra7
-2- Added all instances of IPs in dtsi file
-3- dtsi does a 'disabled' by default and dts enables as needed
-4- soc_is_dra7xx() based on DT compatible instead of using ID code

Changes in v2:
-1- Fixed minor changelog details
-2- Dropped the SRAM support patch since we need to move to drivers/misc/sram.c
-3- Added DTS update patches to this series which were earlier posted as
part of the data series (Since they don't have much objections as against the
other in-kernel data files)
-4- Updated the EVM dts file with pin config details for uart/mcspi and i2c

DRA7xx based SoCs' are high-performance, infotainment application devices,
based on enhanced OMAP architecture integrated on a 28nm
technology.

The DRA7xx family is composed of DRA75x and DRA74x devices.
The current device for which the patches add support is the
DRA752 SoC.

Most of the core IPs are similar to those found on the OMAP5
devices, including the dual cortex-A15 based MPU subsystem,
which has helped quite some reuse from existing OMAP5 support.

This series contains only core support patches and none of
the PRCM and hwmod data needed for the device to boot.

The bootloader support for the platform is already available
in mainline u-boot.

The patches posted in this series are available at:
git://github.com/rrnayak/linux.git for-3.12/dra-core-v3

The patches (including the ones for in-kernel data) which boot
on dra7xx evm are available at:
t://github.com/rrnayak/linux.git out-of-tree/dra-integrated-v3

R Sricharan (8):
  ARM: DRA7: Reuse all of PRCM and MPUSS SMP infra
  ARM: DRA7: Reuse io tables and add a new .init_early
  ARM: DRA7: Resue the clocksource, clockevent support
  ARM: DRA7: board-generic: Add basic DT support
  ARM: DRA7: Kconfig: Make ARCH_NR_GPIO default to 512
  ARM: DRA7: dts: Add the dts files for dra7 SoC and dra7-evm board
  ARM: DRA7: id: Add cpu detection support for DRA7xx based SoCs'
  ARM: DRA7: Add the build support in omap2plus

Rajendra Nayak (1):
  ARM: DRA7: hwmod: Reuse the soc_ops used for OMAP4/5

 .../devicetree/bindings/arm/omap/omap.txt          |    3 +
 arch/arm/Kconfig                                   |    2 +-
 arch/arm/boot/dts/Makefile                         |    3 +-
 arch/arm/boot/dts/dra7-evm.dts                     |  140 +++++
 arch/arm/boot/dts/dra7.dtsi                        |  567 ++++++++++++++++++++
 arch/arm/configs/omap2plus_defconfig               |    1 +
 arch/arm/mach-omap1/include/mach/soc.h             |    1 +
 arch/arm/mach-omap2/Kconfig                        |   12 +-
 arch/arm/mach-omap2/Makefile                       |    6 +
 arch/arm/mach-omap2/board-generic.c                |   18 +
 arch/arm/mach-omap2/common.h                       |    1 +
 arch/arm/mach-omap2/id.c                           |    4 +-
 arch/arm/mach-omap2/io.c                           |   20 +-
 arch/arm/mach-omap2/omap54xx.h                     |    4 +
 arch/arm/mach-omap2/omap_hwmod.c                   |    2 +-
 arch/arm/mach-omap2/soc.h                          |   17 +
 arch/arm/mach-omap2/timer.c                        |    3 +-
 arch/arm/plat-omap/Kconfig                         |    2 +-
 18 files changed, 795 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra7-evm.dts
 create mode 100644 arch/arm/boot/dts/dra7.dtsi

-- 
1.7.9.5

