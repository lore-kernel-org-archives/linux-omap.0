From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 32/65] OMAPDSS: APPLY: configure_* funcs take ovl/manager as args
Date: Tue, 22 Nov 2011 11:21:31 +0200
Message-ID: <1321953724-6350-33-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:51267 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757859Ab1KVJXr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:23:47 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Make configure_overlay() and configure_manager() take overlay/manager
pointer as an argument, instead of the ovl/mgr id. This will be useful
with the future patches.

Also rename the functions to be a bit more informative:
dss_ovl_write_regs, dss_mgr_write_regs, dss_write_regs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   54 +++++++++++++++++++-------------------
 1 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 84ac2d4..1c97069 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -41,7 +41,7 @@
  * |     dss_cache      |
  * +--------------------+
  *          v
- *      configure()
+ *      write_regs()
  *          v
  * +--------------------+
  * |  shadow registers  |
@@ -237,65 +237,63 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 	return r;
 }
 
-static int configure_overlay(enum omap_plane plane)
+static int dss_ovl_write_regs(struct omap_overlay *ovl)
 {
-	struct omap_overlay *ovl;
 	struct overlay_cache_data *c;
 	struct omap_overlay_info *oi;
 	bool ilace, replication;
 	int r;
 
-	DSSDBGF("%d", plane);
+	DSSDBGF("%d", ovl->id);
 
-	c = &dss_cache.overlay_cache[plane];
+	c = &dss_cache.overlay_cache[ovl->id];
 	oi = &c->info;
 
 	if (!c->enabled) {
-		dispc_ovl_enable(plane, 0);
+		dispc_ovl_enable(ovl->id, 0);
 		return 0;
 	}
 
-	ovl = omap_dss_get_overlay(plane);
-
 	replication = dss_use_replication(ovl->manager->device, oi->color_mode);
 
 	ilace = ovl->manager->device->type == OMAP_DISPLAY_TYPE_VENC;
 
-	dispc_ovl_set_channel_out(plane, c->channel);
+	dispc_ovl_set_channel_out(ovl->id, c->channel);
 
-	r = dispc_ovl_setup(plane, oi, ilace, replication);
+	r = dispc_ovl_setup(ovl->id, oi, ilace, replication);
 	if (r) {
 		/* this shouldn't happen */
-		DSSERR("dispc_ovl_setup failed for ovl %d\n", plane);
-		dispc_ovl_enable(plane, 0);
+		DSSERR("dispc_ovl_setup failed for ovl %d\n", ovl->id);
+		dispc_ovl_enable(ovl->id, 0);
 		return r;
 	}
 
-	dispc_ovl_set_fifo_threshold(plane, c->fifo_low, c->fifo_high);
+	dispc_ovl_set_fifo_threshold(ovl->id, c->fifo_low, c->fifo_high);
 
-	dispc_ovl_enable(plane, 1);
+	dispc_ovl_enable(ovl->id, 1);
 
 	return 0;
 }
 
-static void configure_manager(enum omap_channel channel)
+static void dss_mgr_write_regs(struct omap_overlay_manager *mgr)
 {
 	struct omap_overlay_manager_info *mi;
 
-	DSSDBGF("%d", channel);
+	DSSDBGF("%d", mgr->id);
 
-	/* picking info from the cache */
-	mi = &dss_cache.manager_cache[channel].info;
+	mi = &dss_cache.manager_cache[mgr->id].info;
 
-	dispc_mgr_setup(channel, mi);
+	dispc_mgr_setup(mgr->id, mi);
 }
 
-/* configure_dispc() tries to write values from cache to shadow registers.
+/* dss_write_regs() tries to write values from cache to shadow registers.
  * It writes only to those managers/overlays that are not busy.
  * returns 0 if everything could be written to shadow registers.
  * returns 1 if not everything could be written to shadow registers. */
-static int configure_dispc(void)
+static int dss_write_regs(void)
 {
+	struct omap_overlay *ovl;
+	struct omap_overlay_manager *mgr;
 	struct overlay_cache_data *oc;
 	struct manager_cache_data *mc;
 	const int num_ovls = dss_feat_get_num_ovls();
@@ -316,6 +314,7 @@ static int configure_dispc(void)
 
 	/* Commit overlay settings */
 	for (i = 0; i < num_ovls; ++i) {
+		ovl = omap_dss_get_overlay(i);
 		oc = &dss_cache.overlay_cache[i];
 		mc = &dss_cache.manager_cache[oc->channel];
 
@@ -330,9 +329,9 @@ static int configure_dispc(void)
 			continue;
 		}
 
-		r = configure_overlay(i);
+		r = dss_ovl_write_regs(ovl);
 		if (r)
-			DSSERR("configure_overlay %d failed\n", i);
+			DSSERR("dss_ovl_write_regs %d failed\n", i);
 
 		oc->dirty = false;
 		oc->shadow_dirty = true;
@@ -341,6 +340,7 @@ static int configure_dispc(void)
 
 	/* Commit manager settings */
 	for (i = 0; i < num_mgrs; ++i) {
+		mgr = omap_dss_get_overlay_manager(i);
 		mc = &dss_cache.manager_cache[i];
 
 		if (!mc->dirty)
@@ -354,7 +354,7 @@ static int configure_dispc(void)
 			continue;
 		}
 
-		configure_manager(i);
+		dss_mgr_write_regs(mgr);
 		mc->dirty = false;
 		mc->shadow_dirty = true;
 		mgr_go[i] = true;
@@ -391,7 +391,7 @@ void dss_start_update(struct omap_overlay_manager *mgr)
 	mc = &dss_cache.manager_cache[mgr->id];
 
 	mc->do_manual_update = true;
-	configure_dispc();
+	dss_write_regs();
 	mc->do_manual_update = false;
 
 	list_for_each_entry(ovl, &mgr->overlays, list) {
@@ -465,7 +465,7 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 			mc->shadow_dirty = false;
 	}
 
-	r = configure_dispc();
+	r = dss_write_regs();
 	if (r == 1)
 		goto end;
 
@@ -623,7 +623,7 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 		if (!dss_cache.irq_enabled)
 			dss_register_vsync_isr();
 
-		configure_dispc();
+		dss_write_regs();
 	}
 
 	spin_unlock_irqrestore(&dss_cache.lock, flags);
-- 
1.7.4.1

