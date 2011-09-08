From: Abhilash K V <abhilash.kv@ti.com>
Subject: [PATCH v2 0/3] AM35x: Adding PM init
Date: Thu, 8 Sep 2011 18:16:47 +0530
Message-ID: <1315486007-452-1-git-send-email-abhilash.kv@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, sameo@linux.intel.com, santosh.shilimkar@ti.com, premi@ti.com, david.woodhouse@intel.com, Abhilash K V <abhilash.kv@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch-set fixes the power and voltage management initialization sequence
for AM35x.
These patches are dependent on the following patch-set
	[PATCH v3 0/2] AM3517: Booting up
at http://marc.info/?l=linux-kernel&m=131548351225196&w=2
which gets the AM3517 EVM booting.

The patches are tested on master of tmlind/linux-omap-2.6.git.
Kernel version is 3.1-rc3 and last commit on top of which these patches
were added is:
	b148d763841161894ed6629794064065a834aa2b: Linux-omap rebuilt: Updated to
	use omap_sdrc_init

with the folowing commit reverted:
	f3637a5f2e2eb391ff5757bc83fb5de8f9726464: irq: Always set IRQF_ONESHOT
	if no primary handler is specified

Cc: Sanjeev Premi <premi@ti.com>
---
Changes in v2:
  * TWL4030 CORE and POWER drivers are no longer built only for ARM and OMAP
  * changed comments to mark AM35x voltgate-scaling code as ad hoc

Abhilash K V (1):
  OMAP3: Remove auto-selection of PMICs

Sanjeev Premi (2):
  AM35x: voltage: Basic initialization
  OMAP3: Add support for TPS65023 (AM35x only)

 arch/arm/configs/omap2plus_defconfig          |    3 +
 arch/arm/mach-omap2/Kconfig                   |    3 -
 arch/arm/mach-omap2/Makefile                  |    3 +-
 arch/arm/mach-omap2/omap_opp_data.h           |    1 +
 arch/arm/mach-omap2/opp3xxx_data.c            |   10 +++
 arch/arm/mach-omap2/pm.c                      |    4 +-
 arch/arm/mach-omap2/pm.h                      |    9 +++
 arch/arm/mach-omap2/pmic_tps65023.c           |   84 +++++++++++++++++++++++++
 arch/arm/mach-omap2/voltage.c                 |   18 +++++
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |   41 ++++++++++++-
 drivers/mfd/Kconfig                           |    2 +-
 11 files changed, 171 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pmic_tps65023.c
