From: Charulatha V <charu@ti.com>
Subject: [PATCH 0/6] OMAP2PLUS: WDT: Implement WDT in HWMOD way
Date: Sat, 22 May 2010 18:26:00 +0530
Message-ID: <1274532966-19916-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39500 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586Ab0EVMyb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 22 May 2010 08:54:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: wim@iguana.be, khilman@deeprootsystems.com, rnayak@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

This patch series makes OMAP2PLUS Watchdog Timer Module implemented
in HWMOD FW way. It also implements OMAP2/3 Watchdog timer driver to
use the runtime PM layer.

This patch series is created on "origin/pm-wip/hwmod-omap4".

This patch series is tested on OMAP3430 SDP, OMAP3630 SDP and OMAP4430 SDP.
It would be of great help if someone could test the same on
OMAP1 and OMAP2 boards.

The same patchset is also tested on "origin/pm-wip/runtime".
Please note that patch 5/6 "OMAP4: WDT: Enable watchdog timer2
hwmod structure" is not valid in "origin/pm-wip/runtime" branch.

Charulatha V (6):
  OMAP2PLUS: WDT: Add ICLKEN, FCLKEN, WKEN shared bits for WDT
  OMAP3: WDT: Add watchdog timer HWMOD data for OMAP3
  OMAP2420: WDT: Add watchdog timer HWMOD data for OMAP2420
  OMAP2430: WDT: Add watchdog timer HWMOD data for OMAP2430
  OMAP4: WDT: Enable watchdog timer2 hwmod structure
  OMAP2PLUS: WDT: Conversion to runtime PM

 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   56 +++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   56 +++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   61 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 arch/arm/mach-omap2/prcm-common.h          |    4 ++
 arch/arm/plat-omap/devices.c               |   52 ++++++++++++++++-------
 drivers/watchdog/omap_wdt.c                |   43 +++++++++++---------
 7 files changed, 238insertions(+), 36 deletions(-)

