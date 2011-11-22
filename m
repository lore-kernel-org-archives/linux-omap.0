From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 26/65] OMAPDSS: store overlays in an array
Date: Tue, 22 Nov 2011 11:21:25 +0200
Message-ID: <1321953724-6350-27-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:53505 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757732Ab1KVJXe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:23:34 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Overlays are stored in a linked list. There's no need for this list, as
an array would do just as fine.

This patch changes the code to use an array for overlays.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/overlay.c |   49 +++++++++++++------------------------
 1 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 0ab14fa..ccd6127 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -38,7 +38,7 @@
 #include "dss_features.h"
 
 static int num_overlays;
-static struct list_head overlay_list;
+static struct omap_overlay *overlays;
 
 static ssize_t overlay_name_show(struct omap_overlay *ovl, char *buf)
 {
@@ -610,24 +610,13 @@ EXPORT_SYMBOL(omap_dss_get_num_overlays);
 
 struct omap_overlay *omap_dss_get_overlay(int num)
 {
-	int i = 0;
-	struct omap_overlay *ovl;
+	if (num >= num_overlays)
+		return NULL;
 
-	list_for_each_entry(ovl, &overlay_list, list) {
-		if (i++ == num)
-			return ovl;
-	}
-
-	return NULL;
+	return &overlays[num];
 }
 EXPORT_SYMBOL(omap_dss_get_overlay);
 
-static void omap_dss_add_overlay(struct omap_overlay *overlay)
-{
-	++num_overlays;
-	list_add_tail(&overlay->list, &overlay_list);
-}
-
 static struct omap_overlay *dispc_overlays[MAX_DSS_OVERLAYS];
 
 void dss_overlay_setup_dispc_manager(struct omap_overlay_manager *mgr)
@@ -640,15 +629,15 @@ void dss_init_overlays(struct platform_device *pdev)
 {
 	int i, r;
 
-	INIT_LIST_HEAD(&overlay_list);
+	num_overlays = dss_feat_get_num_ovls();
 
-	num_overlays = 0;
+	overlays = kzalloc(sizeof(struct omap_overlay) * num_overlays,
+			GFP_KERNEL);
 
-	for (i = 0; i < dss_feat_get_num_ovls(); ++i) {
-		struct omap_overlay *ovl;
-		ovl = kzalloc(sizeof(*ovl), GFP_KERNEL);
+	BUG_ON(overlays == NULL);
 
-		BUG_ON(ovl == NULL);
+	for (i = 0; i < num_overlays; ++i) {
+		struct omap_overlay *ovl = &overlays[i];
 
 		switch (i) {
 		case 0:
@@ -690,15 +679,11 @@ void dss_init_overlays(struct platform_device *pdev)
 		ovl->supported_modes =
 			dss_feat_get_supported_color_modes(ovl->id);
 
-		omap_dss_add_overlay(ovl);
-
 		r = kobject_init_and_add(&ovl->kobj, &overlay_ktype,
 				&pdev->dev.kobj, "overlay%d", i);
 
-		if (r) {
+		if (r)
 			DSSERR("failed to create sysfs file\n");
-			continue;
-		}
 
 		dispc_overlays[i] = ovl;
 	}
@@ -765,17 +750,17 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
 
 void dss_uninit_overlays(struct platform_device *pdev)
 {
-	struct omap_overlay *ovl;
+	int i;
+
+	for (i = 0; i < num_overlays; ++i) {
+		struct omap_overlay *ovl = &overlays[i];
 
-	while (!list_empty(&overlay_list)) {
-		ovl = list_first_entry(&overlay_list,
-				struct omap_overlay, list);
-		list_del(&ovl->list);
 		kobject_del(&ovl->kobj);
 		kobject_put(&ovl->kobj);
-		kfree(ovl);
 	}
 
+	kfree(overlays);
+	overlays = NULL;
 	num_overlays = 0;
 }
 
-- 
1.7.4.1

