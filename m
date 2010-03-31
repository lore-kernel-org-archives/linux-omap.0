From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2 1/3] OMAP3: PM: Fix crash when enabling SmartReflex on non-supported OMAPs.
Date: Wed, 31 Mar 2010 12:00:12 +0530
Message-ID: <1270017014-27704-2-git-send-email-thara@ti.com>
References: <1270017014-27704-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53811 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932761Ab0CaGac (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 02:30:32 -0400
In-Reply-To: <1270017014-27704-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch sets and unsets is_sr_reset is appropriate places so that
trying to enable smart reflex in a non-supported OMAP chip does not
lead to unnecessary crash. Basically today if sr_enable fails,
sr_disable will crash due to accessing sr registers when sr clocks
are not turned on. By checking on is_sr_reset flag and setting and
unsetting this flag appropriately this crash is fixed in this
patch.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   31 +++++++++++++++++++++----------
 1 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 1d7d2e6..3f4b47b 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -115,9 +115,14 @@ static int sr_clk_enable(struct omap_sr *sr)
 {
 	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
 
+	if (!sr->is_sr_reset)
+		return 0;
+
 	if (pdata->device_enable)
 		pdata->device_enable(sr->pdev);
 
+	sr->is_sr_reset = 0;
+
 	return 0;
 }
 
@@ -125,6 +130,9 @@ static void sr_clk_disable(struct omap_sr *sr)
 {
 	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
 
+	if (sr->is_sr_reset)
+		return;
+
 	if (pdata->device_idle)
 		pdata->device_idle(sr->pdev);
 
@@ -308,7 +316,6 @@ static void sr_configure(struct omap_sr *sr)
 			 ERRCONFIG_MCUVALIDINTEN | ERRCONFIG_MCUVALIDINTST |
 			 ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_MCUBOUNDINTST));
 	}
-	sr->is_sr_reset = 0;
 }
 
 static void sr_start_vddautocomp(int srid)
@@ -329,8 +336,7 @@ static void sr_start_vddautocomp(int srid)
 	sr->is_autocomp_active = 1;
 	if (!sr_class->enable(srid)) {
 		sr->is_autocomp_active = 0;
-		if (sr->is_sr_reset == 1)
-			sr_clk_disable(sr);
+		sr_clk_disable(sr);
 	}
 }
 
@@ -350,8 +356,10 @@ static void  sr_stop_vddautocomp(int srid)
 	}
 
 	if (sr->is_autocomp_active == 1) {
-		sr_class->disable(srid);
-		sr_clk_disable(sr);
+		if (!sr->is_sr_reset) {
+			sr_class->disable(srid);
+			sr_clk_disable(sr);
+		}
 		sr->is_autocomp_active = 0;
 	}
 }
@@ -431,6 +439,11 @@ int sr_enable(int srid, unsigned long volt)
 
 	/* Enable the clocks and configure SR */
 	sr_clk_enable(sr);
+
+	/* Check if SR is already enabled. If yes do nothing */
+	if (sr_read_reg(sr, SRCONFIG) & SRCONFIG_SRENABLE)
+		return true;
+
 	sr_configure(sr);
 
 	sr_write_reg(sr, NVALUERECIPROCAL, nvalue_reciprocal);
@@ -518,10 +531,8 @@ void omap_smartreflex_enable(int srid)
 	}
 
 	if (sr->is_autocomp_active == 1) {
-		if (sr->is_sr_reset == 1) {
-			if (!sr_class->enable(srid))
-				sr_clk_disable(sr);
-		}
+		if (!sr_class->enable(srid))
+			sr_clk_disable(sr);
 	}
 }
 
@@ -550,7 +561,7 @@ void omap_smartreflex_disable(int srid)
 	}
 
 	if (sr->is_autocomp_active == 1) {
-		if (sr->is_sr_reset == 0) {
+		if (!sr->is_sr_reset) {
 			sr_class->disable(srid);
 			/* Disable SR clk */
 			sr_clk_disable(sr);
-- 
1.7.0.rc1.33.g07cf0f

