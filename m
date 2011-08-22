From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/4] OMAP: DSS2: Handle manager change in apply
Date: Mon, 22 Aug 2011 11:27:15 +0300
Message-ID: <1314001636-18036-4-git-send-email-tomi.valkeinen@ti.com>
References: <1314001636-18036-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:53641 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756219Ab1HVI1g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:27:36 -0400
In-Reply-To: <1314001636-18036-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Currently when changing the manager of an overlay, set_manager() directly
calls dispc to set the overlay's destination.

Change this to be more in line with other overlay configurations, and
this will also remove the need to have dispc clocks enabled when calling
set_manager().

A new field is added to overlay struct, "manager_changed". This is
similar to "display_changed" field in manager struct, and is used to
inform apply that the manager has changed and thus write to the
registers is needed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c   |    4 +++-
 drivers/video/omap2/dss/dss.h     |    2 --
 drivers/video/omap2/dss/manager.c |    5 +++++
 drivers/video/omap2/dss/overlay.c |    9 ++-------
 include/video/omapdss.h           |    1 +
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 9d9fbeb..003227c 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -841,7 +841,7 @@ static void _dispc_set_color_mode(enum omap_plane plane,
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), m, 4, 1);
 }
 
-void dispc_set_channel_out(enum omap_plane plane,
+static void dispc_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel)
 {
 	int shift;
@@ -1860,6 +1860,8 @@ int dispc_setup_plane(enum omap_plane plane,
 	_dispc_set_pre_mult_alpha(plane, pre_mult_alpha);
 	_dispc_setup_global_alpha(plane, global_alpha);
 
+	dispc_set_channel_out(plane, channel);
+
 	return 0;
 }
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index adeff04..ff7ac35 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -399,8 +399,6 @@ void dispc_set_plane_ba0(enum omap_plane plane, u32 paddr);
 void dispc_set_plane_ba1(enum omap_plane plane, u32 paddr);
 void dispc_set_plane_pos(enum omap_plane plane, u16 x, u16 y);
 void dispc_set_plane_size(enum omap_plane plane, u16 width, u16 height);
-void dispc_set_channel_out(enum omap_plane plane,
-		enum omap_channel channel_out);
 
 void dispc_enable_gamma_table(bool enable);
 int dispc_setup_plane(enum omap_plane plane,
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 63674b0..a6a909a 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -1338,6 +1338,11 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 		oc = &dss_cache.overlay_cache[ovl->id];
 
+		if (ovl->manager_changed) {
+			ovl->manager_changed = false;
+			ovl->info_dirty  = true;
+		}
+
 		if (!overlay_enabled(ovl)) {
 			if (oc->enabled) {
 				oc->enabled = false;
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index c84380c..ab44403 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -516,6 +516,7 @@ static int omap_dss_set_manager(struct omap_overlay *ovl,
 	}
 
 	ovl->manager = mgr;
+	ovl->manager_changed = true;
 
 	/* XXX: When there is an overlay on a DSI manual update display, and
 	 * the overlay is first disabled, then moved to tv, and enabled, we
@@ -529,15 +530,12 @@ static int omap_dss_set_manager(struct omap_overlay *ovl,
 	 * Userspace workaround for this is to update the LCD after disabling
 	 * the overlay, but before moving the overlay to TV.
 	 */
-	dispc_set_channel_out(ovl->id, mgr->id);
 
 	return 0;
 }
 
 static int omap_dss_unset_manager(struct omap_overlay *ovl)
 {
-	int r;
-
 	if (!ovl->manager) {
 		DSSERR("failed to detach overlay: manager not set\n");
 		return -EINVAL;
@@ -548,11 +546,8 @@ static int omap_dss_unset_manager(struct omap_overlay *ovl)
 		return -EINVAL;
 	}
 
-	r = ovl->wait_for_go(ovl);
-	if (r)
-		return r;
-
 	ovl->manager = NULL;
+	ovl->manager_changed = true;
 
 	return 0;
 }
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 9301805..b965f5a 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -326,6 +326,7 @@ struct omap_overlay {
 	struct omap_overlay_manager *manager;
 	struct omap_overlay_info info;
 
+	bool manager_changed;
 	/* if true, info has been changed, but not applied() yet */
 	bool info_dirty;
 
-- 
1.7.4.1

