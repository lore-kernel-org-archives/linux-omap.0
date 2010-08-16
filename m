From: Charulatha V <charu@ti.com>
Subject: [PATCH 0/5 v3] OMAP2PLUS: WDT: Implement WDT in HWMOD way
Date: Mon, 16 Aug 2010 19:06:44 +0530
Message-ID: <1281965809-20585-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55816 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752788Ab0HPNeE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Aug 2010 09:34:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: wim@iguana.be, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, Charulatha V <charu@ti.com>

This patch series makes OMAP2PLUS Watchdog Timer Module implemented
in HWMOD FW way. It also implements Watchdog timer driver to
use the runtime PM layer.

This patch series is created on "origin/pm-wip/hwmods-omap4".

This patch series is tested on OMAP3430 SDP and OMAP4430 SDP.
It would be of great help if someone could test the same on
OMAP1 and OMAP2 boards.

Version History:
---------------
Vesrion v3:
Fix Minor comments like renaming omap1 watchdog structures
with an omap1_ prefix

Version v2:
Rebase to latest kernel
Some of the v2 links:
http://www.spinics.net/lists/linux-omap/msg34741.html
http://www.spinics.net/lists/linux-omap/msg34673.html

Version v1:
Initial series
Some of the v1 links:
http://www.spinics.net/lists/linux-omap/msg30628.html
http://www.spinics.net/lists/linux-omap/msg30625.html

Benoit Cousson (1):
  OMAP4 HWMOD: Add watchdog hwmods.

Charulatha V (4):
  OMAP3: WDT: Add watchdog timer HWMOD data for OMAP3
  OMAP2420: WDT: Add watchdog timer HWMOD data for OMAP2420
  OMAP2430: WDT: Add watchdog timer HWMOD data for OMAP2430
  OMAP2PLUS: WDT: Conversion to runtime PM

 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   59 ++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   59 ++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   61 +++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   68 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm-common.h          |    4 ++
 arch/arm/plat-omap/devices.c               |   64 ++++++++++++++++++--------
 drivers/watchdog/omap_wdt.c                |   43 +++--------------
 7 files changed, 303 insertions(+), 55 deletions(-)

