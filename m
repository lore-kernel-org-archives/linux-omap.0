From: Archit Taneja <archit@ti.com>
Subject: [RFC 02/11] OMAPDSS: APPLY: Add get/set info functions for writeback
Date: Wed, 7 Nov 2012 20:14:20 +0530
Message-ID: <1352299469-17609-3-git-send-email-archit@ti.com>
References: <n>
 <1352299469-17609-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47545 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753530Ab2KGOo6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 09:44:58 -0500
In-Reply-To: <1352299469-17609-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Writeback contains overlay-like parameters which need to be applied by a user
of writeback.

Create functions in APPLY which get and set user_info of type
omap_dss_writeback_info, these are similar to overlay's dss_ovl_get_info and
dss_ovl_set_info ops. The writeback output driver provides equivalent functions
for a writeback user, these finally call the above APPLY functions.

Add a private data struct for writeback which stores the user_info and it's
state. This struct will be later added with more params to represent the other
levels of the APPLY cache. Add a helper function to retrieve the private data.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c     |   42 +++++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h       |    5 +++++
 drivers/video/omap2/dss/writeback.c |   14 ++++++++++++
 include/video/omapdss.h             |    4 ++++
 4 files changed, 65 insertions(+)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 7a7b820..b2e4f6a 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -106,9 +106,16 @@ struct mgr_priv_data {
 	struct dss_lcd_mgr_config lcd_config;
 };
 
+struct wb_priv_data {
+
+	bool user_info_dirty;
+	struct omap_dss_writeback_info user_info;
+};
+
 static struct {
 	struct ovl_priv_data ovl_priv_data_array[MAX_DSS_OVERLAYS];
 	struct mgr_priv_data mgr_priv_data_array[MAX_DSS_MANAGERS];
+	struct wb_priv_data wb_priv_data;
 
 	bool irq_enabled;
 } dss_data;
@@ -131,6 +138,11 @@ static struct mgr_priv_data *get_mgr_priv(struct omap_overlay_manager *mgr)
 	return &dss_data.mgr_priv_data_array[mgr->id];
 }
 
+static struct wb_priv_data *get_wb_priv(struct omap_dss_output *wb)
+{
+	return &dss_data.wb_priv_data;
+}
+
 void dss_apply_init(void)
 {
 	const int num_ovls = dss_feat_get_num_ovls();
@@ -1465,3 +1477,33 @@ err:
 	return r;
 }
 
+int dss_wb_set_info(struct omap_dss_output *wb,
+		struct omap_dss_writeback_info *info)
+{
+	struct wb_priv_data *wp = get_wb_priv(wb);
+	unsigned long flags;
+
+	/* TODO: Check validity of info */
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	wp->user_info = *info;
+	wp->user_info_dirty = true;
+
+	spin_unlock_irqrestore(&data_lock, flags);
+
+	return 0;
+}
+
+void dss_wb_get_info(struct omap_dss_output *wb,
+		struct omap_dss_writeback_info *info)
+{
+	struct wb_priv_data *wp = get_wb_priv(wb);
+	unsigned long flags;
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	*info = wp->user_info;
+
+	spin_unlock_irqrestore(&data_lock, flags);
+}
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index f7eb7d6..f738c1e 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -210,6 +210,11 @@ int dss_ovl_set_manager(struct omap_overlay *ovl,
 		struct omap_overlay_manager *mgr);
 int dss_ovl_unset_manager(struct omap_overlay *ovl);
 
+int dss_wb_set_info(struct omap_dss_output *wb,
+		struct omap_dss_writeback_info *info);
+void dss_wb_get_info(struct omap_dss_output *wb,
+		struct omap_dss_writeback_info *info);
+
 /* output */
 void dss_register_output(struct omap_dss_output *out);
 void dss_unregister_output(struct omap_dss_output *out);
diff --git a/drivers/video/omap2/dss/writeback.c b/drivers/video/omap2/dss/writeback.c
index b5c6406..be7027b 100644
--- a/drivers/video/omap2/dss/writeback.c
+++ b/drivers/video/omap2/dss/writeback.c
@@ -42,6 +42,20 @@ static inline struct platform_device *writeback_get_wbdev_from_output(struct oma
 	return out->pdev;
 }
 
+int omapdss_writeback_set_info(struct omap_dss_output *wb,
+		struct omap_dss_writeback_info *info)
+{
+	return dss_wb_set_info(wb, info);
+}
+EXPORT_SYMBOL(omapdss_writeback_set_info);
+
+void omapdss_writeback_get_info(struct omap_dss_output *wb,
+		struct omap_dss_writeback_info *info)
+{
+	dss_wb_get_info(wb, info);
+}
+EXPORT_SYMBOL(omapdss_writeback_get_info);
+
 struct omap_dss_output *omap_dss_get_writeback(void)
 {
 	return omap_dss_get_output(OMAP_DSS_OUTPUT_WB);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index e81fcb2..2a3a878 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -837,6 +837,10 @@ void omapdss_rfbi_set_data_lines(struct omap_dss_device *dssdev,
 void omapdss_rfbi_set_interface_timings(struct omap_dss_device *dssdev,
 		struct rfbi_timings *timings);
 
+int omapdss_writeback_set_info(struct omap_dss_output *wb,
+		struct omap_dss_writeback_info *info);
+void omapdss_writeback_get_info(struct omap_dss_output *wb,
+		struct omap_dss_writeback_info *info);
 #ifdef CONFIG_OMAP4_DSS_WRITEBACK
 struct omap_dss_output *omap_dss_get_writeback(void);
 #else
-- 
1.7.9.5

