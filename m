From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 40/65] OMAPDSS: APPLY: add mutex
Date: Tue, 22 Nov 2011 11:21:39 +0200
Message-ID: <1321953724-6350-41-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:59519 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757980Ab1KVJYH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:07 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The functions in apply.c, called mostly via function pointers in overlay
and overlay_manager structs, will be divided into two groups. The other
group will not sleep and can be called from interrupts, and the other
group may sleep.

The idea is that the non-sleeping functions may only change certain
settings in overlays and managers, and those settings may only affect
the particular overlay/manager. For example, set the base address of the
overlay.

The blocking functions, however, will handle more complex configuration
changes. For example, when an overlay is enabled and fifo-merge feature
is used, we need to do the enable in multiple steps, waiting in between,
and the change affects multiple overlays and managers.

This patch adds the mutex which is used in the blocking functions to
have exclusive access to overlays and overlay managers.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   71 ++++++++++++++++++++++++++++++++++-----
 1 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index b935264..fb6d3c2 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -97,6 +97,8 @@ static struct {
 
 /* protects dss_data */
 static spinlock_t data_lock;
+/* lock for blocking functions */
+static DEFINE_MUTEX(apply_lock);
 
 static struct ovl_priv_data *get_ovl_priv(struct omap_overlay *ovl)
 {
@@ -639,14 +641,22 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 void dss_mgr_enable(struct omap_overlay_manager *mgr)
 {
+	mutex_lock(&apply_lock);
+
 	dispc_mgr_enable(mgr->id, true);
 	mgr->enabled = true;
+
+	mutex_unlock(&apply_lock);
 }
 
 void dss_mgr_disable(struct omap_overlay_manager *mgr)
 {
+	mutex_lock(&apply_lock);
+
 	dispc_mgr_enable(mgr->id, false);
 	mgr->enabled = false;
+
+	mutex_unlock(&apply_lock);
 }
 
 int dss_mgr_set_info(struct omap_overlay_manager *mgr,
@@ -669,44 +679,65 @@ int dss_mgr_set_device(struct omap_overlay_manager *mgr,
 {
 	int r;
 
+	mutex_lock(&apply_lock);
+
 	if (dssdev->manager) {
 		DSSERR("display '%s' already has a manager '%s'\n",
 			       dssdev->name, dssdev->manager->name);
-		return -EINVAL;
+		r = -EINVAL;
+		goto err;
 	}
 
 	if ((mgr->supported_displays & dssdev->type) == 0) {
 		DSSERR("display '%s' does not support manager '%s'\n",
 			       dssdev->name, mgr->name);
-		return -EINVAL;
+		r = -EINVAL;
+		goto err;
 	}
 
 	dssdev->manager = mgr;
 	mgr->device = dssdev;
 	mgr->device_changed = true;
 
+	mutex_unlock(&apply_lock);
+
 	return 0;
+err:
+	mutex_unlock(&apply_lock);
+	return r;
 }
 
 int dss_mgr_unset_device(struct omap_overlay_manager *mgr)
 {
+	int r;
+
+	mutex_lock(&apply_lock);
+
 	if (!mgr->device) {
 		DSSERR("failed to unset display, display not set.\n");
-		return -EINVAL;
+		r = -EINVAL;
+		goto err;
 	}
 
 	/*
 	 * Don't allow currently enabled displays to have the overlay manager
 	 * pulled out from underneath them
 	 */
-	if (mgr->device->state != OMAP_DSS_DISPLAY_DISABLED)
-		return -EINVAL;
+	if (mgr->device->state != OMAP_DSS_DISPLAY_DISABLED) {
+		r = -EINVAL;
+		goto err;
+	}
 
 	mgr->device->manager = NULL;
 	mgr->device = NULL;
 	mgr->device_changed = true;
 
+	mutex_unlock(&apply_lock);
+
 	return 0;
+err:
+	mutex_unlock(&apply_lock);
+	return r;
 }
 
 
@@ -729,18 +760,24 @@ void dss_ovl_get_info(struct omap_overlay *ovl,
 int dss_ovl_set_manager(struct omap_overlay *ovl,
 		struct omap_overlay_manager *mgr)
 {
+	int r;
+
 	if (!mgr)
 		return -EINVAL;
 
+	mutex_lock(&apply_lock);
+
 	if (ovl->manager) {
 		DSSERR("overlay '%s' already has a manager '%s'\n",
 				ovl->name, ovl->manager->name);
-		return -EINVAL;
+		r = -EINVAL;
+		goto err;
 	}
 
 	if (ovl->info.enabled) {
 		DSSERR("overlay has to be disabled to change the manager\n");
-		return -EINVAL;
+		r = -EINVAL;
+		goto err;
 	}
 
 	ovl->manager = mgr;
@@ -760,25 +797,41 @@ int dss_ovl_set_manager(struct omap_overlay *ovl,
 	 * the overlay, but before moving the overlay to TV.
 	 */
 
+	mutex_unlock(&apply_lock);
+
 	return 0;
+err:
+	mutex_unlock(&apply_lock);
+	return r;
 }
 
 int dss_ovl_unset_manager(struct omap_overlay *ovl)
 {
+	int r;
+
+	mutex_lock(&apply_lock);
+
 	if (!ovl->manager) {
 		DSSERR("failed to detach overlay: manager not set\n");
-		return -EINVAL;
+		r = -EINVAL;
+		goto err;
 	}
 
 	if (ovl->info.enabled) {
 		DSSERR("overlay has to be disabled to unset the manager\n");
-		return -EINVAL;
+		r = -EINVAL;
+		goto err;
 	}
 
 	ovl->manager = NULL;
 	list_del(&ovl->list);
 	ovl->manager_changed = true;
 
+	mutex_unlock(&apply_lock);
+
 	return 0;
+err:
+	mutex_unlock(&apply_lock);
+	return r;
 }
 
-- 
1.7.4.1

