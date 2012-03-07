From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 15/21] OMAPDSS: remove uses of dss_runtime_get/put
Date: Wed,  7 Mar 2012 14:44:44 +0200
Message-ID: <1331124290-6285-16-git-send-email-tomi.valkeinen@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:56571 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758531Ab2CGMpt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:45:49 -0500
Received: by bkcji17 with SMTP id ji17so5708098bkc.7
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:45:46 -0800 (PST)
In-Reply-To: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
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
index c71d4c5..1fbe480 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3407,19 +3407,12 @@ static int omap_dispchw_remove(struct platform_device *pdev)
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
index 5b7bbab..511df3c 100644
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
index cf59f40..4bee235 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4802,7 +4802,6 @@ static int omap_dsihw_remove(struct platform_device *dsidev)
 static int dsi_runtime_suspend(struct device *dev)
 {
 	dispc_runtime_put();
-	dss_runtime_put();
 
 	return 0;
 }
@@ -4811,20 +4810,11 @@ static int dsi_runtime_resume(struct device *dev)
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
index 3156851..da528b7 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -59,6 +59,9 @@ struct dss_reg {
 #define REG_FLD_MOD(idx, val, start, end) \
 	dss_write_reg(idx, FLD_MOD(dss_read_reg(idx), val, start, end))
 
+static int dss_runtime_get(void);
+static void dss_runtime_put(void);
+
 static struct {
 	struct platform_device *pdev;
 	void __iomem    *base;
@@ -703,7 +706,7 @@ static void dss_put_clocks(void)
 	clk_put(dss.dss_clk);
 }
 
-int dss_runtime_get(void)
+static int dss_runtime_get(void)
 {
 	int r;
 
@@ -714,7 +717,7 @@ int dss_runtime_get(void)
 	return r < 0 ? r : 0;
 }
 
-void dss_runtime_put(void)
+static void dss_runtime_put(void)
 {
 	int r;
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 1981626..24aadde 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -230,9 +230,6 @@ int dss_ovl_check(struct omap_overlay *ovl,
 int dss_init_platform_driver(void);
 void dss_uninit_platform_driver(void);
 
-int dss_runtime_get(void);
-void dss_runtime_put(void);
-
 void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select);
 enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void);
 const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index b4ad13b..08a316b 100644
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
@@ -865,7 +846,6 @@ static int hdmi_runtime_suspend(struct device *dev)
 	clk_disable(hdmi.sys_clk);
 
 	dispc_runtime_put();
-	dss_runtime_put();
 
 	return 0;
 }
@@ -874,23 +854,13 @@ static int hdmi_runtime_resume(struct device *dev)
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
index dfd8ec5..b6990ba 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -972,7 +972,6 @@ static int omap_rfbihw_remove(struct platform_device *pdev)
 static int rfbi_runtime_suspend(struct device *dev)
 {
 	dispc_runtime_put();
-	dss_runtime_put();
 
 	return 0;
 }
@@ -981,20 +980,11 @@ static int rfbi_runtime_resume(struct device *dev)
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
index d886d93..684a4de 100644
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
index c933733..637abcb 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -853,7 +853,6 @@ static int venc_runtime_suspend(struct device *dev)
 		clk_disable(venc.tv_dac_clk);
 
 	dispc_runtime_put();
-	dss_runtime_put();
 
 	return 0;
 }
@@ -862,23 +861,14 @@ static int venc_runtime_resume(struct device *dev)
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
1.7.4.1

