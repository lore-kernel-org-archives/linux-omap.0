From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/65] OMAPDSS: remove L4_EXAMPLE code
Date: Tue, 22 Nov 2011 11:21:02 +0200
Message-ID: <1321953724-6350-4-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:55885 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755394Ab1KVJWi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:22:38 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Some old example code has been left lying around. Remove the example
code.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h     |    3 ---
 drivers/video/omap2/dss/overlay.c |   36 ------------------------------------
 2 files changed, 0 insertions(+), 39 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 3310f10..7d2b6dd 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -192,9 +192,6 @@ void dss_init_overlays(struct platform_device *pdev);
 void dss_uninit_overlays(struct platform_device *pdev);
 int dss_check_overlay(struct omap_overlay *ovl, struct omap_dss_device *dssdev);
 void dss_overlay_setup_dispc_manager(struct omap_overlay_manager *mgr);
-#ifdef L4_EXAMPLE
-void dss_overlay_setup_l4_manager(struct omap_overlay_manager *mgr);
-#endif
 void dss_recheck_connections(struct omap_dss_device *dssdev, bool force);
 
 /* DSS */
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index ab8e40e..d15b826 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -641,15 +641,6 @@ void dss_overlay_setup_dispc_manager(struct omap_overlay_manager *mgr)
 	mgr->overlays = dispc_overlays;
 }
 
-#ifdef L4_EXAMPLE
-static struct omap_overlay *l4_overlays[1];
-void dss_overlay_setup_l4_manager(struct omap_overlay_manager *mgr)
-{
-	mgr->num_overlays = 1;
-	mgr->overlays = l4_overlays;
-}
-#endif
-
 void dss_init_overlays(struct platform_device *pdev)
 {
 	int i, r;
@@ -716,33 +707,6 @@ void dss_init_overlays(struct platform_device *pdev)
 
 		dispc_overlays[i] = ovl;
 	}
-
-#ifdef L4_EXAMPLE
-	{
-		struct omap_overlay *ovl;
-		ovl = kzalloc(sizeof(*ovl), GFP_KERNEL);
-
-		BUG_ON(ovl == NULL);
-
-		ovl->name = "l4";
-		ovl->supported_modes = OMAP_DSS_COLOR_RGB24U;
-
-		ovl->set_manager = &omap_dss_set_manager;
-		ovl->unset_manager = &omap_dss_unset_manager;
-		ovl->set_overlay_info = &dss_ovl_set_overlay_info;
-		ovl->get_overlay_info = &dss_ovl_get_overlay_info;
-
-		omap_dss_add_overlay(ovl);
-
-		r = kobject_init_and_add(&ovl->kobj, &overlay_ktype,
-				&pdev->dev.kobj, "overlayl4");
-
-		if (r)
-			DSSERR("failed to create sysfs file\n");
-
-		l4_overlays[0] = ovl;
-	}
-#endif
 }
 
 /* connect overlays to the new device, if not already connected. if force
-- 
1.7.4.1

