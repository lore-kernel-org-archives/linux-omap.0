From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/27] OMAPDSS: SDI: Add ops
Date: Thu, 30 May 2013 12:36:04 +0300
Message-ID: <1369906580-27585-12-git-send-email-tomi.valkeinen@ti.com>
References: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42839 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030405Ab3E3JhD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 05:37:03 -0400
In-Reply-To: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add "ops" style method for using SDI functionality.

Ops style calls will allow us to have arbitrarily long display
pipelines, where each entity can call ops in the previous display
entity.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/sdi.c | 78 +++++++++++++++++++++++++++++++++++++++++++
 include/video/omapdss.h       | 20 +++++++++++
 2 files changed, 98 insertions(+)

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 0343d08..a676864 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -235,6 +235,26 @@ void omapdss_sdi_set_timings(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_sdi_set_timings);
 
+static void sdi_get_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	*timings = sdi.timings;
+}
+
+static int sdi_check_timings(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings)
+{
+	struct omap_overlay_manager *mgr = sdi.output.manager;
+
+	if (mgr && !dispc_mgr_timings_ok(mgr->id, timings))
+		return -EINVAL;
+
+	if (timings->pixel_clock == 0)
+		return -EINVAL;
+
+	return 0;
+}
+
 void omapdss_sdi_set_datapairs(struct omap_dss_device *dssdev, int datapairs)
 {
 	sdi.datapairs = datapairs;
@@ -339,6 +359,63 @@ static int sdi_probe_pdata(struct platform_device *sdidev)
 	return 0;
 }
 
+static int sdi_connect(struct omap_dss_device *dssdev,
+		struct omap_dss_device *dst)
+{
+	struct omap_overlay_manager *mgr;
+	int r;
+
+	r = sdi_init_regulator();
+	if (r)
+		return r;
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
+static void sdi_disconnect(struct omap_dss_device *dssdev,
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
+static const struct omapdss_sdi_ops sdi_ops = {
+	.connect = sdi_connect,
+	.disconnect = sdi_disconnect,
+
+	.enable = omapdss_sdi_display_enable,
+	.disable = omapdss_sdi_display_disable,
+
+	.check_timings = sdi_check_timings,
+	.set_timings = omapdss_sdi_set_timings,
+	.get_timings = sdi_get_timings,
+
+	.set_datapairs = omapdss_sdi_set_datapairs,
+};
+
 static void sdi_init_output(struct platform_device *pdev)
 {
 	struct omap_dss_device *out = &sdi.output;
@@ -348,6 +425,7 @@ static void sdi_init_output(struct platform_device *pdev)
 	out->output_type = OMAP_DISPLAY_TYPE_SDI;
 	out->name = "sdi.0";
 	out->dispc_channel = OMAP_DSS_CHANNEL_LCD;
+	out->ops.sdi = &sdi_ops;
 	out->owner = THIS_MODULE;
 
 	omapdss_register_output(out);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index d458e43..79e9ec8 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -592,6 +592,25 @@ struct omapdss_dpi_ops {
 	void (*set_data_lines)(struct omap_dss_device *dssdev, int data_lines);
 };
 
+struct omapdss_sdi_ops {
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
+	void (*set_datapairs)(struct omap_dss_device *dssdev, int datapairs);
+};
+
 struct omap_dss_device {
 	/* old device, to be removed */
 	struct device old_dev;
@@ -666,6 +685,7 @@ struct omap_dss_device {
 
 	union {
 		const struct omapdss_dpi_ops *dpi;
+		const struct omapdss_sdi_ops *sdi;
 	} ops;
 
 	/* helper variable for driver suspend/resume */
-- 
1.8.1.2

