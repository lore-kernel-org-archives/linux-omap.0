From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 55/65] OMAPDSS: APPLY: remove device_changed field
Date: Tue, 22 Nov 2011 11:21:54 +0200
Message-ID: <1321953724-6350-56-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:50845 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758205Ab1KVJYi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:38 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

omap_overlay_manager contains device_changed field, which no longer has
any use. So remove the field and the few places where it is touched.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |    7 -------
 include/video/omapdss.h         |    2 --
 2 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index fdd53b6..916acd7 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -608,11 +608,6 @@ static void omap_dss_mgr_apply_mgr(struct omap_overlay_manager *mgr)
 
 	mp = get_mgr_priv(mgr);
 
-	if (mgr->device_changed) {
-		mgr->device_changed = false;
-		mp->user_info_dirty  = true;
-	}
-
 	if (!mp->user_info_dirty)
 		return;
 
@@ -807,7 +802,6 @@ int dss_mgr_set_device(struct omap_overlay_manager *mgr,
 
 	dssdev->manager = mgr;
 	mgr->device = dssdev;
-	mgr->device_changed = true;
 
 	mutex_unlock(&apply_lock);
 
@@ -840,7 +834,6 @@ int dss_mgr_unset_device(struct omap_overlay_manager *mgr)
 
 	mgr->device->manager = NULL;
 	mgr->device = NULL;
-	mgr->device_changed = true;
 
 	mutex_unlock(&apply_lock);
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index e629b0d..98fc026 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -426,8 +426,6 @@ struct omap_overlay_manager {
 	/* dynamic fields */
 	struct omap_dss_device *device;
 
-	bool device_changed;
-
 	int (*set_device)(struct omap_overlay_manager *mgr,
 		struct omap_dss_device *dssdev);
 	int (*unset_device)(struct omap_overlay_manager *mgr);
-- 
1.7.4.1

