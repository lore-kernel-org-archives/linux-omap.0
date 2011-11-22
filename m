From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 48/65] OMAPDSS: APPLY: add updating flag
Date: Tue, 22 Nov 2011 11:21:47 +0200
Message-ID: <1321953724-6350-49-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:46516 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757732Ab1KVJYV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:21 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add "updating" flag to mgr_priv_data, which is used to track whether the
manager is currently actively working, i.e. updating the screen.

For auto-update displays updating is always true when the display is
enabled, but for manual update displays the flag is true only during
frame transfers.

The flag is used to manage registers properly, for example when updating
is false and a register for a manager is written, there's no need to set
shadow_dirty flag nor set the GO bit, as the settings will be taken into
use by the HW automatically when the output is enabled.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   79 +++++++++++++++++++++++++--------------
 1 files changed, 51 insertions(+), 28 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index c4106b6..b2c0462 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -92,6 +92,9 @@ struct mgr_priv_data {
 	 * Never true for manual update displays */
 	bool busy;
 
+	/* If true, dispc output is enabled */
+	bool updating;
+
 	/* If true, a display is enabled using this manager */
 	bool enabled;
 };
@@ -151,28 +154,31 @@ static bool need_isr(void)
 		if (!mp->enabled)
 			continue;
 
-		if (mgr_manual_update(mgr))
-			continue;
-
-		/* to catch GO bit going down */
-		if (mp->busy)
-			return true;
+		if (mgr_manual_update(mgr)) {
+			/* to catch FRAMEDONE */
+			if (mp->updating)
+				return true;
+		} else {
+			/* to catch GO bit going down */
+			if (mp->busy)
+				return true;
 
-		/* to write new values to registers */
-		if (mp->dirty)
-			return true;
+			/* to write new values to registers */
+			if (mp->dirty)
+				return true;
 
-		list_for_each_entry(ovl, &mgr->overlays, list) {
-			struct ovl_priv_data *op;
+			list_for_each_entry(ovl, &mgr->overlays, list) {
+				struct ovl_priv_data *op;
 
-			op = get_ovl_priv(ovl);
+				op = get_ovl_priv(ovl);
 
-			if (!op->enabled)
-				continue;
+				if (!op->enabled)
+					continue;
 
-			/* to write new values to registers */
-			if (op->dirty || op->extra_info_dirty)
-				return true;
+				/* to write new values to registers */
+				if (op->dirty || op->extra_info_dirty)
+					return true;
+			}
 		}
 	}
 
@@ -325,6 +331,7 @@ static void dss_ovl_write_regs(struct omap_overlay *ovl)
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	struct omap_overlay_info *oi;
 	bool ilace, replication;
+	struct mgr_priv_data *mp;
 	int r;
 
 	DSSDBGF("%d", ovl->id);
@@ -356,13 +363,17 @@ static void dss_ovl_write_regs(struct omap_overlay *ovl)
 
 	dispc_ovl_set_fifo_threshold(ovl->id, op->fifo_low, op->fifo_high);
 
+	mp = get_mgr_priv(ovl->manager);
+
 	op->dirty = false;
-	op->shadow_dirty = true;
+	if (mp->updating)
+		op->shadow_dirty = true;
 }
 
 static void dss_ovl_write_regs_extra(struct omap_overlay *ovl)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
+	struct mgr_priv_data *mp;
 
 	DSSDBGF("%d", ovl->id);
 
@@ -374,8 +385,11 @@ static void dss_ovl_write_regs_extra(struct omap_overlay *ovl)
 
 	dispc_ovl_enable(ovl->id, op->enabled);
 
+	mp = get_mgr_priv(ovl->manager);
+
 	op->extra_info_dirty = false;
-	op->shadow_extra_info_dirty = true;
+	if (mp->updating)
+		op->shadow_extra_info_dirty = true;
 }
 
 static void dss_mgr_write_regs(struct omap_overlay_manager *mgr)
@@ -400,7 +414,8 @@ static void dss_mgr_write_regs(struct omap_overlay_manager *mgr)
 		dispc_mgr_setup(mgr->id, &mp->info);
 
 		mp->dirty = false;
-		mp->shadow_dirty = true;
+		if (mp->updating)
+			mp->shadow_dirty = true;
 	}
 }
 
@@ -435,21 +450,18 @@ static void dss_write_regs(void)
 void dss_start_update(struct omap_overlay_manager *mgr)
 {
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
-	struct ovl_priv_data *op;
-	struct omap_overlay *ovl;
 	unsigned long flags;
 
 	spin_lock_irqsave(&data_lock, flags);
 
+	WARN_ON(mp->updating);
+
 	dss_mgr_write_regs(mgr);
 
-	list_for_each_entry(ovl, &mgr->overlays, list) {
-		op = get_ovl_priv(ovl);
-		op->shadow_dirty = false;
-		op->shadow_extra_info_dirty = false;
-	}
+	mp->updating = true;
 
-	mp->shadow_dirty = false;
+	if (!dss_data.irq_enabled && need_isr())
+		dss_register_vsync_isr();
 
 	dispc_mgr_enable(mgr->id, true);
 
@@ -468,6 +480,9 @@ static void dss_register_vsync_isr(void)
 	for (i = 0; i < num_mgrs; ++i)
 		mask |= dispc_mgr_get_vsync_irq(i);
 
+	for (i = 0; i < num_mgrs; ++i)
+		mask |= dispc_mgr_get_framedone_irq(i);
+
 	r = omap_dispc_register_isr(dss_apply_irq_handler, NULL, mask);
 	WARN_ON(r);
 
@@ -484,6 +499,9 @@ static void dss_unregister_vsync_isr(void)
 	for (i = 0; i < num_mgrs; ++i)
 		mask |= dispc_mgr_get_vsync_irq(i);
 
+	for (i = 0; i < num_mgrs; ++i)
+		mask |= dispc_mgr_get_framedone_irq(i);
+
 	r = omap_dispc_unregister_isr(dss_apply_irq_handler, NULL, mask);
 	WARN_ON(r);
 
@@ -507,6 +525,7 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 		mp = get_mgr_priv(mgr);
 
 		mp->busy = dispc_mgr_go_busy(i);
+		mp->updating = dispc_mgr_is_enabled(i);
 	}
 
 	for (i = 0; i < num_ovls; ++i) {
@@ -663,6 +682,9 @@ void dss_mgr_enable(struct omap_overlay_manager *mgr)
 
 	dss_write_regs();
 
+	if (!mgr_manual_update(mgr))
+		mp->updating = true;
+
 	spin_unlock_irqrestore(&data_lock, flags);
 
 	if (!mgr_manual_update(mgr))
@@ -683,6 +705,7 @@ void dss_mgr_disable(struct omap_overlay_manager *mgr)
 
 	spin_lock_irqsave(&data_lock, flags);
 
+	mp->updating = false;
 	mp->enabled = false;
 
 	spin_unlock_irqrestore(&data_lock, flags);
-- 
1.7.4.1

