From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/5] OMAPDSS: DSI: Maintain copy of pixel format in driver data
Date: Fri, 10 Aug 2012 16:07:02 +0530
Message-ID: <1344595026-10607-2-git-send-email-archit@ti.com>
References: <1344595026-10607-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45571 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345Ab2HJKii (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Aug 2012 06:38:38 -0400
In-Reply-To: <1344595026-10607-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The DSI driver currently relies on the omap_dss_device struct to receive the
desired pixel format of the panel. This makes the DSI interface driver dependent
on the omap_dss_device struct.

Make the DSI driver data maintain it's own pixel format field. The panel driver
is expected to call omapdss_dsi_set_pixel_format() to configure the pixel format
before the interface is enabled.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |    1 +
 drivers/video/omap2/dss/dsi.c             |   34 +++++++++++++++++++++--------
 include/video/omapdss.h                   |    2 ++
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index c3bca2f..d220f19 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -1062,6 +1062,7 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 
 	omapdss_dsi_set_size(dssdev, dssdev->panel.timings.x_res,
 		dssdev->panel.timings.y_res);
+	omapdss_dsi_set_pixel_format(dssdev, dssdev->panel.dsi_pix_fmt);
 
 	r = omapdss_dsi_display_enable(dssdev);
 	if (r) {
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 6e1c74b..2497adb 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -334,6 +334,7 @@ struct dsi_data {
 
 	struct dss_lcd_mgr_config mgr_config;
 	struct omap_video_timings timings;
+	enum omap_dss_dsi_pixel_format pix_fmt;
 };
 
 struct dsi_packet_sent_handler_data {
@@ -3609,7 +3610,7 @@ static void dsi_config_vp_num_line_buffers(struct omap_dss_device *dssdev)
 
 	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
 		struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-		int bpp = dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
+		int bpp = dsi_get_pixel_size(dsi->pix_fmt);
 		unsigned line_buf_size = dsi_get_line_buf_size(dsidev);
 		struct omap_video_timings *timings = &dsi->timings;
 		/*
@@ -3741,7 +3742,7 @@ static void dsi_config_cmd_mode_interleaving(struct omap_dss_device *dssdev)
 	int tclk_trail, ths_exit, exiths_clk;
 	bool ddr_alwon;
 	struct omap_video_timings *timings = &dsi->timings;
-	int bpp = dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
+	int bpp = dsi_get_pixel_size(dsi->pix_fmt);
 	int ndl = dsi->num_lanes_used - 1;
 	const struct omapdss_clock_config *clks;
 	int dsi_fclk_hsdiv;
@@ -3856,6 +3857,7 @@ static void dsi_config_cmd_mode_interleaving(struct omap_dss_device *dssdev)
 static int dsi_proto_config(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	u32 r;
 	int buswidth = 0;
 
@@ -3875,7 +3877,7 @@ static int dsi_proto_config(struct omap_dss_device *dssdev)
 	dsi_set_lp_rx_timeout(dsidev, 0x1fff, true, true);
 	dsi_set_hs_tx_timeout(dsidev, 0x1fff, true, true);
 
-	switch (dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt)) {
+	switch (dsi_get_pixel_size(dsi->pix_fmt)) {
 	case 16:
 		buswidth = 0;
 		break;
@@ -3999,7 +4001,7 @@ static void dsi_proto_timings(struct omap_dss_device *dssdev)
 		int window_sync = dssdev->panel.dsi_vm_data.window_sync;
 		bool hsync_end = dssdev->panel.dsi_vm_data.vp_hsync_end;
 		struct omap_video_timings *timings = &dsi->timings;
-		int bpp = dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
+		int bpp = dsi_get_pixel_size(dsi->pix_fmt);
 		int tl, t_he, width_bytes;
 
 		t_he = hsync_end ?
@@ -4108,13 +4110,13 @@ int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	int bpp = dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
+	int bpp = dsi_get_pixel_size(dsi->pix_fmt);
 	u8 data_type;
 	u16 word_count;
 	int r;
 
 	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
-		switch (dssdev->panel.dsi_pix_fmt) {
+		switch (dsi->pix_fmt) {
 		case OMAP_DSS_DSI_FMT_RGB888:
 			data_type = MIPI_DSI_PACKED_PIXEL_STREAM_24;
 			break;
@@ -4201,7 +4203,7 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev)
 
 	dsi_vc_config_source(dsidev, channel, DSI_VC_SOURCE_VP);
 
-	bytespp	= dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt) / 8;
+	bytespp	= dsi_get_pixel_size(dsi->pix_fmt) / 8;
 	bytespl = w * bytespp;
 	bytespf = bytespl * h;
 
@@ -4338,7 +4340,7 @@ int omap_dsi_update(struct omap_dss_device *dssdev, int channel,
 
 #ifdef DEBUG
 	dsi->update_bytes = dw * dh *
-		dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt) / 8;
+		dsi_get_pixel_size(dsi->pix_fmt) / 8;
 #endif
 	dsi_update_screen_dispc(dssdev);
 
@@ -4438,7 +4440,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 
 	dsi->mgr_config.io_pad_mode = DSS_IO_PAD_MODE_BYPASS;
 	dsi->mgr_config.video_port_width =
-			dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
+			dsi_get_pixel_size(dsi->pix_fmt);
 	dsi->mgr_config.lcden_sig_polarity = 0;
 
 	dss_mgr_set_lcd_config(dssdev->manager, &dsi->mgr_config);
@@ -4714,6 +4716,20 @@ void omapdss_dsi_set_size(struct omap_dss_device *dssdev, u16 w, u16 h)
 }
 EXPORT_SYMBOL(omapdss_dsi_set_size);
 
+void omapdss_dsi_set_pixel_format(struct omap_dss_device *dssdev,
+		enum omap_dss_dsi_pixel_format fmt)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	mutex_lock(&dsi->lock);
+
+	dsi->pix_fmt = fmt;
+
+	mutex_unlock(&dsi->lock);
+}
+EXPORT_SYMBOL(omapdss_dsi_set_pixel_format);
+
 static int __init dsi_init_display(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index c5c013e..6e33c6f 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -739,6 +739,8 @@ int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable);
 void omapdss_dsi_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings);
 void omapdss_dsi_set_size(struct omap_dss_device *dssdev, u16 w, u16 h);
+void omapdss_dsi_set_pixel_format(struct omap_dss_device *dssdev,
+		enum omap_dss_dsi_pixel_format fmt);
 
 int omap_dsi_update(struct omap_dss_device *dssdev, int channel,
 		void (*callback)(int, void *), void *data);
-- 
1.7.9.5

