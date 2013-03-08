From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 04/14] OMAPDSS: DSI: get line buffer size at probe
Date: Fri, 8 Mar 2013 13:52:39 +0200
Message-ID: <1362743569-10289-5-git-send-email-tomi.valkeinen@ti.com>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56491 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933779Ab3CHLxS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:53:18 -0500
In-Reply-To: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

To find out the DSI line buffer size we need to read HW registers. To
make it possible to do DSI configuration calculations without HW powered
up, store the line buffer size at DSI driver's probe.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 901b721..374fd8f 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -336,6 +336,7 @@ struct dsi_data {
 	unsigned long lpdiv_max;
 
 	unsigned num_lanes_supported;
+	unsigned line_buffer_size;
 
 	struct dsi_lane_config lanes[DSI_MAX_NR_LANES];
 	unsigned num_lanes_used;
@@ -3791,13 +3792,12 @@ static void dsi_config_vp_num_line_buffers(struct platform_device *dsidev)
 
 	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
 		int bpp = dsi_get_pixel_size(dsi->pix_fmt);
-		unsigned line_buf_size = dsi_get_line_buf_size(dsidev);
 		struct omap_video_timings *timings = &dsi->timings;
 		/*
 		 * Don't use line buffers if width is greater than the video
 		 * port's line buffer size
 		 */
-		if (line_buf_size <= timings->x_res * bpp / 8)
+		if (dsi->line_buffer_size <= timings->x_res * bpp / 8)
 			num_line_buffers = 0;
 		else
 			num_line_buffers = 2;
@@ -4447,7 +4447,7 @@ static void dsi_update_screen_dispc(struct platform_device *dsidev)
 	u32 l;
 	int r;
 	const unsigned channel = dsi->update_channel;
-	const unsigned line_buf_size = dsi_get_line_buf_size(dsidev);
+	const unsigned line_buf_size = dsi->line_buffer_size;
 	u16 w = dsi->timings.x_res;
 	u16 h = dsi->timings.y_res;
 
@@ -5290,6 +5290,8 @@ static int __init omap_dsihw_probe(struct platform_device *dsidev)
 	else
 		dsi->num_lanes_supported = 3;
 
+	dsi->line_buffer_size = dsi_get_line_buf_size(dsidev);
+
 	dsi_init_output(dsidev);
 
 	dsi_probe_pdata(dsidev);
-- 
1.7.10.4

