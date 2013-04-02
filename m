From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] OMAPDSS: DSI: Use devm_clk_get()
Date: Tue,  2 Apr 2013 17:03:23 +0530
Message-ID: <1364902403-9980-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:63260 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760767Ab3DBLpl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Apr 2013 07:45:41 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so200267pbc.3
        for <linux-omap@vger.kernel.org>; Tue, 02 Apr 2013 04:45:40 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: tomi.valkeinen@ti.com, FlorianSchandinat@gmx.de, akpm@linux-foundation.org, sachin.kamat@linaro.org

Using devm_clk_get cleans up some code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
Compile tested on linux-next tree (20130402).
---
 drivers/video/omap2/dss/dsi.c |   19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 8db29bf..9b1c5ec 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -5347,7 +5347,7 @@ static int dsi_get_clocks(struct platform_device *dsidev)
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct clk *clk;
 
-	clk = clk_get(&dsidev->dev, "fck");
+	clk = devm_clk_get(&dsidev->dev, "fck");
 	if (IS_ERR(clk)) {
 		DSSERR("can't get fck\n");
 		return PTR_ERR(clk);
@@ -5355,11 +5355,9 @@ static int dsi_get_clocks(struct platform_device *dsidev)
 
 	dsi->dss_clk = clk;
 
-	clk = clk_get(&dsidev->dev, "sys_clk");
+	clk = devm_clk_get(&dsidev->dev, "sys_clk");
 	if (IS_ERR(clk)) {
 		DSSERR("can't get sys_clk\n");
-		clk_put(dsi->dss_clk);
-		dsi->dss_clk = NULL;
 		return PTR_ERR(clk);
 	}
 
@@ -5368,16 +5366,6 @@ static int dsi_get_clocks(struct platform_device *dsidev)
 	return 0;
 }
 
-static void dsi_put_clocks(struct platform_device *dsidev)
-{
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-
-	if (dsi->dss_clk)
-		clk_put(dsi->dss_clk);
-	if (dsi->sys_clk)
-		clk_put(dsi->sys_clk);
-}
-
 static struct omap_dss_device * __init dsi_find_dssdev(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
@@ -5592,7 +5580,6 @@ static int __init omap_dsihw_probe(struct platform_device *dsidev)
 
 err_runtime_get:
 	pm_runtime_disable(&dsidev->dev);
-	dsi_put_clocks(dsidev);
 	return r;
 }
 
@@ -5608,8 +5595,6 @@ static int __exit omap_dsihw_remove(struct platform_device *dsidev)
 
 	pm_runtime_disable(&dsidev->dev);
 
-	dsi_put_clocks(dsidev);
-
 	if (dsi->vdds_dsi_reg != NULL) {
 		if (dsi->vdds_dsi_enabled) {
 			regulator_disable(dsi->vdds_dsi_reg);
-- 
1.7.9.5

