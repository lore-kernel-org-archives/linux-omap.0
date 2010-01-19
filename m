From: Lesly A M <x0080970@ti.com>
Subject: [PATCH v2 0/6] omap3: pm: Update TRITON power scripts and making it generic
Date: Tue, 19 Jan 2010 22:59:53 +0530
Message-ID: <1263922193-13468-1-git-send-email-x0080970@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51021 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754387Ab0ASRRl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jan 2010 12:17:41 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o0JHHbWV031177
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 19 Jan 2010 11:17:40 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <x0080970@ti.com>

map3: pm: Update TRITON power scripts and making it generic

This series of patch implements a updated TRITON power scripts.
Also moving the sleep, wakeup & warm_reset sequence to a generic script file,
which can be used by different OMAP3 board with the power companion chip TWL4030.

V1: Initial Patch Series

V2: Incorporated comments

 arch/arm/mach-omap2/Makefile                  |   12 ++-
 arch/arm/mach-omap2/board-3430sdp.c           |  124 ++++++++-----------------
 arch/arm/mach-omap2/board-3630sdp.c           |   25 +++++-
 arch/arm/mach-omap2/board-zoom-peripherals.c  |   43 +++++++++-
 arch/arm/mach-omap2/board-zoom2.c             |   25 +++++-
 arch/arm/mach-omap2/board-zoom3.c             |   25 +++++-
 arch/arm/mach-omap2/include/mach/board-zoom.h |    2 +-
 arch/arm/mach-omap2/pm.h                      |   11 ++-
 arch/arm/mach-omap2/pm34xx.c                  |   60 ++++++++++--
 drivers/mfd/twl4030-power.c                   |   30 +++++--
 include/linux/i2c/twl.h                       |    4 +
 11 files changed, 245 insertions(+), 116 deletions(-)


Tested on top of Kevins PM branch commit id:
ad4776c4207a376961372752fe0a0ae3814990b3

