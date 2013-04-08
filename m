From: Archit Taneja <archit@ti.com>
Subject: [PATCH] omapdss: use devm_clk_get()
Date: Mon, 8 Apr 2013 14:25:46 +0530
Message-ID: <1365411346-30611-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60706 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759359Ab3DHI4s (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Apr 2013 04:56:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Use devm_clk_get() instead of clk_get() for dss, and for outputs hdmi and venc.
This reduces reduces code and simplifies error handling.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss.c  |   18 +++---------------
 drivers/video/omap2/dss/hdmi.c |   16 ++--------------
 drivers/video/omap2/dss/venc.c |   10 +---------
 3 files changed, 6 insertions(+), 38 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 054c2a2..645b3bc 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -767,13 +767,11 @@ int dss_dpi_select_source(enum omap_channel channel)
 static int dss_get_clocks(void)
 {
 	struct clk *clk;
-	int r;
 
-	clk = clk_get(&dss.pdev->dev, "fck");
+	clk = devm_clk_get(&dss.pdev->dev, "fck");
 	if (IS_ERR(clk)) {
 		DSSERR("can't get clock fck\n");
-		r = PTR_ERR(clk);
-		goto err;
+		return PTR_ERR(clk);
 	}
 
 	dss.dss_clk = clk;
@@ -782,8 +780,7 @@ static int dss_get_clocks(void)
 		clk = clk_get(NULL, dss.feat->clk_name);
 		if (IS_ERR(clk)) {
 			DSSERR("Failed to get %s\n", dss.feat->clk_name);
-			r = PTR_ERR(clk);
-			goto err;
+			return PTR_ERR(clk);
 		}
 	} else {
 		clk = NULL;
@@ -792,21 +789,12 @@ static int dss_get_clocks(void)
 	dss.dpll4_m4_ck = clk;
 
 	return 0;
-
-err:
-	if (dss.dss_clk)
-		clk_put(dss.dss_clk);
-	if (dss.dpll4_m4_ck)
-		clk_put(dss.dpll4_m4_ck);
-
-	return r;
 }
 
 static void dss_put_clocks(void)
 {
 	if (dss.dpll4_m4_ck)
 		clk_put(dss.dpll4_m4_ck);
-	clk_put(dss.dss_clk);
 }
 
 static int dss_runtime_get(void)
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 7292364..c7e0bf7 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -804,7 +804,7 @@ static int hdmi_get_clocks(struct platform_device *pdev)
 {
 	struct clk *clk;
 
-	clk = clk_get(&pdev->dev, "sys_clk");
+	clk = devm_clk_get(&pdev->dev, "sys_clk");
 	if (IS_ERR(clk)) {
 		DSSERR("can't get sys_clk\n");
 		return PTR_ERR(clk);
@@ -815,12 +815,6 @@ static int hdmi_get_clocks(struct platform_device *pdev)
 	return 0;
 }
 
-static void hdmi_put_clocks(void)
-{
-	if (hdmi.sys_clk)
-		clk_put(hdmi.sys_clk);
-}
-
 #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
 int hdmi_compute_acr(u32 sample_freq, u32 *n, u32 *cts)
 {
@@ -1100,7 +1094,7 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 	r = hdmi_panel_init();
 	if (r) {
 		DSSERR("can't init panel\n");
-		goto err_panel_init;
+		return r;
 	}
 
 	dss_debugfs_create_file("hdmi", hdmi_dump_regs);
@@ -1110,10 +1104,6 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 	hdmi_probe_pdata(pdev);
 
 	return 0;
-
-err_panel_init:
-	hdmi_put_clocks();
-	return r;
 }
 
 static int __exit hdmi_remove_child(struct device *dev, void *data)
@@ -1135,8 +1125,6 @@ static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 
-	hdmi_put_clocks();
-
 	return 0;
 }
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 006caf3..c27ab6f 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -721,7 +721,7 @@ static int venc_get_clocks(struct platform_device *pdev)
 	struct clk *clk;
 
 	if (dss_has_feature(FEAT_VENC_REQUIRES_TV_DAC_CLK)) {
-		clk = clk_get(&pdev->dev, "tv_dac_clk");
+		clk = devm_clk_get(&pdev->dev, "tv_dac_clk");
 		if (IS_ERR(clk)) {
 			DSSERR("can't get tv_dac_clk\n");
 			return PTR_ERR(clk);
@@ -735,12 +735,6 @@ static int venc_get_clocks(struct platform_device *pdev)
 	return 0;
 }
 
-static void venc_put_clocks(void)
-{
-	if (venc.tv_dac_clk)
-		clk_put(venc.tv_dac_clk);
-}
-
 static struct omap_dss_device * __init venc_find_dssdev(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
@@ -886,7 +880,6 @@ static int __init omap_venchw_probe(struct platform_device *pdev)
 err_panel_init:
 err_runtime_get:
 	pm_runtime_disable(&pdev->dev);
-	venc_put_clocks();
 	return r;
 }
 
@@ -904,7 +897,6 @@ static int __exit omap_venchw_remove(struct platform_device *pdev)
 	venc_uninit_output(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-	venc_put_clocks();
 
 	return 0;
 }
-- 
1.7.10.4

