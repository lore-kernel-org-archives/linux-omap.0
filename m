From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/6] OMAPDSS: APPLY: add fifo merge support funcs
Date: Fri, 13 Jan 2012 13:46:29 +0200
Message-ID: <1326455193-19716-3-git-send-email-tomi.valkeinen@ti.com>
References: <1326455193-19716-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:60542 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752900Ab2AMLqr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 06:46:47 -0500
In-Reply-To: <1326455193-19716-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add mechanism to set/unset the DISPC fifo-merge:

Add new fields to dss_data, fifo_merge and fifo_merge_dirty. These are
similar to the other info/dirty flags in ovl_priv_data and ovl_mgr_data,
but fifo merge is a common attribute to all managers and thus outside
the ovl_mgr_data.

The fifo-merge field is used in the dss_write_regs_common, which handles
writing the register.

dss_apply_fifo_merge() can be used to set/unset the fifo merge field in
the dss_data.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   43 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 052dc87..604737f 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -105,6 +105,9 @@ static struct {
 	struct ovl_priv_data ovl_priv_data_array[MAX_DSS_OVERLAYS];
 	struct mgr_priv_data mgr_priv_data_array[MAX_DSS_MANAGERS];
 
+	bool fifo_merge_dirty;
+	bool fifo_merge;
+
 	bool irq_enabled;
 } dss_data;
 
@@ -585,11 +588,40 @@ static void dss_mgr_write_regs(struct omap_overlay_manager *mgr)
 	}
 }
 
+static void dss_write_regs_common(void)
+{
+	const int num_mgrs = omap_dss_get_num_overlay_managers();
+	int i;
+
+	if (!dss_data.fifo_merge_dirty)
+		return;
+
+	for (i = 0; i < num_mgrs; ++i) {
+		struct omap_overlay_manager *mgr;
+		struct mgr_priv_data *mp;
+
+		mgr = omap_dss_get_overlay_manager(i);
+		mp = get_mgr_priv(mgr);
+
+		if (mp->enabled) {
+			if (dss_data.fifo_merge_dirty) {
+				dispc_enable_fifomerge(dss_data.fifo_merge);
+				dss_data.fifo_merge_dirty = false;
+			}
+
+			if (mp->updating)
+				mp->shadow_info_dirty = true;
+		}
+	}
+}
+
 static void dss_write_regs(void)
 {
 	const int num_mgrs = omap_dss_get_num_overlay_managers();
 	int i;
 
+	dss_write_regs_common();
+
 	for (i = 0; i < num_mgrs; ++i) {
 		struct omap_overlay_manager *mgr;
 		struct mgr_priv_data *mp;
@@ -659,6 +691,8 @@ void dss_mgr_start_update(struct omap_overlay_manager *mgr)
 
 	dss_mgr_write_regs(mgr);
 
+	dss_write_regs_common();
+
 	mp->updating = true;
 
 	if (!dss_data.irq_enabled && need_isr())
@@ -859,6 +893,15 @@ static void dss_apply_ovl_fifo_thresholds(struct omap_overlay *ovl,
 	op->extra_info_dirty = true;
 }
 
+static void dss_apply_fifo_merge(bool use_fifo_merge)
+{
+	if (dss_data.fifo_merge == use_fifo_merge)
+		return;
+
+	dss_data.fifo_merge = use_fifo_merge;
+	dss_data.fifo_merge_dirty = true;
+}
+
 static void dss_ovl_setup_fifo(struct omap_overlay *ovl)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
-- 
1.7.4.1

