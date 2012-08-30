From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 07/23] OMAPFB: remove manager->device references
Date: Thu, 30 Aug 2012 17:10:29 +0530
Message-ID: <1346326845-16583-8-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
 <1346326845-16583-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41012 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018Ab2H3Lms (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 07:42:48 -0400
In-Reply-To: <1346326845-16583-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

With the introduction of output entities, managers will now connect to outputs.
Use the helper op for managers named get_device. This will abstract away the
information on how to get the device from an overlay manager.

Using the helper function will reduce the number of pointer dereferences a user
of OMAPDSS needs to do and reduce risk of a NULL dereference.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    7 +++++--
 drivers/video/omap2/omapfb/omapfb.h      |    5 +++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index fc671d3..c6992be 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2353,6 +2353,7 @@ static int __init omapfb_probe(struct platform_device *pdev)
 	struct omap_overlay *ovl;
 	struct omap_dss_device *def_display;
 	struct omap_dss_device *dssdev;
+	struct omap_dss_device *mgr_device;
 
 	DBG("omapfb_probe\n");
 
@@ -2426,8 +2427,10 @@ static int __init omapfb_probe(struct platform_device *pdev)
 	/* gfx overlay should be the default one. find a display
 	 * connected to that, and use it as default display */
 	ovl = omap_dss_get_overlay(0);
-	if (ovl->manager && ovl->manager->device) {
-		def_display = ovl->manager->device;
+	mgr_device = ovl->manager ?
+		ovl->manager->get_device(ovl->manager) : NULL;
+	if (mgr_device) {
+		def_display = mgr_device;
 	} else {
 		dev_warn(&pdev->dev, "cannot find default display\n");
 		def_display = NULL;
diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap2/omapfb/omapfb.h
index 30361a0..2782b1f 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -148,8 +148,9 @@ static inline struct omap_dss_device *fb2display(struct fb_info *fbi)
 
 	/* XXX: returns the display connected to first attached overlay */
 	for (i = 0; i < ofbi->num_overlays; i++) {
-		if (ofbi->overlays[i]->manager)
-			return ofbi->overlays[i]->manager->device;
+		struct omap_overlay_manager *mgr = ofbi->overlays[i]->manager;
+		if (mgr)
+			return mgr->get_device(mgr);
 	}
 
 	return NULL;
-- 
1.7.9.5

