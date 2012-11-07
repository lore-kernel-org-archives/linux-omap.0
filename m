From: Archit Taneja <archit@ti.com>
Subject: [RFC 03/11] OMAPDSS: APPLY: Apply writeback configurations
Date: Wed, 7 Nov 2012 20:14:21 +0530
Message-ID: <1352299469-17609-4-git-send-email-archit@ti.com>
References: <n>
 <1352299469-17609-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50622 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753700Ab2KGOpA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 09:45:00 -0500
In-Reply-To: <1352299469-17609-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Add changes in apply to let a user apply writeback configurations. This
basically involves a writeback user to commit the writeback_info it has set
previously.

Only memory to memory mode is supported for now in APPLY. Actual register
writes would only happen when a mem to mem update is initiated. Therefore,
there isn't a need to support the cases of shadow registers being dirty.

Add the following:
- info and info_dirty fields in private data to represent the lower cache of
  writeback info in APPLY.
- Function omap_dss_wb_apply which propagates user_info to info, and an
  equivalent function in writeback output driver exposed to writeback users.
- Function dss_wb_write_regs to be used by APPLY to configure writeback DISPC
  registers.
- Helper function which tells the mode of writeback.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c     |   68 +++++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h       |    1 +
 drivers/video/omap2/dss/writeback.c |    6 ++++
 include/video/omapdss.h             |    1 +
 4 files changed, 76 insertions(+)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index b2e4f6a..76886da 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -110,6 +110,15 @@ struct wb_priv_data {
 
 	bool user_info_dirty;
 	struct omap_dss_writeback_info user_info;
+
+	bool info_dirty;
+	struct omap_dss_writeback_info info;
+
+	/*
+	 * If true in memory to memory mode, a manager is connected to it.
+	 * However, it may not be active.
+	 */
+	bool enabled;
 };
 
 static struct {
@@ -209,6 +218,11 @@ static bool mgr_manual_update(struct omap_overlay_manager *mgr)
 	return mp->lcd_config.stallmode;
 }
 
+static bool wb_manual_update(struct omap_dss_output *wb)
+{
+	return true;
+}
+
 static int dss_check_settings_low(struct omap_overlay_manager *mgr,
 		bool applying)
 {
@@ -684,6 +698,36 @@ static void dss_mgr_write_regs_extra(struct omap_overlay_manager *mgr)
 		mp->shadow_extra_info_dirty = true;
 }
 
+static void dss_wb_write_regs(struct omap_dss_output *wb)
+{
+	struct wb_priv_data *wp = get_wb_priv(wb);
+	struct omap_dss_writeback_info *wi;
+	struct mgr_priv_data *mp;
+	u32 fifo_low, fifo_high;
+	bool use_fifo_merge = false;
+	int r;
+
+	if (!wp->enabled || !wp->info_dirty)
+		return;
+
+	wi = &wp->info;
+
+	mp = get_mgr_priv(wb->manager);
+
+	dispc_ovl_compute_fifo_thresholds(OMAP_DSS_WB, &fifo_low, &fifo_high,
+			use_fifo_merge, wb_manual_update(wb));
+
+	dispc_ovl_set_fifo_threshold(OMAP_DSS_WB, fifo_low, fifo_high);
+
+	r = dispc_wb_setup(wi, wb_manual_update(wb), &mp->timings);
+	if (r) {
+		DSSERR("dispc_wb_setup failed %d\n", r);
+		return;
+	}
+
+	wp->info_dirty = false;
+}
+
 static void dss_write_regs(void)
 {
 	const int num_mgrs = omap_dss_get_num_overlay_managers();
@@ -1507,3 +1551,27 @@ void dss_wb_get_info(struct omap_dss_output *wb,
 
 	spin_unlock_irqrestore(&data_lock, flags);
 }
+
+int omap_dss_wb_apply(struct omap_dss_output *wb)
+{
+	struct wb_priv_data *wp = get_wb_priv(wb);
+	unsigned long flags;
+
+	DSSDBG("omap_dss_wb_apply\n");
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	/* check for settings here */
+
+	if (!wp->user_info_dirty)
+		goto end;
+
+	wp->user_info_dirty = false;
+	wp->info_dirty = true;
+	wp->info = wp->user_info;
+
+end:
+	spin_unlock_irqrestore(&data_lock, flags);
+
+	return 0;
+}
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index f738c1e..1b9c936 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -214,6 +214,7 @@ int dss_wb_set_info(struct omap_dss_output *wb,
 		struct omap_dss_writeback_info *info);
 void dss_wb_get_info(struct omap_dss_output *wb,
 		struct omap_dss_writeback_info *info);
+int omap_dss_wb_apply(struct omap_dss_output *wb);
 
 /* output */
 void dss_register_output(struct omap_dss_output *out);
diff --git a/drivers/video/omap2/dss/writeback.c b/drivers/video/omap2/dss/writeback.c
index be7027b..c05dd54 100644
--- a/drivers/video/omap2/dss/writeback.c
+++ b/drivers/video/omap2/dss/writeback.c
@@ -42,6 +42,12 @@ static inline struct platform_device *writeback_get_wbdev_from_output(struct oma
 	return out->pdev;
 }
 
+int omapdss_writeback_apply(struct omap_dss_output *wb)
+{
+	return omap_dss_wb_apply(wb);
+}
+EXPORT_SYMBOL(omapdss_writeback_apply);
+
 int omapdss_writeback_set_info(struct omap_dss_output *wb,
 		struct omap_dss_writeback_info *info)
 {
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 2a3a878..2bc10cb 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -837,6 +837,7 @@ void omapdss_rfbi_set_data_lines(struct omap_dss_device *dssdev,
 void omapdss_rfbi_set_interface_timings(struct omap_dss_device *dssdev,
 		struct rfbi_timings *timings);
 
+int omapdss_writeback_apply(struct omap_dss_output *wb);
 int omapdss_writeback_set_info(struct omap_dss_output *wb,
 		struct omap_dss_writeback_info *info);
 void omapdss_writeback_get_info(struct omap_dss_output *wb,
-- 
1.7.9.5

