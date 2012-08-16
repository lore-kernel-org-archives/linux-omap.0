From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/6] OMAPDSS: DSI: Maintain copy of operation mode in driver data
Date: Thu, 16 Aug 2012 13:06:29 +0530
Message-ID: <1345102594-6222-2-git-send-email-archit@ti.com>
References: <343817088-29645-1-git-send-email-archit@ti.com>
 <1345102594-6222-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36077 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752383Ab2HPHiK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 03:38:10 -0400
In-Reply-To: <1345102594-6222-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The DSI driver currently relies on the omap_dss_device struct to know the mode
of operation of the DSI protocol(command or video mode). This makes the DSI
interface driver dependent on the omap_dss_device struct.

Make the DSI driver data maintain it's own operation mode field. The panel
driver is expected to call omapdss_dsi_set_operation_mode() before the interface
is enabled.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |    1 +
 drivers/video/omap2/dss/dsi.c             |   42 +++++++++++++++++++++--------
 include/video/omapdss.h                   |    2 ++
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index d220f19..649247f 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -1063,6 +1063,7 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 	omapdss_dsi_set_size(dssdev, dssdev->panel.timings.x_res,
 		dssdev->panel.timings.y_res);
 	omapdss_dsi_set_pixel_format(dssdev, dssdev->panel.dsi_pix_fmt);
+	omapdss_dsi_set_operation_mode(dssdev, dssdev->panel.dsi_mode);
 
 	r = omapdss_dsi_display_enable(dssdev);
 	if (r) {
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 8f94cb80..c10c8cb 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -335,6 +335,7 @@ struct dsi_data {
 	struct dss_lcd_mgr_config mgr_config;
 	struct omap_video_timings timings;
 	enum omap_dss_dsi_pixel_format pix_fmt;
+	enum omap_dss_dsi_mode mode;
 };
 
 struct dsi_packet_sent_handler_data {
@@ -2362,7 +2363,7 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 
 	dsi_cio_timings(dsidev);
 
-	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
+	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
 		/* DDR_CLK_ALWAYS_ON */
 		REG_FLD_MOD(dsidev, DSI_CLK_CTRL,
 			dssdev->panel.dsi_vm_data.ddr_clk_always_on, 13, 13);
@@ -3609,9 +3610,10 @@ static void dsi_set_hs_tx_timeout(struct platform_device *dsidev,
 static void dsi_config_vp_num_line_buffers(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int num_line_buffers;
 
-	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
+	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
 		struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 		int bpp = dsi_get_pixel_size(dsi->pix_fmt);
 		unsigned line_buf_size = dsi_get_line_buf_size(dsidev);
@@ -3909,7 +3911,7 @@ static int dsi_proto_config(struct omap_dss_device *dssdev)
 
 	dsi_config_vp_num_line_buffers(dssdev);
 
-	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
+	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
 		dsi_config_vp_sync_events(dssdev);
 		dsi_config_blanking_modes(dssdev);
 		dsi_config_cmd_mode_interleaving(dssdev);
@@ -3988,7 +3990,7 @@ static void dsi_proto_timings(struct omap_dss_device *dssdev)
 	DSSDBG("enter_hs_mode_lat %u, exit_hs_mode_lat %u\n",
 			enter_hs_mode_lat, exit_hs_mode_lat);
 
-	 if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
+	 if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
 		/* TODO: Implement a video mode check_timings function */
 		int hsa = dssdev->panel.dsi_vm_data.hsa;
 		int hfp = dssdev->panel.dsi_vm_data.hfp;
@@ -4113,7 +4115,7 @@ int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 	u16 word_count;
 	int r;
 
-	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
+	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
 		switch (dsi->pix_fmt) {
 		case OMAP_DSS_DSI_FMT_RGB888:
 			data_type = MIPI_DSI_PACKED_PIXEL_STREAM_24;
@@ -4149,7 +4151,7 @@ int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 
 	r = dss_mgr_enable(dssdev->manager);
 	if (r) {
-		if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
+		if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
 			dsi_if_enable(dsidev, false);
 			dsi_vc_enable(dsidev, channel, false);
 		}
@@ -4164,8 +4166,9 @@ EXPORT_SYMBOL(dsi_enable_video_output);
 void dsi_disable_video_output(struct omap_dss_device *dssdev, int channel)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
-	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
+	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
 		dsi_if_enable(dsidev, false);
 		dsi_vc_enable(dsidev, channel, false);
 
@@ -4379,7 +4382,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 	int r;
 	u32 irq = 0;
 
-	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_CMD_MODE) {
+	if (dsi->mode == OMAP_DSS_DSI_CMD_MODE) {
 		dsi->timings.hsw = 1;
 		dsi->timings.hfp = 1;
 		dsi->timings.hbp = 1;
@@ -4429,7 +4432,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 
 	return 0;
 err1:
-	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_CMD_MODE)
+	if (dsi->mode == OMAP_DSS_DSI_CMD_MODE)
 		omap_dispc_unregister_isr(dsi_framedone_irq_callback,
 			(void *) dssdev, irq);
 err:
@@ -4438,7 +4441,10 @@ err:
 
 static void dsi_display_uninit_dispc(struct omap_dss_device *dssdev)
 {
-	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_CMD_MODE) {
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	if (dsi->mode == OMAP_DSS_DSI_CMD_MODE) {
 		u32 irq;
 
 		irq = dispc_mgr_get_framedone_irq(dssdev->manager->id);
@@ -4695,6 +4701,20 @@ void omapdss_dsi_set_pixel_format(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_dsi_set_pixel_format);
 
+void omapdss_dsi_set_operation_mode(struct omap_dss_device *dssdev,
+		enum omap_dss_dsi_mode mode)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	mutex_lock(&dsi->lock);
+
+	dsi->mode = mode;
+
+	mutex_unlock(&dsi->lock);
+}
+EXPORT_SYMBOL(omapdss_dsi_set_operation_mode);
+
 static int __init dsi_init_display(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
@@ -4702,7 +4722,7 @@ static int __init dsi_init_display(struct omap_dss_device *dssdev)
 
 	DSSDBG("DSI init\n");
 
-	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_CMD_MODE) {
+	if (dsi->mode == OMAP_DSS_DSI_CMD_MODE) {
 		dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
 			OMAP_DSS_DISPLAY_CAP_TEAR_ELIM;
 	}
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 88ac6e8..ef14ac5 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -724,6 +724,8 @@ void omapdss_dsi_set_timings(struct omap_dss_device *dssdev,
 void omapdss_dsi_set_size(struct omap_dss_device *dssdev, u16 w, u16 h);
 void omapdss_dsi_set_pixel_format(struct omap_dss_device *dssdev,
 		enum omap_dss_dsi_pixel_format fmt);
+void omapdss_dsi_set_operation_mode(struct omap_dss_device *dssdev,
+		enum omap_dss_dsi_mode mode);
 
 int omap_dsi_update(struct omap_dss_device *dssdev, int channel,
 		void (*callback)(int, void *), void *data);
-- 
1.7.9.5

