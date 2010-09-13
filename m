From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [v4 0/6] OMAP: WDT: Implement WDT in hwmod way
Date: Mon, 13 Sep 2010 20:43:23 +0530
Message-ID: <1284390809-11519-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44299 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006Ab0IMPNq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Sep 2010 11:13:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, wim@iguana.be, linux-watchdog@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, linux-omap@vger.kernel.org, "Varadarajan, Charulatha" <charu@ti.com>

Series of patches to port watchdog module to use hwmod
and omap_device apis for OMAP2plus chips. For this hwmod data
structures are poulated. This patch series also implements watchdog
module to use PM runtime APIs.

This patch series is created on "origin/pm-core" and are
tested on OMAP2430, OMAP44430, OMAP3430 SDP boards and zoom3 board.
Also verified that this patch series does not break the OMAP1 build.

This patch series is dependent on the following patch
for testing on OMAP2:
https://patchwork.kernel.org/patch/174172/

Version History:
---------------
Version v4:
*Implement hwmod adapdation first and then PM runtime adaptation
as two different patches in the series
*Remove inclusion of omap_device.h in the driver file.

Version v3:
*Fix Minor comments like renaming omap1 watchdog structures
with an omap1_ prefix
Some of the v3 links:
https://patchwork.kernel.org/patch/119698/
https://patchwork.kernel.org/patch/119696/ 

Version v2:
*Rebase to latest kernel
Some of the v2 links:
http://www.spinics.net/lists/linux-omap/msg34741.html
http://www.spinics.net/lists/linux-omap/msg34673.html

Version v1:
*Initial series
Some of the v1 links:
http://www.spinics.net/lists/linux-omap/msg30628.html
http://www.spinics.net/lists/linux-omap/msg30625.html

Benoit Cousson (1):
  OMAP4: hwmod data: Add watchdog timer

Varadarajan, Charulatha (5):
  OMAP3: hwmod data: Add watchdog timer
  OMAP2420: hwmod data: Add watchdog timer
  OMAP2430: hwmod data: Add watchdog timer
  OMAP2PLUS: WDT: use omap_device_build for device registration
  OMAP: WDT: Use PM runtime APIs instead of clk FW APIs

 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   59 ++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   59 ++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   61 +++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   68 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm-common.h          |    4 ++
 arch/arm/plat-omap/devices.c               |   64 ++++++++++++++++++--------
 drivers/watchdog/omap_wdt.c                |   57 +++++++++--------------
 7 files changed, 317 insertions(+), 55 deletions(-)

