From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 15/32] OMAPDSS: DPI: cleanup pll & regulator init
Date: Thu, 30 May 2013 12:34:36 +0300
Message-ID: <1369906493-27538-16-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49815 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030327Ab3E3Jfm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:35:42 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Split regulator and DSI PLL init code to their own functions for
clarity.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c | 100 ++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 47 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 43f6b26..66ba9a6 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -545,6 +545,53 @@ static int dpi_verify_dsi_pll(struct platform_device *dsidev)
 	return 0;
 }
 
+static int dpi_init_regulator(void)
+{
+	struct regulator *vdds_dsi;
+
+	if (!dss_has_feature(FEAT_DPI_USES_VDDS_DSI))
+		return 0;
+
+	if (dpi.vdds_dsi_reg)
+		return 0;
+
+	vdds_dsi = dss_get_vdds_dsi();
+
+	if (!IS_ERR(vdds_dsi)) {
+		dpi.vdds_dsi_from_core = true;
+		dpi.vdds_dsi_reg = vdds_dsi;
+		return 0;
+	}
+
+	vdds_dsi = regulator_get(&dpi.pdev->dev, "vdds_dsi");
+	if (!IS_ERR(vdds_dsi)) {
+		dpi.vdds_dsi_from_core = false;
+		dpi.vdds_dsi_reg = vdds_dsi;
+		return 0;
+	}
+
+	return PTR_ERR(vdds_dsi);
+}
+
+static void dpi_init_pll(void)
+{
+	struct platform_device *dsidev;
+
+	if (dpi.dsidev)
+		return;
+
+	dsidev = dpi_get_dsidev(dpi.output.dispc_channel);
+	if (!dsidev)
+		return;
+
+	if (dpi_verify_dsi_pll(dsidev)) {
+		DSSWARN("DSI PLL not operational\n");
+		return;
+	}
+
+	dpi.dsidev = dsidev;
+}
+
 /*
  * Return a hardcoded channel for the DPI output. This should work for
  * current use cases, but this can be later expanded to either resolve
@@ -575,46 +622,6 @@ static enum omap_channel dpi_get_channel(void)
 	}
 }
 
-static int dpi_init_display(struct omap_dss_device *dssdev)
-{
-	struct platform_device *dsidev;
-
-	DSSDBG("init_display\n");
-
-	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI) &&
-					dpi.vdds_dsi_reg == NULL) {
-		struct regulator *vdds_dsi;
-
-		vdds_dsi = dss_get_vdds_dsi();
-		if (IS_ERR(vdds_dsi)) {
-			vdds_dsi = regulator_get(&dpi.pdev->dev, "vdds_dsi");
-			if (IS_ERR(vdds_dsi)) {
-				DSSERR("can't get VDDS_DSI regulator\n");
-				return PTR_ERR(vdds_dsi);
-			}
-			dpi.vdds_dsi_from_core = false;
-		} else {
-			dpi.vdds_dsi_from_core = true;
-		}
-
-		dpi.vdds_dsi_reg = vdds_dsi;
-	}
-
-	dsidev = dpi_get_dsidev(dpi.output.dispc_channel);
-
-	if (dsidev && dpi_verify_dsi_pll(dsidev)) {
-		dsidev = NULL;
-		DSSWARN("DSI PLL not operational\n");
-	}
-
-	if (dsidev)
-		DSSDBG("using DSI PLL for DPI clock\n");
-
-	dpi.dsidev = dsidev;
-
-	return 0;
-}
-
 static struct omap_dss_device *dpi_find_dssdev(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
@@ -654,19 +661,18 @@ static int dpi_probe_pdata(struct platform_device *dpidev)
 	if (!plat_dssdev)
 		return 0;
 
+	r = dpi_init_regulator();
+	if (r)
+		return r;
+
+	dpi_init_pll();
+
 	dssdev = dss_alloc_and_init_device(&dpidev->dev);
 	if (!dssdev)
 		return -ENOMEM;
 
 	dss_copy_device_pdata(dssdev, plat_dssdev);
 
-	r = dpi_init_display(dssdev);
-	if (r) {
-		DSSERR("device %s init failed: %d\n", dssdev->name, r);
-		dss_put_device(dssdev);
-		return r;
-	}
-
 	r = omapdss_output_set_device(&dpi.output, dssdev);
 	if (r) {
 		DSSERR("failed to connect output to new device: %s\n",
-- 
1.8.1.2

