From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v7 0/8] omap3: pm: TWL4030 power scripts and workaround for TWL errata 27
Date: Sat, 26 Feb 2011 17:55:31 +0530
Message-ID: <1298723139-1693-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47238 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab1BZMW2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Feb 2011 07:22:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Patch series for TWL4030 power scripts and workaround for TWL errata 27.

Changes for implementing TWL4030 power scripts recommended by hardware team.
Introduced a new TWL4030 power script file, which can be used by different
OMAP3 board with the power companion chip TWL4030.

Updated the changes for TWL4030 errata 27 & 28, and modified the
TWL4030 power script.
Workaround for TWL4030 errata 27 & 28 is required for
Si version less than or equal to TWL5030 ES1.1.

TWL4030 script changes rebased on Kevin's PM tree in pm branch.

Changes in v7:
	changes to fix Nishanth Menon's comments
		i) Added the TWL4030 Errata 27 fix
  
	split the first patch in v6
		i)  fix for twl4030 script load
		ii) correct the warning print during script loading

	Added new patch files
		i) changing sys_off signal polarity

	Updated the change logs

Since the voltage layer is evolving to a new design, the voltage dependant
changes required for the TRITON script are not incorporated in the patch series.
So this TRITON script patch series can be tested with a separate patch for
voltage layer changes.

	lnk: http://pastebin.mozilla.org/1102845 

This changes are tested on OMAP3430 & OMAP3630 SDP with off mode enabled in suspend path.
	Tested with suspend/resume script, which will test system suspend in a loop.
	Tested for more than 1000 iterations.

Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
Lesly A M (8):
  omap3: pm: Fix for the TRITON sleep/wakeup sequence
  omap3: pm: Correct the warning print during script loading
  omap3: pm: Correcting the sys_offmode signal polarity
  omap3: pm: TWL4030 power scripts for OMAP3 boards
  omap3: pm: TWL5030 version checking
  mfd: TWL4030: changes for TRITON Errata 27 workaround
  omap3430: Updating the board file to use TWL4030 scripts
  omap3630: Updating the board file to use TWL4030 scripts

 arch/arm/mach-omap2/Makefile                 |   12 +-
 arch/arm/mach-omap2/board-3430sdp.c          |   93 +---------
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +
 arch/arm/mach-omap2/pm34xx.c                 |    4 +
 arch/arm/mach-omap2/twl4030.c                |  259 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/twl4030.h                |   20 ++
 drivers/mfd/twl-core.c                       |   64 +++++++
 drivers/mfd/twl4030-power.c                  |   69 +++++++-
 include/linux/i2c/twl.h                      |   51 +++++-
 9 files changed, 473 insertions(+), 101 deletions(-)
 create mode 100644 arch/arm/mach-omap2/twl4030.c
 create mode 100644 arch/arm/mach-omap2/twl4030.h

