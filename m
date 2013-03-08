From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 05/14] OMAPDSS: DSI: add enum omap_dss_dsi_trans_mode
Date: Fri, 8 Mar 2013 13:52:40 +0200
Message-ID: <1362743569-10289-6-git-send-email-tomi.valkeinen@ti.com>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44138 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933865Ab3CHLxU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Mar 2013 06:53:20 -0500
In-Reply-To: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Instead of managing DSI sync ends with booleans, add an enum for the DSI
transfer mode. This is much cleaner way to handle the DSI syncs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   15 ++++++++++-----
 include/video/omapdss.h       |   13 ++++++++++---
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 374fd8f..7faad58 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3813,18 +3813,22 @@ static void dsi_config_vp_num_line_buffers(struct platform_device *dsidev)
 static void dsi_config_vp_sync_events(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	bool vsync_end = dsi->vm_timings.vp_vsync_end;
-	bool hsync_end = dsi->vm_timings.vp_hsync_end;
+	bool sync_end;
 	u32 r;
 
+	if (dsi->vm_timings.trans_mode == OMAP_DSS_DSI_PULSE_MODE)
+		sync_end = true;
+	else
+		sync_end = false;
+
 	r = dsi_read_reg(dsidev, DSI_CTRL);
 	r = FLD_MOD(r, 1, 9, 9);		/* VP_DE_POL */
 	r = FLD_MOD(r, 1, 10, 10);		/* VP_HSYNC_POL */
 	r = FLD_MOD(r, 1, 11, 11);		/* VP_VSYNC_POL */
 	r = FLD_MOD(r, 1, 15, 15);		/* VP_VSYNC_START */
-	r = FLD_MOD(r, vsync_end, 16, 16);	/* VP_VSYNC_END */
+	r = FLD_MOD(r, sync_end, 16, 16);	/* VP_VSYNC_END */
 	r = FLD_MOD(r, 1, 17, 17);		/* VP_HSYNC_START */
-	r = FLD_MOD(r, hsync_end, 18, 18);	/* VP_HSYNC_END */
+	r = FLD_MOD(r, sync_end, 18, 18);	/* VP_HSYNC_END */
 	dsi_write_reg(dsidev, DSI_CTRL, r);
 }
 
@@ -4171,11 +4175,12 @@ static void dsi_proto_timings(struct platform_device *dsidev)
 		int vfp = dsi->vm_timings.vfp;
 		int vbp = dsi->vm_timings.vbp;
 		int window_sync = dsi->vm_timings.window_sync;
-		bool hsync_end = dsi->vm_timings.vp_hsync_end;
+		bool hsync_end;
 		struct omap_video_timings *timings = &dsi->timings;
 		int bpp = dsi_get_pixel_size(dsi->pix_fmt);
 		int tl, t_he, width_bytes;
 
+		hsync_end = dsi->vm_timings.trans_mode == OMAP_DSS_DSI_PULSE_MODE;
 		t_he = hsync_end ?
 			((hsa == 0 && ndl == 3) ? 1 : DIV_ROUND_UP(4, ndl)) : 0;
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 4a52197..161011e 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -257,6 +257,15 @@ void rfbi_bus_unlock(void);
 
 /* DSI */
 
+enum omap_dss_dsi_trans_mode {
+	/* Sync Pulses: both sync start and end packets sent */
+	OMAP_DSS_DSI_PULSE_MODE,
+	/* Sync Events: only sync start packets sent */
+	OMAP_DSS_DSI_EVENT_MODE,
+	/* Burst: only sync start packets sent, pixels are time compressed */
+	OMAP_DSS_DSI_BURST_MODE,
+};
+
 struct omap_dss_dsi_videomode_timings {
 	/* DSI video mode blanking data */
 	/* Unit: byte clock cycles */
@@ -274,9 +283,7 @@ struct omap_dss_dsi_videomode_timings {
 	int hbp_blanking_mode;
 	int hfp_blanking_mode;
 
-	/* Video port sync events */
-	bool vp_vsync_end;
-	bool vp_hsync_end;
+	enum omap_dss_dsi_trans_mode trans_mode;
 
 	bool ddr_clk_always_on;
 	int window_sync;
-- 
1.7.10.4

