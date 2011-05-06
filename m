From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v10 0/7] MFD: TWL4030: power script and workaround for erratum 27
Date: Fri, 6 May 2011 18:47:06 +0530
Message-ID: <1304687833-4578-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40075 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411Ab1EFNRO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 May 2011 09:17:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Patch series for TWL4030 power scripts for OMAP3 boards and
workaround for TWL erratum 27.

Changes for implementing TWL4030 power scripts recommended by hardware team.
Introduced a new TWL4030 power script file, which can be used by different
OMAP3 board with the power companion chip TWL4030.

Updated the changes for TWL4030 errata 27 & 28, and modified
the TWL4030 power script.
Workaround for TWL4030 erratum 27 is required for Si version less than or
equal to TWL5030 ES1.1.

TWL4030 script changes re-based on Kevin's PM tree in pm branch.

This patch series have a dependency with the patch:
	http://www.spinics.net/lists/linux-omap/msg50547.html

Changes in v7:
	changes to fix Nishanth Menon's comments
		i) Added the workaround for TWL4030 Erratum 27
  
	split the first patch in v6
		i)  fix for twl4030 script load
		ii) correct the warning print during script loading

	Added new patch files
		i) changing sys_off signal polarity

Changes in v8:
	updated the change logs
	moving the TWL IDCODE checking to twl-core.c

Changes in V9:
	changes to fix David Derrick's comments
		i) turn OFF the NRES_PWRON resource in warm reset sequence
		ii) optimize the i2c writes during resource configuration

Changes in V10:
	changes for Tony's comments
		i) making the TWL4030 power scripts loadable module

Since the voltage layer is evolving to a new design, the voltage dependant
changes required for the TWL4030 script are not incorporated in the patch series.
So this TWL4030 script patch series can be tested with a separate patch for
voltage layer changes.

	link: http://pastebin.mozilla.org/1219625

This changes are tested on OMAP3430 & OMAP3630 SDP with off mode enabled in suspend path.
	Tested with suspend/resume script, which will test system suspend in a loop.
	Tested for more than 1000 iterations.
	Also tested the reboot with WRM_RST button & reboot command.

Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
Lesly A M (7):
  MFD: TWL4030: Fix for the TWL4030 sleep/wakeup sequence
  MFD: TWL4030: Correct the warning print during script loading
  MFD: TWL4030: Modifying the macro name Main_Ref to all caps
  MFD: TWL4030: power scripts for OMAP3 boards
  MFD: TWL4030: TWL version checking
  MFD: TWL4030: workaround changes for Erratum 27
  MFD: TWL4030: optimizing resource configuration

 arch/arm/configs/omap2plus_defconfig         |    1 +
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 arch/arm/mach-omap2/devices.c                |   15 +
 drivers/mfd/Kconfig                          |   11 +
 drivers/mfd/Makefile                         |    1 +
 drivers/mfd/twl-core.c                       |   62 +++
 drivers/mfd/twl4030-power.c                  |  241 +++++++++----
 drivers/mfd/twl4030-script-omap.c            |  523 ++++++++++++++++++++++++++
 include/linux/i2c/twl.h                      |   61 +++-
 9 files changed, 839 insertions(+), 78 deletions(-)
 create mode 100644 drivers/mfd/twl4030-script-omap.c

