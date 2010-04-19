From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v5 0/5] omap3: pm: Update TRITON power scripts and making it generic
Date: Mon, 19 Apr 2010 17:12:39 +0530
Message-ID: <1271677359-2072-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39785 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754362Ab0DSLVm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Apr 2010 07:21:42 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3JBLcPE026954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 19 Apr 2010 06:21:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: leslyam@ti.com

T2 script changes rebased on top of Thara's SmartReflex patches.

This series of patch implements a updated TRITON power scripts.
Also moving the sleep, wakeup & warm_reset sequence to a generic script file,
which can be used by different OMAP3 board with the power companion chip TWL4030.

This patch series is based off Kevin's tree origin/pm-wip-opp branch,
and also depends on the SmartReflex changes(v3) done by Thara Gopinath.

Changes to fix Kevins comments.

This changes are tested on OMAP3430 SDP board with:
	enable_off_mode
	voltage_off_while_idle
	sleep_while_idle (VDD1/VDD2 voltage scaling to 0v) enabled in cpuidle and suspned path.

Lesly A M (5):
  omap3: pm: fix for twl4030 script load
  omap3: pm: Using separate clk/volt setup_time for RET and OFF states
  omap3: pm: Generic TRITON power scripts for OMAP3 based boards
  omap3: pm: Use generic TRITON power scripts for 3430SDP board
  omap3: pm: Use generic TRITON power scripts for ZOOM[2,3], 3630SDP
    board

 arch/arm/mach-omap2/Makefile                 |   12 ++-
 arch/arm/mach-omap2/board-3430sdp.c          |  129 +++++-----------------
 arch/arm/mach-omap2/board-3630sdp.c          |    4 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |   36 ++++++
 arch/arm/mach-omap2/board-zoom2.c            |    4 +-
 arch/arm/mach-omap2/board-zoom3.c            |    4 +-
 arch/arm/mach-omap2/pm.h                     |   18 ---
 arch/arm/mach-omap2/pm34xx.c                 |   26 +----
 arch/arm/mach-omap2/twl4030.c                |  154 +++++++++++++++++++++++++
 arch/arm/mach-omap2/twl4030.h                |   15 +++
 arch/arm/mach-omap2/voltage.c                |  156 ++++++++++++++++++++------
 arch/arm/mach-omap2/voltage.h                |   31 +++++
 drivers/mfd/twl4030-power.c                  |    6 -
 include/linux/i2c/twl.h                      |    4 +
 14 files changed, 407 insertions(+), 192 deletions(-)
 create mode 100644 arch/arm/mach-omap2/twl4030.c
 create mode 100644 arch/arm/mach-omap2/twl4030.h

