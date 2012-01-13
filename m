From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/6] OMAPDSS: DISPC: move fifo threhold calc to dispc.c
Date: Fri, 13 Jan 2012 13:46:32 +0200
Message-ID: <1326455193-19716-6-git-send-email-tomi.valkeinen@ti.com>
References: <1326455193-19716-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:55444 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752900Ab2AMLqx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 06:46:53 -0500
In-Reply-To: <1326455193-19716-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Move fifo threshold calculation into dispc.c, as the thresholds are
really dispc internal thing.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c   |   34 ++--------------------------------
 drivers/video/omap2/dss/dispc.c   |   22 ++++++++++++++++++++--
 drivers/video/omap2/dss/display.c |   10 ----------
 drivers/video/omap2/dss/dsi.c     |    8 --------
 drivers/video/omap2/dss/dss.h     |   10 ++--------
 5 files changed, 24 insertions(+), 60 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 6f7b213..b0264a1 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -907,7 +907,6 @@ static void dss_ovl_setup_fifo(struct omap_overlay *ovl,
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	struct omap_dss_device *dssdev;
-	u32 size, burst_size;
 	u32 fifo_low, fifo_high;
 
 	if (!op->enabled && !op->enabling)
@@ -915,37 +914,8 @@ static void dss_ovl_setup_fifo(struct omap_overlay *ovl,
 
 	dssdev = ovl->manager->device;
 
-	if (use_fifo_merge) {
-		int i;
-
-		size = 0;
-
-		for (i = 0; i < omap_dss_get_num_overlays(); ++i)
-			size += dispc_ovl_get_fifo_size(i);
-	} else {
-		size = dispc_ovl_get_fifo_size(ovl->id);
-	}
-
-	burst_size = dispc_ovl_get_burst_size(ovl->id);
-
-	switch (dssdev->type) {
-	case OMAP_DISPLAY_TYPE_DPI:
-	case OMAP_DISPLAY_TYPE_DBI:
-	case OMAP_DISPLAY_TYPE_SDI:
-	case OMAP_DISPLAY_TYPE_VENC:
-	case OMAP_DISPLAY_TYPE_HDMI:
-		default_get_overlay_fifo_thresholds(ovl->id, size,
-				burst_size, &fifo_low, &fifo_high);
-		break;
-#ifdef CONFIG_OMAP2_DSS_DSI
-	case OMAP_DISPLAY_TYPE_DSI:
-		dsi_get_overlay_fifo_thresholds(ovl->id, size,
-				burst_size, &fifo_low, &fifo_high);
-		break;
-#endif
-	default:
-		BUG();
-	}
+	dispc_ovl_compute_fifo_thresholds(ovl->id, &fifo_low, &fifo_high,
+			use_fifo_merge);
 
 	dss_apply_ovl_fifo_thresholds(ovl, fifo_low, fifo_high);
 }
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index ba907bd..a759722 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -909,7 +909,7 @@ static void dispc_configure_burst_sizes(void)
 		dispc_ovl_set_burst_size(i, burst_size);
 }
 
-u32 dispc_ovl_get_burst_size(enum omap_plane plane)
+static u32 dispc_ovl_get_burst_size(enum omap_plane plane)
 {
 	unsigned unit = dss_feat_get_burst_size_unit();
 	/* burst multiplier is always x8 (see dispc_configure_burst_sizes()) */
@@ -1018,7 +1018,7 @@ static void dispc_read_plane_fifo_sizes(void)
 	}
 }
 
-u32 dispc_ovl_get_fifo_size(enum omap_plane plane)
+static u32 dispc_ovl_get_fifo_size(enum omap_plane plane)
 {
 	return dispc.fifo_size[plane];
 }
@@ -1063,6 +1063,24 @@ void dispc_enable_fifomerge(bool enable)
 	REG_FLD_MOD(DISPC_CONFIG, enable ? 1 : 0, 14, 14);
 }
 
+void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
+		u32 *fifo_low, u32 *fifo_high, bool use_fifomerge)
+{
+	/*
+	 * All sizes are in bytes. Both the buffer and burst are made of
+	 * buffer_units, and the fifo thresholds must be buffer_unit aligned.
+	 */
+
+	unsigned buf_unit = dss_feat_get_buffer_size_unit();
+	unsigned fifo_size, burst_size;
+
+	burst_size = dispc_ovl_get_burst_size(plane);
+	fifo_size = dispc_ovl_get_fifo_size(plane);
+
+	*fifo_low = fifo_size - burst_size;
+	*fifo_high = fifo_size - buf_unit;
+}
+
 static void dispc_ovl_set_fir(enum omap_plane plane,
 				int hinc, int vinc,
 				enum omap_color_component color_comp)
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index be331dc..4424c19 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -279,16 +279,6 @@ void omapdss_default_get_resolution(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_default_get_resolution);
 
-void default_get_overlay_fifo_thresholds(enum omap_plane plane,
-		u32 fifo_size, u32 burst_size,
-		u32 *fifo_low, u32 *fifo_high)
-{
-	unsigned buf_unit = dss_feat_get_buffer_size_unit();
-
-	*fifo_high = fifo_size - buf_unit;
-	*fifo_low = fifo_size - burst_size;
-}
-
 int omapdss_default_get_recommended_bpp(struct omap_dss_device *dssdev)
 {
 	switch (dssdev->type) {
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 511ae2a..1cbb7a5 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4524,14 +4524,6 @@ int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable)
 }
 EXPORT_SYMBOL(omapdss_dsi_enable_te);
 
-void dsi_get_overlay_fifo_thresholds(enum omap_plane plane,
-		u32 fifo_size, u32 burst_size,
-		u32 *fifo_low, u32 *fifo_high)
-{
-	*fifo_high = fifo_size - burst_size;
-	*fifo_low = fifo_size - burst_size * 2;
-}
-
 int dsi_init_display(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 3cf99a9..f2378a8 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -202,9 +202,6 @@ void dss_uninit_device(struct platform_device *pdev,
 		struct omap_dss_device *dssdev);
 bool dss_use_replication(struct omap_dss_device *dssdev,
 		enum omap_color_mode mode);
-void default_get_overlay_fifo_thresholds(enum omap_plane plane,
-		u32 fifo_size, u32 burst_size,
-		u32 *fifo_low, u32 *fifo_high);
 
 /* manager */
 int dss_init_overlay_managers(struct platform_device *pdev);
@@ -313,9 +310,6 @@ int dsi_pll_calc_clock_div_pck(struct platform_device *dsidev, bool is_tft,
 int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
 		bool enable_hsdiv);
 void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes);
-void dsi_get_overlay_fifo_thresholds(enum omap_plane plane,
-		u32 fifo_size, u32 burst_size,
-		u32 *fifo_low, u32 *fifo_high);
 void dsi_wait_pll_hsdiv_dispc_active(struct platform_device *dsidev);
 void dsi_wait_pll_hsdiv_dsi_active(struct platform_device *dsidev);
 struct platform_device *dsi_get_dsidev_from_id(int module);
@@ -429,8 +423,8 @@ int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
 
 
 void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high);
-u32 dispc_ovl_get_fifo_size(enum omap_plane plane);
-u32 dispc_ovl_get_burst_size(enum omap_plane plane);
+void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
+		u32 *fifo_low, u32 *fifo_high, bool use_fifomerge);
 int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 		bool ilace, bool replication);
 int dispc_ovl_enable(enum omap_plane plane, bool enable);
-- 
1.7.4.1

