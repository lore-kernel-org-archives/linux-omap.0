From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/3] OMAP: DSS2: remove unneeded fck enable/disables
Date: Mon, 22 Aug 2011 11:26:11 +0300
Message-ID: <1314001571-17877-4-git-send-email-tomi.valkeinen@ti.com>
References: <1314001571-17877-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:37238 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754735Ab1HVI03 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:26:29 -0400
In-Reply-To: <1314001571-17877-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that the HWMOD fmwk handles the fcks of DSS modules properly, the
DSS driver no longer needs to explicitely enable/disable the fck.

This patch removes the enables/disables of fck from dispc, dsi and dss.
The clk_get(fck) is still needed there, as the modules need to know the
frequency of the clock.

For hdmi and venc this patch also removes the clk_get(fck), as they
don't need the clock at all.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    2 --
 drivers/video/omap2/dss/dsi.c   |    7 -------
 drivers/video/omap2/dss/dss.c   |    2 --
 drivers/video/omap2/dss/hdmi.c  |   14 --------------
 drivers/video/omap2/dss/venc.c  |   14 --------------
 5 files changed, 0 insertions(+), 39 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index bbd8340..9d9fbeb 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3480,7 +3480,6 @@ static int omap_dispchw_remove(struct platform_device *pdev)
 static int dispc_runtime_suspend(struct device *dev)
 {
 	dispc_save_context();
-	clk_disable(dispc.dss_clk);
 	dss_runtime_put();
 
 	return 0;
@@ -3494,7 +3493,6 @@ static int dispc_runtime_resume(struct device *dev)
 	if (r < 0)
 		return r;
 
-	clk_enable(dispc.dss_clk);
 	dispc_restore_context();
 
 	return 0;
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 707e5af..d167a54 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4605,10 +4605,6 @@ static int omap_dsi1hw_remove(struct platform_device *dsidev)
 
 static int dsi_runtime_suspend(struct device *dev)
 {
-	struct dsi_data *dsi = dsi_get_dsidrv_data(to_platform_device(dev));
-
-	clk_disable(dsi->dss_clk);
-
 	dispc_runtime_put();
 	dss_runtime_put();
 
@@ -4617,7 +4613,6 @@ static int dsi_runtime_suspend(struct device *dev)
 
 static int dsi_runtime_resume(struct device *dev)
 {
-	struct dsi_data *dsi = dsi_get_dsidrv_data(to_platform_device(dev));
 	int r;
 
 	r = dss_runtime_get();
@@ -4628,8 +4623,6 @@ static int dsi_runtime_resume(struct device *dev)
 	if (r)
 		goto err_get_dispc;
 
-	clk_enable(dsi->dss_clk);
-
 	return 0;
 
 err_get_dispc:
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 9423a2e..356d3c1 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -819,13 +819,11 @@ static int omap_dsshw_remove(struct platform_device *pdev)
 static int dss_runtime_suspend(struct device *dev)
 {
 	dss_save_context();
-	clk_disable(dss.dss_clk);
 	return 0;
 }
 
 static int dss_runtime_resume(struct device *dev)
 {
-	clk_enable(dss.dss_clk);
 	dss_restore_context();
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 9353dcf..876274b 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -56,7 +56,6 @@ static struct {
 	struct hdmi_config cfg;
 
 	struct clk *sys_clk;
-	struct clk *hdmi_clk;
 } hdmi;
 
 /*
@@ -1704,15 +1703,6 @@ static int hdmi_get_clocks(struct platform_device *pdev)
 
 	hdmi.sys_clk = clk;
 
-	clk = clk_get(&pdev->dev, "fck");
-	if (IS_ERR(clk)) {
-		DSSERR("can't get fck\n");
-		clk_put(hdmi.sys_clk);
-		return PTR_ERR(clk);
-	}
-
-	hdmi.hdmi_clk = clk;
-
 	return 0;
 }
 
@@ -1720,8 +1710,6 @@ static void hdmi_put_clocks(void)
 {
 	if (hdmi.sys_clk)
 		clk_put(hdmi.sys_clk);
-	if (hdmi.hdmi_clk)
-		clk_put(hdmi.hdmi_clk);
 }
 
 /* HDMI HW IP initialisation */
@@ -1792,7 +1780,6 @@ static int omapdss_hdmihw_remove(struct platform_device *pdev)
 
 static int hdmi_runtime_suspend(struct device *dev)
 {
-	clk_disable(hdmi.hdmi_clk);
 	clk_disable(hdmi.sys_clk);
 
 	dispc_runtime_put();
@@ -1815,7 +1802,6 @@ static int hdmi_runtime_resume(struct device *dev)
 
 
 	clk_enable(hdmi.sys_clk);
-	clk_enable(hdmi.hdmi_clk);
 
 	return 0;
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 71e005d..5331958 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -295,7 +295,6 @@ static struct {
 	u32 wss_data;
 	struct regulator *vdda_dac_reg;
 
-	struct clk	*tv_clk;
 	struct clk	*tv_dac_clk;
 } venc;
 
@@ -732,19 +731,10 @@ static int venc_get_clocks(struct platform_device *pdev)
 {
 	struct clk *clk;
 
-	clk = clk_get(&pdev->dev, "fck");
-	if (IS_ERR(clk)) {
-		DSSERR("can't get fck\n");
-		return PTR_ERR(clk);
-	}
-
-	venc.tv_clk = clk;
-
 	if (dss_has_feature(FEAT_VENC_REQUIRES_TV_DAC_CLK)) {
 		clk = clk_get(&pdev->dev, "tv_dac_clk");
 		if (IS_ERR(clk)) {
 			DSSERR("can't get tv_dac_clk\n");
-			clk_put(venc.tv_clk);
 			return PTR_ERR(clk);
 		}
 	} else {
@@ -758,8 +748,6 @@ static int venc_get_clocks(struct platform_device *pdev)
 
 static void venc_put_clocks(void)
 {
-	if (venc.tv_clk)
-		clk_put(venc.tv_clk);
 	if (venc.tv_dac_clk)
 		clk_put(venc.tv_dac_clk);
 }
@@ -835,7 +823,6 @@ static int venc_runtime_suspend(struct device *dev)
 {
 	if (venc.tv_dac_clk)
 		clk_disable(venc.tv_dac_clk);
-	clk_disable(venc.tv_clk);
 
 	dispc_runtime_put();
 	dss_runtime_put();
@@ -855,7 +842,6 @@ static int venc_runtime_resume(struct device *dev)
 	if (r < 0)
 		goto err_get_dispc;
 
-	clk_enable(venc.tv_clk);
 	if (venc.tv_dac_clk)
 		clk_enable(venc.tv_dac_clk);
 
-- 
1.7.4.1

