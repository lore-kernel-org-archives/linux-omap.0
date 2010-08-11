From: Charulatha V <charu@ti.com>
Subject: [PATCH 0/6 v2] OMAP2PLUS: WDT: Implement WDT in HWMOD way
Date: Wed, 11 Aug 2010 15:41:05 +0530
Message-ID: <1281521471-15802-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49974 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756149Ab0HKKIi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 06:08:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: wim@iguana.be, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, Charulatha V <charu@ti.com>

This patch series makes OMAP2PLUS Watchdog Timer Module implemented
in HWMOD FW way. It also implements OMAP2/3 Watchdog timer driver to
use the runtime PM layer.

This patch series is created on "origin/pm-wip/hwmods-omap4".

This patch series is tested on OMAP3430 SDP and OMAP4430 SDP.
It would be of great help if someone could test the same on
OMAP1 and OMAP2 boards.

Version History:
---------------
Version v2:
Rebase to latest kernel

Version v1:
Some of the v1 links:
http://www.spinics.net/lists/linux-omap/msg30628.html
http://www.spinics.net/lists/linux-omap/msg30625.html

Charulatha V (6):
  OMAP2PLUS: WDT: Add ICLKEN, FCLKEN, WKEN shared bits for WDT
  OMAP3: WDT: Add watchdog timer HWMOD data for OMAP3
  OMAP2420: WDT: Add watchdog timer HWMOD data for OMAP2420
  OMAP2430: WDT: Add watchdog timer HWMOD data for OMAP2430
  OMAP4: WDT: Enable watchdog timer2 hwmod structure
  OMAP2PLUS: WDT: Conversion to runtime PM

 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   59 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   59 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   61 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 arch/arm/mach-omap2/prcm-common.h          |    4 ++
 arch/arm/plat-omap/devices.c               |   52 +++++++++++++++++------
 drivers/watchdog/omap_wdt.c                |   43 ++++----------------
 7 files changed, 230 insertions(+), 50 deletions(-)

