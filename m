From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 03/13] OMAPDSS: DSI: Maintain own copy of timings in driver data
Date: Thu, 9 Aug 2012 17:19:39 +0530
Message-ID: <1344512989-4071-4-git-send-email-archit@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
 <1344512989-4071-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53272 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753417Ab2HILv3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Aug 2012 07:51:29 -0400
In-Reply-To: <1344512989-4071-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The DSI driver currently relies on the timings in omap_dss_device struct to
configure the DISPC and DSI blocks accordingly. This makes the DSI interface
driver dependent on the omap_dss_device struct.

Make the DSI driver data maintain it's own timings field. A DSI video mode panel
driver is expected to call omapdss_dsi_set_timings() to set these timings before
the panel is enabled.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   58 +++++++++++++++++++++++++----------------
 include/video/omapdss.h       |    2 ++
 2 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 27c27c4..815b606 100644
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
@@ -4370,7 +4373,6 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct omap_video_timings timings;
 	const struct omapdss_clock_config *clks;
 	int r, lcd_id;
 	u32 irq = 0;
@@ -4380,14 +4382,14 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 
 		dssdev->driver->get_resolution(dssdev, &dw, &dh);
 
-		timings.x_res = dw;
-		timings.y_res = dh;
-		timings.hsw = 1;
-		timings.hfp = 1;
-		timings.hbp = 1;
-		timings.vsw = 1;
-		timings.vfp = 0;
-		timings.vbp = 0;
+		dsi->timings.x_res = dw;
+		dsi->timings.y_res = dh;
+		dsi->timings.hsw = 1;
+		dsi->timings.hfp = 1;
+		dsi->timings.hbp = 1;
+		dsi->timings.vsw = 1;
+		dsi->timings.vfp = 0;
+		dsi->timings.vbp = 0;
 
 		irq = dispc_mgr_get_framedone_irq(dssdev->manager->id);
 
@@ -4401,8 +4403,6 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 		dsi->mgr_config.stallmode = true;
 		dsi->mgr_config.fifohandcheck = true;
 	} else {
-		timings = dssdev->panel.timings;
-
 		dsi->mgr_config.stallmode = false;
 		dsi->mgr_config.fifohandcheck = false;
 	}
@@ -4411,14 +4411,14 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 	 * override interlace, logic level and edge related parameters in
 	 * omap_video_timings with default values
 	 */
-	timings.interlace = false;
-	timings.hsync_level = OMAPDSS_SIG_ACTIVE_HIGH;
-	timings.vsync_level = OMAPDSS_SIG_ACTIVE_HIGH;
-	timings.data_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
-	timings.de_level = OMAPDSS_SIG_ACTIVE_HIGH;
-	timings.sync_pclk_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
+	dsi->timings.interlace = false;
+	dsi->timings.hsync_level = OMAPDSS_SIG_ACTIVE_HIGH;
+	dsi->timings.vsync_level = OMAPDSS_SIG_ACTIVE_HIGH;
+	dsi->timings.data_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
+	dsi->timings.de_level = OMAPDSS_SIG_ACTIVE_HIGH;
+	dsi->timings.sync_pclk_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
 
-	dss_mgr_set_timings(dssdev->manager, &timings);
+	dss_mgr_set_timings(dssdev->manager, &dsi->timings);
 
 	switch (dssdev->manager->id) {
 	case OMAP_DSS_CHANNEL_LCD:
@@ -4688,6 +4688,20 @@ int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable)
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

