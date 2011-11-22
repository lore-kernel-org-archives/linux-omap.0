From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 54/65] OMAPDSS: APPLY: rename dirty & shadow_dirty
Date: Tue, 22 Nov 2011 11:21:53 +0200
Message-ID: <1321953724-6350-55-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:40667 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758192Ab1KVJYf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:35 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Rename ovl_priv_data's and mgr_priv_data's dirty and shadow_dirty fields
to info_dirty and shadow_info_dirty to better reflect what they mean.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   62 +++++++++++++++++----------------------
 1 files changed, 27 insertions(+), 35 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 0e93ae5..fdd53b6 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -31,8 +31,10 @@
  * We have 4 levels of cache for the dispc settings. First two are in SW and
  * the latter two in HW.
  *
+ *       set_info()
+ *          v
  * +--------------------+
- * |overlay/manager_info|
+ * |     user_info      |
  * +--------------------+
  *          v
  *        apply()
@@ -59,16 +61,11 @@ struct ovl_priv_data {
 	bool user_info_dirty;
 	struct omap_overlay_info user_info;
 
-	/* If true, cache changed, but not written to shadow registers. Set
-	 * in apply(), cleared when registers written. */
-	bool dirty;
-	/* If true, shadow registers contain changed values not yet in real
-	 * registers. Set when writing to shadow registers, cleared at
-	 * VSYNC/EVSYNC */
-	bool shadow_dirty;
-
+	bool info_dirty;
 	struct omap_overlay_info info;
 
+	bool shadow_info_dirty;
+
 	bool extra_info_dirty;
 	bool shadow_extra_info_dirty;
 
@@ -82,16 +79,11 @@ struct mgr_priv_data {
 	bool user_info_dirty;
 	struct omap_overlay_manager_info user_info;
 
-	/* If true, cache changed, but not written to shadow registers. Set
-	 * in apply(), cleared when registers written. */
-	bool dirty;
-	/* If true, shadow registers contain changed values not yet in real
-	 * registers. Set when writing to shadow registers, cleared at
-	 * VSYNC/EVSYNC */
-	bool shadow_dirty;
-
+	bool info_dirty;
 	struct omap_overlay_manager_info info;
 
+	bool shadow_info_dirty;
+
 	/* If true, GO bit is up and shadow registers cannot be written.
 	 * Never true for manual update displays */
 	bool busy;
@@ -199,7 +191,7 @@ static bool need_isr(void)
 				return true;
 
 			/* to write new values to registers */
-			if (mp->dirty)
+			if (mp->info_dirty)
 				return true;
 
 			list_for_each_entry(ovl, &mgr->overlays, list) {
@@ -211,7 +203,7 @@ static bool need_isr(void)
 					continue;
 
 				/* to write new values to registers */
-				if (op->dirty || op->extra_info_dirty)
+				if (op->info_dirty || op->extra_info_dirty)
 					return true;
 			}
 		}
@@ -228,12 +220,12 @@ static bool need_go(struct omap_overlay_manager *mgr)
 
 	mp = get_mgr_priv(mgr);
 
-	if (mp->shadow_dirty)
+	if (mp->shadow_info_dirty)
 		return true;
 
 	list_for_each_entry(ovl, &mgr->overlays, list) {
 		op = get_ovl_priv(ovl);
-		if (op->shadow_dirty || op->shadow_extra_info_dirty)
+		if (op->shadow_info_dirty || op->shadow_extra_info_dirty)
 			return true;
 	}
 
@@ -264,8 +256,8 @@ int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 		bool shadow_dirty, dirty;
 
 		spin_lock_irqsave(&data_lock, flags);
-		dirty = mp->dirty;
-		shadow_dirty = mp->shadow_dirty;
+		dirty = mp->info_dirty;
+		shadow_dirty = mp->shadow_info_dirty;
 		spin_unlock_irqrestore(&data_lock, flags);
 
 		if (!dirty && !shadow_dirty) {
@@ -327,8 +319,8 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 		bool shadow_dirty, dirty;
 
 		spin_lock_irqsave(&data_lock, flags);
-		dirty = op->dirty;
-		shadow_dirty = op->shadow_dirty;
+		dirty = op->info_dirty;
+		shadow_dirty = op->shadow_info_dirty;
 		spin_unlock_irqrestore(&data_lock, flags);
 
 		if (!dirty && !shadow_dirty) {
@@ -371,7 +363,7 @@ static void dss_ovl_write_regs(struct omap_overlay *ovl)
 
 	DSSDBGF("%d", ovl->id);
 
-	if (!op->enabled || !op->dirty)
+	if (!op->enabled || !op->info_dirty)
 		return;
 
 	oi = &op->info;
@@ -396,9 +388,9 @@ static void dss_ovl_write_regs(struct omap_overlay *ovl)
 
 	mp = get_mgr_priv(ovl->manager);
 
-	op->dirty = false;
+	op->info_dirty = false;
 	if (mp->updating)
-		op->shadow_dirty = true;
+		op->shadow_info_dirty = true;
 }
 
 static void dss_ovl_write_regs_extra(struct omap_overlay *ovl)
@@ -443,12 +435,12 @@ static void dss_mgr_write_regs(struct omap_overlay_manager *mgr)
 		dss_ovl_write_regs_extra(ovl);
 	}
 
-	if (mp->dirty) {
+	if (mp->info_dirty) {
 		dispc_mgr_setup(mgr->id, &mp->info);
 
-		mp->dirty = false;
+		mp->info_dirty = false;
 		if (mp->updating)
-			mp->shadow_dirty = true;
+			mp->shadow_info_dirty = true;
 	}
 }
 
@@ -548,11 +540,11 @@ static void mgr_clear_shadow_dirty(struct omap_overlay_manager *mgr)
 	struct ovl_priv_data *op;
 
 	mp = get_mgr_priv(mgr);
-	mp->shadow_dirty = false;
+	mp->shadow_info_dirty = false;
 
 	list_for_each_entry(ovl, &mgr->overlays, list) {
 		op = get_ovl_priv(ovl);
-		op->shadow_dirty = false;
+		op->shadow_info_dirty = false;
 		op->shadow_extra_info_dirty = false;
 	}
 }
@@ -606,7 +598,7 @@ static void omap_dss_mgr_apply_ovl(struct omap_overlay *ovl)
 		return;
 
 	op->user_info_dirty = false;
-	op->dirty = true;
+	op->info_dirty = true;
 	op->info = op->user_info;
 }
 
@@ -625,7 +617,7 @@ static void omap_dss_mgr_apply_mgr(struct omap_overlay_manager *mgr)
 		return;
 
 	mp->user_info_dirty = false;
-	mp->dirty = true;
+	mp->info_dirty = true;
 	mp->info = mp->user_info;
 }
 
-- 
1.7.4.1

