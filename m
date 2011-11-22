From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 18/65] OMAPDSS: split omap_dss_mgr_apply() to smaller funcs
Date: Tue, 22 Nov 2011 11:21:17 +0200
Message-ID: <1321953724-6350-19-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:39470 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757473Ab1KVJXQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:23:16 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Split omap_dss_mgr_apply() into smaller functions for clarity.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/manager.c |  168 +++++++++++++++++++++----------------
 1 files changed, 94 insertions(+), 74 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index e8838d3..3aca2b4 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -993,107 +993,92 @@ end:
 	spin_unlock(&dss_cache.lock);
 }
 
-static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
+static int omap_dss_mgr_apply_ovl(struct omap_overlay *ovl)
 {
 	struct overlay_cache_data *oc;
-	struct manager_cache_data *mc;
-	int i;
-	struct omap_overlay *ovl;
-	unsigned long flags;
-	int r;
-
-	DSSDBG("omap_dss_mgr_apply(%s)\n", mgr->name);
+	struct omap_dss_device *dssdev;
 
-	r = dispc_runtime_get();
-	if (r)
-		return r;
+	oc = &dss_cache.overlay_cache[ovl->id];
 
-	spin_lock_irqsave(&dss_cache.lock, flags);
+	if (ovl->manager_changed) {
+		ovl->manager_changed = false;
+		ovl->info_dirty  = true;
+	}
 
-	/* Configure overlays */
-	for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
-		struct omap_dss_device *dssdev;
+	if (!overlay_enabled(ovl)) {
+		if (oc->enabled) {
+			oc->enabled = false;
+			oc->dirty = true;
+		}
+		return 0;
+	}
 
-		ovl = omap_dss_get_overlay(i);
+	if (!ovl->info_dirty)
+		return 0;
 
-		oc = &dss_cache.overlay_cache[ovl->id];
+	dssdev = ovl->manager->device;
 
-		if (ovl->manager_changed) {
-			ovl->manager_changed = false;
-			ovl->info_dirty  = true;
+	if (dss_check_overlay(ovl, dssdev)) {
+		if (oc->enabled) {
+			oc->enabled = false;
+			oc->dirty = true;
 		}
+		return -EINVAL;
+	}
 
-		if (!overlay_enabled(ovl)) {
-			if (oc->enabled) {
-				oc->enabled = false;
-				oc->dirty = true;
-			}
-			continue;
-		}
+	ovl->info_dirty = false;
+	oc->dirty = true;
+	oc->info = ovl->info;
 
-		if (!ovl->info_dirty)
-			continue;
+	oc->channel = ovl->manager->id;
 
-		dssdev = ovl->manager->device;
+	oc->enabled = true;
 
-		if (dss_check_overlay(ovl, dssdev)) {
-			if (oc->enabled) {
-				oc->enabled = false;
-				oc->dirty = true;
-			}
-			continue;
-		}
+	return 0;
+}
 
-		ovl->info_dirty = false;
-		oc->dirty = true;
-		oc->info = ovl->info;
+static void omap_dss_mgr_apply_mgr(struct omap_overlay_manager *mgr)
+{
+	struct manager_cache_data *mc;
 
-		oc->channel = ovl->manager->id;
+	mc = &dss_cache.manager_cache[mgr->id];
 
-		oc->enabled = true;
+	if (mgr->device_changed) {
+		mgr->device_changed = false;
+		mgr->info_dirty  = true;
 	}
 
-	/* Configure managers */
-	list_for_each_entry(mgr, &manager_list, list) {
-		mc = &dss_cache.manager_cache[mgr->id];
-
-		if (mgr->device_changed) {
-			mgr->device_changed = false;
-			mgr->info_dirty  = true;
-		}
+	if (!mgr->info_dirty)
+		return;
 
-		if (!mgr->info_dirty)
-			continue;
+	if (!mgr->device)
+		return;
 
-		if (!mgr->device)
-			continue;
+	mgr->info_dirty = false;
+	mc->dirty = true;
+	mc->info = mgr->info;
 
-		mgr->info_dirty = false;
-		mc->dirty = true;
-		mc->info = mgr->info;
-
-		mc->manual_update = mgr_manual_update(mgr);
-	}
-
-	/* Configure overlay fifos */
-	for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
-		struct omap_dss_device *dssdev;
-		u32 size, burst_size;
+	mc->manual_update = mgr_manual_update(mgr);
+}
 
-		ovl = omap_dss_get_overlay(i);
+static void omap_dss_mgr_apply_ovl_fifos(struct omap_overlay *ovl)
+{
+	struct overlay_cache_data *oc;
+	struct omap_dss_device *dssdev;
+	u32 size, burst_size;
 
-		oc = &dss_cache.overlay_cache[ovl->id];
+	oc = &dss_cache.overlay_cache[ovl->id];
 
-		if (!oc->enabled)
-			continue;
+	if (!oc->enabled)
+		return;
 
-		dssdev = ovl->manager->device;
+	dssdev = ovl->manager->device;
 
-		size = dispc_ovl_get_fifo_size(ovl->id);
+	size = dispc_ovl_get_fifo_size(ovl->id);
 
-		burst_size = dispc_ovl_get_burst_size(ovl->id);
+	burst_size = dispc_ovl_get_burst_size(ovl->id);
 
-		switch (dssdev->type) {
+	switch (dssdev->type) {
 		case OMAP_DISPLAY_TYPE_DPI:
 		case OMAP_DISPLAY_TYPE_DBI:
 		case OMAP_DISPLAY_TYPE_SDI:
@@ -1112,7 +1097,42 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 #endif
 		default:
 			BUG();
-		}
+	}
+}
+
+static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
+{
+	int i, r;
+	unsigned long flags;
+
+	DSSDBG("omap_dss_mgr_apply(%s)\n", mgr->name);
+
+	r = dispc_runtime_get();
+	if (r)
+		return r;
+
+	spin_lock_irqsave(&dss_cache.lock, flags);
+
+	/* Configure overlays */
+	for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+		struct omap_overlay *ovl;
+
+		ovl = omap_dss_get_overlay(i);
+
+		omap_dss_mgr_apply_ovl(ovl);
+	}
+
+	/* Configure managers */
+	list_for_each_entry(mgr, &manager_list, list)
+		omap_dss_mgr_apply_mgr(mgr);
+
+	/* Configure overlay fifos */
+	for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+		struct omap_overlay *ovl;
+
+		ovl = omap_dss_get_overlay(i);
+
+		omap_dss_mgr_apply_ovl_fifos(ovl);
 	}
 
 	r = 0;
-- 
1.7.4.1

