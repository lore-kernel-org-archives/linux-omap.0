From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 03/29] OMAPDSS: Writeback: Add writeback interface and panel driver
Date: Tue, 27 Dec 2011 18:06:46 +0530
Message-ID: <1324989432-3625-4-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58015 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612Ab1L0Mic (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Dec 2011 07:38:32 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Create a new struct called omap_dss_writeback. This will represent a writeback
pipeline the way omap_overlay and omap_overlay_manager represent overlay and
managers respectively.

Create a writeback interface and a dummy writeback panel driver. The writeback
panel driver is needed for the omap_dss_device pointer which represents
writeback in omap_dss_mgr_output.

Add a omap_dss_device pointer to the omap_dss_writeback struct, and a
omap_dss_writeback pointer in omap_dss_device struct, link the writeback and
dss_device together when the latter is added.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/Makefile       |    2 +-
 drivers/video/omap2/dss/core.c         |    2 +
 drivers/video/omap2/dss/display.c      |    3 +
 drivers/video/omap2/dss/dss.h          |    5 +
 drivers/video/omap2/dss/dss_features.c |    8 +
 drivers/video/omap2/dss/dss_features.h |    1 +
 drivers/video/omap2/dss/writeback.c    |  223 ++++++++++++++++++++++++++++++++
 include/video/omapdss.h                |   13 ++
 8 files changed, 256 insertions(+), 1 deletions(-)
 create mode 100644 drivers/video/omap2/dss/writeback.c

diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index 5c450b0..51c544e 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_OMAP2_DSS) += omapdss.o
 omapdss-y := core.o dss.o dss_features.o dispc.o dispc_coefs.o display.o \
-	manager.o overlay.o apply.o
+	manager.o overlay.o apply.o writeback.o
 omapdss-$(CONFIG_OMAP2_DSS_DPI) += dpi.o
 omapdss-$(CONFIG_OMAP2_DSS_RFBI) += rfbi.o
 omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 5c46430..21bfd0a 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -182,6 +182,7 @@ static int omap_dss_probe(struct platform_device *pdev)
 
 	dss_init_overlay_managers(pdev);
 	dss_init_overlays(pdev);
+	dss_init_writeback();
 
 	r = dss_init_platform_driver();
 	if (r) {
@@ -276,6 +277,7 @@ static int omap_dss_remove(struct platform_device *pdev)
 	dispc_uninit_platform_driver();
 	dss_uninit_platform_driver();
 
+	dss_uninit_writeback();
 	dss_uninit_overlays(pdev);
 	dss_uninit_overlay_managers(pdev);
 
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index be331dc..a712bad 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -391,6 +391,9 @@ void dss_init_device(struct platform_device *pdev,
 	case OMAP_DISPLAY_TYPE_HDMI:
 		r = hdmi_init_display(dssdev);
 		break;
+	case OMAP_DISPLAY_TYPE_WB:
+		r = writeback_init_display(dssdev);
+		break;
 	default:
 		DSSERR("Support for display '%s' not compiled in.\n",
 				dssdev->name);
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 3cf99a9..607e730 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -226,6 +226,11 @@ int dss_ovl_simple_check(struct omap_overlay *ovl,
 int dss_ovl_check(struct omap_overlay *ovl,
 		struct omap_overlay_info *info, struct omap_dss_device *dssdev);
 
+/* writeback */
+void dss_init_writeback(void);
+void dss_uninit_writeback(void);
+int writeback_init_display(struct omap_dss_device *dssdev);
+
 /* DSS */
 int dss_init_platform_driver(void);
 void dss_uninit_platform_driver(void);
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 5e4b829..ca41620 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -45,6 +45,7 @@ struct omap_dss_features {
 
 	const int num_mgrs;
 	const int num_ovls;
+	const int num_wb;
 	const enum omap_display_type *supported_displays;
 	const enum omap_color_mode *supported_color_modes;
 	const enum omap_overlay_caps *overlay_caps;
@@ -423,6 +424,7 @@ static const struct omap_dss_features omap4430_es1_0_dss_features  = {
 
 	.num_mgrs = 3,
 	.num_ovls = 4,
+	.num_wb = 1,
 	.supported_displays = omap4_dss_supported_displays,
 	.supported_color_modes = omap4_dss_supported_color_modes,
 	.overlay_caps = omap4_dss_overlay_caps,
@@ -447,6 +449,7 @@ static const struct omap_dss_features omap4_dss_features = {
 
 	.num_mgrs = 3,
 	.num_ovls = 4,
+	.num_wb = 1,
 	.supported_displays = omap4_dss_supported_displays,
 	.supported_color_modes = omap4_dss_supported_color_modes,
 	.overlay_caps = omap4_dss_overlay_caps,
@@ -493,6 +496,11 @@ int dss_feat_get_num_ovls(void)
 	return omap_current_dss_features->num_ovls;
 }
 
+int dss_feat_get_num_wb(void)
+{
+	return omap_current_dss_features->num_wb;
+}
+
 unsigned long dss_feat_get_param_min(enum dss_range_param param)
 {
 	return omap_current_dss_features->dss_params[param].min;
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index cd833bb..75ee1f1 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -92,6 +92,7 @@ enum dss_range_param {
 /* DSS Feature Functions */
 int dss_feat_get_num_mgrs(void);
 int dss_feat_get_num_ovls(void);
+int dss_feat_get_num_wb(void);
 unsigned long dss_feat_get_param_min(enum dss_range_param param);
 unsigned long dss_feat_get_param_max(enum dss_range_param param);
 enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel);
diff --git a/drivers/video/omap2/dss/writeback.c b/drivers/video/omap2/dss/writeback.c
new file mode 100644
index 0000000..ac5d3ba
--- /dev/null
+++ b/drivers/video/omap2/dss/writeback.c
@@ -0,0 +1,223 @@
+/*
+ * Copyright (C) 2011 Texas Instruments
+ * Author: Archit Taneja <archit@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define DSS_SUBSYS_NAME "WRITEBACK"
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/sysfs.h>
+
+#include <video/omapdss.h>
+
+#include "dss.h"
+#include "dss_features.h"
+
+static int num_writeback, num_wb_panels;
+static struct omap_dss_writeback *writeback;
+static struct omap_dss_driver writeback_panel_driver;
+
+static int dss_writeback_enable(struct omap_dss_writeback *wb)
+{
+	int r;
+
+	r = dispc_runtime_get();
+	if (r)
+		return r;
+
+	return 0;
+}
+
+static void dss_writeback_disable(struct omap_dss_writeback *wb)
+{
+	dispc_runtime_put();
+}
+
+struct omap_dss_writeback *omap_dss_get_writeback(int id)
+{
+	if (id >= num_writeback)
+		return NULL;
+
+	return &writeback[id];
+}
+EXPORT_SYMBOL(omap_dss_get_writeback);
+
+int omap_dss_get_num_writeback(void)
+{
+	return num_writeback;
+}
+EXPORT_SYMBOL(omap_dss_get_num_writeback);
+
+void dss_init_writeback(void)
+{
+	int i;
+
+	num_writeback = dss_feat_get_num_wb();
+
+	writeback = kzalloc(sizeof(struct omap_dss_writeback) * num_writeback,
+		GFP_KERNEL);
+
+	BUG_ON(writeback == NULL);
+
+	for (i = 0; i < num_writeback; i++) {
+		struct omap_dss_writeback *wb = &writeback[i];
+
+		wb->id = i;
+	}
+
+	omap_dss_register_driver(&writeback_panel_driver);
+}
+
+void dss_uninit_writeback(void)
+{
+	kfree(writeback);
+	writeback = NULL;
+	num_writeback = 0;
+
+	omap_dss_unregister_driver(&writeback_panel_driver);
+}
+
+int writeback_init_display(struct omap_dss_device *dssdev)
+{
+	struct omap_dss_writeback *wb;
+
+	DSSDBG("init_display\n");
+
+	if (num_wb_panels >= num_writeback)
+		return -EINVAL;
+
+	wb = omap_dss_get_writeback(num_wb_panels++);
+
+	wb->dssdev = dssdev;
+	dssdev->wbdev = wb;
+
+	return 0;
+}
+
+/* Dummy Writeback Panel driver */
+
+static int writeback_panel_probe(struct omap_dss_device *dssdev)
+{
+	return 0;
+}
+
+static void __exit writeback_panel_remove(struct omap_dss_device *dssdev)
+{
+}
+
+static int writeback_panel_power_on(struct omap_dss_device *dssdev)
+{
+	int r;
+
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
+		return 0;
+
+	r = dss_writeback_enable(dssdev->wbdev);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+static void writeback_panel_power_off(struct omap_dss_device *dssdev)
+{
+	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
+		return;
+
+	dss_writeback_disable(dssdev->wbdev);
+}
+
+static int writeback_panel_enable(struct omap_dss_device *dssdev)
+{
+	int r;
+
+	r = writeback_panel_power_on(dssdev);
+	if (r)
+		return r;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
+}
+
+static void writeback_panel_disable(struct omap_dss_device *dssdev)
+{
+	writeback_panel_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+}
+
+static int writeback_panel_suspend(struct omap_dss_device *dssdev)
+{
+	writeback_panel_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
+
+	return 0;
+}
+
+static int writeback_panel_resume(struct omap_dss_device *dssdev)
+{
+	int r;
+
+	r = writeback_panel_power_on(dssdev);
+	if (r)
+		return r;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
+}
+
+static void writeback_panel_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	dssdev->panel.timings.x_res = timings->x_res;
+	dssdev->panel.timings.y_res = timings->y_res;
+}
+
+static void writeback_panel_get_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	*timings = dssdev->panel.timings;
+}
+
+static int writeback_panel_check_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	return 0;
+}
+
+static struct omap_dss_driver writeback_panel_driver = {
+	.probe = writeback_panel_probe,
+	.remove = writeback_panel_remove,
+
+	.enable = writeback_panel_enable,
+	.disable = writeback_panel_disable,
+	.suspend = writeback_panel_suspend,
+	.resume = writeback_panel_resume,
+
+	.set_timings = writeback_panel_set_timings,
+	.get_timings = writeback_panel_get_timings,
+	.check_timings = writeback_panel_check_timings,
+
+	.driver = {
+		.name = "writeback",
+		.owner = THIS_MODULE,
+	},
+};
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 93a1cd3..77e2ca4 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -60,6 +60,7 @@ enum omap_display_type {
 	OMAP_DISPLAY_TYPE_DSI		= 1 << 3,
 	OMAP_DISPLAY_TYPE_VENC		= 1 << 4,
 	OMAP_DISPLAY_TYPE_HDMI		= 1 << 5,
+	OMAP_DISPLAY_TYPE_WB		= 1 << 6,
 };
 
 enum omap_plane {
@@ -471,6 +472,13 @@ struct omap_overlay_manager {
 	struct omap_dss_device *(*get_writeback)(struct omap_overlay_manager *mgr);
 };
 
+struct omap_dss_writeback {
+	int id;
+
+	/* dummy panel we are connected to */
+	struct omap_dss_device *dssdev;
+};
+
 struct omap_dss_device {
 	struct device dev;
 
@@ -584,6 +592,8 @@ struct omap_dss_device {
 
 	struct omap_overlay_manager *manager;
 
+	struct omap_dss_writeback *wbdev;
+
 	enum omap_dss_display_state state;
 
 	/* platform specific  */
@@ -661,6 +671,9 @@ struct omap_overlay_manager *omap_dss_get_overlay_manager(int num);
 int omap_dss_get_num_overlays(void);
 struct omap_overlay *omap_dss_get_overlay(int num);
 
+struct omap_dss_writeback *omap_dss_get_writeback(int id);
+int omap_dss_get_num_writeback(void);
+
 void omapdss_default_get_resolution(struct omap_dss_device *dssdev,
 		u16 *xres, u16 *yres);
 int omapdss_default_get_recommended_bpp(struct omap_dss_device *dssdev);
-- 
1.7.4.1

