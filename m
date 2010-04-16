From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv3 22/22] OMAP3: PM: Fix crash when enabling SmartReflex on non-supported OMAPs.
Date: Fri, 16 Apr 2010 14:33:17 +0530
Message-ID: <1271408597-3066-23-git-send-email-thara@ti.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
 <1271408597-3066-2-git-send-email-thara@ti.com>
 <1271408597-3066-3-git-send-email-thara@ti.com>
 <1271408597-3066-4-git-send-email-thara@ti.com>
 <1271408597-3066-5-git-send-email-thara@ti.com>
 <1271408597-3066-6-git-send-email-thara@ti.com>
 <1271408597-3066-7-git-send-email-thara@ti.com>
 <1271408597-3066-8-git-send-email-thara@ti.com>
 <1271408597-3066-9-git-send-email-thara@ti.com>
 <1271408597-3066-10-git-send-email-thara@ti.com>
 <1271408597-3066-11-git-send-email-thara@ti.com>
 <1271408597-3066-12-git-send-email-thara@ti.com>
 <1271408597-3066-13-git-send-email-thara@ti.com>
 <1271408597-3066-14-git-send-email-thara@ti.com>
 <1271408597-3066-15-git-send-email-thara@ti.com>
 <1271408597-3066-16-git-send-email-thara@ti.com>
 <1271408597-3066-17-git-send-email-thara@ti.com>
 <1271408597-3066-18-git-send-email-thara@ti.com>
 <1271408597-3066-19-git-send-email-thara@ti.com>
 <1271408597-3066-20-git-send-email-thara@ti.com>
 <1271408597-3066-21-git-send-email-thara@ti.com>
 <1271408597-3066-22-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40662 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757127Ab0DPJDc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 05:03:32 -0400
In-Reply-To: <1271408597-3066-22-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch renames is_sr_reset to is_sr_enable and  sets and unsets
this flag in appropriate places so that trying to enable smart reflex in a
non-supported OMAP chip does not lead to unnecessary crash.
Basically today if sr_enable fails, sr_disable will crash due to accessing
sr registers when sr clocks are not turned on.
By checking on is_sr_reset flag and setting and
unsetting this flag appropriately this crash is fixed in this
patch.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   93 +++++++++++++++++++------------------
 1 files changed, 47 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 6b7d9aa..4dccfd1 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -41,7 +41,7 @@
 
 struct omap_sr {
 	int			srid;
-	int			is_sr_reset;
+	int			is_sr_enable;
 	int			is_autocomp_active;
 	u32			clk_length;
 	u32			err_weight;
@@ -111,26 +111,6 @@ static struct omap_sr *_sr_lookup(int srid)
 	return sr_info;
 }
 
-static int sr_clk_enable(struct omap_sr *sr)
-{
-	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
-
-	if (pdata->device_enable)
-		pdata->device_enable(sr->pdev);
-
-	return 0;
-}
-
-static void sr_clk_disable(struct omap_sr *sr)
-{
-	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
-
-	if (pdata->device_idle)
-		pdata->device_idle(sr->pdev);
-
-	sr->is_sr_reset = 1;
-}
-
 static irqreturn_t sr_omap_isr(int irq, void *data)
 {
 	struct omap_sr *sr_info = (struct omap_sr *)data;
@@ -211,11 +191,8 @@ static void sr_start_vddautocomp(struct omap_sr *sr)
 	}
 
 	sr->is_autocomp_active = 1;
-	if (!sr_class->enable(sr->srid)) {
+	if (!sr_class->enable(sr->srid))
 		sr->is_autocomp_active = 0;
-		if (sr->is_sr_reset == 1)
-			sr_clk_disable(sr);
-	}
 }
 
 static void  sr_stop_vddautocomp(struct omap_sr *sr)
@@ -227,7 +204,6 @@ static void  sr_stop_vddautocomp(struct omap_sr *sr)
 
 	if (sr->is_autocomp_active == 1) {
 		sr_class->disable(sr->srid, 1);
-		sr_clk_disable(sr);
 		sr->is_autocomp_active = 0;
 	}
 }
@@ -314,7 +290,6 @@ void sr_configure_errgen(int srid)
 	sr_modify_reg(sr, ERRCONFIG,
 		(ERRCONFIG_VPBOUNDINTEN),
 		(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST));
-	sr->is_sr_reset = 0;
 }
 
 /**
@@ -366,7 +341,6 @@ void sr_configure_minmax(int srid)
 		(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUACCUMINTST |
 		 ERRCONFIG_MCUVALIDINTEN | ERRCONFIG_MCUVALIDINTST |
 		 ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_MCUBOUNDINTST));
-	sr->is_sr_reset = 0;
 }
 
 /**
@@ -406,8 +380,25 @@ int sr_enable(int srid, unsigned long volt)
 	/* errminlimit is opp dependent and hence linked to voltage */
 	sr->err_minlimit = volt_data.sr_errminlimit;
 
-	/* Enable the clocks and configure SR */
-	sr_clk_enable(sr);
+	/* Enable the clocks */
+	if (!sr->is_sr_enable) {
+		struct omap_smartreflex_data *pdata =
+				sr->pdev->dev.platform_data;
+		if (pdata->device_enable) {
+			pdata->device_enable(sr->pdev);
+		} else {
+			pr_warning("Not able to turn on SR%d clocks during \
+					enable. So returning", sr->srid + 1);
+			return false;
+		}
+		sr->is_sr_enable = 1;
+	}
+
+	/* Check if SR is already enabled. If yes do nothing */
+	if (sr_read_reg(sr, SRCONFIG) & SRCONFIG_SRENABLE)
+		return true;
+
+	/* Configure SR */
 	sr_class->configure(sr->srid);
 
 	sr_write_reg(sr, NVALUERECIPROCAL, nvalue_reciprocal);
@@ -426,6 +417,7 @@ int sr_enable(int srid, unsigned long volt)
 void sr_disable(int srid)
 {
 	struct omap_sr *sr = _sr_lookup(srid);
+	struct omap_smartreflex_data *pdata;
 	int timeout = 0;
 
 	if (!sr) {
@@ -434,10 +426,14 @@ void sr_disable(int srid)
 		return;
 	}
 
-	/* Check if SR is already disabled. If yes do nothing */
-	if (!(sr_read_reg(sr, SRCONFIG) & SRCONFIG_SRENABLE))
+	/* Check if SR clocks are already disabled. If yes do nothing */
+	if (!sr->is_sr_enable)
 		return;
 
+	/* Check if SR is already disabled. If yes just disable the clocks */
+	if (!(sr_read_reg(sr, SRCONFIG) & SRCONFIG_SRENABLE))
+		goto disable_clocks;
+
 	/* Enable MCUDisableAcknowledge interrupt */
 	sr_modify_reg(sr, ERRCONFIG,
 			ERRCONFIG_MCUDISACKINTEN, ERRCONFIG_MCUDISACKINTEN);
@@ -467,6 +463,17 @@ void sr_disable(int srid)
 	 */
 	sr_modify_reg(sr, ERRCONFIG, ERRCONFIG_MCUDISACKINTEN,
 			ERRCONFIG_MCUDISACKINTST);
+
+disable_clocks:
+	pdata = sr->pdev->dev.platform_data;
+	if (pdata->device_idle) {
+		pdata->device_idle(sr->pdev);
+	} else {
+		pr_warning("Unable to turn off SR%d clocks during SR disable",
+				srid);
+		return;
+	}
+	sr->is_sr_enable = 0;
 }
 
 /**
@@ -489,17 +496,15 @@ void omap_smartreflex_enable(int srid)
 		return;
 	}
 
+	if (!sr->is_autocomp_active)
+		return;
+
 	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
 		pr_warning("smartreflex class driver not registered\n");
 		return;
 	}
 
-	if (sr->is_autocomp_active == 1) {
-		if (sr->is_sr_reset == 1) {
-			if (!sr_class->enable(srid))
-				sr_clk_disable(sr);
-		}
-	}
+	sr_class->enable(srid);
 }
 
 /**
@@ -525,18 +530,15 @@ void omap_smartreflex_disable(int srid, int is_volt_reset)
 		return;
 	}
 
+	if (!sr->is_autocomp_active)
+		return;
+
 	if (!sr_class || !(sr_class->disable)) {
 		pr_warning("smartreflex class driver not registered\n");
 		return;
 	}
 
-	if (sr->is_autocomp_active == 1) {
-		if (sr->is_sr_reset == 0) {
-			sr_class->disable(srid, is_volt_reset);
-			/* Disable SR clk */
-			sr_clk_disable(sr);
-		}
-	}
+	sr_class->disable(srid, is_volt_reset);
 }
 
 /**
@@ -615,7 +617,6 @@ static int __devinit omap_smartreflex_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	sr_info->pdev = pdev;
 	sr_info->srid = pdev->id;
-	sr_info->is_sr_reset = 1,
 	sr_info->is_autocomp_active = 0;
 	sr_info->clk_length = 0;
 	if (odev->hwmods[0]->mpu_irqs)
-- 
1.7.0.rc1.33.g07cf0f

