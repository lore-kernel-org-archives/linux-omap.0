From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 49/65] OMAPDSS: APPLY: clean up isr_handler
Date: Tue, 22 Nov 2011 11:21:48 +0200
Message-ID: <1321953724-6350-50-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:57222 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758140Ab1KVJYX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:23 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add a helper function mgr_clear_shadow_dirty(), which clears the
shadow_dirty flags for the given manager and for the overlays on that
manager.

This lets us simplify the code in the dss_apply_irq_handler().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   52 +++++++++++++++++++++------------------
 1 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index b2c0462..601dbc7 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -508,47 +508,51 @@ static void dss_unregister_vsync_isr(void)
 	dss_data.irq_enabled = false;
 }
 
-static void dss_apply_irq_handler(void *data, u32 mask)
+static void mgr_clear_shadow_dirty(struct omap_overlay_manager *mgr)
 {
 	struct omap_overlay *ovl;
-	struct omap_overlay_manager *mgr;
 	struct mgr_priv_data *mp;
 	struct ovl_priv_data *op;
-	const int num_ovls = dss_feat_get_num_ovls();
+
+	mp = get_mgr_priv(mgr);
+	mp->shadow_dirty = false;
+
+	list_for_each_entry(ovl, &mgr->overlays, list) {
+		op = get_ovl_priv(ovl);
+		op->shadow_dirty = false;
+		op->shadow_extra_info_dirty = false;
+	}
+}
+
+static void dss_apply_irq_handler(void *data, u32 mask)
+{
 	const int num_mgrs = dss_feat_get_num_mgrs();
 	int i;
 
 	spin_lock(&data_lock);
 
+	/* clear busy, updating flags, shadow_dirty flags */
 	for (i = 0; i < num_mgrs; i++) {
+		struct omap_overlay_manager *mgr;
+		struct mgr_priv_data *mp;
+
 		mgr = omap_dss_get_overlay_manager(i);
 		mp = get_mgr_priv(mgr);
 
-		mp->busy = dispc_mgr_go_busy(i);
-		mp->updating = dispc_mgr_is_enabled(i);
-	}
-
-	for (i = 0; i < num_ovls; ++i) {
-		ovl = omap_dss_get_overlay(i);
-		op = get_ovl_priv(ovl);
-
-		if (!op->enabled)
+		if (!mp->enabled)
 			continue;
 
-		mp = get_mgr_priv(ovl->manager);
-
-		if (!mp->busy) {
-			op->shadow_dirty = false;
-			op->shadow_extra_info_dirty = false;
-		}
-	}
+		mp->updating = dispc_mgr_is_enabled(i);
 
-	for (i = 0; i < num_mgrs; ++i) {
-		mgr = omap_dss_get_overlay_manager(i);
-		mp = get_mgr_priv(mgr);
+		if (!mgr_manual_update(mgr)) {
+			mp->busy = dispc_mgr_go_busy(i);
 
-		if (!mp->busy)
-			mp->shadow_dirty = false;
+			if (!mp->busy)
+				mgr_clear_shadow_dirty(mgr);
+		} else {
+			if (!mp->updating)
+				mgr_clear_shadow_dirty(mgr);
+		}
 	}
 
 	dss_write_regs();
-- 
1.7.4.1

