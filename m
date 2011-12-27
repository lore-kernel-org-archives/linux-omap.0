From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 21/29] OMAPDSS: DISPC: Configure overlay-like parameters in dispc_wb_setup
Date: Tue, 27 Dec 2011 18:07:04 +0530
Message-ID: <1324989432-3625-22-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52246 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752Ab1L0Mjv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Dec 2011 07:39:51 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Call dispc_plane_setup() through dispc_wb_setup() to configure overlay-like
parameters. Create a helper function in writeback.c called dss_wb_calc_params()
which for now calculates the input width and height which goes to writeback.
Create a dummy dispc function which returns the channel of the manager to which
the writeback pipeline is connected.

The parameters in dispc_plane_setup() which do not hold for writeback are filled
passed as zeroes or false, dispc_plane_setup() takes care of not configuring
them if the plane is writeback.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c     |    5 ++++-
 drivers/video/omap2/dss/dispc.c     |   33 +++++++++++++++++++++++++++++++--
 drivers/video/omap2/dss/dss.h       |    6 +++++-
 drivers/video/omap2/dss/writeback.c |   17 +++++++++++++++++
 4 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index a17cc47..dd1fd419 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -661,6 +661,7 @@ static void dss_wb_write_regs(struct omap_dss_writeback *wb)
 {
 	struct wb_priv_data *wp = get_wb_priv(wb);
 	struct omap_dss_writeback_info *wi;
+	u16 in_width, in_height;
 	int r;
 
 	if (!wp->enabled || !wp->info_dirty)
@@ -670,7 +671,9 @@ static void dss_wb_write_regs(struct omap_dss_writeback *wb)
 
 	wi = &wp->info;
 
-	r = dispc_wb_setup(wb->id, wi);
+	dss_wb_calc_params(wb, wi, &in_width, &in_height);
+
+	r = dispc_wb_setup(wb->id, wi, in_width, in_height);
 	if (r) {
 		DSSERR("dispc_wb_setup failed\n");
 		return;
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 3a40f8e..c7de56d 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -908,6 +908,13 @@ void dispc_wb_set_channel_in(int id, enum dss_writeback_channel_in ch_in)
 	return;
 }
 
+static enum omap_channel dispc_wb_get_channel_in(int plane)
+{
+	/* Return LCD channel for now */
+
+	return OMAP_DSS_CHANNEL_LCD;
+}
+
 static void dispc_ovl_set_burst_size(enum omap_plane plane,
 		enum omap_burst_size burst_size)
 {
@@ -1935,9 +1942,31 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	return r;
 }
 
-int dispc_wb_setup(int id, struct omap_dss_writeback_info *wi)
+int dispc_wb_setup(int id, struct omap_dss_writeback_info *wi,
+		u16 in_width, u16 in_height)
 {
-	return 0;
+	int r;
+	struct omap_dss_writeback *wb = omap_dss_get_writeback(id);
+	const int pos_x = 0, pos_y = 0;
+	const u8 zorder = 0, global_alpha = 0;
+	const bool chroma_upscale = false, ilace = false, replication = false;
+	enum omap_channel channel;
+
+	channel = dispc_wb_get_channel_in(wb->plane_id);
+
+	DSSDBG("dispc_wb_setup %d, pa %x, pa_uv %x, %d,%d -> %dx%d, cmode %x, "
+		"rot %d, mir %d, chan %d\n",
+		wb->id, wi->paddr, wi->p_uv_addr, in_width, in_height,
+		wi->buf_width, wi->buf_height, wi->color_mode, wi->rotation,
+		wi->mirror, channel);
+
+	r = dispc_plane_setup(wb->plane_id, channel, wb->caps, wi->paddr,
+		wi->p_uv_addr, in_width, pos_x, pos_y, in_width, in_height,
+		wi->buf_width, wi->buf_height, wi->color_mode, wi->rotation,
+		wi->mirror, zorder, wi->pre_mult_alpha, global_alpha,
+		wi->rotation_type, chroma_upscale, ilace, replication);
+
+	return r;
 }
 
 int dispc_ovl_enable(enum omap_plane plane, bool enable)
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 1b128f1..69b4793 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -249,6 +249,9 @@ void dss_init_writeback(void);
 void dss_uninit_writeback(void);
 int writeback_init_display(struct omap_dss_device *dssdev);
 enum dss_writeback_channel_in dss_wb_calc_channel_in(struct omap_dss_writeback *wb);
+void dss_wb_calc_params(struct omap_dss_writeback *wb,
+		struct omap_dss_writeback_info *wi, u16 *in_width,
+		u16 *in_height);
 int dss_wb_simple_check(struct omap_dss_writeback *wb,
 		const struct omap_dss_writeback_info *info);
 
@@ -492,7 +495,8 @@ void dispc_mgr_setup(enum omap_channel channel,
 
 bool dispc_wb_go_busy(int id);
 void dispc_wb_go(int id);
-int dispc_wb_setup(int id, struct omap_dss_writeback_info *wi);
+int dispc_wb_setup(int id, struct omap_dss_writeback_info *wi,
+		u16 in_width, u16 in_height);
 void dispc_wb_enable(int id, bool enable);
 void dispc_wb_set_channel_in(int id, enum dss_writeback_channel_in ch_in);
 
diff --git a/drivers/video/omap2/dss/writeback.c b/drivers/video/omap2/dss/writeback.c
index 14103bf..7c4e9c0 100644
--- a/drivers/video/omap2/dss/writeback.c
+++ b/drivers/video/omap2/dss/writeback.c
@@ -141,6 +141,23 @@ enum dss_writeback_channel_in dss_wb_calc_channel_in(struct omap_dss_writeback *
 	}
 }
 
+void dss_wb_calc_params(struct omap_dss_writeback *wb,
+		struct omap_dss_writeback_info *wi, u16 *in_width,
+		u16 *in_height)
+{
+	struct omap_video_timings timings;
+	struct omap_dss_device *dssdev;
+	struct omap_overlay_manager *mgr;
+
+	mgr = wb->dssdev->manager;
+	dssdev = mgr->get_display(mgr);
+
+	dssdev->driver->get_timings(dssdev, &timings);
+
+	*in_width = timings.x_res;
+	*in_height = timings.y_res;
+}
+
 int dss_wb_simple_check(struct omap_dss_writeback *wb,
 		const struct omap_dss_writeback_info *info)
 {
-- 
1.7.4.1

