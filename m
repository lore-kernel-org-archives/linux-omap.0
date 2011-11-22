From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 37/65] OMAPDSS: APPLY: move ovl funcs to apply.c
Date: Tue, 22 Nov 2011 11:21:36 +0200
Message-ID: <1321953724-6350-38-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:34622 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757932Ab1KVJYC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:02 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

apply.c will handle the management of dispc in the future patches. This
patch moves overlay related functions to apply.c so that they will have
access to the private data and functions of apply.c.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c   |   84 ++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h     |    8 +++
 drivers/video/omap2/dss/overlay.c |   96 ++----------------------------------
 3 files changed, 98 insertions(+), 90 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 46d6a5c..b120f95 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -662,3 +662,87 @@ void dss_mgr_disable(struct omap_overlay_manager *mgr)
 	mgr->enabled = false;
 }
 
+int dss_ovl_set_info(struct omap_overlay *ovl,
+		struct omap_overlay_info *info)
+{
+	int r;
+	struct omap_overlay_info old_info;
+
+	old_info = ovl->info;
+	ovl->info = *info;
+
+	if (ovl->manager) {
+		r = dss_check_overlay(ovl, ovl->manager->device);
+		if (r) {
+			ovl->info = old_info;
+			return r;
+		}
+	}
+
+	ovl->info_dirty = true;
+
+	return 0;
+}
+
+void dss_ovl_get_info(struct omap_overlay *ovl,
+		struct omap_overlay_info *info)
+{
+	*info = ovl->info;
+}
+
+int dss_ovl_set_manager(struct omap_overlay *ovl,
+		struct omap_overlay_manager *mgr)
+{
+	if (!mgr)
+		return -EINVAL;
+
+	if (ovl->manager) {
+		DSSERR("overlay '%s' already has a manager '%s'\n",
+				ovl->name, ovl->manager->name);
+		return -EINVAL;
+	}
+
+	if (ovl->info.enabled) {
+		DSSERR("overlay has to be disabled to change the manager\n");
+		return -EINVAL;
+	}
+
+	ovl->manager = mgr;
+	list_add_tail(&ovl->list, &mgr->overlays);
+	ovl->manager_changed = true;
+
+	/* XXX: When there is an overlay on a DSI manual update display, and
+	 * the overlay is first disabled, then moved to tv, and enabled, we
+	 * seem to get SYNC_LOST_DIGIT error.
+	 *
+	 * Waiting doesn't seem to help, but updating the manual update display
+	 * after disabling the overlay seems to fix this. This hints that the
+	 * overlay is perhaps somehow tied to the LCD output until the output
+	 * is updated.
+	 *
+	 * Userspace workaround for this is to update the LCD after disabling
+	 * the overlay, but before moving the overlay to TV.
+	 */
+
+	return 0;
+}
+
+int dss_ovl_unset_manager(struct omap_overlay *ovl)
+{
+	if (!ovl->manager) {
+		DSSERR("failed to detach overlay: manager not set\n");
+		return -EINVAL;
+	}
+
+	if (ovl->info.enabled) {
+		DSSERR("overlay has to be disabled to unset the manager\n");
+		return -EINVAL;
+	}
+
+	ovl->manager = NULL;
+	list_del(&ovl->list);
+	ovl->manager_changed = true;
+
+	return 0;
+}
+
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 5a6f1db..ee155a1 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -172,6 +172,14 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr);
 void dss_mgr_enable(struct omap_overlay_manager *mgr);
 void dss_mgr_disable(struct omap_overlay_manager *mgr);
 
+int dss_ovl_set_info(struct omap_overlay *ovl,
+		struct omap_overlay_info *info);
+void dss_ovl_get_info(struct omap_overlay *ovl,
+		struct omap_overlay_info *info);
+int dss_ovl_set_manager(struct omap_overlay *ovl,
+		struct omap_overlay_manager *mgr);
+int dss_ovl_unset_manager(struct omap_overlay *ovl);
+
 /* display */
 int dss_suspend_all_devices(void);
 int dss_resume_all_devices(void);
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 3c94065..00c01a3 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -520,90 +520,6 @@ int dss_check_overlay(struct omap_overlay *ovl, struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static int dss_ovl_set_overlay_info(struct omap_overlay *ovl,
-		struct omap_overlay_info *info)
-{
-	int r;
-	struct omap_overlay_info old_info;
-
-	old_info = ovl->info;
-	ovl->info = *info;
-
-	if (ovl->manager) {
-		r = dss_check_overlay(ovl, ovl->manager->device);
-		if (r) {
-			ovl->info = old_info;
-			return r;
-		}
-	}
-
-	ovl->info_dirty = true;
-
-	return 0;
-}
-
-static void dss_ovl_get_overlay_info(struct omap_overlay *ovl,
-		struct omap_overlay_info *info)
-{
-	*info = ovl->info;
-}
-
-static int omap_dss_set_manager(struct omap_overlay *ovl,
-		struct omap_overlay_manager *mgr)
-{
-	if (!mgr)
-		return -EINVAL;
-
-	if (ovl->manager) {
-		DSSERR("overlay '%s' already has a manager '%s'\n",
-				ovl->name, ovl->manager->name);
-		return -EINVAL;
-	}
-
-	if (ovl->info.enabled) {
-		DSSERR("overlay has to be disabled to change the manager\n");
-		return -EINVAL;
-	}
-
-	ovl->manager = mgr;
-	list_add_tail(&ovl->list, &mgr->overlays);
-	ovl->manager_changed = true;
-
-	/* XXX: When there is an overlay on a DSI manual update display, and
-	 * the overlay is first disabled, then moved to tv, and enabled, we
-	 * seem to get SYNC_LOST_DIGIT error.
-	 *
-	 * Waiting doesn't seem to help, but updating the manual update display
-	 * after disabling the overlay seems to fix this. This hints that the
-	 * overlay is perhaps somehow tied to the LCD output until the output
-	 * is updated.
-	 *
-	 * Userspace workaround for this is to update the LCD after disabling
-	 * the overlay, but before moving the overlay to TV.
-	 */
-
-	return 0;
-}
-
-static int omap_dss_unset_manager(struct omap_overlay *ovl)
-{
-	if (!ovl->manager) {
-		DSSERR("failed to detach overlay: manager not set\n");
-		return -EINVAL;
-	}
-
-	if (ovl->info.enabled) {
-		DSSERR("overlay has to be disabled to unset the manager\n");
-		return -EINVAL;
-	}
-
-	ovl->manager = NULL;
-	list_del(&ovl->list);
-	ovl->manager_changed = true;
-
-	return 0;
-}
-
 int omap_dss_get_num_overlays(void)
 {
 	return num_overlays;
@@ -663,10 +579,10 @@ void dss_init_overlays(struct platform_device *pdev)
 			break;
 		}
 
-		ovl->set_manager = &omap_dss_set_manager;
-		ovl->unset_manager = &omap_dss_unset_manager;
-		ovl->set_overlay_info = &dss_ovl_set_overlay_info;
-		ovl->get_overlay_info = &dss_ovl_get_overlay_info;
+		ovl->set_manager = &dss_ovl_set_manager;
+		ovl->unset_manager = &dss_ovl_unset_manager;
+		ovl->set_overlay_info = &dss_ovl_set_info;
+		ovl->get_overlay_info = &dss_ovl_get_info;
 		ovl->wait_for_go = &dss_mgr_wait_for_go_ovl;
 
 		ovl->caps = dss_feat_get_overlay_caps(ovl->id);
@@ -731,8 +647,8 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
 			ovl = omap_dss_get_overlay(i);
 			if (!ovl->manager || force) {
 				if (ovl->manager)
-					omap_dss_unset_manager(ovl);
-				omap_dss_set_manager(ovl, mgr);
+					ovl->unset_manager(ovl);
+				ovl->set_manager(ovl, mgr);
 			}
 		}
 
-- 
1.7.4.1

