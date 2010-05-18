From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v6 0/7] omap3: pm: Update TRITON power scripts and making it generic
Date: Tue, 18 May 2010 18:01:30 +0530
Message-ID: <1274185890-23745-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41353 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757050Ab0ERMbt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:31:49 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4ICVkjj029393
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 07:31:48 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id o4ICViTY010125
	for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 18:01:45 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

T2 script changes rebased on top of Thara's SmartReflex patches.

This series of patch implements a updated TRITON power scripts.
Also moving the sleep, wakeup & warm_reset sequence to a generic script file,
which can be used by different OMAP3 board with the power companion chip TWL4030.

This patch series is based off Kevin's tree remotes/origin/pm-wip-sr branch,
which have the SmartReflex changes done by Thara Gopinath.

Changes to fix Kevin's & Peter's comments.

This changes are tested on OMAP3430 SDP board with:
	enable_off_mode
	voltage_off_while_idle
	sleep_while_idle (VDD1/VDD2 voltage scaling to 0v) enabled in cpuidle and suspned path.

Lesly A M (7):
  omap3: pm: fix for twl4030 script load
  omap3: pm: Using separate clk/volt setup_time for RET and OFF states
  omap3: pm: re-programing the setup time based on CORE_DOMAIN target
    state.
  omap3: pm: changing vdd0_/vdd1_ to vdd1_/vdd2_ in VC param structure.
  omap3: pm: Generic TRITON power scripts for OMAP3 based boards
  omap3: pm: Use generic TRITON power scripts for 3430SDP board
  omap3: pm: Use generic TRITON power scripts for ZOOM[2,3], 3630SDP
    board

 arch/arm/mach-omap2/Makefile                 |   12 +-
 arch/arm/mach-omap2/board-3430sdp.c          |  111 +---------------
 arch/arm/mach-omap2/board-zoom-peripherals.c |    6 +
 arch/arm/mach-omap2/pm.h                     |   18 ---
 arch/arm/mach-omap2/pm34xx.c                 |   26 +---
 arch/arm/mach-omap2/twl4030.c                |  185 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/twl4030.h                |   15 ++
 arch/arm/mach-omap2/voltage.c                |  157 +++++++++++++++++-----
 arch/arm/mach-omap2/voltage.h                |   26 ++++
 drivers/mfd/twl4030-power.c                  |    5 +-
 include/linux/i2c/twl.h                      |    4 +
 11 files changed, 373 insertions(+), 192 deletions(-)
 create mode 100644 arch/arm/mach-omap2/twl4030.c
 create mode 100644 arch/arm/mach-omap2/twl4030.h

