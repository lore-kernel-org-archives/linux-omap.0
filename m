From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v4 0/5] omap3: pm: Update TRITON power scripts and making it generic
Date: Wed, 31 Mar 2010 15:49:12 +0530
Message-ID: <1270030752-1900-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34684 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755755Ab0CaJ4v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 05:56:51 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2V9uljq020855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 31 Mar 2010 04:56:50 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2V9ukwc007546
	for <linux-omap@vger.kernel.org>; Wed, 31 Mar 2010 15:26:47 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This series of patch implements a updated TRITON power scripts.
Also moving the sleep, wakeup & warm_reset sequence to a generic script file,
which can be used by different OMAP3 board with the power companion chip TWL4030.

This patch series is based off Kevin's tree origin/pm branch.

This changes are tested on OMAP3430 SDP board with:
	enable_off_mode
	voltage_off_while_idle
	sleep_while_idle (VDD1/VDD2 voltage scaling to 0v) enabled in cpuidle and suspned path.

Also tested for reboot and dvfs.

Changes to fix Kevins & Nishanths comments.

Lesly A M (5):
  omap3: pm: fix for twl4030 script load
  omap3: pm: Using separate clk/volt setup_time for RET and OFF states
  omap3: pm: Generic TRITON power scripts for OMAP3 based boards
  omap3: pm: Use generic TRITON power scripts for 3430SDP board
  omap3: pm: Use generic TRITON power scripts for ZOOM[2,3], 3630SDP
    board

 arch/arm/mach-omap2/Makefile                 |   12 ++-
 arch/arm/mach-omap2/board-3430sdp.c          |  137 +++++++----------------
 arch/arm/mach-omap2/board-3630sdp.c          |   17 +++
 arch/arm/mach-omap2/board-zoom-peripherals.c |   36 ++++++
 arch/arm/mach-omap2/board-zoom2.c            |   17 +++
 arch/arm/mach-omap2/board-zoom3.c            |   17 +++
 arch/arm/mach-omap2/pm.h                     |   17 ---
 arch/arm/mach-omap2/pm34xx.c                 |   14 ++-
 arch/arm/mach-omap2/twl4030-script.c         |  154 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/twl4030-script.h         |   15 +++
 arch/arm/mach-omap2/voltage.c                |  149 ++++++++++++++++++-------
 arch/arm/mach-omap2/voltage.h                |   30 +++++
 drivers/mfd/twl4030-power.c                  |    6 -
 include/linux/i2c/twl.h                      |    4 +
 14 files changed, 458 insertions(+), 167 deletions(-)
 create mode 100644 arch/arm/mach-omap2/twl4030-script.c
 create mode 100644 arch/arm/mach-omap2/twl4030-script.h

