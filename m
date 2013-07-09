From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/8] DRA7xx core support
Date: Tue, 9 Jul 2013 12:57:45 +0530
Message-ID: <1373354873-12359-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51191 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752624Ab3GIH2b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Jul 2013 03:28:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, Rajendra Nayak <rnayak@ti.com>

DRA7xx based SoCs' are high-performance, infotainment application devices,
based on enhanced OMAP architecture integrated on a 28nm
technology.

The DRA7xx family is composed of DRA75x and DRA74x devices.
The current device for which the patches add support is the
DRA752 SoC.

Most of the core IPs are similar to those found on the OMAP5
devices, including the dual cortex-A15 based MPU subsystem,
which has helped quite some reuse from existing OMAP5 support.

This series contains only core support patches and the PRCM,
DT and hwmod data needed for the device will be posted as a
seperate patch series.

The bootloader support for the platform is already available
in mainline u-boot.

The patches are available at:
git://github.com/rrnayak/linux.git for-3.12/dra-core

R Sricharan (6):
  ARM: DRA7: id: Add cpu detection support for DRA7xx based SoCs'
  ARM: DRA7: Reuse all of PRCM and MPUSS SMP infra
  ARM: DRA7: Reuse io tables and add a new .init_early
  ARM: DRA7: Resue the clocksource, clockevent support
  ARM: DRA7: board-generic: Add basic DT support
  ARM: DRA7: Kconfig: Increase the default gpio count

Rajendra Nayak (2):
  ARM: DRA7: Update SRAM details
  ARM: DRA7: hwmod: Reuse the soc_ops used for OMAP4/5

 .../devicetree/bindings/arm/omap/omap.txt          |    3 ++
 arch/arm/Kconfig                                   |    2 +-
 arch/arm/mach-omap1/include/mach/soc.h             |    1 +
 arch/arm/mach-omap2/Kconfig                        |    2 +-
 arch/arm/mach-omap2/Makefile                       |    8 ++++
 arch/arm/mach-omap2/board-generic.c                |   18 +++++++++
 arch/arm/mach-omap2/common.h                       |    1 +
 arch/arm/mach-omap2/id.c                           |   30 ++++++++++++++-
 arch/arm/mach-omap2/io.c                           |   22 ++++++++++-
 arch/arm/mach-omap2/omap54xx.h                     |    4 ++
 arch/arm/mach-omap2/omap_hwmod.c                   |    2 +-
 arch/arm/mach-omap2/soc.h                          |   39 ++++++++++++++++++++
 arch/arm/mach-omap2/sram.c                         |    7 ++++
 arch/arm/mach-omap2/timer.c                        |    3 +-
 14 files changed, 134 insertions(+), 8 deletions(-)

-- 
1.7.9.5

