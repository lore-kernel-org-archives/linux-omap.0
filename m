From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v4 0/9] OMAP3: Adding Smartreflex and Voltage driver support
Date: Wed, 27 Oct 2010 21:40:47 +0530
Message-ID: <1288195856-11011-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55766 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761142Ab0J0QLK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Oct 2010 12:11:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch series introduces smartreflex and voltage driver support
for OMAP3430 and OMAP3630. SmartReflex modules do adaptive voltage
control for real-time voltage adjustments.

Originally all the functionalities introduced in this patch
were present in arch/arm/mach-omap2/smartreflex.c file in Kevin's
pm tree. This patch series does a major rewrite of this file
and introduces a separate voltage driver. Major contributors
to the original driver are

Eduardo Valentin (1):
      OMAP3: PM: SmartReflex: Fix scheduled while atomic problem

Kalle Jokiniemi (1):
      OMAP3: PM: SmartReflex driver integration

Kevin Hilman (2):
      temp: SR: IO_ADDRESS conversion
      OMAP: SR: OPP interfaces removed from OMAP PM layer

Nishanth Menon (1):
      omap3: pm: sr: replace get_opp with freq_to_opp

Paul Walmsley (2):
      OMAP SR: use opp_find_opp_by_opp_id()
      OMAP SR: use OPP API for OPP ID, remove direct access

Phil Carmody (2):
      OMAP3: PM: Don't do unnecessary searches in omap_sr_vdd*_autocomp_store
      OMAP3: PM: Early exit on invalid parameters

Rajendra Nayak (9):
      OMAP3: SR: Fix init voltage on OPP change
      OMAP3: SR: Update VDD1/2 voltages at boot
      OMAP3: SR: Use sysclk for SR CLKLENGTH calc
      OMAP3: SR: Reset voltage level on SR disable
      OMAP3: SR: Replace printk's with pr_* calls
      OMAP3: SR: Remove redundant defines
      OMAP3: SR: Fix SR driver to check for omap-pm return values
      OMAP3: PM: Put optimal SMPS stabilization delay
      OMAP3: SR: Wait for VP idle before a VP disable

Roger Quadros (4):
      OMAP3: PM: Fix Smartreflex when used with PM_NOOP layer
      OMAP3: PM: Make Smartreflex driver independent of SRF
      OMAP3: PM: Do not Enable SmartReflex if OPP tables not defined
      OMAP3: PM: Smartreflex: Fix VDD2 OPP determining logic

Romit Dasgupta (1):
      omap: pm: SR: use enum for OPP types

Teerth Reddy (1):
      OMAP3: SR: Replace SR_PASS/FAIL,SR_TRUE/FALSE

Tero Kristo (1):
      Smartreflex: Avoid unnecessary spam

This patch series is based against lo-master with the following additional
patches applied.
	https://patchwork.kernel.org/patch/266911/
	https://patchwork.kernel.org/patch/266921/
	https://patchwork.kernel.org/patch/266931/
	https://patchwork.kernel.org/patch/183712/
	https://patchwork.kernel.org/patch/285872/

The entire series with the dependencies are available at
        http://dev.omapzoom.org/?p=thara/omap-dvfs.git;a=summary
        head: thara-pm-sr

This patch series has been tested on OMAP3430 SDP with omap2plus_defconfig
with the following menuconfig options enabled.
System type -> TI OMAP Implementations -> Smartreflex Support
System type -> TI OMAP Implementations ->
		Class 3 mode of Smartreflex Implementation

Thara Gopinath (9):
  OMAP3: PM: Adding voltage driver support for OMAP3
  OMAP3: PM: Adding smartreflex driver support.
  OMAP3: PM: Adding smartreflex device file.
  OMAP3: PM: Adding smartreflex hwmod data
  OMAP3: PM: Adding smartreflex class3 driver
  OMAP3: PM: Adding T2 enabling of smartreflex support
  OMAP3: PM: Adding debug support to Voltage and Smartreflex drivers
  OMAP3: PM: Program correct init voltages for VDD1 and VDD2
  OMAP3: PM: Register TWL4030 pmic info with the voltage driver.

 arch/arm/mach-omap2/Makefile                  |    5 +-
 arch/arm/mach-omap2/control.h                 |   27 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |  249 +++++
 arch/arm/mach-omap2/pm.c                      |   68 ++
 arch/arm/mach-omap2/smartreflex-class3.c      |   59 ++
 arch/arm/mach-omap2/smartreflex.c             | 1005 ++++++++++++++++++
 arch/arm/mach-omap2/sr_device.c               |  177 ++++
 arch/arm/mach-omap2/voltage.c                 | 1369 +++++++++++++++++++++++++
 arch/arm/plat-omap/Kconfig                    |   45 +
 arch/arm/plat-omap/include/plat/smartreflex.h |  271 +++++
 arch/arm/plat-omap/include/plat/voltage.h     |  142 +++
 arch/arm/plat-omap/opp_twl_tps.c              |   17 +
 drivers/mfd/twl-core.c                        |    7 +-
 drivers/mfd/twl4030-power.c                   |   29 +
 include/linux/i2c/twl.h                       |    1 +
 15 files changed, 3468 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-omap2/smartreflex-class3.c
 create mode 100644 arch/arm/mach-omap2/smartreflex.c
 create mode 100644 arch/arm/mach-omap2/sr_device.c
 create mode 100644 arch/arm/mach-omap2/voltage.c
 create mode 100644 arch/arm/plat-omap/include/plat/smartreflex.h
 create mode 100644 arch/arm/plat-omap/include/plat/voltage.h

