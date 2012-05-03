From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/25] OMAPDSS: remove uses of dss_runtime_get/put
Date: Thu,  3 May 2012 16:57:50 +0300
Message-ID: <1336053481-25433-15-git-send-email-tomi.valkeinen@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:34165 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756185Ab2ECN6n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 09:58:43 -0400
Received: by lbom4 with SMTP id m4so1523880lbo.2
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 06:58:40 -0700 (PDT)
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that the omapdss_core device is the parent for all other dss
devices, we don't need to use the dss_runtime_get/put anymore. Instead,
enabling omapdss_core will happen automatically when a child device is
enabled.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    7 -------
 drivers/video/omap2/dss/dpi.c   |   16 +---------------
 drivers/video/omap2/dss/dsi.c   |   12 +-----------
 drivers/video/omap2/dss/dss.c   |    7 +++++--
 drivers/video/omap2/dss/dss.h   |    3 ---
 drivers/video/omap2/dss/hdmi.c  |   34 ++--------------------------------
 drivers/video/omap2/dss/rfbi.c  |   12 +-----------
 drivers/video/omap2/dss/sdi.c   |    7 -------
 drivers/video/omap2/dss/venc.c  |   12 +-----------
 9 files changed, 11 insertions(+), 99 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 68aa566..1cccd4c 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3596,19 +3596,12 @@ static int omap_dispchw_remove(struct platform_device *pdev)
 static int dispc_runtime_suspend(struct device *dev)
 {
 	dispc_save_context();
-	dss_runtime_put();
 
 	return 0;
 }
 
 static int dispc_runtime_resume(struct device *dev)
 {
-	int r;
-
-	r = dss_runtime_get();
-	if (r < 0)
-		return r;
-
 	dispc_restore_context();
 
 	return 0;
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index f4398fd..d7a433b 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -202,10 +202,6 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 			goto err_reg_enable;
 	}
 
-	r = dss_runtime_get();
-	if (r)
-		goto err_get_dss;
-
 	r = dispc_runtime_get();
 	if (r)
 		goto err_get_dispc;
@@ -244,8 +240,6 @@ err_dsi_pll_init:
 err_get_dsi:
 	dispc_runtime_put();
 err_get_dispc:
-	dss_runtime_put();
-err_get_dss:
 	if (cpu_is_omap34xx())
 		regulator_disable(dpi.vdds_dsi_reg);
 err_reg_enable:
@@ -266,7 +260,6 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 	}
 
 	dispc_runtime_put();
-	dss_runtime_put();
 
 	if (cpu_is_omap34xx())
 		regulator_disable(dpi.vdds_dsi_reg);
@@ -283,21 +276,14 @@ void dpi_set_timings(struct omap_dss_device *dssdev,
 	DSSDBG("dpi_set_timings\n");
 	dssdev->panel.timings = *timings;
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
-		r = dss_runtime_get();
-		if (r)
-			return;
-
 		r = dispc_runtime_get();
-		if (r) {
-			dss_runtime_put();
+		if (r)
 			return;
-		}
 
 		dpi_set_mode(dssdev);
 		dispc_mgr_go(dssdev->manager->id);
 
 		dispc_runtime_put();
-		dss_runtime_put();
 	}
 }
 EXPORT_SYMBOL(dpi_set_timings);
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 45ba9e7..c365942 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4769,7 +4769,6 @@ static int omap_dsihw_remove(struct platform_device *dsidev)
 static int dsi_runtime_suspend(struct device *dev)
 {
 	dispc_runtime_put();
-	dss_runtime_put();
 
 	return 0;
 }
@@ -4778,20 +4777,11 @@ static int dsi_runtime_resume(struct device *dev)
 {
 	int r;
 
-	r = dss_runtime_get();
-	if (r)
-		goto err_get_dss;
-
 	r = dispc_runtime_get();
 	if (r)
-		goto err_get_dispc;
+		return r;
 
 	return 0;
-
-err_get_dispc:
-	dss_runtime_put();
-err_get_dss:
-	return r;
 }
 
 static const struct dev_pm_ops dsi_pm_ops = {
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 17a1927..06fb5dc 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -62,6 +62,9 @@ struct dss_reg {
 #define REG_FLD_MOD(idx, val, start, end) \
 	dss_write_reg(idx, FLD_MOD(dss_read_reg(idx), val, start, end))
 
+static int dss_runtime_get(void);
+static void dss_runtime_put(void);
+
 static struct {
 	struct platform_device *pdev;
 	void __iomem    *base;
@@ -706,7 +709,7 @@ static void dss_put_clocks(void)
 	clk_put(dss.dss_clk);
 }
 
-int dss_runtime_get(void)
+static int dss_runtime_get(void)
 {
 	int r;
 
@@ -717,7 +720,7 @@ int dss_runtime_get(void)
 	return r < 0 ? r : 0;
 }
 
-void dss_runtime_put(void)
+static void dss_runtime_put(void)
 {
 	int r;
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 4373b15..b53b2e6 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -228,9 +228,6 @@ int dss_ovl_check(struct omap_overlay *ovl,
 int dss_init_platform_driver(void);
 void dss_uninit_platform_driver(void);
 
-int dss_runtime_get(void);
-void dss_runtime_put(void);
-
 void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select);
 enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void);
 const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 35580b1..bfbe811 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -129,25 +129,12 @@ static int hdmi_runtime_get(void)
 
 	DSSDBG("hdmi_runtime_get\n");
 
-	/*
-	 * HACK: Add dss_runtime_get() to ensure DSS clock domain is enabled.
-	 * This should be removed later.
-	 */
-	r = dss_runtime_get();
-	if (r < 0)
-		goto err_get_dss;
-
 	r = pm_runtime_get_sync(&hdmi.pdev->dev);
 	WARN_ON(r < 0);
 	if (r < 0)
-		goto err_get_hdmi;
+		return r;
 
 	return 0;
-
-err_get_hdmi:
-	dss_runtime_put();
-err_get_dss:
-	return r;
 }
 
 static void hdmi_runtime_put(void)
@@ -158,12 +145,6 @@ static void hdmi_runtime_put(void)
 
 	r = pm_runtime_put_sync(&hdmi.pdev->dev);
 	WARN_ON(r < 0);
-
-	/*
-	 * HACK: This is added to complement the dss_runtime_get() call in
-	 * hdmi_runtime_get(). This should be removed later.
-	 */
-	dss_runtime_put();
 }
 
 int hdmi_init_display(struct omap_dss_device *dssdev)
@@ -864,7 +845,6 @@ static int hdmi_runtime_suspend(struct device *dev)
 	clk_disable(hdmi.sys_clk);
 
 	dispc_runtime_put();
-	dss_runtime_put();
 
 	return 0;
 }
@@ -873,23 +853,13 @@ static int hdmi_runtime_resume(struct device *dev)
 {
 	int r;
 
-	r = dss_runtime_get();
-	if (r < 0)
-		goto err_get_dss;
-
 	r = dispc_runtime_get();
 	if (r < 0)
-		goto err_get_dispc;
-
+		return r;
 
 	clk_enable(hdmi.sys_clk);
 
 	return 0;
-
-err_get_dispc:
-	dss_runtime_put();
-err_get_dss:
-	return r;
 }
 
 static const struct dev_pm_ops hdmi_pm_ops = {
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 39aac0b..01fd9e7 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -992,7 +992,6 @@ static int omap_rfbihw_remove(struct platform_device *pdev)
 static int rfbi_runtime_suspend(struct device *dev)
 {
 	dispc_runtime_put();
-	dss_runtime_put();
 
 	return 0;
 }
@@ -1001,20 +1000,11 @@ static int rfbi_runtime_resume(struct device *dev)
 {
 	int r;
 
-	r = dss_runtime_get();
-	if (r < 0)
-		goto err_get_dss;
-
 	r = dispc_runtime_get();
 	if (r < 0)
-		goto err_get_dispc;
+		return r;
 
 	return 0;
-
-err_get_dispc:
-	dss_runtime_put();
-err_get_dss:
-	return r;
 }
 
 static const struct dev_pm_ops rfbi_pm_ops = {
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index a047f44..90a1955 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -72,10 +72,6 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_reg_enable;
 
-	r = dss_runtime_get();
-	if (r)
-		goto err_get_dss;
-
 	r = dispc_runtime_get();
 	if (r)
 		goto err_get_dispc;
@@ -138,8 +134,6 @@ err_set_dss_clock_div:
 err_calc_clock_div:
 	dispc_runtime_put();
 err_get_dispc:
-	dss_runtime_put();
-err_get_dss:
 	regulator_disable(sdi.vdds_sdi_reg);
 err_reg_enable:
 	omap_dss_stop_device(dssdev);
@@ -155,7 +149,6 @@ void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
 	dss_sdi_disable();
 
 	dispc_runtime_put();
-	dss_runtime_put();
 
 	regulator_disable(sdi.vdds_sdi_reg);
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 7b0e8ed..9f13748 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -851,7 +851,6 @@ static int venc_runtime_suspend(struct device *dev)
 		clk_disable(venc.tv_dac_clk);
 
 	dispc_runtime_put();
-	dss_runtime_put();
 
 	return 0;
 }
@@ -860,23 +859,14 @@ static int venc_runtime_resume(struct device *dev)
 {
 	int r;
 
-	r = dss_runtime_get();
-	if (r < 0)
-		goto err_get_dss;
-
 	r = dispc_runtime_get();
 	if (r < 0)
-		goto err_get_dispc;
+		return r;
 
 	if (venc.tv_dac_clk)
 		clk_enable(venc.tv_dac_clk);
 
 	return 0;
-
-err_get_dispc:
-	dss_runtime_put();
-err_get_dss:
-	return r;
 }
 
 static const struct dev_pm_ops venc_pm_ops = {
-- 
1.7.9.5

