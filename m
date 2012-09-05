From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 13/17] Revert "OMAPDSS: APPLY: add fifo-merge support"
Date: Wed,  5 Sep 2012 11:25:51 +0300
Message-ID: <1346833555-31258-14-git-send-email-tomi.valkeinen@ti.com>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:59313 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758162Ab2IEI0h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 04:26:37 -0400
Received: by lbbgj3 with SMTP id gj3so189937lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 01:26:34 -0700 (PDT)
In-Reply-To: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

This reverts commit 1d71f42b35ed66d90a9a39bc515bb16cfe2d4a46.

Adding fifo merge feature as an omapdss internal configuration was a
mistake. We cannot hide from the users of omapdss the complexities of
fifo merge.

This commit removes the fifo merge support, which luckily is easily done
as it was handled totally inside apply.c.

The plan is to try fifo merge again later when it is more clear how the
hardware acts in various situations, and how the omapdrm wants to use
fifo merge.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |  154 ++-------------------------------------
 1 file changed, 8 insertions(+), 146 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 1b49019..02943a5 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -993,11 +993,11 @@ static void dss_apply_fifo_merge(bool use_fifo_merge)
 	dss_data.fifo_merge_dirty = true;
 }
 
-static void dss_ovl_setup_fifo(struct omap_overlay *ovl,
-		bool use_fifo_merge)
+static void dss_ovl_setup_fifo(struct omap_overlay *ovl)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	u32 fifo_low, fifo_high;
+	bool use_fifo_merge = false;
 
 	if (!op->enabled && !op->enabling)
 		return;
@@ -1008,8 +1008,7 @@ static void dss_ovl_setup_fifo(struct omap_overlay *ovl,
 	dss_apply_ovl_fifo_thresholds(ovl, fifo_low, fifo_high);
 }
 
-static void dss_mgr_setup_fifos(struct omap_overlay_manager *mgr,
-		bool use_fifo_merge)
+static void dss_mgr_setup_fifos(struct omap_overlay_manager *mgr)
 {
 	struct omap_overlay *ovl;
 	struct mgr_priv_data *mp;
@@ -1020,10 +1019,10 @@ static void dss_mgr_setup_fifos(struct omap_overlay_manager *mgr,
 		return;
 
 	list_for_each_entry(ovl, &mgr->overlays, list)
-		dss_ovl_setup_fifo(ovl, use_fifo_merge);
+		dss_ovl_setup_fifo(ovl);
 }
 
-static void dss_setup_fifos(bool use_fifo_merge)
+static void dss_setup_fifos(void)
 {
 	const int num_mgrs = omap_dss_get_num_overlay_managers();
 	struct omap_overlay_manager *mgr;
@@ -1031,91 +1030,15 @@ static void dss_setup_fifos(bool use_fifo_merge)
 
 	for (i = 0; i < num_mgrs; ++i) {
 		mgr = omap_dss_get_overlay_manager(i);
-		dss_mgr_setup_fifos(mgr, use_fifo_merge);
+		dss_mgr_setup_fifos(mgr);
 	}
 }
 
-static int get_num_used_managers(void)
-{
-	const int num_mgrs = omap_dss_get_num_overlay_managers();
-	struct omap_overlay_manager *mgr;
-	struct mgr_priv_data *mp;
-	int i;
-	int enabled_mgrs;
-
-	enabled_mgrs = 0;
-
-	for (i = 0; i < num_mgrs; ++i) {
-		mgr = omap_dss_get_overlay_manager(i);
-		mp = get_mgr_priv(mgr);
-
-		if (!mp->enabled)
-			continue;
-
-		enabled_mgrs++;
-	}
-
-	return enabled_mgrs;
-}
-
-static int get_num_used_overlays(void)
-{
-	const int num_ovls = omap_dss_get_num_overlays();
-	struct omap_overlay *ovl;
-	struct ovl_priv_data *op;
-	struct mgr_priv_data *mp;
-	int i;
-	int enabled_ovls;
-
-	enabled_ovls = 0;
-
-	for (i = 0; i < num_ovls; ++i) {
-		ovl = omap_dss_get_overlay(i);
-		op = get_ovl_priv(ovl);
-
-		if (!op->enabled && !op->enabling)
-			continue;
-
-		mp = get_mgr_priv(ovl->manager);
-
-		if (!mp->enabled)
-			continue;
-
-		enabled_ovls++;
-	}
-
-	return enabled_ovls;
-}
-
-static bool get_use_fifo_merge(void)
-{
-	int enabled_mgrs = get_num_used_managers();
-	int enabled_ovls = get_num_used_overlays();
-
-	if (!dss_has_feature(FEAT_FIFO_MERGE))
-		return false;
-
-	/*
-	 * In theory the only requirement for fifomerge is enabled_ovls <= 1.
-	 * However, if we have two managers enabled and set/unset the fifomerge,
-	 * we need to set the GO bits in particular sequence for the managers,
-	 * and wait in between.
-	 *
-	 * This is rather difficult as new apply calls can happen at any time,
-	 * so we simplify the problem by requiring also that enabled_mgrs <= 1.
-	 * In practice this shouldn't matter, because when only one overlay is
-	 * enabled, most likely only one output is enabled.
-	 */
-
-	return enabled_mgrs <= 1 && enabled_ovls <= 1;
-}
-
 int dss_mgr_enable(struct omap_overlay_manager *mgr)
 {
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 	unsigned long flags;
 	int r;
-	bool fifo_merge;
 
 	mutex_lock(&apply_lock);
 
@@ -1133,23 +1056,11 @@ int dss_mgr_enable(struct omap_overlay_manager *mgr)
 		goto err;
 	}
 
-	/* step 1: setup fifos/fifomerge before enabling the manager */
-
-	fifo_merge = get_use_fifo_merge();
-	dss_setup_fifos(fifo_merge);
-	dss_apply_fifo_merge(fifo_merge);
+	dss_setup_fifos();
 
 	dss_write_regs();
 	dss_set_go_bits();
 
-	spin_unlock_irqrestore(&data_lock, flags);
-
-	/* wait until fifo config is in */
-	wait_pending_extra_info_updates();
-
-	/* step 2: enable the manager */
-	spin_lock_irqsave(&data_lock, flags);
-
 	if (!mgr_manual_update(mgr))
 		mp->updating = true;
 
@@ -1174,7 +1085,6 @@ void dss_mgr_disable(struct omap_overlay_manager *mgr)
 {
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 	unsigned long flags;
-	bool fifo_merge;
 
 	mutex_lock(&apply_lock);
 
@@ -1189,16 +1099,8 @@ void dss_mgr_disable(struct omap_overlay_manager *mgr)
 	mp->updating = false;
 	mp->enabled = false;
 
-	fifo_merge = get_use_fifo_merge();
-	dss_setup_fifos(fifo_merge);
-	dss_apply_fifo_merge(fifo_merge);
-
-	dss_write_regs();
-	dss_set_go_bits();
-
 	spin_unlock_irqrestore(&data_lock, flags);
 
-	wait_pending_extra_info_updates();
 out:
 	mutex_unlock(&apply_lock);
 }
@@ -1505,7 +1407,6 @@ int dss_ovl_enable(struct omap_overlay *ovl)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	unsigned long flags;
-	bool fifo_merge;
 	int r;
 
 	mutex_lock(&apply_lock);
@@ -1531,22 +1432,7 @@ int dss_ovl_enable(struct omap_overlay *ovl)
 		goto err2;
 	}
 
-	/* step 1: configure fifos/fifomerge for currently enabled ovls */
-
-	fifo_merge = get_use_fifo_merge();
-	dss_setup_fifos(fifo_merge);
-	dss_apply_fifo_merge(fifo_merge);
-
-	dss_write_regs();
-	dss_set_go_bits();
-
-	spin_unlock_irqrestore(&data_lock, flags);
-
-	/* wait for fifo configs to go in */
-	wait_pending_extra_info_updates();
-
-	/* step 2: enable the overlay */
-	spin_lock_irqsave(&data_lock, flags);
+	dss_setup_fifos();
 
 	op->enabling = false;
 	dss_apply_ovl_enable(ovl, true);
@@ -1556,9 +1442,6 @@ int dss_ovl_enable(struct omap_overlay *ovl)
 
 	spin_unlock_irqrestore(&data_lock, flags);
 
-	/* wait for overlay to be enabled */
-	wait_pending_extra_info_updates();
-
 	mutex_unlock(&apply_lock);
 
 	return 0;
@@ -1574,7 +1457,6 @@ int dss_ovl_disable(struct omap_overlay *ovl)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	unsigned long flags;
-	bool fifo_merge;
 	int r;
 
 	mutex_lock(&apply_lock);
@@ -1589,34 +1471,14 @@ int dss_ovl_disable(struct omap_overlay *ovl)
 		goto err;
 	}
 
-	/* step 1: disable the overlay */
 	spin_lock_irqsave(&data_lock, flags);
 
 	dss_apply_ovl_enable(ovl, false);
-
 	dss_write_regs();
 	dss_set_go_bits();
 
 	spin_unlock_irqrestore(&data_lock, flags);
 
-	/* wait for the overlay to be disabled */
-	wait_pending_extra_info_updates();
-
-	/* step 2: configure fifos/fifomerge */
-	spin_lock_irqsave(&data_lock, flags);
-
-	fifo_merge = get_use_fifo_merge();
-	dss_setup_fifos(fifo_merge);
-	dss_apply_fifo_merge(fifo_merge);
-
-	dss_write_regs();
-	dss_set_go_bits();
-
-	spin_unlock_irqrestore(&data_lock, flags);
-
-	/* wait for fifo config to go in */
-	wait_pending_extra_info_updates();
-
 	mutex_unlock(&apply_lock);
 
 	return 0;
-- 
1.7.9.5

