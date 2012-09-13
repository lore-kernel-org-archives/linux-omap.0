From: Archit Taneja <archit@ti.com>
Subject: [PATCH 18/21] OMAPDSS: DISPC: Configure writeback specific parameters in dispc_wb_setup()
Date: Thu, 13 Sep 2012 17:45:02 +0530
Message-ID: <1347538505-25359-19-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52162 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757971Ab2IMMP5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 08:15:57 -0400
In-Reply-To: <1347538505-25359-1-git-send-email-archit@ti.com>
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
 drivers/video/omap2/dss/dispc.c |   26 +++++++++++++++++++++++++-
 drivers/video/omap2/dss/dss.h   |    2 +-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index f575875..a44cbac 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2465,13 +2465,15 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
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
 	unsigned long out_rate;
@@ -2491,6 +2493,28 @@ int dispc_wb_setup(const struct omap_dss_writeback_info *wi,
 		wi->mirror, zorder, wi->pre_mult_alpha, global_alpha,
 		wi->rotation_type, replication, mgr_timings);
 
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
+
 	return r;
 }
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index bd7c5cf..c49c054 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -483,7 +483,7 @@ void dispc_mgr_setup(enum omap_channel channel,
 
 void dispc_wb_set_channel_in(enum dss_writeback_channel channel);
 int dispc_wb_setup(const struct omap_dss_writeback_info *wi,
-		const struct omap_video_timings *timings);
+		bool mem_to_mem, const struct omap_video_timings *timings);
 
 /* VENC */
 #ifdef CONFIG_OMAP2_DSS_VENC
-- 
1.7.9.5

