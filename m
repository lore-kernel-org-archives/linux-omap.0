From: Archit Taneja <archit@ti.com>
Subject: [PATCH 3/6] OMAPDSS: DSI: Maintain copy of video mode timings in driver data
Date: Thu, 16 Aug 2012 13:06:31 +0530
Message-ID: <1345102594-6222-4-git-send-email-archit@ti.com>
References: <343817088-29645-1-git-send-email-archit@ti.com>
 <1345102594-6222-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45206 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890Ab2HPHiR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 03:38:17 -0400
In-Reply-To: <1345102594-6222-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The DSI driver currently relies on the omap_dss_device struct to receive the
video mode timings requested by the panel driver. This makes the DSI interface
driver dependent on the omap_dss_device struct.

Make the DSI driver data maintain it's own video mode timings field. The panel
driver is expected to call omapdss_dsi_set_videomode_timings() to configure the
video mode timings before the interface is enabled. The function takes in a
void pointer rather than a pointer to omap_dss_dsi_videomode_timings struct.
This is because this function will finally be an output op shared across
different outputs to set custom or private timings.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   52 ++++++++++++++++++++++++++++-------------
 include/video/omapdss.h       |    2 ++
 2 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 62549f6..6c2c746 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -336,6 +336,7 @@ struct dsi_data {
 	struct omap_video_timings timings;
 	enum omap_dss_dsi_pixel_format pix_fmt;
 	enum omap_dss_dsi_mode mode;
+	struct omap_dss_dsi_videomode_timings vm_timings;
 };
 
 struct dsi_packet_sent_handler_data {
@@ -2366,7 +2367,7 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
 		/* DDR_CLK_ALWAYS_ON */
 		REG_FLD_MOD(dsidev, DSI_CLK_CTRL,
-			dssdev->panel.dsi_vm_timings.ddr_clk_always_on, 13, 13);
+			dsi->vm_timings.ddr_clk_always_on, 13, 13);
 	}
 
 	dsi->ulps_enabled = false;
@@ -2688,6 +2689,7 @@ void omapdss_dsi_vc_enable_hs(struct omap_dss_device *dssdev, int channel,
 		bool enable)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	DSSDBG("dsi_vc_enable_hs(%d, %d)\n", channel, enable);
 
@@ -2704,7 +2706,7 @@ void omapdss_dsi_vc_enable_hs(struct omap_dss_device *dssdev, int channel,
 	dsi_force_tx_stop_mode_io(dsidev);
 
 	/* start the DDR clock by sending a NULL packet */
-	if (dssdev->panel.dsi_vm_timings.ddr_clk_always_on && enable)
+	if (dsi->vm_timings.ddr_clk_always_on && enable)
 		dsi_vc_send_null(dssdev, channel);
 }
 EXPORT_SYMBOL(omapdss_dsi_vc_enable_hs);
@@ -3638,8 +3640,9 @@ static void dsi_config_vp_num_line_buffers(struct omap_dss_device *dssdev)
 static void dsi_config_vp_sync_events(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
-	bool vsync_end = dssdev->panel.dsi_vm_timings.vp_vsync_end;
-	bool hsync_end = dssdev->panel.dsi_vm_timings.vp_hsync_end;
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	bool vsync_end = dsi->vm_timings.vp_vsync_end;
+	bool hsync_end = dsi->vm_timings.vp_hsync_end;
 	u32 r;
 
 	r = dsi_read_reg(dsidev, DSI_CTRL);
@@ -3656,10 +3659,11 @@ static void dsi_config_vp_sync_events(struct omap_dss_device *dssdev)
 static void dsi_config_blanking_modes(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
-	int blanking_mode = dssdev->panel.dsi_vm_timings.blanking_mode;
-	int hfp_blanking_mode = dssdev->panel.dsi_vm_timings.hfp_blanking_mode;
-	int hbp_blanking_mode = dssdev->panel.dsi_vm_timings.hbp_blanking_mode;
-	int hsa_blanking_mode = dssdev->panel.dsi_vm_timings.hsa_blanking_mode;
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	int blanking_mode = dsi->vm_timings.blanking_mode;
+	int hfp_blanking_mode = dsi->vm_timings.hfp_blanking_mode;
+	int hbp_blanking_mode = dsi->vm_timings.hbp_blanking_mode;
+	int hsa_blanking_mode = dsi->vm_timings.hsa_blanking_mode;
 	u32 r;
 
 	/*
@@ -3992,14 +3996,14 @@ static void dsi_proto_timings(struct omap_dss_device *dssdev)
 
 	 if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
 		/* TODO: Implement a video mode check_timings function */
-		int hsa = dssdev->panel.dsi_vm_timings.hsa;
-		int hfp = dssdev->panel.dsi_vm_timings.hfp;
-		int hbp = dssdev->panel.dsi_vm_timings.hbp;
-		int vsa = dssdev->panel.dsi_vm_timings.vsa;
-		int vfp = dssdev->panel.dsi_vm_timings.vfp;
-		int vbp = dssdev->panel.dsi_vm_timings.vbp;
-		int window_sync = dssdev->panel.dsi_vm_timings.window_sync;
-		bool hsync_end = dssdev->panel.dsi_vm_timings.vp_hsync_end;
+		int hsa = dsi->vm_timings.hsa;
+		int hfp = dsi->vm_timings.hfp;
+		int hbp = dsi->vm_timings.hbp;
+		int vsa = dsi->vm_timings.vsa;
+		int vfp = dsi->vm_timings.vfp;
+		int vbp = dsi->vm_timings.vbp;
+		int window_sync = dsi->vm_timings.window_sync;
+		bool hsync_end = dsi->vm_timings.vp_hsync_end;
 		struct omap_video_timings *timings = &dsi->timings;
 		int bpp = dsi_get_pixel_size(dsi->pix_fmt);
 		int tl, t_he, width_bytes;
@@ -4715,6 +4719,22 @@ void omapdss_dsi_set_operation_mode(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_dsi_set_operation_mode);
 
+void omapdss_dsi_set_videomode_timings(struct omap_dss_device *dssdev,
+		void *timings)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct omap_dss_dsi_videomode_timings *vm_timings =
+			(struct omap_dss_dsi_videomode_timings *) timings;
+
+	mutex_lock(&dsi->lock);
+
+	dsi->vm_timings = *vm_timings;
+
+	mutex_unlock(&dsi->lock);
+}
+EXPORT_SYMBOL(omapdss_dsi_set_videomode_timings);
+
 static int __init dsi_init_display(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 363235c..faac986 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -726,6 +726,8 @@ void omapdss_dsi_set_pixel_format(struct omap_dss_device *dssdev,
 		enum omap_dss_dsi_pixel_format fmt);
 void omapdss_dsi_set_operation_mode(struct omap_dss_device *dssdev,
 		enum omap_dss_dsi_mode mode);
+void omapdss_dsi_set_videomode_timings(struct omap_dss_device *dssdev,
+		void *timings);
 
 int omap_dsi_update(struct omap_dss_device *dssdev, int channel,
 		void (*callback)(int, void *), void *data);
-- 
1.7.9.5

