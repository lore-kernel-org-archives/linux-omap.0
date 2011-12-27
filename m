From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 07/29] OMAPDSS: APPLY: Add extra_info for writeback
Date: Tue, 27 Dec 2011 18:06:50 +0530
Message-ID: <1324989432-3625-8-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58022 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621Ab1L0Mis (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Dec 2011 07:38:48 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Like overlays, writeback pipeline has a a FIFO and a channel which shouldn't
be configured along with the other info struct. Introduce flags extra_info
dirty and shadow_dirty flags. Configure them like done for overlays.

No extra parameters have been added for now. They will be added on later.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |   48 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 5263ae7..ff0baeb 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -111,6 +111,9 @@ struct wb_priv_data {
 
 	bool shadow_info_dirty;
 
+	bool extra_info_dirty;
+	bool shadow_extra_info_dirty;
+
 	/* If true, GO bit is up and shadow registers cannot be written.
 	 * Never true for writeback in memory to memory mode */
 	bool busy;
@@ -335,6 +338,12 @@ static bool need_isr(void)
 				if (wp->shadow_info_dirty)
 					return true;
 
+				if (wp->extra_info_dirty)
+					return true;
+
+				if (wp->shadow_extra_info_dirty)
+					return true;
+
 			}
 		}
 	}
@@ -368,7 +377,7 @@ static bool need_wb_go(struct omap_dss_writeback *wb)
 
 	wp = get_wb_priv(wb);
 
-	if (wp->shadow_info_dirty)
+	if (wp->shadow_info_dirty || wp->shadow_extra_info_dirty)
 		return true;
 
 	return false;
@@ -378,6 +387,7 @@ static bool need_wb_go(struct omap_dss_writeback *wb)
 static bool extra_info_update_ongoing(void)
 {
 	const int num_ovls = omap_dss_get_num_overlays();
+	const int num_wb = dss_feat_get_num_wb();
 	struct ovl_priv_data *op;
 	struct omap_overlay *ovl;
 	struct mgr_priv_data *mp;
@@ -402,6 +412,27 @@ static bool extra_info_update_ongoing(void)
 			return true;
 	}
 
+	for (i = 0; i < num_wb; ++i) {
+		struct omap_dss_writeback *wb;
+		struct wb_priv_data *wp;
+
+		wb = omap_dss_get_writeback(i);
+		wp = get_wb_priv(wb);
+		mp = get_mgr_priv(wb->dssdev->manager);
+
+		if (!mp->enabled)
+			continue;
+
+		if (!mp->updating)
+			continue;
+
+		if (!wp->enabled)
+			continue;
+
+		if (wp->extra_info_dirty || wp->shadow_extra_info_dirty)
+			return true;
+	}
+
 	return false;
 }
 
@@ -644,6 +675,19 @@ static void dss_wb_write_regs(struct omap_dss_writeback *wb)
 	wp->shadow_info_dirty = true;
 }
 
+static void dss_wb_write_regs_extra(struct omap_dss_writeback *wb)
+{
+	struct wb_priv_data *wp = get_wb_priv(wb);
+
+	if (!wp->extra_info_dirty)
+		return;
+
+	/* Write extra registers here */
+
+	wp->extra_info_dirty = false;
+	wp->shadow_extra_info_dirty = true;
+}
+
 static void dss_mgr_write_regs(struct omap_overlay_manager *mgr)
 {
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
@@ -716,6 +760,7 @@ static void dss_write_regs(void)
 			continue;
 
 		dss_wb_write_regs(wb);
+		dss_wb_write_regs_extra(wb);
 	}
 }
 
@@ -867,6 +912,7 @@ static void wb_clear_shadow_dirty(struct omap_dss_writeback *wb)
 
 	wp = get_wb_priv(wb);
 	wp->shadow_info_dirty = false;
+	wp->shadow_extra_info_dirty = false;
 }
 
 static void dss_apply_irq_handler(void *data, u32 mask)
-- 
1.7.4.1

