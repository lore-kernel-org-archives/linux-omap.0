From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 14/18] OMAPDSS: DISPC: Configure overlay-like parameters in dispc_wb_setup
Date: Tue, 25 Sep 2012 11:49:49 +0530
Message-ID: <1348553993-8083-15-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
 <1348553993-8083-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60589 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752857Ab2IYGUj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 02:20:39 -0400
In-Reply-To: <1348553993-8083-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Create struct omap_dss_writeback_info, this is similar to omap_overlay_info,
the major difference is that there is no parameter which describes the input
size to writeback, this is because this is always fixed, and decided by the
connected overlay or overlay manager. One more difference is that screen_width
is renamed to buf_width, to give the value of stride the writeback buffer has.

Call dispc_ovl_setup_common() through dispc_wb_setup() to configure overlay-like
parameters. The parameters in dispc_ovl_setup_common() which do not hold for
writeback are filled passed as zeroes or false, the code takes care of not
configuring them as they won't possess the needed overlay caps.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   27 +++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h   |    2 ++
 include/video/omapdss.h         |   13 +++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 6d482f5..2e5f033 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2479,6 +2479,33 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 	return r;
 }
 
+int dispc_wb_setup(const struct omap_dss_writeback_info *wi,
+		const struct omap_video_timings *mgr_timings)
+{
+	int r;
+	enum omap_plane plane = OMAP_DSS_WB;
+	const int pos_x = 0, pos_y = 0;
+	const u8 zorder = 0, global_alpha = 0;
+	const bool replication = false;
+	int in_width = mgr_timings->x_res;
+	int in_height = mgr_timings->y_res;
+	enum omap_overlay_caps caps =
+		OMAP_DSS_OVL_CAP_SCALE | OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA;
+
+	DSSDBG("dispc_wb_setup, pa %x, pa_uv %x, %d,%d -> %dx%d, cmode %x, "
+		"rot %d, mir %d\n", wi->paddr, wi->p_uv_addr, in_width,
+		in_height, wi->width, wi->height, wi->color_mode, wi->rotation,
+		wi->mirror);
+
+	r = dispc_ovl_setup_common(plane, caps, wi->paddr, wi->p_uv_addr,
+		wi->buf_width, pos_x, pos_y, in_width, in_height, wi->width,
+		wi->height, wi->color_mode, wi->rotation, wi->mirror, zorder,
+		wi->pre_mult_alpha, global_alpha, wi->rotation_type,
+		replication, mgr_timings, false);
+
+	return r;
+}
+
 int dispc_ovl_enable(enum omap_plane plane, bool enable)
 {
 	DSSDBG("dispc_enable_plane %d, %d\n", plane, enable);
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 872e420..1a09f00 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -483,6 +483,8 @@ void dispc_mgr_setup(enum omap_channel channel,
 		struct omap_overlay_manager_info *info);
 
 void dispc_wb_set_channel_in(enum dss_writeback_channel channel);
+int dispc_wb_setup(const struct omap_dss_writeback_info *wi,
+		const struct omap_video_timings *timings);
 
 /* VENC */
 #ifdef CONFIG_OMAP2_DSS_VENC
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 46097bd..3729173 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -510,6 +510,19 @@ struct omap_dsi_pin_config {
 	int pins[OMAP_DSS_MAX_DSI_PINS];
 };
 
+struct omap_dss_writeback_info {
+	u32 paddr;
+	u32 p_uv_addr;
+	u16 buf_width;
+	u16 width;
+	u16 height;
+	enum omap_color_mode color_mode;
+	u8 rotation;
+	enum omap_dss_rotation_type rotation_type;
+	bool mirror;
+	u8 pre_mult_alpha;
+};
+
 struct omap_dss_output {
 	struct list_head list;
 
-- 
1.7.9.5

