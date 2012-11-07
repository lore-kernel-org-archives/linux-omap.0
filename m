From: Archit Taneja <archit@ti.com>
Subject: [RFC 04/11] OMAPDSS: writeback: Configure writeback input size
Date: Wed, 7 Nov 2012 20:14:22 +0530
Message-ID: <1352299469-17609-5-git-send-email-archit@ti.com>
References: <n>
 <1352299469-17609-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47554 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753719Ab2KGOpE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 09:45:04 -0500
In-Reply-To: <1352299469-17609-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The input to the writeback piepline comes from an overlay manager or an overlay
in mem to mem mode. In both cases the input size configured for writeback should
be the size of the overlay or overlay manager output.

We ignore the case of direct connections between an overlay and writeback for
now. Assuming that writeback output connected only to a manager, we need to
ensure that the manger dimensions change when the user tries to change
writeback's input size.

This is achieved by the output driver calling dss_mgr_set_timings. When applying
the manager timings, we also dirty the writeback_info cache so that the next
writeback update will incorporate the new manager timings. In effect, we don't
maintain private data/cache for the input size of writeback as it's always equal
to the manager's input size. However, we take care of updating the writeback
registers whenever we change the manager's input size.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c     |   18 ++++++++++++++++++
 drivers/video/omap2/dss/writeback.c |   31 +++++++++++++++++++++++++++++++
 include/video/omapdss.h             |    1 +
 3 files changed, 50 insertions(+)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 76886da..8fe7fce 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -223,6 +223,11 @@ static bool wb_manual_update(struct omap_dss_output *wb)
 	return true;
 }
 
+static bool output_is_wb(struct omap_dss_output *out)
+{
+	return out ? out->id == OMAP_DSS_OUTPUT_WB : false;
+}
+
 static int dss_check_settings_low(struct omap_overlay_manager *mgr,
 		bool applying)
 {
@@ -1226,6 +1231,19 @@ static void dss_apply_mgr_timings(struct omap_overlay_manager *mgr,
 
 	mp->timings = *timings;
 	mp->extra_info_dirty = true;
+
+	/*
+	 * If the connected output is writeback, and if the width or height of
+	 * the overlay manager change, writeback's input size needs to be
+	 * changed too. Dirty the writeback info so that it's reconfigured
+	 * along with the manager timings change.
+	 */
+	if (output_is_wb(mgr->output)) {
+		struct omap_dss_output *wb = mgr->output;
+		struct wb_priv_data *wp = get_wb_priv(wb);
+
+		wp->info_dirty = true;
+	}
 }
 
 void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
diff --git a/drivers/video/omap2/dss/writeback.c b/drivers/video/omap2/dss/writeback.c
index c05dd54..9a80f72 100644
--- a/drivers/video/omap2/dss/writeback.c
+++ b/drivers/video/omap2/dss/writeback.c
@@ -30,6 +30,12 @@ struct writeback_data {
 	struct mutex lock;
 
 	struct omap_dss_output output;
+	/*
+	 * timings of manager to which writeback is connected, only configured
+	 * by writeback driver in mem to mem mode. In capture mode, manager
+	 * timings will be configured by the display interface.
+	 */
+	struct omap_video_timings input_timings;
 };
 
 static inline struct writeback_data *writeback_get_drv_data(struct platform_device *wbdev)
@@ -42,6 +48,23 @@ static inline struct platform_device *writeback_get_wbdev_from_output(struct oma
 	return out->pdev;
 }
 
+void omapdss_writeback_set_input_size(struct omap_dss_output *wb, u16 w, u16 h)
+{
+	struct platform_device *wbdev = writeback_get_wbdev_from_output(wb);
+	struct writeback_data *wb_data = writeback_get_drv_data(wbdev);
+
+	mutex_lock(&wb_data->lock);
+
+	wb_data->input_timings.x_res = w;
+	wb_data->input_timings.y_res = h;
+
+	if (wb->manager)
+		dss_mgr_set_timings(wb->manager, &wb_data->input_timings);
+
+	mutex_unlock(&wb_data->lock);
+}
+EXPORT_SYMBOL(omapdss_writeback_set_input_size);
+
 int omapdss_writeback_apply(struct omap_dss_output *wb)
 {
 	return omap_dss_wb_apply(wb);
@@ -92,6 +115,14 @@ static int __init omap_writeback_probe(struct platform_device *pdev)
 
 	mutex_init(&wb_data->lock);
 
+	/* initialize with dummy timings */
+	wb_data->input_timings = (struct omap_video_timings)
+		{ 640, 480, 0, 1, 1, 1, 1, 0, 0, false,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
+			OMAPDSS_DRIVE_SIG_RISING_EDGE, OMAPDSS_SIG_ACTIVE_HIGH,
+			OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
+		};
+
 	writeback_init_output(pdev, wb_data);
 
 	return 0;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 2bc10cb..d8064ed 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -837,6 +837,7 @@ void omapdss_rfbi_set_data_lines(struct omap_dss_device *dssdev,
 void omapdss_rfbi_set_interface_timings(struct omap_dss_device *dssdev,
 		struct rfbi_timings *timings);
 
+void omapdss_writeback_set_input_size(struct omap_dss_output *wb, u16 w, u16 h);
 int omapdss_writeback_apply(struct omap_dss_output *wb);
 int omapdss_writeback_set_info(struct omap_dss_output *wb,
 		struct omap_dss_writeback_info *info);
-- 
1.7.9.5

