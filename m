From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 34/65] OMAPDSS: APPLY: rename manager_cache_data
Date: Tue, 22 Nov 2011 11:21:33 +0200
Message-ID: <1321953724-6350-35-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:46061 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757795Ab1KVJXu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:23:50 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

manager_cache_data is not a suitable name for the struct. It is more of
a private data for the manager.

Rename the struct to mgr_priv_data, and add a function,
get_mgr_priv(mgr), to get a pointer to the data.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   72 +++++++++++++++++++++-----------------
 1 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index d07bcc9..23c723a 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -73,7 +73,7 @@ struct ovl_priv_data {
 	u32 fifo_high;
 };
 
-struct manager_cache_data {
+struct mgr_priv_data {
 	/* If true, cache changed, but not written to shadow registers. Set
 	 * in apply(), cleared when registers written. */
 	bool dirty;
@@ -91,7 +91,7 @@ struct manager_cache_data {
 static struct {
 	spinlock_t lock;
 	struct ovl_priv_data ovl_priv_data_array[MAX_DSS_OVERLAYS];
-	struct manager_cache_data manager_cache[MAX_DSS_MANAGERS];
+	struct mgr_priv_data mgr_priv_data_array[MAX_DSS_MANAGERS];
 
 	bool irq_enabled;
 } dss_cache;
@@ -101,6 +101,11 @@ static struct ovl_priv_data *get_ovl_priv(struct omap_overlay *ovl)
 	return &dss_cache.ovl_priv_data_array[ovl->id];
 }
 
+static struct mgr_priv_data *get_mgr_priv(struct omap_overlay_manager *mgr)
+{
+	return &dss_cache.mgr_priv_data_array[mgr->id];
+}
+
 void dss_apply_init(void)
 {
 	spin_lock_init(&dss_cache.lock);
@@ -124,7 +129,7 @@ static int overlay_enabled(struct omap_overlay *ovl)
 int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 {
 	unsigned long timeout = msecs_to_jiffies(500);
-	struct manager_cache_data *mc;
+	struct mgr_priv_data *mp;
 	u32 irq;
 	int r;
 	int i;
@@ -138,15 +143,15 @@ int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 
 	irq = dispc_mgr_get_vsync_irq(mgr->id);
 
-	mc = &dss_cache.manager_cache[mgr->id];
+	mp = get_mgr_priv(mgr);
 	i = 0;
 	while (1) {
 		unsigned long flags;
 		bool shadow_dirty, dirty;
 
 		spin_lock_irqsave(&dss_cache.lock, flags);
-		dirty = mc->dirty;
-		shadow_dirty = mc->shadow_dirty;
+		dirty = mp->dirty;
+		shadow_dirty = mp->shadow_dirty;
 		spin_unlock_irqrestore(&dss_cache.lock, flags);
 
 		if (!dirty && !shadow_dirty) {
@@ -282,11 +287,13 @@ static int dss_ovl_write_regs(struct omap_overlay *ovl)
 
 static void dss_mgr_write_regs(struct omap_overlay_manager *mgr)
 {
+	struct mgr_priv_data *mp;
 	struct omap_overlay_manager_info *mi;
 
 	DSSDBGF("%d", mgr->id);
 
-	mi = &dss_cache.manager_cache[mgr->id].info;
+	mp = get_mgr_priv(mgr);
+	mi = &mp->info;
 
 	dispc_mgr_setup(mgr->id, mi);
 }
@@ -300,7 +307,7 @@ static int dss_write_regs(void)
 	struct omap_overlay *ovl;
 	struct omap_overlay_manager *mgr;
 	struct ovl_priv_data *op;
-	struct manager_cache_data *mc;
+	struct mgr_priv_data *mp;
 	const int num_ovls = dss_feat_get_num_ovls();
 	const int num_mgrs = dss_feat_get_num_mgrs();
 	int i;
@@ -321,12 +328,13 @@ static int dss_write_regs(void)
 	for (i = 0; i < num_ovls; ++i) {
 		ovl = omap_dss_get_overlay(i);
 		op = get_ovl_priv(ovl);
-		mc = &dss_cache.manager_cache[op->channel];
 
 		if (!op->dirty)
 			continue;
 
-		if (mc->manual_update && !mc->do_manual_update)
+		mp = get_mgr_priv(ovl->manager);
+
+		if (mp->manual_update && !mp->do_manual_update)
 			continue;
 
 		if (mgr_busy[op->channel]) {
@@ -346,12 +354,12 @@ static int dss_write_regs(void)
 	/* Commit manager settings */
 	for (i = 0; i < num_mgrs; ++i) {
 		mgr = omap_dss_get_overlay_manager(i);
-		mc = &dss_cache.manager_cache[i];
+		mp = get_mgr_priv(mgr);
 
-		if (!mc->dirty)
+		if (!mp->dirty)
 			continue;
 
-		if (mc->manual_update && !mc->do_manual_update)
+		if (mp->manual_update && !mp->do_manual_update)
 			continue;
 
 		if (mgr_busy[i]) {
@@ -360,14 +368,15 @@ static int dss_write_regs(void)
 		}
 
 		dss_mgr_write_regs(mgr);
-		mc->dirty = false;
-		mc->shadow_dirty = true;
+		mp->dirty = false;
+		mp->shadow_dirty = true;
 		mgr_go[i] = true;
 	}
 
 	/* set GO */
 	for (i = 0; i < num_mgrs; ++i) {
-		mc = &dss_cache.manager_cache[i];
+		mgr = omap_dss_get_overlay_manager(i);
+		mp = get_mgr_priv(mgr);
 
 		if (!mgr_go[i])
 			continue;
@@ -375,7 +384,7 @@ static int dss_write_regs(void)
 		/* We don't need GO with manual update display. LCD iface will
 		 * always be turned off after frame, and new settings will be
 		 * taken in to use at next update */
-		if (!mc->manual_update)
+		if (!mp->manual_update)
 			dispc_mgr_go(i);
 	}
 
@@ -389,23 +398,20 @@ static int dss_write_regs(void)
 
 void dss_start_update(struct omap_overlay_manager *mgr)
 {
-	struct manager_cache_data *mc;
+	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 	struct ovl_priv_data *op;
 	struct omap_overlay *ovl;
 
-	mc = &dss_cache.manager_cache[mgr->id];
-
-	mc->do_manual_update = true;
+	mp->do_manual_update = true;
 	dss_write_regs();
-	mc->do_manual_update = false;
+	mp->do_manual_update = false;
 
 	list_for_each_entry(ovl, &mgr->overlays, list) {
 		op = get_ovl_priv(ovl);
 		op->shadow_dirty = false;
 	}
 
-	mc = &dss_cache.manager_cache[mgr->id];
-	mc->shadow_dirty = false;
+	mp->shadow_dirty = false;
 
 	dispc_mgr_enable(mgr->id, true);
 }
@@ -447,7 +453,8 @@ static void dss_unregister_vsync_isr(void)
 static void dss_apply_irq_handler(void *data, u32 mask)
 {
 	struct omap_overlay *ovl;
-	struct manager_cache_data *mc;
+	struct omap_overlay_manager *mgr;
+	struct mgr_priv_data *mp;
 	struct ovl_priv_data *op;
 	const int num_ovls = dss_feat_get_num_ovls();
 	const int num_mgrs = dss_feat_get_num_mgrs();
@@ -467,9 +474,10 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 	}
 
 	for (i = 0; i < num_mgrs; ++i) {
-		mc = &dss_cache.manager_cache[i];
+		mgr = omap_dss_get_overlay_manager(i);
+		mp = get_mgr_priv(mgr);
 		if (!mgr_busy[i])
-			mc->shadow_dirty = false;
+			mp->shadow_dirty = false;
 	}
 
 	r = dss_write_regs();
@@ -539,9 +547,9 @@ static int omap_dss_mgr_apply_ovl(struct omap_overlay *ovl)
 
 static void omap_dss_mgr_apply_mgr(struct omap_overlay_manager *mgr)
 {
-	struct manager_cache_data *mc;
+	struct mgr_priv_data *mp;
 
-	mc = &dss_cache.manager_cache[mgr->id];
+	mp = get_mgr_priv(mgr);
 
 	if (mgr->device_changed) {
 		mgr->device_changed = false;
@@ -555,10 +563,10 @@ static void omap_dss_mgr_apply_mgr(struct omap_overlay_manager *mgr)
 		return;
 
 	mgr->info_dirty = false;
-	mc->dirty = true;
-	mc->info = mgr->info;
+	mp->dirty = true;
+	mp->info = mgr->info;
 
-	mc->manual_update = mgr_manual_update(mgr);
+	mp->manual_update = mgr_manual_update(mgr);
 }
 
 static void omap_dss_mgr_apply_ovl_fifos(struct omap_overlay *ovl)
-- 
1.7.4.1

