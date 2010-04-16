From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv3 12/22] OMAP3: PM: Minimizing the passing around of sr id in smartreflex.c
Date: Fri, 16 Apr 2010 14:33:07 +0530
Message-ID: <1271408597-3066-13-git-send-email-thara@ti.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36075 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756941Ab0DPJDa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Apr 2010 05:03:30 -0400
In-Reply-To: <1271408597-3066-12-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch ensures that sr id is passed as a parameter only to
public APIs in smartreflex.c and other APIs in smartreflex.c
uses the omap_sr strucutres.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   36 +++++++++++++-----------------------
 1 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index fffd5f7..c6942e9 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -190,16 +190,8 @@ static void sr_configure(struct omap_sr *sr)
 	sr->is_sr_reset = 0;
 }
 
-static void sr_start_vddautocomp(int srid)
+static void sr_start_vddautocomp(struct omap_sr *sr)
 {
-	struct omap_sr *sr = _sr_lookup(srid);
-
-	if (!sr) {
-		pr_warning("omap_sr struct corresponding to SR%d not found\n",
-								srid + 1);
-		return;
-	}
-
 	if (!sr_class || !(sr_class->enable)) {
 		pr_warning("smartreflex class driver not registered\n");
 		return;
@@ -211,30 +203,22 @@ static void sr_start_vddautocomp(int srid)
 	}
 
 	sr->is_autocomp_active = 1;
-	if (!sr_class->enable(srid)) {
+	if (!sr_class->enable(sr->srid)) {
 		sr->is_autocomp_active = 0;
 		if (sr->is_sr_reset == 1)
 			sr_clk_disable(sr);
 	}
 }
 
-static void  sr_stop_vddautocomp(int srid)
+static void  sr_stop_vddautocomp(struct omap_sr *sr)
 {
-	struct omap_sr *sr = _sr_lookup(srid);
-
-	if (!sr) {
-		pr_warning("omap_sr struct corresponding to SR%d not found\n",
-								srid + 1);
-		return;
-	}
-
 	if (!sr_class || !(sr_class->disable)) {
 		pr_warning("smartreflex class driver not registered\n");
 		return;
 	}
 
 	if (sr->is_autocomp_active == 1) {
-		sr_class->disable(srid);
+		sr_class->disable(sr->srid);
 		sr_clk_disable(sr);
 		sr->is_autocomp_active = 0;
 	}
@@ -426,9 +410,9 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 		return 0;
 	}
 	if (val == 0)
-		sr_stop_vddautocomp(sr_info->srid);
+		sr_stop_vddautocomp(sr_info);
 	else
-		sr_start_vddautocomp(sr_info->srid);
+		sr_start_vddautocomp(sr_info);
 	return 0;
 }
 
@@ -468,9 +452,15 @@ static int __devexit omap_smartreflex_remove(struct platform_device *pdev)
 {
 	struct omap_sr *sr_info = _sr_lookup(pdev->id + 1);
 
+	if (!sr_info) {
+		pr_warning("omap_sr struct corresponding to SR%d not found\n",
+							pdev->id + 1);
+		return 0;
+	}
+
 	/* Disable Autocompensation if enabled before removing the module */
 	if (sr_info->is_autocomp_active == 1)
-		sr_stop_vddautocomp(sr_info->srid);
+		sr_stop_vddautocomp(sr_info);
 	list_del(&sr_info->node);
 	kfree(sr_info);
 
-- 
1.7.0.rc1.33.g07cf0f

