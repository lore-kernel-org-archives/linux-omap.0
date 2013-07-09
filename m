From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 00/12] DRA7xx PRCM, hwmod and DT data
Date: Tue, 9 Jul 2013 13:02:07 +0530
Message-ID: <1373355139-12487-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51423 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752624Ab3GIHcx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Jul 2013 03:32:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, Rajendra Nayak <rnayak@ti.com>

This series adds the data files for DRA7xx devices for
PRCM, hwmod and DT. This is dependent on the core support [1]
patches for DRA7xx and leaves out the clock data since its
on its way to DT [2]

The regbit headers for prm and cm are cleaned up post the
autogeneration as 95% was seen to be currently unused
(prm-regbits-7xx.h was 100% unused and hence removed)

These patches along with the core support patches are available at:
git://github.com/rrnayak/linux.git for-3.12/dra-core-data

[1] http://marc.info/?l=linux-omap&m=137335492102004&w=2

[2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg91318.html

Ambresh K (7):
  ARM: DRA7: PRM: Add DRA7XX register definitions
  ARM: DRA7: CM: Add DRA7XX register defines
  ARM: DRA7: PRCM: Add DRA7XX local MPU PRCM regsiters
  ARM: DRA7: clockdomain: Add DRA7XX data and update header
  ARM: DRA7: powerdomain: Add DRA7XX data and update header
  ARM: DRA7: hwmod: Create initial DRA7XX SoC data
  ARM: DRA7: Enable PM framework initializations

R Sricharan (2):
  ARM: DRA7: Add the build support in omap2plus
  ARM: DRA7: dts: Add the dts files for dra7 SoC and dra7-evm board

Rajendra Nayak (3):
  ARM: DRA7: CM: Add minimal regbit shifts
  ARM: DRA7: powerdomain: Handle missing vc/vp
  ARM: DRA7: Reuse the omap44xx_restart and fix the device instance

 arch/arm/boot/dts/Makefile                 |    3 +-
 arch/arm/boot/dts/dra7-evm.dts             |   20 +
 arch/arm/boot/dts/dra7.dtsi                |  488 +++++
 arch/arm/configs/omap2plus_defconfig       |    1 +
 arch/arm/mach-omap2/Kconfig                |   10 +-
 arch/arm/mach-omap2/Makefile               |    4 +
 arch/arm/mach-omap2/board-generic.c        |    1 +
 arch/arm/mach-omap2/clockdomain.h          |    1 +
 arch/arm/mach-omap2/clockdomains7xx_data.c |  739 ++++++++
 arch/arm/mach-omap2/cm-regbits-7xx.h       |   50 +
 arch/arm/mach-omap2/cm1_7xx.h              |  323 ++++
 arch/arm/mach-omap2/cm2_7xx.h              |  512 ++++++
 arch/arm/mach-omap2/io.c                   |    5 +
 arch/arm/mach-omap2/omap_hwmod.h           |    1 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 2724 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h          |    1 +
 arch/arm/mach-omap2/powerdomains7xx_data.c |  453 +++++
 arch/arm/mach-omap2/prcm44xx.h             |    5 +
 arch/arm/mach-omap2/prcm_mpu7xx.h          |   77 +
 arch/arm/mach-omap2/prm44xx.c              |   12 +-
 arch/arm/mach-omap2/prm7xx.h               |  677 +++++++
 arch/arm/mach-omap2/prminst44xx.c          |   20 +-
 arch/arm/plat-omap/Kconfig                 |    2 +-
 23 files changed, 6121 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra7-evm.dts
 create mode 100644 arch/arm/boot/dts/dra7.dtsi
 create mode 100644 arch/arm/mach-omap2/clockdomains7xx_data.c
 create mode 100644 arch/arm/mach-omap2/cm-regbits-7xx.h
 create mode 100644 arch/arm/mach-omap2/cm1_7xx.h
 create mode 100644 arch/arm/mach-omap2/cm2_7xx.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_7xx_data.c
 create mode 100644 arch/arm/mach-omap2/powerdomains7xx_data.c
 create mode 100644 arch/arm/mach-omap2/prcm_mpu7xx.h
 create mode 100644 arch/arm/mach-omap2/prm7xx.h

-- 
1.7.9.5

