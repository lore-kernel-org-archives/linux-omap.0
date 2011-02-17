From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH] omap3: Adding vdd_sdi regulator supply to OMAP3EVM
Date: Thu, 17 Feb 2011 16:11:14 +0800
Message-ID: <1297930274-16278-1-git-send-email-bryan.wu@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:39291 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab1BQILc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 03:11:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, kernel-team@lists.ubuntu.com

From: Mathieu J. Poirier <mathieu.poirier@canonical.com>

https://bugs.launchpad.net/bugs/630885

When booting, the omapdss subsystem is looking for a regulator named
"vdds_sdi". When the regulator is not found the initialisation sequence
is aborted resulting in omapfb not finding a display to work with.  This
patch allows the omapfb sub system to complete its initialisation
properly and enable LCD display. The problem was fixed by lumping a
"vdds_sdi" with the already existing "vdds_dsi" regulator. This fix
takes its root from work done on the Beagle board and the Pandora board.

Signed-off-by: Mathieu Poirier <mathieu.poirier@canonical.com>
Signed-off-by: Andy Whitcroft <apw@canonical.com>
Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index c2a0fca..8b8eb36 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -521,8 +521,10 @@ static struct regulator_init_data omap3_evm_vdac = {
 };
 
 /* VPLL2 for digital video outputs */
-static struct regulator_consumer_supply omap3_evm_vpll2_supply =
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss");
+static struct regulator_consumer_supply omap3_evm_vdds_supplies[] = {
+	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
+};
 
 static struct regulator_init_data omap3_evm_vpll2 = {
 	.constraints = {
@@ -534,8 +536,8 @@ static struct regulator_init_data omap3_evm_vpll2 = {
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &omap3_evm_vpll2_supply,
+	.num_consumer_supplies	= ARRAY_SIZE(omap3_evm_vdds_supplies),
+	.consumer_supplies	= omap3_evm_vdds_supplies,
 };
 
 static struct twl4030_platform_data omap3evm_twldata = {
-- 
1.7.1

