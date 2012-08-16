From: Archit Taneja <archit@ti.com>
Subject: [PATCH 2/6] OMAPDSS: DSI: Rename dsi_videomode_data to dsi_videomode_timings
Date: Thu, 16 Aug 2012 13:06:30 +0530
Message-ID: <1345102594-6222-3-git-send-email-archit@ti.com>
References: <343817088-29645-1-git-send-email-archit@ti.com>
 <1345102594-6222-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42132 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751805Ab2HPHiO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 03:38:14 -0400
In-Reply-To: <1345102594-6222-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The struct omap_dss_dsi_videomode_data holds fields which need to be configured
for DSI to operate in video mode. Rename the struct to dsi_videomode_timings.

One reason to do this is because most of the fields in the struct are timings
related. The other reason is to create a generic op for output specific
timings. This generic op can be considered as a way to set custom or private
timings for the output.

In the case of OMAP, DSI and RFBI require some more timings apart from the
regular DISPC timings. The structs omap_dss_videomode_timings and rfbi_timings
can be considered as these output specific timings respectively.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   32 ++++++++++++++++----------------
 include/video/omapdss.h       |    4 ++--
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index c10c8cb..62549f6 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2366,7 +2366,7 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
 		/* DDR_CLK_ALWAYS_ON */
 		REG_FLD_MOD(dsidev, DSI_CLK_CTRL,
-			dssdev->panel.dsi_vm_data.ddr_clk_always_on, 13, 13);
+			dssdev->panel.dsi_vm_timings.ddr_clk_always_on, 13, 13);
 	}
 
 	dsi->ulps_enabled = false;
@@ -2704,7 +2704,7 @@ void omapdss_dsi_vc_enable_hs(struct omap_dss_device *dssdev, int channel,
 	dsi_force_tx_stop_mode_io(dsidev);
 
 	/* start the DDR clock by sending a NULL packet */
-	if (dssdev->panel.dsi_vm_data.ddr_clk_always_on && enable)
+	if (dssdev->panel.dsi_vm_timings.ddr_clk_always_on && enable)
 		dsi_vc_send_null(dssdev, channel);
 }
 EXPORT_SYMBOL(omapdss_dsi_vc_enable_hs);
@@ -3638,8 +3638,8 @@ static void dsi_config_vp_num_line_buffers(struct omap_dss_device *dssdev)
 static void dsi_config_vp_sync_events(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
-	bool vsync_end = dssdev->panel.dsi_vm_data.vp_vsync_end;
-	bool hsync_end = dssdev->panel.dsi_vm_data.vp_hsync_end;
+	bool vsync_end = dssdev->panel.dsi_vm_timings.vp_vsync_end;
+	bool hsync_end = dssdev->panel.dsi_vm_timings.vp_hsync_end;
 	u32 r;
 
 	r = dsi_read_reg(dsidev, DSI_CTRL);
@@ -3656,10 +3656,10 @@ static void dsi_config_vp_sync_events(struct omap_dss_device *dssdev)
 static void dsi_config_blanking_modes(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
-	int blanking_mode = dssdev->panel.dsi_vm_data.blanking_mode;
-	int hfp_blanking_mode = dssdev->panel.dsi_vm_data.hfp_blanking_mode;
-	int hbp_blanking_mode = dssdev->panel.dsi_vm_data.hbp_blanking_mode;
-	int hsa_blanking_mode = dssdev->panel.dsi_vm_data.hsa_blanking_mode;
+	int blanking_mode = dssdev->panel.dsi_vm_timings.blanking_mode;
+	int hfp_blanking_mode = dssdev->panel.dsi_vm_timings.hfp_blanking_mode;
+	int hbp_blanking_mode = dssdev->panel.dsi_vm_timings.hbp_blanking_mode;
+	int hsa_blanking_mode = dssdev->panel.dsi_vm_timings.hsa_blanking_mode;
 	u32 r;
 
 	/*
@@ -3992,14 +3992,14 @@ static void dsi_proto_timings(struct omap_dss_device *dssdev)
 
 	 if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
 		/* TODO: Implement a video mode check_timings function */
-		int hsa = dssdev->panel.dsi_vm_data.hsa;
-		int hfp = dssdev->panel.dsi_vm_data.hfp;
-		int hbp = dssdev->panel.dsi_vm_data.hbp;
-		int vsa = dssdev->panel.dsi_vm_data.vsa;
-		int vfp = dssdev->panel.dsi_vm_data.vfp;
-		int vbp = dssdev->panel.dsi_vm_data.vbp;
-		int window_sync = dssdev->panel.dsi_vm_data.window_sync;
-		bool hsync_end = dssdev->panel.dsi_vm_data.vp_hsync_end;
+		int hsa = dssdev->panel.dsi_vm_timings.hsa;
+		int hfp = dssdev->panel.dsi_vm_timings.hfp;
+		int hbp = dssdev->panel.dsi_vm_timings.hbp;
+		int vsa = dssdev->panel.dsi_vm_timings.vsa;
+		int vfp = dssdev->panel.dsi_vm_timings.vfp;
+		int vbp = dssdev->panel.dsi_vm_timings.vbp;
+		int window_sync = dssdev->panel.dsi_vm_timings.window_sync;
+		bool hsync_end = dssdev->panel.dsi_vm_timings.vp_hsync_end;
 		struct omap_video_timings *timings = &dsi->timings;
 		int bpp = dsi_get_pixel_size(dsi->pix_fmt);
 		int tl, t_he, width_bytes;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index ef14ac5..363235c 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -243,7 +243,7 @@ void rfbi_bus_unlock(void);
 
 /* DSI */
 
-struct omap_dss_dsi_videomode_data {
+struct omap_dss_dsi_videomode_timings {
 	/* DSI video mode blanking data */
 	/* Unit: byte clock cycles */
 	u16 hsa;
@@ -564,7 +564,7 @@ struct omap_dss_device {
 
 		enum omap_dss_dsi_pixel_format dsi_pix_fmt;
 		enum omap_dss_dsi_mode dsi_mode;
-		struct omap_dss_dsi_videomode_data dsi_vm_data;
+		struct omap_dss_dsi_videomode_timings dsi_vm_timings;
 	} panel;
 
 	struct {
-- 
1.7.9.5

