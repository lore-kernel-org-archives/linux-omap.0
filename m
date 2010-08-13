From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2 0/8] OMAP3: Adding Smartreflex and Voltage driver support
Date: Fri, 13 Aug 2010 19:17:03 +0530
Message-ID: <1281707231-3026-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53791 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761639Ab0HMNrZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 09:47:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, dderrick@ti.com, thara gopinath <thara@ti.com>

From: thara gopinath <thara@ti.com>

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

This patch series is based against origin/opp branch off
Kevin's pm tree which in turn is based off lo-master.
This series will apply against lo-master also but will
break compilation due to lack of opp framework support
on lo-master.

This patch series has been tested on OMAP3430 SDP with the extra five patches
from origin/cpufreq branch off Kevin's pm tree applied. This series
has been tested with with omap3_defconfig with the following
menuconfig options enabled.
System type -> TI OMAP Implementations -> Smartreflex Support
System type -> TI OMAP Implementations ->
		Class 3 mode of Smartreflex Implementation

Thara Gopinath (8):
  OMAP: PM: Allowing an early init of pm debugfs driver.
  OMAP3: PM: Adding voltage driver support for OMAP3
  OMAP3: PM: Adding smartreflex driver support.
  OMAP3: PM: Adding smartreflex device file.
  OMAP3: PM: Adding smartreflex hwmod data
  OMAP3: PM: Adding smartreflex class3 driver
  OMAP3: PM: Adding T2 enabling of smartreflex support
  OMAP3: PM: Adding debug support to Voltage and Smartreflex drivers

 arch/arm/mach-omap2/Makefile                  |    5 +-
 arch/arm/mach-omap2/board-3430sdp.c           |    2 +
 arch/arm/mach-omap2/board-3630sdp.c           |    2 +
 arch/arm/mach-omap2/board-zoom3.c             |    2 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |  249 +++++
 arch/arm/mach-omap2/pm-debug.c                |   18 +-
 arch/arm/mach-omap2/smartreflex-class3.c      |   61 ++
 arch/arm/mach-omap2/smartreflex-class3.h      |   23 +
 arch/arm/mach-omap2/smartreflex.c             | 1009 +++++++++++++++++++
 arch/arm/mach-omap2/sr_device.c               |  185 ++++
 arch/arm/mach-omap2/voltage.c                 | 1275 +++++++++++++++++++++++++
 arch/arm/plat-omap/Kconfig                    |   41 +
 arch/arm/plat-omap/include/plat/control.h     |   27 +
 arch/arm/plat-omap/include/plat/smartreflex.h |  285 ++++++
 arch/arm/plat-omap/include/plat/voltage.h     |  137 +++
 drivers/mfd/twl-core.c                        |    7 +-
 drivers/mfd/twl4030-power.c                   |   29 +
 include/linux/i2c/twl.h                       |    1 +
 18 files changed, 3353 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-omap2/smartreflex-class3.c
 create mode 100644 arch/arm/mach-omap2/smartreflex-class3.h
 create mode 100644 arch/arm/mach-omap2/smartreflex.c
 create mode 100644 arch/arm/mach-omap2/sr_device.c
 create mode 100644 arch/arm/mach-omap2/voltage.c
 create mode 100644 arch/arm/plat-omap/include/plat/smartreflex.h
 create mode 100644 arch/arm/plat-omap/include/plat/voltage.h

-- 
1.7.1.GIT

