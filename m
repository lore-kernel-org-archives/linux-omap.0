From: Archit Taneja <archit@ti.com>
Subject: [RFC 08/17] OMAPDSS: DSI: Maintain own copy of timings in driver data
Date: Wed, 1 Aug 2012 16:01:19 +0530
Message-ID: <1343817088-29645-9-git-send-email-archit@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50158 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099Ab2HAKd2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Aug 2012 06:33:28 -0400
In-Reply-To: <1343817088-29645-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com, Archit Taneja <archit@ti.com>

The DSI driver currently relies on the timings in omap_dss_device struct to
configure the DISPC and DSI blocks accordingly. This makes the DSI interface
driver dependent on the omap_dss_device struct.

Make the DPI driver data maintain it's own timings field. The panel driver is
expected to call omapdss_dsi_set_timings() to set these timings before the panel
is enabled.

Signed-off-by: Archit Taneja <archit@ti.com>d
---
 drivers/video/omap2/displays/panel-taal.c |    2 ++
 drivers/video/omap2/dss/dsi.c             |   27 ++++++++++++++++++++++-----
 include/video/omapdss.h                   |    2 ++
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 3f5acc7..4775580 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -1060,6 +1060,8 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 		goto err0;
 	};
 
+	omapdss_dsi_set_timings(dssdev, &td->panel_config->timings);
+
 	r = omapdss_dsi_display_enable(dssdev);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to enable DSI\n");
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 27c27c4..598d965 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -333,6 +333,7 @@ struct dsi_data {
 	unsigned scp_clk_refcount;
 
 	struct dss_lcd_mgr_config mgr_config;
+	struct omap_video_timings timings;
 };
 
 struct dsi_packet_sent_handler_data {
@@ -3607,9 +3608,10 @@ static void dsi_config_vp_num_line_buffers(struct omap_dss_device *dssdev)
 	int num_line_buffers;
 
 	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
+		struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 		int bpp = dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
 		unsigned line_buf_size = dsi_get_line_buf_size(dsidev);
-		struct omap_video_timings *timings = &dssdev->panel.timings;
+		struct omap_video_timings *timings = &dsi->timings;
 		/*
 		 * Don't use line buffers if width is greater than the video
 		 * port's line buffer size
@@ -3738,7 +3740,7 @@ static void dsi_config_cmd_mode_interleaving(struct omap_dss_device *dssdev)
 	int ddr_clk_pre, ddr_clk_post, enter_hs_mode_lat, exit_hs_mode_lat;
 	int tclk_trail, ths_exit, exiths_clk;
 	bool ddr_alwon;
-	struct omap_video_timings *timings = &dssdev->panel.timings;
+	struct omap_video_timings *timings = &dsi->timings;
 	int bpp = dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
 	int ndl = dsi->num_lanes_used - 1;
 	const struct omapdss_clock_config *clks;
@@ -3996,7 +3998,7 @@ static void dsi_proto_timings(struct omap_dss_device *dssdev)
 		int vbp = dssdev->panel.dsi_vm_data.vbp;
 		int window_sync = dssdev->panel.dsi_vm_data.window_sync;
 		bool hsync_end = dssdev->panel.dsi_vm_data.vp_hsync_end;
-		struct omap_video_timings *timings = &dssdev->panel.timings;
+		struct omap_video_timings *timings = &dsi->timings;
 		int bpp = dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
 		int tl, t_he, width_bytes;
 
@@ -4105,6 +4107,7 @@ EXPORT_SYMBOL(omapdss_dsi_configure_pins);
 int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int bpp = dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
 	u8 data_type;
 	u16 word_count;
@@ -4135,7 +4138,7 @@ int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 		/* MODE, 1 = video mode */
 		REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), 1, 4, 4);
 
-		word_count = DIV_ROUND_UP(dssdev->panel.timings.x_res * bpp, 8);
+		word_count = DIV_ROUND_UP(dsi->timings.x_res * bpp, 8);
 
 		dsi_vc_write_long_header(dsidev, channel, data_type,
 				word_count, 0);
@@ -4401,7 +4404,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 		dsi->mgr_config.stallmode = true;
 		dsi->mgr_config.fifohandcheck = true;
 	} else {
-		timings = dssdev->panel.timings;
+		timings = dsi->timings;
 
 		dsi->mgr_config.stallmode = false;
 		dsi->mgr_config.fifohandcheck = false;
@@ -4688,6 +4691,20 @@ int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable)
 }
 EXPORT_SYMBOL(omapdss_dsi_enable_te);
 
+void omapdss_dsi_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	mutex_lock(&dsi->lock);
+
+	dsi->timings = *timings;
+
+	mutex_unlock(&dsi->lock);
+}
+EXPORT_SYMBOL(omapdss_dsi_set_timings);
+
 static int __init dsi_init_display(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index ebf2ebd..a2cd133 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -736,6 +736,8 @@ int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
 void omapdss_dsi_vc_enable_hs(struct omap_dss_device *dssdev, int channel,
 		bool enable);
 int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable);
+void omapdss_dsi_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings);
 
 int omap_dsi_update(struct omap_dss_device *dssdev, int channel,
 		void (*callback)(int, void *), void *data);
-- 
1.7.9.5

