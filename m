From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 38/65] OMAPDSS: APPLY: move mgr funcs to apply.c
Date: Tue, 22 Nov 2011 11:21:37 +0200
Message-ID: <1321953724-6350-39-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:40297 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757795Ab1KVJYA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:00 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

apply.c will handle the management of dispc in the future patches. This
patch moves overlay manager related functions to apply.c so that they
will have access to the private data and functions of apply.c.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c   |   83 +++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h     |    9 ++++
 drivers/video/omap2/dss/manager.c |   91 ++-----------------------------------
 3 files changed, 97 insertions(+), 86 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index b120f95..543a10b 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -662,6 +662,89 @@ void dss_mgr_disable(struct omap_overlay_manager *mgr)
 	mgr->enabled = false;
 }
 
+int dss_mgr_set_info(struct omap_overlay_manager *mgr,
+		struct omap_overlay_manager_info *info)
+{
+	int r;
+	struct omap_overlay_manager_info old_info;
+
+	old_info = mgr->info;
+	mgr->info = *info;
+
+	r = dss_check_manager(mgr);
+	if (r) {
+		mgr->info = old_info;
+		return r;
+	}
+
+	mgr->info_dirty = true;
+
+	return 0;
+}
+
+void dss_mgr_get_info(struct omap_overlay_manager *mgr,
+		struct omap_overlay_manager_info *info)
+{
+	*info = mgr->info;
+}
+
+int dss_mgr_set_device(struct omap_overlay_manager *mgr,
+		struct omap_dss_device *dssdev)
+{
+	int r;
+	struct omap_overlay *ovl;
+
+	if (dssdev->manager) {
+		DSSERR("display '%s' already has a manager '%s'\n",
+			       dssdev->name, dssdev->manager->name);
+		return -EINVAL;
+	}
+
+	if ((mgr->supported_displays & dssdev->type) == 0) {
+		DSSERR("display '%s' does not support manager '%s'\n",
+			       dssdev->name, mgr->name);
+		return -EINVAL;
+	}
+
+	list_for_each_entry(ovl, &mgr->overlays, list) {
+		if (!ovl->info.enabled)
+			continue;
+
+		r = dss_check_overlay(ovl, dssdev);
+		if (r)
+			return r;
+	}
+
+	dssdev->manager = mgr;
+	mgr->device = dssdev;
+	mgr->device_changed = true;
+
+	return 0;
+}
+
+int dss_mgr_unset_device(struct omap_overlay_manager *mgr)
+{
+	if (!mgr->device) {
+		DSSERR("failed to unset display, display not set.\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Don't allow currently enabled displays to have the overlay manager
+	 * pulled out from underneath them
+	 */
+	if (mgr->device->state != OMAP_DSS_DISPLAY_DISABLED)
+		return -EINVAL;
+
+	mgr->device->manager = NULL;
+	mgr->device = NULL;
+	mgr->device_changed = true;
+
+	return 0;
+}
+
+
+
 int dss_ovl_set_info(struct omap_overlay *ovl,
 		struct omap_overlay_info *info)
 {
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index ee155a1..afe9713 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -169,8 +169,16 @@ int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr);
 int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl);
 void dss_start_update(struct omap_overlay_manager *mgr);
 int omap_dss_mgr_apply(struct omap_overlay_manager *mgr);
+
 void dss_mgr_enable(struct omap_overlay_manager *mgr);
 void dss_mgr_disable(struct omap_overlay_manager *mgr);
+int dss_mgr_set_info(struct omap_overlay_manager *mgr,
+		struct omap_overlay_manager_info *info);
+void dss_mgr_get_info(struct omap_overlay_manager *mgr,
+		struct omap_overlay_manager_info *info);
+int dss_mgr_set_device(struct omap_overlay_manager *mgr,
+		struct omap_dss_device *dssdev);
+int dss_mgr_unset_device(struct omap_overlay_manager *mgr);
 
 int dss_ovl_set_info(struct omap_overlay *ovl,
 		struct omap_overlay_info *info);
@@ -198,6 +206,7 @@ void default_get_overlay_fifo_thresholds(enum omap_plane plane,
 /* manager */
 int dss_init_overlay_managers(struct platform_device *pdev);
 void dss_uninit_overlay_managers(struct platform_device *pdev);
+int dss_check_manager(struct omap_overlay_manager *mgr);
 
 /* overlay */
 void dss_init_overlays(struct platform_device *pdev);
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 62bcc38..ab0b61b 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -467,61 +467,6 @@ static struct kobj_type manager_ktype = {
 	.default_attrs = manager_sysfs_attrs,
 };
 
-static int omap_dss_set_device(struct omap_overlay_manager *mgr,
-		struct omap_dss_device *dssdev)
-{
-	int r;
-	struct omap_overlay *ovl;
-
-	if (dssdev->manager) {
-		DSSERR("display '%s' already has a manager '%s'\n",
-			       dssdev->name, dssdev->manager->name);
-		return -EINVAL;
-	}
-
-	if ((mgr->supported_displays & dssdev->type) == 0) {
-		DSSERR("display '%s' does not support manager '%s'\n",
-			       dssdev->name, mgr->name);
-		return -EINVAL;
-	}
-
-	list_for_each_entry(ovl, &mgr->overlays, list) {
-		if (!ovl->info.enabled)
-			continue;
-
-		r = dss_check_overlay(ovl, dssdev);
-		if (r)
-			return r;
-	}
-
-	dssdev->manager = mgr;
-	mgr->device = dssdev;
-	mgr->device_changed = true;
-
-	return 0;
-}
-
-static int omap_dss_unset_device(struct omap_overlay_manager *mgr)
-{
-	if (!mgr->device) {
-		DSSERR("failed to unset display, display not set.\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * Don't allow currently enabled displays to have the overlay manager
-	 * pulled out from underneath them
-	 */
-	if (mgr->device->state != OMAP_DSS_DISPLAY_DISABLED)
-		return -EINVAL;
-
-	mgr->device->manager = NULL;
-	mgr->device = NULL;
-	mgr->device_changed = true;
-
-	return 0;
-}
-
 static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
 {
 	unsigned long timeout = msecs_to_jiffies(500);
@@ -540,7 +485,7 @@ static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
 	return omap_dispc_wait_for_irq_interruptible_timeout(irq, timeout);
 }
 
-static int dss_check_manager(struct omap_overlay_manager *mgr)
+int dss_check_manager(struct omap_overlay_manager *mgr)
 {
 	if (dss_has_feature(FEAT_ALPHA_FIXED_ZORDER)) {
 		/*
@@ -557,32 +502,6 @@ static int dss_check_manager(struct omap_overlay_manager *mgr)
 	return 0;
 }
 
-static int omap_dss_mgr_set_info(struct omap_overlay_manager *mgr,
-		struct omap_overlay_manager_info *info)
-{
-	int r;
-	struct omap_overlay_manager_info old_info;
-
-	old_info = mgr->info;
-	mgr->info = *info;
-
-	r = dss_check_manager(mgr);
-	if (r) {
-		mgr->info = old_info;
-		return r;
-	}
-
-	mgr->info_dirty = true;
-
-	return 0;
-}
-
-static void omap_dss_mgr_get_info(struct omap_overlay_manager *mgr,
-		struct omap_overlay_manager_info *info)
-{
-	*info = mgr->info;
-}
-
 int dss_init_overlay_managers(struct platform_device *pdev)
 {
 	int i, r;
@@ -612,11 +531,11 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 			break;
 		}
 
-		mgr->set_device = &omap_dss_set_device;
-		mgr->unset_device = &omap_dss_unset_device;
+		mgr->set_device = &dss_mgr_set_device;
+		mgr->unset_device = &dss_mgr_unset_device;
 		mgr->apply = &omap_dss_mgr_apply;
-		mgr->set_manager_info = &omap_dss_mgr_set_info;
-		mgr->get_manager_info = &omap_dss_mgr_get_info;
+		mgr->set_manager_info = &dss_mgr_set_info;
+		mgr->get_manager_info = &dss_mgr_get_info;
 		mgr->wait_for_go = &dss_mgr_wait_for_go;
 		mgr->wait_for_vsync = &dss_mgr_wait_for_vsync;
 
-- 
1.7.4.1

