From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 13/32] OMAPDSS: CORE: use devm_regulator_get
Date: Thu, 30 May 2013 12:34:34 +0300
Message-ID: <1369906493-27538-14-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37444 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030278Ab3E3Jfj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:35:39 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use devm_regulator_get() instead of regulator_get() to simplify code.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 4bd8f79..f64d0ac 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -80,7 +80,7 @@ struct regulator *dss_get_vdds_dsi(void)
 	if (core.vdds_dsi_reg != NULL)
 		return core.vdds_dsi_reg;
 
-	reg = regulator_get(&core.pdev->dev, "vdds_dsi");
+	reg = devm_regulator_get(&core.pdev->dev, "vdds_dsi");
 	if (!IS_ERR(reg))
 		core.vdds_dsi_reg = reg;
 
@@ -94,7 +94,7 @@ struct regulator *dss_get_vdds_sdi(void)
 	if (core.vdds_sdi_reg != NULL)
 		return core.vdds_sdi_reg;
 
-	reg = regulator_get(&core.pdev->dev, "vdds_sdi");
+	reg = devm_regulator_get(&core.pdev->dev, "vdds_sdi");
 	if (!IS_ERR(reg))
 		core.vdds_sdi_reg = reg;
 
@@ -654,16 +654,6 @@ static int __init omap_dss_init(void)
 
 static void __exit omap_dss_exit(void)
 {
-	if (core.vdds_dsi_reg != NULL) {
-		regulator_put(core.vdds_dsi_reg);
-		core.vdds_dsi_reg = NULL;
-	}
-
-	if (core.vdds_sdi_reg != NULL) {
-		regulator_put(core.vdds_sdi_reg);
-		core.vdds_sdi_reg = NULL;
-	}
-
 	omap_dss_unregister_drivers();
 
 	omap_dss_bus_unregister();
-- 
1.8.1.2

