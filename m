From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 04/20] OMAPDSS: DSI: remove omap_dss_device uses
Date: Fri, 8 Mar 2013 13:51:39 +0200
Message-ID: <1362743515-10152-5-git-send-email-tomi.valkeinen@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56450 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756753Ab3CHLwM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:52:12 -0500
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The role of struct omap_dss_device will change in the future. The exact
details of that are still a bit unclear. However, the less uses of
omap_dss_device we have, the easier the change is in the future.

This patch removes uses of omap_dss_device from dsi.c, where it can be
done easily. Mostly this means passing dsi platform device to functions,
instead of the omap_dss_device.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   68 ++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 39 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 9eb7845..815c930 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1199,9 +1199,8 @@ static unsigned long dsi_fclk_rate(struct platform_device *dsidev)
 	return r;
 }
 
-static int dsi_set_lp_clk_divisor(struct omap_dss_device *dssdev)
+static int dsi_set_lp_clk_divisor(struct platform_device *dsidev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	unsigned long dsi_fclk;
 	unsigned lp_clk_div;
@@ -3904,9 +3903,8 @@ static int dsi_compute_interleave_lp(int blank, int enter_hs, int exit_hs,
 	return max(lp_inter, 0);
 }
 
-static void dsi_config_cmd_mode_interleaving(struct omap_dss_device *dssdev)
+static void dsi_config_cmd_mode_interleaving(struct platform_device *dsidev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int blanking_mode;
 	int hfp_blanking_mode, hbp_blanking_mode, hsa_blanking_mode;
@@ -4022,9 +4020,8 @@ static void dsi_config_cmd_mode_interleaving(struct omap_dss_device *dssdev)
 	dsi_write_reg(dsidev, DSI_VM_TIMING6, r);
 }
 
-static int dsi_proto_config(struct omap_dss_device *dssdev)
+static int dsi_proto_config(struct platform_device *dsidev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	u32 r;
 	int buswidth = 0;
@@ -4082,7 +4079,7 @@ static int dsi_proto_config(struct omap_dss_device *dssdev)
 	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
 		dsi_config_vp_sync_events(dsidev);
 		dsi_config_blanking_modes(dsidev);
-		dsi_config_cmd_mode_interleaving(dssdev);
+		dsi_config_cmd_mode_interleaving(dsidev);
 	}
 
 	dsi_vc_initial_config(dsidev, 0);
@@ -4343,7 +4340,7 @@ int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
+	struct omap_overlay_manager *mgr = dsi->output.manager;
 	int bpp = dsi_get_pixel_size(dsi->pix_fmt);
 	u8 data_type;
 	u16 word_count;
@@ -4401,7 +4398,7 @@ void dsi_disable_video_output(struct omap_dss_device *dssdev, int channel)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
+	struct omap_overlay_manager *mgr = dsi->output.manager;
 
 	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
 		dsi_if_enable(dsidev, false);
@@ -4418,11 +4415,10 @@ void dsi_disable_video_output(struct omap_dss_device *dssdev, int channel)
 }
 EXPORT_SYMBOL(dsi_disable_video_output);
 
-static void dsi_update_screen_dispc(struct omap_dss_device *dssdev)
+static void dsi_update_screen_dispc(struct platform_device *dsidev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
+	struct omap_overlay_manager *mgr = dsi->output.manager;
 	unsigned bytespp;
 	unsigned bytespl;
 	unsigned bytespf;
@@ -4578,7 +4574,7 @@ int omap_dsi_update(struct omap_dss_device *dssdev, int channel,
 	dsi->update_bytes = dw * dh *
 		dsi_get_pixel_size(dsi->pix_fmt) / 8;
 #endif
-	dsi_update_screen_dispc(dssdev);
+	dsi_update_screen_dispc(dsidev);
 
 	return 0;
 }
@@ -4586,9 +4582,8 @@ EXPORT_SYMBOL(omap_dsi_update);
 
 /* Display funcs */
 
-static int dsi_configure_dispc_clocks(struct omap_dss_device *dssdev)
+static int dsi_configure_dispc_clocks(struct platform_device *dsidev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct dispc_clock_info dispc_cinfo;
 	int r;
@@ -4610,11 +4605,10 @@ static int dsi_configure_dispc_clocks(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
+static int dsi_display_init_dispc(struct platform_device *dsidev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
+	struct omap_overlay_manager *mgr = dsi->output.manager;
 	int r;
 
 	if (dsi->mode == OMAP_DSS_DSI_CMD_MODE) {
@@ -4652,7 +4646,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 
 	dss_mgr_set_timings(mgr, &dsi->timings);
 
-	r = dsi_configure_dispc_clocks(dssdev);
+	r = dsi_configure_dispc_clocks(dsidev);
 	if (r)
 		goto err1;
 
@@ -4672,20 +4666,18 @@ err:
 	return r;
 }
 
-static void dsi_display_uninit_dispc(struct omap_dss_device *dssdev)
+static void dsi_display_uninit_dispc(struct platform_device *dsidev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
+	struct omap_overlay_manager *mgr = dsi->output.manager;
 
 	if (dsi->mode == OMAP_DSS_DSI_CMD_MODE)
 		dss_mgr_unregister_framedone_handler(mgr,
 				dsi_framedone_irq_callback, dsidev);
 }
 
-static int dsi_configure_dsi_clocks(struct omap_dss_device *dssdev)
+static int dsi_configure_dsi_clocks(struct platform_device *dsidev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct dsi_clock_info cinfo;
 	int r;
@@ -4707,18 +4699,17 @@ static int dsi_configure_dsi_clocks(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
+static int dsi_display_init_dsi(struct platform_device *dsidev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
+	struct omap_overlay_manager *mgr = dsi->output.manager;
 	int r;
 
 	r = dsi_pll_init(dsidev, true, true);
 	if (r)
 		goto err0;
 
-	r = dsi_configure_dsi_clocks(dssdev);
+	r = dsi_configure_dsi_clocks(dsidev);
 	if (r)
 		goto err1;
 
@@ -4734,12 +4725,12 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 	_dsi_print_reset_status(dsidev);
 
 	dsi_proto_timings(dsidev);
-	dsi_set_lp_clk_divisor(dssdev);
+	dsi_set_lp_clk_divisor(dsidev);
 
 	if (1)
 		_dsi_print_reset_status(dsidev);
 
-	r = dsi_proto_config(dssdev);
+	r = dsi_proto_config(dsidev);
 	if (r)
 		goto err3;
 
@@ -4764,12 +4755,11 @@ err0:
 	return r;
 }
 
-static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
+static void dsi_display_uninit_dsi(struct platform_device *dsidev,
 		bool disconnect_lanes, bool enter_ulps)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
+	struct omap_overlay_manager *mgr = dsi->output.manager;
 
 	if (enter_ulps && !dsi->ulps_enabled)
 		dsi_enter_ulps(dsidev);
@@ -4791,7 +4781,7 @@ int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct omap_dss_output *out = dssdev->output;
+	struct omap_dss_output *out = &dsi->output;
 	int r = 0;
 
 	DSSDBG("dsi_display_enable\n");
@@ -4820,11 +4810,11 @@ int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 
 	_dsi_initialize_irq(dsidev);
 
-	r = dsi_display_init_dispc(dssdev);
+	r = dsi_display_init_dispc(dsidev);
 	if (r)
 		goto err_init_dispc;
 
-	r = dsi_display_init_dsi(dssdev);
+	r = dsi_display_init_dsi(dsidev);
 	if (r)
 		goto err_init_dsi;
 
@@ -4833,7 +4823,7 @@ int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 	return 0;
 
 err_init_dsi:
-	dsi_display_uninit_dispc(dssdev);
+	dsi_display_uninit_dispc(dsidev);
 err_init_dispc:
 	dsi_enable_pll_clock(dsidev, 0);
 	dsi_runtime_put(dsidev);
@@ -4863,9 +4853,9 @@ void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
 	dsi_sync_vc(dsidev, 2);
 	dsi_sync_vc(dsidev, 3);
 
-	dsi_display_uninit_dispc(dssdev);
+	dsi_display_uninit_dispc(dsidev);
 
-	dsi_display_uninit_dsi(dssdev, disconnect_lanes, enter_ulps);
+	dsi_display_uninit_dsi(dsidev, disconnect_lanes, enter_ulps);
 
 	dsi_runtime_put(dsidev);
 	dsi_enable_pll_clock(dsidev, 0);
-- 
1.7.10.4

