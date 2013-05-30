From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/27] OMAPDSS: DPI: Add ops
Date: Thu, 30 May 2013 12:36:03 +0300
Message-ID: <1369906580-27585-11-git-send-email-tomi.valkeinen@ti.com>
References: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42837 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030422Ab3E3JhC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 05:37:02 -0400
In-Reply-To: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add "ops" style method for using DPI functionality.

Ops style calls will allow us to have arbitrarily long display
pipelines, where each entity can call ops in the previous display
entity.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c | 70 +++++++++++++++++++++++++++++++++++++++++++
 include/video/omapdss.h       | 23 ++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 3299e27..a7d40dd 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -462,6 +462,16 @@ void omapdss_dpi_set_timings(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_dpi_set_timings);
 
+static void dpi_get_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	mutex_lock(&dpi.lock);
+
+	*timings = dpi.timings;
+
+	mutex_unlock(&dpi.lock);
+}
+
 int dpi_check_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
 {
@@ -682,6 +692,65 @@ static int dpi_probe_pdata(struct platform_device *dpidev)
 	return 0;
 }
 
+static int dpi_connect(struct omap_dss_device *dssdev,
+		struct omap_dss_device *dst)
+{
+	struct omap_overlay_manager *mgr;
+	int r;
+
+	r = dpi_init_regulator();
+	if (r)
+		return r;
+
+	dpi_init_pll();
+
+	mgr = omap_dss_get_overlay_manager(dssdev->dispc_channel);
+	if (!mgr)
+		return -ENODEV;
+
+	r = dss_mgr_connect(mgr, dssdev);
+	if (r)
+		return r;
+
+	r = omapdss_output_set_device(dssdev, dst);
+	if (r) {
+		DSSERR("failed to connect output to new device: %s\n",
+				dst->name);
+		dss_mgr_disconnect(mgr, dssdev);
+		return r;
+	}
+
+	return 0;
+}
+
+static void dpi_disconnect(struct omap_dss_device *dssdev,
+		struct omap_dss_device *dst)
+{
+	WARN_ON(dst != dssdev->device);
+
+	if (dst != dssdev->device)
+		return;
+
+	omapdss_output_unset_device(dssdev);
+
+	if (dssdev->manager)
+		dss_mgr_disconnect(dssdev->manager, dssdev);
+}
+
+static const struct omapdss_dpi_ops dpi_ops = {
+	.connect = dpi_connect,
+	.disconnect = dpi_disconnect,
+
+	.enable = omapdss_dpi_display_enable,
+	.disable = omapdss_dpi_display_disable,
+
+	.check_timings = dpi_check_timings,
+	.set_timings = omapdss_dpi_set_timings,
+	.get_timings = dpi_get_timings,
+
+	.set_data_lines = omapdss_dpi_set_data_lines,
+};
+
 static void dpi_init_output(struct platform_device *pdev)
 {
 	struct omap_dss_device *out = &dpi.output;
@@ -691,6 +760,7 @@ static void dpi_init_output(struct platform_device *pdev)
 	out->output_type = OMAP_DISPLAY_TYPE_DPI;
 	out->name = "dpi.0";
 	out->dispc_channel = dpi_get_channel();
+	out->ops.dpi = &dpi_ops;
 	out->owner = THIS_MODULE;
 
 	omapdss_register_output(out);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 6796b0d..d458e43 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -573,6 +573,25 @@ struct omap_dss_writeback_info {
 	u8 pre_mult_alpha;
 };
 
+struct omapdss_dpi_ops {
+	int (*connect)(struct omap_dss_device *dssdev,
+			struct omap_dss_device *dst);
+	void (*disconnect)(struct omap_dss_device *dssdev,
+			struct omap_dss_device *dst);
+
+	int (*enable)(struct omap_dss_device *dssdev);
+	void (*disable)(struct omap_dss_device *dssdev);
+
+	int (*check_timings)(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings);
+	void (*set_timings)(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings);
+	void (*get_timings)(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings);
+
+	void (*set_data_lines)(struct omap_dss_device *dssdev, int data_lines);
+};
+
 struct omap_dss_device {
 	/* old device, to be removed */
 	struct device old_dev;
@@ -645,6 +664,10 @@ struct omap_dss_device {
 
 	struct omap_dss_driver *driver;
 
+	union {
+		const struct omapdss_dpi_ops *dpi;
+	} ops;
+
 	/* helper variable for driver suspend/resume */
 	bool activate_after_resume;
 
-- 
1.8.1.2

