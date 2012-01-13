From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/6] OMAPDSS: APPLY: add fifo-merge support
Date: Fri, 13 Jan 2012 13:46:30 +0200
Message-ID: <1326455193-19716-4-git-send-email-tomi.valkeinen@ti.com>
References: <1326455193-19716-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:53895 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752936Ab2AMLqt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 06:46:49 -0500
In-Reply-To: <1326455193-19716-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add fifo-merge support. This is done mainly in four functions:
mgr_enable/disable and ovl_enable/disable. These are the functions where
overlays are taken into and out of active use.

The process to enable and disable fifo-merge is not simple. We need to
do it in steps, waiting in between for certain settings to be taken into
use, and continuing after that. The reason for this is that fifo-merge
is a common thing for all managers/overlays, and its use must be
synchronized.

As an example, when we disable an overlay, we first set the overlay as
disabled, then wait until the overlay is actually disabled in the HW,
and only after that we may re-configure the fifos, possibly taking
fifo-merge into use.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |  164 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 156 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 604737f..6f7b213 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -902,7 +902,8 @@ static void dss_apply_fifo_merge(bool use_fifo_merge)
 	dss_data.fifo_merge_dirty = true;
 }
 
-static void dss_ovl_setup_fifo(struct omap_overlay *ovl)
+static void dss_ovl_setup_fifo(struct omap_overlay *ovl,
+		bool use_fifo_merge)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	struct omap_dss_device *dssdev;
@@ -914,7 +915,16 @@ static void dss_ovl_setup_fifo(struct omap_overlay *ovl)
 
 	dssdev = ovl->manager->device;
 
-	size = dispc_ovl_get_fifo_size(ovl->id);
+	if (use_fifo_merge) {
+		int i;
+
+		size = 0;
+
+		for (i = 0; i < omap_dss_get_num_overlays(); ++i)
+			size += dispc_ovl_get_fifo_size(i);
+	} else {
+		size = dispc_ovl_get_fifo_size(ovl->id);
+	}
 
 	burst_size = dispc_ovl_get_burst_size(ovl->id);
 
@@ -940,7 +950,8 @@ static void dss_ovl_setup_fifo(struct omap_overlay *ovl)
 	dss_apply_ovl_fifo_thresholds(ovl, fifo_low, fifo_high);
 }
 
-static void dss_mgr_setup_fifos(struct omap_overlay_manager *mgr)
+static void dss_mgr_setup_fifos(struct omap_overlay_manager *mgr,
+		bool use_fifo_merge)
 {
 	struct omap_overlay *ovl;
 	struct mgr_priv_data *mp;
@@ -951,10 +962,10 @@ static void dss_mgr_setup_fifos(struct omap_overlay_manager *mgr)
 		return;
 
 	list_for_each_entry(ovl, &mgr->overlays, list)
-		dss_ovl_setup_fifo(ovl);
+		dss_ovl_setup_fifo(ovl, use_fifo_merge);
 }
 
-static void dss_setup_fifos(void)
+static void dss_setup_fifos(bool use_fifo_merge)
 {
 	const int num_mgrs = omap_dss_get_num_overlay_managers();
 	struct omap_overlay_manager *mgr;
@@ -962,15 +973,91 @@ static void dss_setup_fifos(void)
 
 	for (i = 0; i < num_mgrs; ++i) {
 		mgr = omap_dss_get_overlay_manager(i);
-		dss_mgr_setup_fifos(mgr);
+		dss_mgr_setup_fifos(mgr, use_fifo_merge);
 	}
 }
 
+static int get_num_used_managers(void)
+{
+	const int num_mgrs = omap_dss_get_num_overlay_managers();
+	struct omap_overlay_manager *mgr;
+	struct mgr_priv_data *mp;
+	int i;
+	int enabled_mgrs;
+
+	enabled_mgrs = 0;
+
+	for (i = 0; i < num_mgrs; ++i) {
+		mgr = omap_dss_get_overlay_manager(i);
+		mp = get_mgr_priv(mgr);
+
+		if (!mp->enabled)
+			continue;
+
+		enabled_mgrs++;
+	}
+
+	return enabled_mgrs;
+}
+
+static int get_num_used_overlays(void)
+{
+	const int num_ovls = omap_dss_get_num_overlays();
+	struct omap_overlay *ovl;
+	struct ovl_priv_data *op;
+	struct mgr_priv_data *mp;
+	int i;
+	int enabled_ovls;
+
+	enabled_ovls = 0;
+
+	for (i = 0; i < num_ovls; ++i) {
+		ovl = omap_dss_get_overlay(i);
+		op = get_ovl_priv(ovl);
+
+		if (!op->enabled && !op->enabling)
+			continue;
+
+		mp = get_mgr_priv(ovl->manager);
+
+		if (!mp->enabled)
+			continue;
+
+		enabled_ovls++;
+	}
+
+	return enabled_ovls;
+}
+
+static bool get_use_fifo_merge(void)
+{
+	int enabled_mgrs = get_num_used_managers();
+	int enabled_ovls = get_num_used_overlays();
+
+	if (!dss_has_feature(FEAT_FIFO_MERGE))
+		return false;
+
+	/*
+	 * In theory the only requirement for fifomerge is enabled_ovls <= 1.
+	 * However, if we have two managers enabled and set/unset the fifomerge,
+	 * we need to set the GO bits in particular sequence for the managers,
+	 * and wait in between.
+	 *
+	 * This is rather difficult as new apply calls can happen at any time,
+	 * so we simplify the problem by requiring also that enabled_mgrs <= 1.
+	 * In practice this shouldn't matter, because when only one overlay is
+	 * enabled, most likely only one output is enabled.
+	 */
+
+	return enabled_mgrs <= 1 && enabled_ovls <= 1;
+}
+
 int dss_mgr_enable(struct omap_overlay_manager *mgr)
 {
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 	unsigned long flags;
 	int r;
+	bool fifo_merge;
 
 	mutex_lock(&apply_lock);
 
@@ -988,11 +1075,23 @@ int dss_mgr_enable(struct omap_overlay_manager *mgr)
 		goto err;
 	}
 
-	dss_setup_fifos();
+	/* step 1: setup fifos/fifomerge before enabling the manager */
+
+	fifo_merge = get_use_fifo_merge();
+	dss_setup_fifos(fifo_merge);
+	dss_apply_fifo_merge(fifo_merge);
 
 	dss_write_regs();
 	dss_set_go_bits();
 
+	spin_unlock_irqrestore(&data_lock, flags);
+
+	/* wait until fifo config is in */
+	wait_pending_extra_info_updates();
+
+	/* step 2: enable the manager */
+	spin_lock_irqsave(&data_lock, flags);
+
 	if (!mgr_manual_update(mgr))
 		mp->updating = true;
 
@@ -1017,6 +1116,7 @@ void dss_mgr_disable(struct omap_overlay_manager *mgr)
 {
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 	unsigned long flags;
+	bool fifo_merge;
 
 	mutex_lock(&apply_lock);
 
@@ -1031,8 +1131,16 @@ void dss_mgr_disable(struct omap_overlay_manager *mgr)
 	mp->updating = false;
 	mp->enabled = false;
 
+	fifo_merge = get_use_fifo_merge();
+	dss_setup_fifos(fifo_merge);
+	dss_apply_fifo_merge(fifo_merge);
+
+	dss_write_regs();
+	dss_set_go_bits();
+
 	spin_unlock_irqrestore(&data_lock, flags);
 
+	wait_pending_extra_info_updates();
 out:
 	mutex_unlock(&apply_lock);
 }
@@ -1284,6 +1392,7 @@ int dss_ovl_enable(struct omap_overlay *ovl)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	unsigned long flags;
+	bool fifo_merge;
 	int r;
 
 	mutex_lock(&apply_lock);
@@ -1309,7 +1418,22 @@ int dss_ovl_enable(struct omap_overlay *ovl)
 		goto err2;
 	}
 
-	dss_setup_fifos();
+	/* step 1: configure fifos/fifomerge for currently enabled ovls */
+
+	fifo_merge = get_use_fifo_merge();
+	dss_setup_fifos(fifo_merge);
+	dss_apply_fifo_merge(fifo_merge);
+
+	dss_write_regs();
+	dss_set_go_bits();
+
+	spin_unlock_irqrestore(&data_lock, flags);
+
+	/* wait for fifo configs to go in */
+	wait_pending_extra_info_updates();
+
+	/* step 2: enable the overlay */
+	spin_lock_irqsave(&data_lock, flags);
 
 	op->enabling = false;
 	dss_apply_ovl_enable(ovl, true);
@@ -1319,6 +1443,9 @@ int dss_ovl_enable(struct omap_overlay *ovl)
 
 	spin_unlock_irqrestore(&data_lock, flags);
 
+	/* wait for overlay to be enabled */
+	wait_pending_extra_info_updates();
+
 	mutex_unlock(&apply_lock);
 
 	return 0;
@@ -1334,6 +1461,7 @@ int dss_ovl_disable(struct omap_overlay *ovl)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	unsigned long flags;
+	bool fifo_merge;
 	int r;
 
 	mutex_lock(&apply_lock);
@@ -1348,14 +1476,34 @@ int dss_ovl_disable(struct omap_overlay *ovl)
 		goto err;
 	}
 
+	/* step 1: disable the overlay */
 	spin_lock_irqsave(&data_lock, flags);
 
 	dss_apply_ovl_enable(ovl, false);
+
 	dss_write_regs();
 	dss_set_go_bits();
 
 	spin_unlock_irqrestore(&data_lock, flags);
 
+	/* wait for the overlay to be disabled */
+	wait_pending_extra_info_updates();
+
+	/* step 2: configure fifos/fifomerge */
+	spin_lock_irqsave(&data_lock, flags);
+
+	fifo_merge = get_use_fifo_merge();
+	dss_setup_fifos(fifo_merge);
+	dss_apply_fifo_merge(fifo_merge);
+
+	dss_write_regs();
+	dss_set_go_bits();
+
+	spin_unlock_irqrestore(&data_lock, flags);
+
+	/* wait for fifo config to go in */
+	wait_pending_extra_info_updates();
+
 	mutex_unlock(&apply_lock);
 
 	return 0;
-- 
1.7.4.1

