From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 33/65] OMAPDSS: APPLY: rename overlay_cache_data
Date: Tue, 22 Nov 2011 11:21:32 +0200
Message-ID: <1321953724-6350-34-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:59673 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757780Ab1KVJXs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:23:48 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

overlay_cache_data is not a suitable name for the struct. It is more of
a private data for the overlay.

Rename the struct to ovl_priv_data, and add a function,
get_ovl_priv(ovl), to get a pointer to the data.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   99 +++++++++++++++++++++------------------
 1 files changed, 53 insertions(+), 46 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 1c97069..d07bcc9 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -54,7 +54,7 @@
  * +--------------------+
  */
 
-struct overlay_cache_data {
+struct ovl_priv_data {
 	/* If true, cache changed, but not written to shadow registers. Set
 	 * in apply(), cleared when registers written. */
 	bool dirty;
@@ -90,12 +90,17 @@ struct manager_cache_data {
 
 static struct {
 	spinlock_t lock;
-	struct overlay_cache_data overlay_cache[MAX_DSS_OVERLAYS];
+	struct ovl_priv_data ovl_priv_data_array[MAX_DSS_OVERLAYS];
 	struct manager_cache_data manager_cache[MAX_DSS_MANAGERS];
 
 	bool irq_enabled;
 } dss_cache;
 
+static struct ovl_priv_data *get_ovl_priv(struct omap_overlay *ovl)
+{
+	return &dss_cache.ovl_priv_data_array[ovl->id];
+}
+
 void dss_apply_init(void)
 {
 	spin_lock_init(&dss_cache.lock);
@@ -177,7 +182,7 @@ int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 {
 	unsigned long timeout = msecs_to_jiffies(500);
-	struct overlay_cache_data *oc;
+	struct ovl_priv_data *op;
 	struct omap_dss_device *dssdev;
 	u32 irq;
 	int r;
@@ -196,15 +201,15 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 
 	irq = dispc_mgr_get_vsync_irq(ovl->manager->id);
 
-	oc = &dss_cache.overlay_cache[ovl->id];
+	op = get_ovl_priv(ovl);
 	i = 0;
 	while (1) {
 		unsigned long flags;
 		bool shadow_dirty, dirty;
 
 		spin_lock_irqsave(&dss_cache.lock, flags);
-		dirty = oc->dirty;
-		shadow_dirty = oc->shadow_dirty;
+		dirty = op->dirty;
+		shadow_dirty = op->shadow_dirty;
 		spin_unlock_irqrestore(&dss_cache.lock, flags);
 
 		if (!dirty && !shadow_dirty) {
@@ -239,17 +244,17 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 
 static int dss_ovl_write_regs(struct omap_overlay *ovl)
 {
-	struct overlay_cache_data *c;
+	struct ovl_priv_data *op;
 	struct omap_overlay_info *oi;
 	bool ilace, replication;
 	int r;
 
 	DSSDBGF("%d", ovl->id);
 
-	c = &dss_cache.overlay_cache[ovl->id];
-	oi = &c->info;
+	op = get_ovl_priv(ovl);
+	oi = &op->info;
 
-	if (!c->enabled) {
+	if (!op->enabled) {
 		dispc_ovl_enable(ovl->id, 0);
 		return 0;
 	}
@@ -258,7 +263,7 @@ static int dss_ovl_write_regs(struct omap_overlay *ovl)
 
 	ilace = ovl->manager->device->type == OMAP_DISPLAY_TYPE_VENC;
 
-	dispc_ovl_set_channel_out(ovl->id, c->channel);
+	dispc_ovl_set_channel_out(ovl->id, op->channel);
 
 	r = dispc_ovl_setup(ovl->id, oi, ilace, replication);
 	if (r) {
@@ -268,7 +273,7 @@ static int dss_ovl_write_regs(struct omap_overlay *ovl)
 		return r;
 	}
 
-	dispc_ovl_set_fifo_threshold(ovl->id, c->fifo_low, c->fifo_high);
+	dispc_ovl_set_fifo_threshold(ovl->id, op->fifo_low, op->fifo_high);
 
 	dispc_ovl_enable(ovl->id, 1);
 
@@ -294,7 +299,7 @@ static int dss_write_regs(void)
 {
 	struct omap_overlay *ovl;
 	struct omap_overlay_manager *mgr;
-	struct overlay_cache_data *oc;
+	struct ovl_priv_data *op;
 	struct manager_cache_data *mc;
 	const int num_ovls = dss_feat_get_num_ovls();
 	const int num_mgrs = dss_feat_get_num_mgrs();
@@ -315,16 +320,16 @@ static int dss_write_regs(void)
 	/* Commit overlay settings */
 	for (i = 0; i < num_ovls; ++i) {
 		ovl = omap_dss_get_overlay(i);
-		oc = &dss_cache.overlay_cache[i];
-		mc = &dss_cache.manager_cache[oc->channel];
+		op = get_ovl_priv(ovl);
+		mc = &dss_cache.manager_cache[op->channel];
 
-		if (!oc->dirty)
+		if (!op->dirty)
 			continue;
 
 		if (mc->manual_update && !mc->do_manual_update)
 			continue;
 
-		if (mgr_busy[oc->channel]) {
+		if (mgr_busy[op->channel]) {
 			busy = true;
 			continue;
 		}
@@ -333,9 +338,9 @@ static int dss_write_regs(void)
 		if (r)
 			DSSERR("dss_ovl_write_regs %d failed\n", i);
 
-		oc->dirty = false;
-		oc->shadow_dirty = true;
-		mgr_go[oc->channel] = true;
+		op->dirty = false;
+		op->shadow_dirty = true;
+		mgr_go[op->channel] = true;
 	}
 
 	/* Commit manager settings */
@@ -385,7 +390,7 @@ static int dss_write_regs(void)
 void dss_start_update(struct omap_overlay_manager *mgr)
 {
 	struct manager_cache_data *mc;
-	struct overlay_cache_data *oc;
+	struct ovl_priv_data *op;
 	struct omap_overlay *ovl;
 
 	mc = &dss_cache.manager_cache[mgr->id];
@@ -395,8 +400,8 @@ void dss_start_update(struct omap_overlay_manager *mgr)
 	mc->do_manual_update = false;
 
 	list_for_each_entry(ovl, &mgr->overlays, list) {
-		oc = &dss_cache.overlay_cache[ovl->id];
-		oc->shadow_dirty = false;
+		op = get_ovl_priv(ovl);
+		op->shadow_dirty = false;
 	}
 
 	mc = &dss_cache.manager_cache[mgr->id];
@@ -441,8 +446,9 @@ static void dss_unregister_vsync_isr(void)
 
 static void dss_apply_irq_handler(void *data, u32 mask)
 {
+	struct omap_overlay *ovl;
 	struct manager_cache_data *mc;
-	struct overlay_cache_data *oc;
+	struct ovl_priv_data *op;
 	const int num_ovls = dss_feat_get_num_ovls();
 	const int num_mgrs = dss_feat_get_num_mgrs();
 	int i, r;
@@ -454,9 +460,10 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 	spin_lock(&dss_cache.lock);
 
 	for (i = 0; i < num_ovls; ++i) {
-		oc = &dss_cache.overlay_cache[i];
-		if (!mgr_busy[oc->channel])
-			oc->shadow_dirty = false;
+		ovl = omap_dss_get_overlay(i);
+		op = get_ovl_priv(ovl);
+		if (!mgr_busy[op->channel])
+			op->shadow_dirty = false;
 	}
 
 	for (i = 0; i < num_mgrs; ++i) {
@@ -488,10 +495,10 @@ end:
 
 static int omap_dss_mgr_apply_ovl(struct omap_overlay *ovl)
 {
-	struct overlay_cache_data *oc;
+	struct ovl_priv_data *op;
 	struct omap_dss_device *dssdev;
 
-	oc = &dss_cache.overlay_cache[ovl->id];
+	op = get_ovl_priv(ovl);
 
 	if (ovl->manager_changed) {
 		ovl->manager_changed = false;
@@ -499,9 +506,9 @@ static int omap_dss_mgr_apply_ovl(struct omap_overlay *ovl)
 	}
 
 	if (!overlay_enabled(ovl)) {
-		if (oc->enabled) {
-			oc->enabled = false;
-			oc->dirty = true;
+		if (op->enabled) {
+			op->enabled = false;
+			op->dirty = true;
 		}
 		return 0;
 	}
@@ -512,20 +519,20 @@ static int omap_dss_mgr_apply_ovl(struct omap_overlay *ovl)
 	dssdev = ovl->manager->device;
 
 	if (dss_check_overlay(ovl, dssdev)) {
-		if (oc->enabled) {
-			oc->enabled = false;
-			oc->dirty = true;
+		if (op->enabled) {
+			op->enabled = false;
+			op->dirty = true;
 		}
 		return -EINVAL;
 	}
 
 	ovl->info_dirty = false;
-	oc->dirty = true;
-	oc->info = ovl->info;
+	op->dirty = true;
+	op->info = ovl->info;
 
-	oc->channel = ovl->manager->id;
+	op->channel = ovl->manager->id;
 
-	oc->enabled = true;
+	op->enabled = true;
 
 	return 0;
 }
@@ -556,13 +563,13 @@ static void omap_dss_mgr_apply_mgr(struct omap_overlay_manager *mgr)
 
 static void omap_dss_mgr_apply_ovl_fifos(struct omap_overlay *ovl)
 {
-	struct overlay_cache_data *oc;
+	struct ovl_priv_data *op;
 	struct omap_dss_device *dssdev;
 	u32 size, burst_size;
 
-	oc = &dss_cache.overlay_cache[ovl->id];
+	op = get_ovl_priv(ovl);
 
-	if (!oc->enabled)
+	if (!op->enabled)
 		return;
 
 	dssdev = ovl->manager->device;
@@ -578,14 +585,14 @@ static void omap_dss_mgr_apply_ovl_fifos(struct omap_overlay *ovl)
 	case OMAP_DISPLAY_TYPE_VENC:
 	case OMAP_DISPLAY_TYPE_HDMI:
 		default_get_overlay_fifo_thresholds(ovl->id, size,
-				burst_size, &oc->fifo_low,
-				&oc->fifo_high);
+				burst_size, &op->fifo_low,
+				&op->fifo_high);
 		break;
 #ifdef CONFIG_OMAP2_DSS_DSI
 	case OMAP_DISPLAY_TYPE_DSI:
 		dsi_get_overlay_fifo_thresholds(ovl->id, size,
-				burst_size, &oc->fifo_low,
-				&oc->fifo_high);
+				burst_size, &op->fifo_low,
+				&op->fifo_high);
 		break;
 #endif
 	default:
-- 
1.7.4.1

