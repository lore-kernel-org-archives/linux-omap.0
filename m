From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 13/29] OMAPDSS: APPLY: Configure writeback FIFOs
Date: Tue, 27 Dec 2011 18:06:56 +0530
Message-ID: <1324989432-3625-14-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52211 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621Ab1L0MjL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Dec 2011 07:39:11 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Add writeback FIFO thresholds as extra_info parameters. Modify function
dss_ovl_fifo_setup() so that it can also also configure writeback pipeline
FIFOs. Extend the DISPC fifo functions to also configure the writeback
registers.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |   70 +++++++++++++++++++++++++++++++++-----
 drivers/video/omap2/dss/dispc.c |    8 +++--
 2 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 9f3c174..a17cc47 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -115,6 +115,7 @@ struct wb_priv_data {
 	bool shadow_extra_info_dirty;
 
 	enum dss_writeback_channel_in channel_in;
+	u32 fifo_low, fifo_high;
 
 	/* If true, GO bit is up and shadow registers cannot be written.
 	 * Never true for writeback in memory to memory mode */
@@ -687,6 +688,7 @@ static void dss_wb_write_regs_extra(struct omap_dss_writeback *wb)
 		return;
 
 	dispc_wb_set_channel_in(wb->id, wp->channel_in);
+	dispc_ovl_set_fifo_threshold(wb->plane_id, wp->fifo_low, wp->fifo_high);
 
 	wp->extra_info_dirty = false;
 	wp->shadow_extra_info_dirty = true;
@@ -1102,21 +1104,59 @@ static void dss_apply_ovl_fifo_thresholds(struct omap_overlay *ovl,
 	op->extra_info_dirty = true;
 }
 
-static void dss_ovl_setup_fifo(struct omap_overlay *ovl)
+static void dss_apply_wb_fifo_thresholds(struct omap_dss_writeback *wb,
+		u32 fifo_low, u32 fifo_high)
 {
-	struct ovl_priv_data *op = get_ovl_priv(ovl);
+	struct wb_priv_data *wp = get_wb_priv(wb);
+
+	if (wp->fifo_low == fifo_low && wp->fifo_high == fifo_high)
+		return;
+
+	wp->fifo_low = fifo_low;
+	wp->fifo_high = fifo_high;
+	wp->extra_info_dirty = true;
+}
+
+static void dss_plane_setup_fifo(struct omap_overlay *ovl,
+		struct omap_dss_writeback *wb)
+{
+	enum omap_plane plane;
+	struct omap_overlay_manager *mgr;
 	struct omap_dss_device *dssdev;
+	bool enabled, enabling;
 	u32 size, burst_size;
 	u32 fifo_low, fifo_high;
 
-	if (!op->enabled && !op->enabling)
+	if (ovl) {
+		struct ovl_priv_data *op;
+
+		mgr = ovl->manager;
+		op = get_ovl_priv(ovl);
+
+		enabled = op->enabled;
+		enabling = op->enabling;
+
+		plane = ovl->id;
+	} else {
+		struct wb_priv_data *wp;
+
+		mgr = wb->dssdev->manager;
+		wp = get_wb_priv(wb);
+
+		enabled = wp->enabled;
+		enabling = false;
+
+		plane = wb->plane_id;
+	}
+
+	if (!enabled && !enabling)
 		return;
 
-	dssdev = ovl->manager->get_output(ovl->manager);
+	dssdev = mgr->get_output(mgr);
 
-	size = dispc_ovl_get_fifo_size(ovl->id);
+	size = dispc_ovl_get_fifo_size(plane);
 
-	burst_size = dispc_ovl_get_burst_size(ovl->id);
+	burst_size = dispc_ovl_get_burst_size(plane);
 
 	switch (dssdev->type) {
 	case OMAP_DISPLAY_TYPE_DPI:
@@ -1124,12 +1164,12 @@ static void dss_ovl_setup_fifo(struct omap_overlay *ovl)
 	case OMAP_DISPLAY_TYPE_SDI:
 	case OMAP_DISPLAY_TYPE_VENC:
 	case OMAP_DISPLAY_TYPE_HDMI:
-		default_get_overlay_fifo_thresholds(ovl->id, size,
+		default_get_overlay_fifo_thresholds(plane, size,
 				burst_size, &fifo_low, &fifo_high);
 		break;
 #ifdef CONFIG_OMAP2_DSS_DSI
 	case OMAP_DISPLAY_TYPE_DSI:
-		dsi_get_overlay_fifo_thresholds(ovl->id, size,
+		dsi_get_overlay_fifo_thresholds(plane, size,
 				burst_size, &fifo_low, &fifo_high);
 		break;
 #endif
@@ -1137,13 +1177,17 @@ static void dss_ovl_setup_fifo(struct omap_overlay *ovl)
 		BUG();
 	}
 
-	dss_apply_ovl_fifo_thresholds(ovl, fifo_low, fifo_high);
+	if (ovl)
+		dss_apply_ovl_fifo_thresholds(ovl, fifo_low, fifo_high);
+	else
+		dss_apply_wb_fifo_thresholds(wb, fifo_low, fifo_high);
 }
 
 static void dss_mgr_setup_fifos(struct omap_overlay_manager *mgr)
 {
 	struct omap_overlay *ovl;
 	struct mgr_priv_data *mp;
+	struct omap_dss_device *dssdev;
 
 	mp = get_mgr_priv(mgr);
 
@@ -1151,7 +1195,13 @@ static void dss_mgr_setup_fifos(struct omap_overlay_manager *mgr)
 		return;
 
 	list_for_each_entry(ovl, &mgr->overlays, list)
-		dss_ovl_setup_fifo(ovl);
+		dss_plane_setup_fifo(ovl, NULL);
+
+	dssdev = mgr->get_writeback(mgr);
+	if (dssdev) {
+		struct omap_dss_writeback *wb = dssdev->wbdev;
+		dss_plane_setup_fifo(NULL, wb);
+	}
 }
 
 static void dss_setup_fifos(void)
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index a4d5504..231369a 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -91,7 +91,7 @@ static struct {
 	int irq;
 	struct clk *dss_clk;
 
-	u32	fifo_size[MAX_DSS_OVERLAYS];
+	u32	fifo_size[MAX_DSS_OVERLAYS + MAX_DSS_WB];
 
 	spinlock_t irq_lock;
 	u32 irq_error_mask;
@@ -907,7 +907,7 @@ void dispc_wb_set_channel_in(int id, enum dss_writeback_channel_in ch_in)
 static void dispc_ovl_set_burst_size(enum omap_plane plane,
 		enum omap_burst_size burst_size)
 {
-	static const unsigned shifts[] = { 6, 14, 14, 14, };
+	static const unsigned shifts[] = { 6, 14, 14, 14, 14, };
 	int shift;
 
 	shift = shifts[plane];
@@ -1021,12 +1021,14 @@ static void dispc_read_plane_fifo_sizes(void)
 	int plane;
 	u8 start, end;
 	u32 unit;
+	int num_ovl = dss_feat_get_num_ovls();
+	int num_wb = dss_feat_get_num_wb();
 
 	unit = dss_feat_get_buffer_size_unit();
 
 	dss_feat_get_reg_field(FEAT_REG_FIFOSIZE, &start, &end);
 
-	for (plane = 0; plane < dss_feat_get_num_ovls(); ++plane) {
+	for (plane = 0; plane < num_ovl + num_wb; ++plane) {
 		size = REG_GET(DISPC_OVL_FIFO_SIZE_STATUS(plane), start, end);
 		size *= unit;
 		dispc.fifo_size[plane] = size;
-- 
1.7.4.1

