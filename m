From: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>
Subject: [PATCH 1/2] omap3: beagle: adding regulator supply for vdds_sdi.
Date: Fri, 28 Jan 2011 01:49:30 -0200
Message-ID: <1296186571-22009-2-git-send-email-ricardo.salveti@canonical.com>
References: <1296186571-22009-1-git-send-email-ricardo.salveti@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:37600 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888Ab1A1Dtw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jan 2011 22:49:52 -0500
In-Reply-To: <1296186571-22009-1-git-send-email-ricardo.salveti@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Mathieu J. Poirier" <mathieu.poirier@canonical.com>, Leann Ogasawara <leann.ogasawara@canonical.com>

From: Mathieu J. Poirier <mathieu.poirier@canonical.com>

The omapfb driver couldn't locate its display sink because of
an initialisation error in the DSS subsystem.  This error was
caused by a missing 'sdi' entry in the board power regulator list.

BugLink: https://bugs.launchpad.net/bugs/597904

Signed-off-by: Mathieu J. Poirier <mathieu.poirier@canonical.com>
Signed-off-by: Leann Ogasawara <leann.ogasawara@canonical.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 46d814a..685ac06 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -239,8 +239,10 @@ static struct platform_device beagle_dss_device = {
 static struct regulator_consumer_supply beagle_vdac_supply =
 	REGULATOR_SUPPLY("vdda_dac", "omapdss");
 
-static struct regulator_consumer_supply beagle_vdvi_supply =
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss");
+static struct regulator_consumer_supply beagle_vdds_supplies[] = {
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
+	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
+};
 
 static void __init beagle_display_init(void)
 {
@@ -419,7 +421,6 @@ static struct regulator_init_data beagle_vdac = {
 /* VPLL2 for digital video outputs */
 static struct regulator_init_data beagle_vpll2 = {
 	.constraints = {
-		.name			= "VDVI",
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
@@ -427,8 +428,8 @@ static struct regulator_init_data beagle_vpll2 = {
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &beagle_vdvi_supply,
+	.num_consumer_supplies  = ARRAY_SIZE(beagle_vdds_supplies),
+	.consumer_supplies      = beagle_vdds_supplies,
 };
 
 static struct twl4030_usb_data beagle_usb_data = {
-- 
1.7.2.3

