From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/65] OMAPDSS: handle ilace/replication when configuring overlay
Date: Tue, 22 Nov 2011 11:21:10 +0200
Message-ID: <1321953724-6350-12-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:48436 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757184Ab1KVJW4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:22:56 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Move the configuration of interlace and replication from
omap_dss_mgr_apply() to configure_overlay(). This removes the need to
store the values into the cache data.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/manager.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index bc28bfa..626f6b7 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -510,8 +510,6 @@ struct overlay_cache_data {
 	struct omap_overlay_info info;
 
 	enum omap_channel channel;
-	bool replication;
-	bool ilace;
 
 	u32 fifo_low;
 	u32 fifo_high;
@@ -757,8 +755,10 @@ static int overlay_enabled(struct omap_overlay *ovl)
 
 static int configure_overlay(enum omap_plane plane)
 {
+	struct omap_overlay *ovl;
 	struct overlay_cache_data *c;
 	struct omap_overlay_info *oi;
+	bool ilace, replication;
 	int r;
 
 	DSSDBGF("%d", plane);
@@ -771,8 +771,14 @@ static int configure_overlay(enum omap_plane plane)
 		return 0;
 	}
 
-	r = dispc_ovl_setup(plane, oi, c->ilace, c->channel,
-		c->replication, c->fifo_low, c->fifo_high);
+	ovl = omap_dss_get_overlay(plane);
+
+	replication = dss_use_replication(ovl->manager->device, oi->color_mode);
+
+	ilace = ovl->manager->device->type == OMAP_DISPLAY_TYPE_VENC;
+
+	r = dispc_ovl_setup(plane, oi, ilace, c->channel,
+		replication, c->fifo_low, c->fifo_high);
 	if (r) {
 		/* this shouldn't happen */
 		DSSERR("dispc_ovl_setup failed for ovl %d\n", plane);
@@ -1038,11 +1044,6 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 		oc->dirty = true;
 		oc->info = ovl->info;
 
-		oc->replication =
-			dss_use_replication(dssdev, ovl->info.color_mode);
-
-		oc->ilace = dssdev->type == OMAP_DISPLAY_TYPE_VENC;
-
 		oc->channel = ovl->manager->id;
 
 		oc->enabled = true;
-- 
1.7.4.1

