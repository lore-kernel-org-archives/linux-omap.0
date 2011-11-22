From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 46/65] OMAPDSS: APPLY: rewrite register writing
Date: Tue, 22 Nov 2011 11:21:45 +0200
Message-ID: <1321953724-6350-47-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:49698 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758095Ab1KVJYV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:21 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The functions writing to the DISPC registers in apply.c are more complex
than needed. This patch cleans things up.

Two helper functions are added: need_isr(), which returns if an isr for
VSYNC is needed, and need_go(), which tells if there has been a write to
the shadow registers and we need to set the GO bit.

The functions that call the actual dispc write functions will set the
dirty and shadow_dirty flags themselves, instead of that being done on
the caller side. The writing functions also check if the dirty flag is
even set, and return immediately if not.

This allows us to clean up dss_write_regs().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |  290 +++++++++++++++++---------------------
 1 files changed, 130 insertions(+), 160 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 2c60e77..c4106b6 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -88,9 +88,6 @@ struct mgr_priv_data {
 
 	struct omap_overlay_manager_info info;
 
-	bool manual_update;
-	bool do_manual_update;
-
 	/* If true, GO bit is up and shadow registers cannot be written.
 	 * Never true for manual update displays */
 	bool busy;
@@ -111,6 +108,8 @@ static spinlock_t data_lock;
 /* lock for blocking functions */
 static DEFINE_MUTEX(apply_lock);
 
+static void dss_register_vsync_isr(void);
+
 static struct ovl_priv_data *get_ovl_priv(struct omap_overlay *ovl)
 {
 	return &dss_data.ovl_priv_data_array[ovl->id];
@@ -136,6 +135,70 @@ static bool mgr_manual_update(struct omap_overlay_manager *mgr)
 	return mgr->device->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
 }
 
+static bool need_isr(void)
+{
+	const int num_mgrs = dss_feat_get_num_mgrs();
+	int i;
+
+	for (i = 0; i < num_mgrs; ++i) {
+		struct omap_overlay_manager *mgr;
+		struct mgr_priv_data *mp;
+		struct omap_overlay *ovl;
+
+		mgr = omap_dss_get_overlay_manager(i);
+		mp = get_mgr_priv(mgr);
+
+		if (!mp->enabled)
+			continue;
+
+		if (mgr_manual_update(mgr))
+			continue;
+
+		/* to catch GO bit going down */
+		if (mp->busy)
+			return true;
+
+		/* to write new values to registers */
+		if (mp->dirty)
+			return true;
+
+		list_for_each_entry(ovl, &mgr->overlays, list) {
+			struct ovl_priv_data *op;
+
+			op = get_ovl_priv(ovl);
+
+			if (!op->enabled)
+				continue;
+
+			/* to write new values to registers */
+			if (op->dirty || op->extra_info_dirty)
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static bool need_go(struct omap_overlay_manager *mgr)
+{
+	struct omap_overlay *ovl;
+	struct mgr_priv_data *mp;
+	struct ovl_priv_data *op;
+
+	mp = get_mgr_priv(mgr);
+
+	if (mp->shadow_dirty)
+		return true;
+
+	list_for_each_entry(ovl, &mgr->overlays, list) {
+		op = get_ovl_priv(ovl);
+		if (op->shadow_dirty || op->shadow_extra_info_dirty)
+			return true;
+	}
+
+	return false;
+}
+
 int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 {
 	unsigned long timeout = msecs_to_jiffies(500);
@@ -257,20 +320,19 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 	return r;
 }
 
-static int dss_ovl_write_regs(struct omap_overlay *ovl)
+static void dss_ovl_write_regs(struct omap_overlay *ovl)
 {
-	struct ovl_priv_data *op;
+	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	struct omap_overlay_info *oi;
 	bool ilace, replication;
 	int r;
 
 	DSSDBGF("%d", ovl->id);
 
-	op = get_ovl_priv(ovl);
-	oi = &op->info;
+	if (!op->enabled || !op->dirty)
+		return;
 
-	if (!op->enabled)
-		return 0;
+	oi = &op->info;
 
 	replication = dss_use_replication(ovl->manager->device, oi->color_mode);
 
@@ -280,15 +342,22 @@ static int dss_ovl_write_regs(struct omap_overlay *ovl)
 
 	r = dispc_ovl_setup(ovl->id, oi, ilace, replication);
 	if (r) {
-		/* this shouldn't happen */
+		/*
+		 * We can't do much here, as this function can be called from
+		 * vsync interrupt.
+		 */
 		DSSERR("dispc_ovl_setup failed for ovl %d\n", ovl->id);
-		dispc_ovl_enable(ovl->id, 0);
-		return r;
+
+		/* This will leave fifo configurations in a nonoptimal state */
+		op->enabled = false;
+		dispc_ovl_enable(ovl->id, false);
+		return;
 	}
 
 	dispc_ovl_set_fifo_threshold(ovl->id, op->fifo_low, op->fifo_high);
 
-	return 0;
+	op->dirty = false;
+	op->shadow_dirty = true;
 }
 
 static void dss_ovl_write_regs_extra(struct omap_overlay *ovl)
@@ -297,141 +366,70 @@ static void dss_ovl_write_regs_extra(struct omap_overlay *ovl)
 
 	DSSDBGF("%d", ovl->id);
 
+	if (!op->extra_info_dirty)
+		return;
+
 	/* note: write also when op->enabled == false, so that the ovl gets
 	 * disabled */
 
 	dispc_ovl_enable(ovl->id, op->enabled);
+
+	op->extra_info_dirty = false;
+	op->shadow_extra_info_dirty = true;
 }
 
 static void dss_mgr_write_regs(struct omap_overlay_manager *mgr)
 {
-	struct mgr_priv_data *mp;
-	struct omap_overlay_manager_info *mi;
+	struct mgr_priv_data *mp = get_mgr_priv(mgr);
+	struct omap_overlay *ovl;
 
 	DSSDBGF("%d", mgr->id);
 
-	mp = get_mgr_priv(mgr);
-	mi = &mp->info;
-
-	dispc_mgr_setup(mgr->id, mi);
-}
-
-/* dss_write_regs() tries to write values from cache to shadow registers.
- * It writes only to those managers/overlays that are not busy.
- * returns 0 if everything could be written to shadow registers.
- * returns 1 if not everything could be written to shadow registers. */
-static int dss_write_regs(void)
-{
-	struct omap_overlay *ovl;
-	struct omap_overlay_manager *mgr;
-	struct ovl_priv_data *op;
-	struct mgr_priv_data *mp;
-	const int num_ovls = dss_feat_get_num_ovls();
-	const int num_mgrs = dss_feat_get_num_mgrs();
-	int i;
-	int r;
-	bool mgr_go[MAX_DSS_MANAGERS] = { false };
-	bool busy;
+	if (!mp->enabled)
+		return;
 
-	r = 0;
-	busy = false;
+	WARN_ON(mp->busy);
 
 	/* Commit overlay settings */
-	for (i = 0; i < num_ovls; ++i) {
-		ovl = omap_dss_get_overlay(i);
-		op = get_ovl_priv(ovl);
-
-		if (!op->dirty)
-			continue;
-
-		mp = get_mgr_priv(ovl->manager);
-
-		if (mp->manual_update && !mp->do_manual_update)
-			continue;
-
-		if (mp->busy) {
-			busy = true;
-			continue;
-		}
-
-		r = dss_ovl_write_regs(ovl);
-		if (r)
-			DSSERR("dss_ovl_write_regs %d failed\n", i);
-
-		op->dirty = false;
-		op->shadow_dirty = true;
-		mgr_go[op->channel] = true;
-	}
-
-	for (i = 0; i < num_ovls; ++i) {
-		ovl = omap_dss_get_overlay(i);
-		op = get_ovl_priv(ovl);
-
-		if (!op->extra_info_dirty)
-			continue;
-
-		mp = get_mgr_priv(ovl->manager);
-
-		if (mp->manual_update && !mp->do_manual_update)
-			continue;
-
-		if (mp->busy) {
-			busy = true;
-			continue;
-		}
-
+	list_for_each_entry(ovl, &mgr->overlays, list) {
+		dss_ovl_write_regs(ovl);
 		dss_ovl_write_regs_extra(ovl);
-
-		op->extra_info_dirty = false;
-		op->shadow_extra_info_dirty = true;
-		mgr_go[op->channel] = true;
 	}
 
-	/* Commit manager settings */
-	for (i = 0; i < num_mgrs; ++i) {
-		mgr = omap_dss_get_overlay_manager(i);
-		mp = get_mgr_priv(mgr);
-
-		if (!mp->dirty)
-			continue;
-
-		if (mp->manual_update && !mp->do_manual_update)
-			continue;
-
-		if (mp->busy) {
-			busy = true;
-			continue;
-		}
+	if (mp->dirty) {
+		dispc_mgr_setup(mgr->id, &mp->info);
 
-		dss_mgr_write_regs(mgr);
 		mp->dirty = false;
 		mp->shadow_dirty = true;
-		mgr_go[i] = true;
 	}
+}
+
+static void dss_write_regs(void)
+{
+	const int num_mgrs = omap_dss_get_num_overlay_managers();
+	int i;
 
-	/* set GO */
 	for (i = 0; i < num_mgrs; ++i) {
+		struct omap_overlay_manager *mgr;
+		struct mgr_priv_data *mp;
+
 		mgr = omap_dss_get_overlay_manager(i);
 		mp = get_mgr_priv(mgr);
 
-		if (!mgr_go[i])
+		if (!mp->enabled || mgr_manual_update(mgr) || mp->busy)
 			continue;
 
-		/* We don't need GO with manual update display. LCD iface will
-		 * always be turned off after frame, and new settings will be
-		 * taken in to use at next update */
-		if (!mp->manual_update) {
+		dss_mgr_write_regs(mgr);
+
+		if (need_go(mgr)) {
 			mp->busy = true;
-			dispc_mgr_go(i);
-		}
-	}
 
-	if (busy)
-		r = 1;
-	else
-		r = 0;
+			if (!dss_data.irq_enabled && need_isr())
+				dss_register_vsync_isr();
 
-	return r;
+			dispc_mgr_go(mgr->id);
+		}
+	}
 }
 
 void dss_start_update(struct omap_overlay_manager *mgr)
@@ -443,9 +441,7 @@ void dss_start_update(struct omap_overlay_manager *mgr)
 
 	spin_lock_irqsave(&data_lock, flags);
 
-	mp->do_manual_update = true;
-	dss_write_regs();
-	mp->do_manual_update = false;
+	dss_mgr_write_regs(mgr);
 
 	list_for_each_entry(ovl, &mgr->overlays, list) {
 		op = get_ovl_priv(ovl);
@@ -502,7 +498,7 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 	struct ovl_priv_data *op;
 	const int num_ovls = dss_feat_get_num_ovls();
 	const int num_mgrs = dss_feat_get_num_mgrs();
-	int i, r;
+	int i;
 
 	spin_lock(&data_lock);
 
@@ -536,31 +532,11 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 			mp->shadow_dirty = false;
 	}
 
-	r = dss_write_regs();
-	if (r == 1)
-		goto end;
-
-	/* re-read busy flags */
-	for (i = 0; i < num_mgrs; i++) {
-		mgr = omap_dss_get_overlay_manager(i);
-		mp = get_mgr_priv(mgr);
-
-		mp->busy = dispc_mgr_go_busy(i);
-	}
-
-	/* keep running as long as there are busy managers, so that
-	 * we can collect overlay-applied information */
-	for (i = 0; i < num_mgrs; ++i) {
-		mgr = omap_dss_get_overlay_manager(i);
-		mp = get_mgr_priv(mgr);
-
-		if (mp->busy)
-			goto end;
-	}
+	dss_write_regs();
 
-	dss_unregister_vsync_isr();
+	if (!need_isr())
+		dss_unregister_vsync_isr();
 
-end:
 	spin_unlock(&data_lock);
 }
 
@@ -599,14 +575,9 @@ static void omap_dss_mgr_apply_mgr(struct omap_overlay_manager *mgr)
 	if (!mgr->info_dirty)
 		return;
 
-	if (!mgr->device)
-		return;
-
 	mgr->info_dirty = false;
 	mp->dirty = true;
 	mp->info = mgr->info;
-
-	mp->manual_update = mgr_manual_update(mgr);
 }
 
 static void omap_dss_mgr_apply_ovl_fifos(struct omap_overlay *ovl)
@@ -650,7 +621,6 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 	int r;
 	unsigned long flags;
 	struct omap_overlay *ovl;
-	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 
 	DSSDBG("omap_dss_mgr_apply(%s)\n", mgr->name);
 
@@ -671,13 +641,7 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 	list_for_each_entry(ovl, &mgr->overlays, list)
 		omap_dss_mgr_apply_ovl_fifos(ovl);
 
-	r = 0;
-	if (mp->enabled && !mgr_manual_update(mgr)) {
-		if (!dss_data.irq_enabled)
-			dss_register_vsync_isr();
-
-		dss_write_regs();
-	}
+	dss_write_regs();
 
 	spin_unlock_irqrestore(&data_lock, flags);
 
@@ -693,15 +657,17 @@ void dss_mgr_enable(struct omap_overlay_manager *mgr)
 
 	mutex_lock(&apply_lock);
 
-	if (!mgr_manual_update(mgr))
-		dispc_mgr_enable(mgr->id, true);
-
 	spin_lock_irqsave(&data_lock, flags);
 
 	mp->enabled = true;
 
+	dss_write_regs();
+
 	spin_unlock_irqrestore(&data_lock, flags);
 
+	if (!mgr_manual_update(mgr))
+		dispc_mgr_enable(mgr->id, true);
+
 	mutex_unlock(&apply_lock);
 }
 
@@ -971,6 +937,8 @@ int dss_ovl_enable(struct omap_overlay *ovl)
 	op->enabled = true;
 	op->extra_info_dirty = true;
 
+	dss_write_regs();
+
 	spin_unlock_irqrestore(&data_lock, flags);
 
 	mutex_unlock(&apply_lock);
@@ -999,6 +967,8 @@ int dss_ovl_disable(struct omap_overlay *ovl)
 	op->enabled = false;
 	op->extra_info_dirty = true;
 
+	dss_write_regs();
+
 	spin_unlock_irqrestore(&data_lock, flags);
 
 	mutex_unlock(&apply_lock);
-- 
1.7.4.1

