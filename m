From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH] omap: mmc: make mmc build again for omap1
Date: Wed, 12 Nov 2008 01:05:44 +0200
Message-ID: <1226444744-22617-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56725 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbYKKXF7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:05:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Trivial fix making mmc build for omap1 boards.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/board-innovator.c |    2 +-
 arch/arm/mach-omap1/devices.c         |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 7a97f6b..feaf616 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -385,7 +385,7 @@ static struct omap_mmc_platform_data mmc1_data = {
 	.nr_slots                       = 1,
 	.slots[0]       = {
 		.set_power		= mmc_set_power,
-		.wire4			= 1,
+		.wires			= 4,
 		.name                   = "mmcblk",
 	},
 };
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 45712a5..e8ff6b5 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -116,7 +116,7 @@ static inline void omap1_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 			omap_cfg_reg(P19_1710_MMC_CMDDIR);
 			omap_cfg_reg(P20_1710_MMC_DATDIR0);
 		}
-		if (mmc_controller->slots[0].wire4) {
+		if (mmc_controller->slots[0].wires == 4) {
 			omap_cfg_reg(MMC_DAT1);
 			/* NOTE: DAT2 can be on W10 (here) or M15 */
 			if (!mmc_controller->slots[0].nomux)
@@ -132,7 +132,7 @@ static inline void omap1_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 			omap_cfg_reg(Y10_1610_MMC2_CLK);
 			omap_cfg_reg(R18_1610_MMC2_CLKIN);
 			omap_cfg_reg(W8_1610_MMC2_DAT0);
-			if (mmc_controller->slots[1].wire4) {
+			if (mmc_controller->slots[1].wires == 4) {
 				omap_cfg_reg(V8_1610_MMC2_DAT1);
 				omap_cfg_reg(W15_1610_MMC2_DAT2);
 				omap_cfg_reg(R10_1610_MMC2_DAT3);
-- 
1.6.0.2.307.gc427

