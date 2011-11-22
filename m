From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 28/65] OMAPDSS: store overlays in a list for each manager
Date: Tue, 22 Nov 2011 11:21:27 +0200
Message-ID: <1321953724-6350-29-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:35630 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757740Ab1KVJXj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:23:39 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Current way of handling overlay-manager links is a bit strange: each
manager has a static array, containing pointers to all the overlays
(even those used by other managers). The overlays contain a pointer to
the manager being used.

This patch makes the system a bit saner: each manager has a linked list
of overlays, and only the overlays linked to that manager are in the
list.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c   |   33 +++++++--------------------------
 drivers/video/omap2/dss/manager.c |   10 ++++------
 drivers/video/omap2/dss/overlay.c |   12 ++----------
 include/video/omapdss.h           |    3 +--
 4 files changed, 14 insertions(+), 44 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index cfcf816..cca5732 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -398,8 +398,7 @@ void dss_start_update(struct omap_overlay_manager *mgr)
 {
 	struct manager_cache_data *mc;
 	struct overlay_cache_data *oc;
-	const int num_ovls = dss_feat_get_num_ovls();
-	int i;
+	struct omap_overlay *ovl;
 
 	mc = &dss_cache.manager_cache[mgr->id];
 
@@ -407,11 +406,8 @@ void dss_start_update(struct omap_overlay_manager *mgr)
 	configure_dispc();
 	mc->do_manual_update = false;
 
-	for (i = 0; i < num_ovls; ++i) {
-		oc = &dss_cache.overlay_cache[i];
-		if (oc->channel != mgr->id)
-			continue;
-
+	list_for_each_entry(ovl, &mgr->overlays, list) {
+		oc = &dss_cache.overlay_cache[ovl->id];
 		oc->shadow_dirty = false;
 	}
 
@@ -584,8 +580,9 @@ static void omap_dss_mgr_apply_ovl_fifos(struct omap_overlay *ovl)
 
 int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 {
-	int i, r;
+	int r;
 	unsigned long flags;
+	struct omap_overlay *ovl;
 
 	DSSDBG("omap_dss_mgr_apply(%s)\n", mgr->name);
 
@@ -596,31 +593,15 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 	spin_lock_irqsave(&dss_cache.lock, flags);
 
 	/* Configure overlays */
-	for (i = 0; i < mgr->num_overlays; ++i) {
-		struct omap_overlay *ovl;
-
-		ovl = mgr->overlays[i];
-
-		if (ovl->manager != mgr)
-			continue;
-
+	list_for_each_entry(ovl, &mgr->overlays, list)
 		omap_dss_mgr_apply_ovl(ovl);
-	}
 
 	/* Configure manager */
 	omap_dss_mgr_apply_mgr(mgr);
 
 	/* Configure overlay fifos */
-	for (i = 0; i < mgr->num_overlays; ++i) {
-		struct omap_overlay *ovl;
-
-		ovl = mgr->overlays[i];
-
-		if (ovl->manager != mgr)
-			continue;
-
+	list_for_each_entry(ovl, &mgr->overlays, list)
 		omap_dss_mgr_apply_ovl_fifos(ovl);
-	}
 
 	r = 0;
 	if (mgr->enabled && !mgr_manual_update(mgr)) {
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index a08cc6e..62bcc38 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -470,8 +470,8 @@ static struct kobj_type manager_ktype = {
 static int omap_dss_set_device(struct omap_overlay_manager *mgr,
 		struct omap_dss_device *dssdev)
 {
-	int i;
 	int r;
+	struct omap_overlay *ovl;
 
 	if (dssdev->manager) {
 		DSSERR("display '%s' already has a manager '%s'\n",
@@ -485,10 +485,8 @@ static int omap_dss_set_device(struct omap_overlay_manager *mgr,
 		return -EINVAL;
 	}
 
-	for (i = 0; i < mgr->num_overlays; i++) {
-		struct omap_overlay *ovl = mgr->overlays[i];
-
-		if (ovl->manager != mgr || !ovl->info.enabled)
+	list_for_each_entry(ovl, &mgr->overlays, list) {
+		if (!ovl->info.enabled)
 			continue;
 
 		r = dss_check_overlay(ovl, dssdev);
@@ -626,7 +624,7 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 		mgr->supported_displays =
 			dss_feat_get_supported_displays(mgr->id);
 
-		dss_overlay_setup_dispc_manager(mgr);
+		INIT_LIST_HEAD(&mgr->overlays);
 
 		r = kobject_init_and_add(&mgr->kobj, &manager_ktype,
 				&pdev->dev.kobj, "manager%d", i);
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index ccd6127..3c94065 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -566,6 +566,7 @@ static int omap_dss_set_manager(struct omap_overlay *ovl,
 	}
 
 	ovl->manager = mgr;
+	list_add_tail(&ovl->list, &mgr->overlays);
 	ovl->manager_changed = true;
 
 	/* XXX: When there is an overlay on a DSI manual update display, and
@@ -597,6 +598,7 @@ static int omap_dss_unset_manager(struct omap_overlay *ovl)
 	}
 
 	ovl->manager = NULL;
+	list_del(&ovl->list);
 	ovl->manager_changed = true;
 
 	return 0;
@@ -617,14 +619,6 @@ struct omap_overlay *omap_dss_get_overlay(int num)
 }
 EXPORT_SYMBOL(omap_dss_get_overlay);
 
-static struct omap_overlay *dispc_overlays[MAX_DSS_OVERLAYS];
-
-void dss_overlay_setup_dispc_manager(struct omap_overlay_manager *mgr)
-{
-	mgr->num_overlays = dss_feat_get_num_ovls();
-	mgr->overlays = dispc_overlays;
-}
-
 void dss_init_overlays(struct platform_device *pdev)
 {
 	int i, r;
@@ -684,8 +678,6 @@ void dss_init_overlays(struct platform_device *pdev)
 
 		if (r)
 			DSSERR("failed to create sysfs file\n");
-
-		dispc_overlays[i] = ovl;
 	}
 }
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index fd5a96c..eaeca89 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -423,8 +423,7 @@ struct omap_overlay_manager {
 	const char *name;
 	enum omap_channel id;
 	enum omap_overlay_manager_caps caps;
-	int num_overlays;
-	struct omap_overlay **overlays;
+	struct list_head overlays;
 	enum omap_display_type supported_displays;
 
 	/* dynamic fields */
-- 
1.7.4.1

