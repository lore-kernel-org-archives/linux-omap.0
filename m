From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH v2 2/4] ARM: OMAP3: cm-t35: fix DSS regulator supply
Date: Sun,  6 Nov 2011 16:16:24 +0200
Message-ID: <1320588986-9480-2-git-send-email-grinberg@compulab.co.il>
References: <1320588827-9407-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:47331
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752335Ab1KFOQm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Nov 2011 09:16:42 -0500
In-Reply-To: <1320588827-9407-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

cm-t35 DSS suplies are connected to VIO.
In fact, TPS65930 does not have VPLL2.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
v2:	- Rebase on top of fixes branch

 arch/arm/mach-omap2/board-cm-t35.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 7141cb6..724a23c 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -339,12 +339,10 @@ static struct regulator_consumer_supply cm_t35_vsim_supply[] = {
 	REGULATOR_SUPPLY("vmmc_aux", "omap_hsmmc.0"),
 };
 
-static struct regulator_consumer_supply cm_t35_vdvi_supply[] = {
-	REGULATOR_SUPPLY("vdvi", "omapdss"),
-};
-
 static struct regulator_consumer_supply cm_t35_vio_supplies[] = {
 	REGULATOR_SUPPLY("vcc", "spi1.0"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
 };
 
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
@@ -479,12 +477,7 @@ static struct twl4030_platform_data cm_t35_twldata = {
 static void __init cm_t35_init_i2c(void)
 {
 	omap3_pmic_get_config(&cm_t35_twldata, TWL_COMMON_PDATA_USB,
-			TWL_COMMON_REGULATOR_VDAC | TWL_COMMON_REGULATOR_VPLL2);
-
-	cm_t35_twldata.vpll2->constraints.name = "VDVI";
-	cm_t35_twldata.vpll2->num_consumer_supplies =
-						ARRAY_SIZE(cm_t35_vdvi_supply);
-	cm_t35_twldata.vpll2->consumer_supplies = cm_t35_vdvi_supply;
+			TWL_COMMON_REGULATOR_VDAC);
 
 	omap3_pmic_init("tps65930", &cm_t35_twldata);
 }
-- 
1.7.3.4

