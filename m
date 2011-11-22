From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 53/65] OMAPDSS: APPLY: move fifo thresholds to extra_info set
Date: Tue, 22 Nov 2011 11:21:52 +0200
Message-ID: <1321953724-6350-54-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:37024 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758155Ab1KVJYd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:33 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Setting overlay's fifo thresholds is currently handled at the same time
as other overlay attributes. This is not right, as the normal attributes
should only affect one overlay and manager, but changing the fifo
thresholds are needed in cases like fifo-merge, where multiple managers
are affected.

This patch moves the channel field into the "extra_info" set, handled
together with channel and enabled-status.

This also lets us to calculate the fifos only when needed, specifically,
when an overlay or a manager is enabled.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   95 +++++++++++++++++++++++---------------
 1 files changed, 57 insertions(+), 38 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 3e345d7..0e93ae5 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -69,14 +69,12 @@ struct ovl_priv_data {
 
 	struct omap_overlay_info info;
 
-	u32 fifo_low;
-	u32 fifo_high;
-
 	bool extra_info_dirty;
 	bool shadow_extra_info_dirty;
 
 	bool enabled;
 	enum omap_channel channel;
+	u32 fifo_low, fifo_high;
 };
 
 struct mgr_priv_data {
@@ -396,8 +394,6 @@ static void dss_ovl_write_regs(struct omap_overlay *ovl)
 		return;
 	}
 
-	dispc_ovl_set_fifo_threshold(ovl->id, op->fifo_low, op->fifo_high);
-
 	mp = get_mgr_priv(ovl->manager);
 
 	op->dirty = false;
@@ -420,6 +416,7 @@ static void dss_ovl_write_regs_extra(struct omap_overlay *ovl)
 
 	dispc_ovl_enable(ovl->id, op->enabled);
 	dispc_ovl_set_channel_out(ovl->id, op->channel);
+	dispc_ovl_set_fifo_threshold(ovl->id, op->fifo_low, op->fifo_high);
 
 	mp = get_mgr_priv(ovl->manager);
 
@@ -632,13 +629,42 @@ static void omap_dss_mgr_apply_mgr(struct omap_overlay_manager *mgr)
 	mp->info = mp->user_info;
 }
 
-static void omap_dss_mgr_apply_ovl_fifos(struct omap_overlay *ovl)
+int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 {
-	struct ovl_priv_data *op;
+	int r;
+	unsigned long flags;
+	struct omap_overlay *ovl;
+
+	DSSDBG("omap_dss_mgr_apply(%s)\n", mgr->name);
+
+	r = dispc_runtime_get();
+	if (r)
+		return r;
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	/* Configure overlays */
+	list_for_each_entry(ovl, &mgr->overlays, list)
+		omap_dss_mgr_apply_ovl(ovl);
+
+	/* Configure manager */
+	omap_dss_mgr_apply_mgr(mgr);
+
+	dss_write_regs();
+
+	spin_unlock_irqrestore(&data_lock, flags);
+
+	dispc_runtime_put();
+
+	return r;
+}
+
+static void dss_ovl_setup_fifo(struct omap_overlay *ovl)
+{
+	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	struct omap_dss_device *dssdev;
 	u32 size, burst_size;
-
-	op = get_ovl_priv(ovl);
+	u32 fifo_low, fifo_high;
 
 	dssdev = ovl->manager->device;
 
@@ -653,53 +679,42 @@ static void omap_dss_mgr_apply_ovl_fifos(struct omap_overlay *ovl)
 	case OMAP_DISPLAY_TYPE_VENC:
 	case OMAP_DISPLAY_TYPE_HDMI:
 		default_get_overlay_fifo_thresholds(ovl->id, size,
-				burst_size, &op->fifo_low,
-				&op->fifo_high);
+				burst_size, &fifo_low, &fifo_high);
 		break;
 #ifdef CONFIG_OMAP2_DSS_DSI
 	case OMAP_DISPLAY_TYPE_DSI:
 		dsi_get_overlay_fifo_thresholds(ovl->id, size,
-				burst_size, &op->fifo_low,
-				&op->fifo_high);
+				burst_size, &fifo_low, &fifo_high);
 		break;
 #endif
 	default:
 		BUG();
 	}
+
+	op->fifo_low = fifo_low;
+	op->fifo_high = fifo_high;
+	op->extra_info_dirty = true;
 }
 
-int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
+static void dss_mgr_setup_fifos(struct omap_overlay_manager *mgr)
 {
-	int r;
-	unsigned long flags;
 	struct omap_overlay *ovl;
+	struct ovl_priv_data *op;
+	struct mgr_priv_data *mp;
 
-	DSSDBG("omap_dss_mgr_apply(%s)\n", mgr->name);
-
-	r = dispc_runtime_get();
-	if (r)
-		return r;
-
-	spin_lock_irqsave(&data_lock, flags);
-
-	/* Configure overlays */
-	list_for_each_entry(ovl, &mgr->overlays, list)
-		omap_dss_mgr_apply_ovl(ovl);
-
-	/* Configure manager */
-	omap_dss_mgr_apply_mgr(mgr);
-
-	/* Configure overlay fifos */
-	list_for_each_entry(ovl, &mgr->overlays, list)
-		omap_dss_mgr_apply_ovl_fifos(ovl);
+	mp = get_mgr_priv(mgr);
 
-	dss_write_regs();
+	if (!mp->enabled)
+		return;
 
-	spin_unlock_irqrestore(&data_lock, flags);
+	list_for_each_entry(ovl, &mgr->overlays, list) {
+		op = get_ovl_priv(ovl);
 
-	dispc_runtime_put();
+		if (!op->enabled)
+			continue;
 
-	return r;
+		dss_ovl_setup_fifo(ovl);
+	}
 }
 
 void dss_mgr_enable(struct omap_overlay_manager *mgr)
@@ -713,6 +728,8 @@ void dss_mgr_enable(struct omap_overlay_manager *mgr)
 
 	mp->enabled = true;
 
+	dss_mgr_setup_fifos(mgr);
+
 	dss_write_regs();
 
 	if (!mgr_manual_update(mgr))
@@ -1000,6 +1017,8 @@ int dss_ovl_enable(struct omap_overlay *ovl)
 	op->enabled = true;
 	op->extra_info_dirty = true;
 
+	dss_ovl_setup_fifo(ovl);
+
 	dss_write_regs();
 
 	spin_unlock_irqrestore(&data_lock, flags);
-- 
1.7.4.1

