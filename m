From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/17] Revert "OMAPDSS: APPLY: add fifo merge support funcs"
Date: Wed,  5 Sep 2012 11:25:52 +0300
Message-ID: <1346833555-31258-15-git-send-email-tomi.valkeinen@ti.com>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:44529 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758176Ab2IEI0j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 04:26:39 -0400
Received: by lbbgj3 with SMTP id gj3so189949lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 01:26:36 -0700 (PDT)
In-Reply-To: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

This reverts commit fb0119742291b6f30cd97026ee137b2d3d1f4de8.

Adding fifo merge feature as an omapdss internal configuration was a
mistake. We cannot hide from the users of omapdss the complexities of
fifo merge.

The previous commit removed fifo merge itself, and this removes the
remaining fifo merge support functions.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   43 ---------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 02943a5..32b5379 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -111,9 +111,6 @@ static struct {
 	struct ovl_priv_data ovl_priv_data_array[MAX_DSS_OVERLAYS];
 	struct mgr_priv_data mgr_priv_data_array[MAX_DSS_MANAGERS];
 
-	bool fifo_merge_dirty;
-	bool fifo_merge;
-
 	bool irq_enabled;
 } dss_data;
 
@@ -677,40 +674,11 @@ static void dss_mgr_write_regs_extra(struct omap_overlay_manager *mgr)
 		mp->shadow_extra_info_dirty = true;
 }
 
-static void dss_write_regs_common(void)
-{
-	const int num_mgrs = omap_dss_get_num_overlay_managers();
-	int i;
-
-	if (!dss_data.fifo_merge_dirty)
-		return;
-
-	for (i = 0; i < num_mgrs; ++i) {
-		struct omap_overlay_manager *mgr;
-		struct mgr_priv_data *mp;
-
-		mgr = omap_dss_get_overlay_manager(i);
-		mp = get_mgr_priv(mgr);
-
-		if (mp->enabled) {
-			if (dss_data.fifo_merge_dirty) {
-				dispc_enable_fifomerge(dss_data.fifo_merge);
-				dss_data.fifo_merge_dirty = false;
-			}
-
-			if (mp->updating)
-				mp->shadow_info_dirty = true;
-		}
-	}
-}
-
 static void dss_write_regs(void)
 {
 	const int num_mgrs = omap_dss_get_num_overlay_managers();
 	int i;
 
-	dss_write_regs_common();
-
 	for (i = 0; i < num_mgrs; ++i) {
 		struct omap_overlay_manager *mgr;
 		struct mgr_priv_data *mp;
@@ -799,8 +767,6 @@ void dss_mgr_start_update(struct omap_overlay_manager *mgr)
 	dss_mgr_write_regs(mgr);
 	dss_mgr_write_regs_extra(mgr);
 
-	dss_write_regs_common();
-
 	mp->updating = true;
 
 	if (!dss_data.irq_enabled && need_isr())
@@ -984,15 +950,6 @@ static void dss_apply_ovl_fifo_thresholds(struct omap_overlay *ovl,
 	op->extra_info_dirty = true;
 }
 
-static void dss_apply_fifo_merge(bool use_fifo_merge)
-{
-	if (dss_data.fifo_merge == use_fifo_merge)
-		return;
-
-	dss_data.fifo_merge = use_fifo_merge;
-	dss_data.fifo_merge_dirty = true;
-}
-
 static void dss_ovl_setup_fifo(struct omap_overlay *ovl)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
-- 
1.7.9.5

