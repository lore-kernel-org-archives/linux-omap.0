From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 18/20] OMAPDSS: DSI: delay dispc initialization
Date: Fri, 8 Mar 2013 13:51:53 +0200
Message-ID: <1362743515-10152-19-git-send-email-tomi.valkeinen@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57879 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933603Ab3CHLwa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:52:30 -0500
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We currently setup both DSI and DISPC related things when the DSI bus is
enabled. There's no need for DISPC related thing at that point, though,
but only later when the video output is enabled.

To make it possible to use the DSI bus before DISPC overlay manager is
selected, this patch moves DSI's DISPC initialization to
dsi_enable_video_output(), from omapdss_dsi_display_enable(). We also
move the selection of DISPC's LCD clock to dsi_enable_video_output.

This way there are no DISPC dependencies until the video output is
enabled.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   75 ++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index f44316a..da8a678 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -200,6 +200,11 @@ struct dsi_reg { u16 idx; };
 
 typedef void (*omap_dsi_isr_t) (void *arg, u32 mask);
 
+static int dsi_display_init_dispc(struct platform_device *dsidev,
+	struct omap_overlay_manager *mgr);
+static void dsi_display_uninit_dispc(struct platform_device *dsidev,
+	struct omap_overlay_manager *mgr);
+
 #define DSI_MAX_NR_ISRS                2
 #define DSI_MAX_NR_LANES	5
 
@@ -4342,10 +4347,20 @@ int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct omap_overlay_manager *mgr = dsi->output.manager;
 	int bpp = dsi_get_pixel_size(dsi->pix_fmt);
+	struct omap_dss_output *out = &dsi->output;
 	u8 data_type;
 	u16 word_count;
 	int r;
 
+	if (out == NULL || out->manager == NULL) {
+		DSSERR("failed to enable display: no output/manager\n");
+		return -ENODEV;
+	}
+
+	r = dsi_display_init_dispc(dsidev, mgr);
+	if (r)
+		goto err_init_dispc;
+
 	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
 		switch (dsi->pix_fmt) {
 		case OMAP_DSS_DSI_FMT_RGB888:
@@ -4361,8 +4376,8 @@ int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 			data_type = MIPI_DSI_PACKED_PIXEL_STREAM_16;
 			break;
 		default:
-			BUG();
-			return -EINVAL;
+			r = -EINVAL;
+			goto err_pix_fmt;
 		};
 
 		dsi_if_enable(dsidev, false);
@@ -4381,16 +4396,20 @@ int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 	}
 
 	r = dss_mgr_enable(mgr);
-	if (r) {
-		if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
-			dsi_if_enable(dsidev, false);
-			dsi_vc_enable(dsidev, channel, false);
-		}
-
-		return r;
-	}
+	if (r)
+		goto err_mgr_enable;
 
 	return 0;
+
+err_mgr_enable:
+	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
+		dsi_if_enable(dsidev, false);
+		dsi_vc_enable(dsidev, channel, false);
+	}
+err_pix_fmt:
+	dsi_display_uninit_dispc(dsidev, mgr);
+err_init_dispc:
+	return r;
 }
 EXPORT_SYMBOL(dsi_enable_video_output);
 
@@ -4412,6 +4431,8 @@ void dsi_disable_video_output(struct omap_dss_device *dssdev, int channel)
 	}
 
 	dss_mgr_disable(mgr);
+
+	dsi_display_uninit_dispc(dsidev, mgr);
 }
 EXPORT_SYMBOL(dsi_disable_video_output);
 
@@ -4605,12 +4626,14 @@ static int dsi_configure_dispc_clocks(struct platform_device *dsidev)
 	return 0;
 }
 
-static int dsi_display_init_dispc(struct platform_device *dsidev)
+static int dsi_display_init_dispc(struct platform_device *dsidev,
+		struct omap_overlay_manager *mgr)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct omap_overlay_manager *mgr = dsi->output.manager;
 	int r;
 
+	dss_select_lcd_clk_source(mgr->id, dsi->user_lcd_clk_src);
+
 	if (dsi->mode == OMAP_DSS_DSI_CMD_MODE) {
 		dsi->timings.hsw = 1;
 		dsi->timings.hfp = 1;
@@ -4663,17 +4686,20 @@ err1:
 		dss_mgr_unregister_framedone_handler(mgr,
 				dsi_framedone_irq_callback, dsidev);
 err:
+	dss_select_lcd_clk_source(mgr->id, OMAP_DSS_CLK_SRC_FCK);
 	return r;
 }
 
-static void dsi_display_uninit_dispc(struct platform_device *dsidev)
+static void dsi_display_uninit_dispc(struct platform_device *dsidev,
+		struct omap_overlay_manager *mgr)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct omap_overlay_manager *mgr = dsi->output.manager;
 
 	if (dsi->mode == OMAP_DSS_DSI_CMD_MODE)
 		dss_mgr_unregister_framedone_handler(mgr,
 				dsi_framedone_irq_callback, dsidev);
+
+	dss_select_lcd_clk_source(mgr->id, OMAP_DSS_CLK_SRC_FCK);
 }
 
 static int dsi_configure_dsi_clocks(struct platform_device *dsidev)
@@ -4702,7 +4728,6 @@ static int dsi_configure_dsi_clocks(struct platform_device *dsidev)
 static int dsi_display_init_dsi(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct omap_overlay_manager *mgr = dsi->output.manager;
 	int r;
 
 	r = dsi_pll_init(dsidev, true, true);
@@ -4714,7 +4739,6 @@ static int dsi_display_init_dsi(struct platform_device *dsidev)
 		goto err1;
 
 	dss_select_dsi_clk_source(dsi->module_id, dsi->user_dsi_fclk_src);
-	dss_select_lcd_clk_source(mgr->id, dsi->user_lcd_clk_src);
 
 	DSSDBG("PLL OK\n");
 
@@ -4747,8 +4771,6 @@ err3:
 	dsi_cio_uninit(dsidev);
 err2:
 	dss_select_dsi_clk_source(dsi->module_id, OMAP_DSS_CLK_SRC_FCK);
-	dss_select_lcd_clk_source(mgr->id, OMAP_DSS_CLK_SRC_FCK);
-
 err1:
 	dsi_pll_uninit(dsidev, true);
 err0:
@@ -4759,7 +4781,6 @@ static void dsi_display_uninit_dsi(struct platform_device *dsidev,
 		bool disconnect_lanes, bool enter_ulps)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct omap_overlay_manager *mgr = dsi->output.manager;
 
 	if (enter_ulps && !dsi->ulps_enabled)
 		dsi_enter_ulps(dsidev);
@@ -4772,7 +4793,6 @@ static void dsi_display_uninit_dsi(struct platform_device *dsidev,
 	dsi_vc_enable(dsidev, 3, 0);
 
 	dss_select_dsi_clk_source(dsi->module_id, OMAP_DSS_CLK_SRC_FCK);
-	dss_select_lcd_clk_source(mgr->id, OMAP_DSS_CLK_SRC_FCK);
 	dsi_cio_uninit(dsidev);
 	dsi_pll_uninit(dsidev, disconnect_lanes);
 }
@@ -4781,7 +4801,6 @@ int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct omap_dss_output *out = &dsi->output;
 	int r = 0;
 
 	DSSDBG("dsi_display_enable\n");
@@ -4790,12 +4809,6 @@ int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 
 	mutex_lock(&dsi->lock);
 
-	if (out == NULL || out->manager == NULL) {
-		DSSERR("failed to enable display: no output/manager\n");
-		r = -ENODEV;
-		goto err_start_dev;
-	}
-
 	r = omap_dss_start_device(dssdev);
 	if (r) {
 		DSSERR("failed to start device\n");
@@ -4810,10 +4823,6 @@ int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 
 	_dsi_initialize_irq(dsidev);
 
-	r = dsi_display_init_dispc(dsidev);
-	if (r)
-		goto err_init_dispc;
-
 	r = dsi_display_init_dsi(dsidev);
 	if (r)
 		goto err_init_dsi;
@@ -4823,8 +4832,6 @@ int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 	return 0;
 
 err_init_dsi:
-	dsi_display_uninit_dispc(dsidev);
-err_init_dispc:
 	dsi_enable_pll_clock(dsidev, 0);
 	dsi_runtime_put(dsidev);
 err_get_dsi:
@@ -4853,8 +4860,6 @@ void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
 	dsi_sync_vc(dsidev, 2);
 	dsi_sync_vc(dsidev, 3);
 
-	dsi_display_uninit_dispc(dsidev);
-
 	dsi_display_uninit_dsi(dsidev, disconnect_lanes, enter_ulps);
 
 	dsi_runtime_put(dsidev);
-- 
1.7.10.4

