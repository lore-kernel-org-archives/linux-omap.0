From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v6 0/7] OMAP: WDT: Implement WDT in hwmod way
Date: Fri, 17 Sep 2010 19:48:49 +0530
Message-ID: <1284733136-20952-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39132 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750695Ab0IQOTV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Sep 2010 10:19:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, wim@iguana.be, linux-watchdog@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, linux-omap@vger.kernel.org, "Varadarajan, Charulatha" <charu@ti.com>

Series of patches to port watchdog module to use hwmod APIs
for OMAP2PLUS chips and use runtime APIs for all OMAP chips.
For this hwmod database for OMAP2PLUS watchdog instances are
populated. This patch series also implements watchdog
module to use PM runtime APIs.

This patch series is created on "origin/pm-core" and is
tested on OMAP2430, OMAP44430, OMAP3430 SDP boards and zoom3 board.
Also verified that this patch series does not break the OMAP1 build.

This series is tested on OMAP4430 ES2 using the below series
http://www.spinics.net/lists/linux-omap/msg36023.html

Version History:
---------------
Version v6:
*Split omap_init_wdt() into separate omap_init_wdt functions
under mach-omap1 and mach-omap2 and set them up with
subsys_initcall
*Include wd_timer3 database for OMAP4
*In hwmod database follow naming convention "wd_timerX"

Version v5:
*Delete wdt_runtime_resume and wdt_runtime_suspend
functions as the fix for the return values in the generic
runtime PM calls has been queued for 2.6.37 (see below link)
https://lists.linux-foundation.org/pipermail/linux-pm/2010-September/028466.html
Some of the v5 links:
https://patchwork.kernel.org/patch/181812/
https://patchwork.kernel.org/patch/181782/
https://patchwork.kernel.org/patch/181772/
https://patchwork.kernel.org/patch/181792/

Version v4:
*Implement hwmod adapdation first and then PM runtime adaptation
as two different patches in the series
*Remove inclusion of omap_device.h in the driver file.
Some of the v4 links:
https://patchwork.kernel.org/patch/174672/
https://patchwork.kernel.org/patch/174662/

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

Varadarajan, Charulatha (6):
  OMAP2PLUS: WDT: Add ICLKEN, FCLKEN, WKEN shared bits for WDT
  OMAP3: hwmod data: Add watchdog timer
  OMAP2420: hwmod data: Add watchdog timer
  OMAP2430: hwmod data: Add watchdog timer
  OMAP2PLUS: WDT: use omap_device_build for device registration
  OMAP: WDT: Use PM runtime APIs instead of clk FW APIs

 arch/arm/mach-omap1/devices.c              |   27 ++++++
 arch/arm/mach-omap2/devices.c              |   38 ++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   63 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   63 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   65 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  135 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm-common.h          |    4 +
 arch/arm/plat-omap/devices.c               |   41 ---------
 drivers/watchdog/omap_wdt.c                |   42 ++-------
 9 files changed, 402 insertions(+), 76 deletions(-)

