From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 25/32] OMAPDSS: DISPC: add dispc_ovl_check()
Date: Thu, 15 Nov 2012 17:58:33 +0200
Message-ID: <1352995120-3288-26-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56270 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768296Ab2KOP7v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 10:59:51 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

This patch adds a new function, dispc_ovl_check(), which can be used to
verify scaling configuration for an overlay. The function gets both the
overlay and overlay manager as parameters, so that the caller does not
need to configure the hardware before using this function.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   40 +++++++++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h   |    4 ++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index b3bb604..15ef1d1 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2314,6 +2314,46 @@ static int dispc_ovl_calc_scaling(unsigned long pclk, unsigned long lclk,
 	return 0;
 }
 
+int dispc_ovl_check(enum omap_plane plane, enum omap_channel channel,
+		const struct omap_overlay_info *oi,
+		const struct omap_video_timings *timings,
+		int *x_predecim, int *y_predecim)
+{
+	enum omap_overlay_caps caps = dss_feat_get_overlay_caps(plane);
+	bool five_taps = true;
+	bool fieldmode = 0;
+	u16 in_height = oi->height;
+	u16 in_width = oi->width;
+	bool ilace = timings->interlace;
+	u16 out_width, out_height;
+	int pos_x = oi->pos_x;
+	unsigned long pclk = dispc_mgr_pclk_rate(channel);
+	unsigned long lclk = dispc_mgr_lclk_rate(channel);
+
+	out_width = oi->out_width == 0 ? oi->width : oi->out_width;
+	out_height = oi->out_height == 0 ? oi->height : oi->out_height;
+
+	if (ilace && oi->height == out_height)
+		fieldmode = 1;
+
+	if (ilace) {
+		if (fieldmode)
+			in_height /= 2;
+		out_height /= 2;
+
+		DSSDBG("adjusting for ilace: height %d, out_height %d\n",
+				in_height, out_height);
+	}
+
+	if (!dss_feat_color_mode_supported(plane, oi->color_mode))
+		return -EINVAL;
+
+	return dispc_ovl_calc_scaling(pclk, lclk, caps, timings, in_width,
+			in_height, out_width, out_height, oi->color_mode,
+			&five_taps, x_predecim, y_predecim, pos_x,
+			oi->rotation_type, false);
+}
+
 static int dispc_ovl_setup_common(enum omap_plane plane,
 		enum omap_overlay_caps caps, u32 paddr, u32 p_uv_addr,
 		u16 screen_width, int pos_x, int pos_y, u16 width, u16 height,
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 16fbaaa..8004bdf 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -423,6 +423,10 @@ int dispc_ovl_enable(enum omap_plane plane, bool enable);
 bool dispc_ovl_enabled(enum omap_plane plane);
 void dispc_ovl_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel);
+int dispc_ovl_check(enum omap_plane plane, enum omap_channel channel,
+		const struct omap_overlay_info *oi,
+		const struct omap_video_timings *timings,
+		int *x_predecim, int *y_predecim);
 
 u32 dispc_mgr_get_vsync_irq(enum omap_channel channel);
 u32 dispc_mgr_get_framedone_irq(enum omap_channel channel);
-- 
1.7.10.4

