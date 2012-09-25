From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 15/18] OMAPDSS: DISPC: Configure writeback specific parameters in dispc_wb_setup()
Date: Tue, 25 Sep 2012 11:49:50 +0530
Message-ID: <1348553993-8083-16-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
 <1348553993-8083-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48610 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753180Ab2IYGUl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 02:20:41 -0400
In-Reply-To: <1348553993-8083-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Configure some of the writeback specific parameters in dispc_wb_setup(). The
writeback parameters configured are:

truncation: This needs to be set if the color depth input to writeback is more
than the color depth of the color mode we want to store in memory.

writeback mode: This configures whether we want to use writeback in mem to mem
or capture mode. This information will be directly passed by APPLY later.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   28 ++++++++++++++++++++++++++--
 drivers/video/omap2/dss/dss.h   |    2 +-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 2e5f033..ca28a88 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2480,13 +2480,15 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 }
 
 int dispc_wb_setup(const struct omap_dss_writeback_info *wi,
-		const struct omap_video_timings *mgr_timings)
+		bool mem_to_mem, const struct omap_video_timings *mgr_timings)
 {
 	int r;
+	u32 l;
 	enum omap_plane plane = OMAP_DSS_WB;
 	const int pos_x = 0, pos_y = 0;
 	const u8 zorder = 0, global_alpha = 0;
 	const bool replication = false;
+	bool truncation;
 	int in_width = mgr_timings->x_res;
 	int in_height = mgr_timings->y_res;
 	enum omap_overlay_caps caps =
@@ -2501,7 +2503,29 @@ int dispc_wb_setup(const struct omap_dss_writeback_info *wi,
 		wi->buf_width, pos_x, pos_y, in_width, in_height, wi->width,
 		wi->height, wi->color_mode, wi->rotation, wi->mirror, zorder,
 		wi->pre_mult_alpha, global_alpha, wi->rotation_type,
-		replication, mgr_timings, false);
+		replication, mgr_timings, mem_to_mem);
+
+	switch (wi->color_mode) {
+	case OMAP_DSS_COLOR_RGB16:
+	case OMAP_DSS_COLOR_RGB24P:
+	case OMAP_DSS_COLOR_ARGB16:
+	case OMAP_DSS_COLOR_RGBA16:
+	case OMAP_DSS_COLOR_RGB12U:
+	case OMAP_DSS_COLOR_ARGB16_1555:
+	case OMAP_DSS_COLOR_XRGB16_1555:
+	case OMAP_DSS_COLOR_RGBX16:
+		truncation = true;
+		break;
+	default:
+		truncation = false;
+		break;
+	}
+
+	/* setup extra DISPC_WB_ATTRIBUTES */
+	l = dispc_read_reg(DISPC_OVL_ATTRIBUTES(plane));
+	l = FLD_MOD(l, truncation, 10, 10);	/* TRUNCATIONENABLE */
+	l = FLD_MOD(l, mem_to_mem, 19, 19);	/* WRITEBACKMODE */
+	dispc_write_reg(DISPC_OVL_ATTRIBUTES(plane), l);
 
 	return r;
 }
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 1a09f00..442c06a 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -484,7 +484,7 @@ void dispc_mgr_setup(enum omap_channel channel,
 
 void dispc_wb_set_channel_in(enum dss_writeback_channel channel);
 int dispc_wb_setup(const struct omap_dss_writeback_info *wi,
-		const struct omap_video_timings *timings);
+		bool mem_to_mem, const struct omap_video_timings *timings);
 
 /* VENC */
 #ifdef CONFIG_OMAP2_DSS_VENC
-- 
1.7.9.5

