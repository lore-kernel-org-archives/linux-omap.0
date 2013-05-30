From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/32] OMAPDSS: DSI: cleanup regulator init
Date: Thu, 30 May 2013 12:34:35 +0300
Message-ID: <1369906493-27538-15-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42774 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030321Ab3E3Jfk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 05:35:40 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Separate the regulator initialization code to its own function, removing
duplicate code.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c | 82 ++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 51 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index bdddd0d..37ca980 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1114,6 +1114,30 @@ void dsi_runtime_put(struct platform_device *dsidev)
 	WARN_ON(r < 0 && r != -ENOSYS);
 }
 
+static int dsi_regulator_init(struct platform_device *dsidev)
+{
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct regulator *vdds_dsi;
+
+	if (dsi->vdds_dsi_reg != NULL)
+		return 0;
+
+	vdds_dsi = regulator_get(&dsi->pdev->dev, "vdds_dsi");
+
+	/* DT HACK: try VCXIO to make omapdss work for o4 sdp/panda */
+	if (IS_ERR(vdds_dsi))
+		vdds_dsi = regulator_get(&dsi->pdev->dev, "VCXIO");
+
+	if (IS_ERR(vdds_dsi)) {
+		DSSERR("can't get VDDS_DSI regulator\n");
+		return PTR_ERR(vdds_dsi);
+	}
+
+	dsi->vdds_dsi_reg = vdds_dsi;
+
+	return 0;
+}
+
 /* source clock for DSI PLL. this could also be PCLKFREE */
 static inline void dsi_enable_pll_clock(struct platform_device *dsidev,
 		bool enable)
@@ -1592,22 +1616,9 @@ int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
 	 */
 	enable_hsclk = enable_hsdiv = true;
 
-	if (dsi->vdds_dsi_reg == NULL) {
-		struct regulator *vdds_dsi;
-
-		vdds_dsi = regulator_get(&dsi->pdev->dev, "vdds_dsi");
-
-		/* DT HACK: try VCXIO to make omapdss work for o4 sdp/panda */
-		if (IS_ERR(vdds_dsi))
-			vdds_dsi = regulator_get(&dsi->pdev->dev, "VCXIO");
-
-		if (IS_ERR(vdds_dsi)) {
-			DSSERR("can't get VDDS_DSI regulator\n");
-			return PTR_ERR(vdds_dsi);
-		}
-
-		dsi->vdds_dsi_reg = vdds_dsi;
-	}
+	r = dsi_regulator_init(dsidev);
+	if (r)
+		return r;
 
 	dsi_enable_pll_clock(dsidev, 1);
 	/*
@@ -5225,34 +5236,6 @@ static enum omap_channel dsi_get_channel(int module_id)
 	}
 }
 
-static int dsi_init_display(struct omap_dss_device *dssdev)
-{
-	struct platform_device *dsidev =
-			dsi_get_dsidev_from_id(dssdev->phy.dsi.module);
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-
-	DSSDBG("DSI init\n");
-
-	if (dsi->vdds_dsi_reg == NULL) {
-		struct regulator *vdds_dsi;
-
-		vdds_dsi = regulator_get(&dsi->pdev->dev, "vdds_dsi");
-
-		/* DT HACK: try VCXIO to make omapdss work for o4 sdp/panda */
-		if (IS_ERR(vdds_dsi))
-			vdds_dsi = regulator_get(&dsi->pdev->dev, "VCXIO");
-
-		if (IS_ERR(vdds_dsi)) {
-			DSSERR("can't get VDDS_DSI regulator\n");
-			return PTR_ERR(vdds_dsi);
-		}
-
-		dsi->vdds_dsi_reg = vdds_dsi;
-	}
-
-	return 0;
-}
-
 int omap_dsi_request_vc(struct omap_dss_device *dssdev, int *channel)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
@@ -5410,19 +5393,16 @@ static int dsi_probe_pdata(struct platform_device *dsidev)
 	if (!plat_dssdev)
 		return 0;
 
+	r = dsi_regulator_init(dsidev);
+	if (r)
+		return r;
+
 	dssdev = dss_alloc_and_init_device(&dsidev->dev);
 	if (!dssdev)
 		return -ENOMEM;
 
 	dss_copy_device_pdata(dssdev, plat_dssdev);
 
-	r = dsi_init_display(dssdev);
-	if (r) {
-		DSSERR("device %s init failed: %d\n", dssdev->name, r);
-		dss_put_device(dssdev);
-		return r;
-	}
-
 	r = omapdss_output_set_device(&dsi->output, dssdev);
 	if (r) {
 		DSSERR("failed to connect output to new device: %s\n",
-- 
1.8.1.2

