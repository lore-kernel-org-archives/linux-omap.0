From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 17/65] OMAPDSS: add ovl/mgr_manual_update() helpers
Date: Tue, 22 Nov 2011 11:21:16 +0200
Message-ID: <1321953724-6350-18-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:37661 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756169Ab1KVJXN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:23:13 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add helper functions ovl_manual_update() and mgr_manual_update() which
return whether the overlay or manager is used with a manual update
display.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/manager.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index fc19f01..e8838d3 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -538,7 +538,15 @@ static struct {
 	bool irq_enabled;
 } dss_cache;
 
+static bool ovl_manual_update(struct omap_overlay *ovl)
+{
+	return ovl->manager->device->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
+}
 
+static bool mgr_manual_update(struct omap_overlay_manager *mgr)
+{
+	return mgr->device->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
+}
 
 static int omap_dss_set_device(struct omap_overlay_manager *mgr,
 		struct omap_dss_device *dssdev)
@@ -627,7 +635,7 @@ static int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 	if (!dssdev || dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
-	if (dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE)
+	if (mgr_manual_update(mgr))
 		return 0;
 
 	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC
@@ -696,7 +704,7 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 	if (!dssdev || dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
-	if (dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE)
+	if (ovl_manual_update(ovl))
 		return 0;
 
 	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC
@@ -1047,8 +1055,6 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 	/* Configure managers */
 	list_for_each_entry(mgr, &manager_list, list) {
-		struct omap_dss_device *dssdev;
-
 		mc = &dss_cache.manager_cache[mgr->id];
 
 		if (mgr->device_changed) {
@@ -1062,14 +1068,11 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 		if (!mgr->device)
 			continue;
 
-		dssdev = mgr->device;
-
 		mgr->info_dirty = false;
 		mc->dirty = true;
 		mc->info = mgr->info;
 
-		mc->manual_update =
-			dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
+		mc->manual_update = mgr_manual_update(mgr);
 	}
 
 	/* Configure overlay fifos */
-- 
1.7.4.1

