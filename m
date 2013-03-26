From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/26] OMAPDSS: add panel list
Date: Tue, 26 Mar 2013 15:33:37 +0200
Message-ID: <1364304836-18134-8-git-send-email-tomi.valkeinen@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36234 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934238Ab3CZNel (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 09:34:41 -0400
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We currently use the omapdss bus (which contains all the available
displays) to iterate the displays. As the omapdss bus is on its way out,
this needs to be changed.

Instead of using the dss bus to iterate displays, this patch adds our
own list of displays which we manage. The panels on the dss bus are
automatically added to this new list.

An "alias" field is also added to omap_dss_device. This field is
set to "display%d", the same way as omap_dss_device's dev name is set.
This alias is later used to keep backward compatibility, when the
embedded dev is no longer used.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c    |    2 ++
 drivers/video/omap2/dss/display.c |   30 ++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h     |    3 +++
 include/video/omapdss.h           |    5 +++++
 4 files changed, 40 insertions(+)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index a9bab9f..5bdd442 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -428,6 +428,7 @@ struct omap_dss_device *dss_alloc_and_init_device(struct device *parent)
 
 int dss_add_device(struct omap_dss_device *dssdev)
 {
+	dss_add_panel(dssdev);
 	return device_add(&dssdev->dev);
 }
 
@@ -439,6 +440,7 @@ void dss_put_device(struct omap_dss_device *dssdev)
 void dss_unregister_device(struct omap_dss_device *dssdev)
 {
 	device_unregister(&dssdev->dev);
+	dss_remove_panel(dssdev);
 }
 
 static int dss_unregister_dss_dev(struct device *dev, void *data)
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 0aa8ad8..e785694 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -146,6 +146,36 @@ void dss_disable_all_devices(void)
 	bus_for_each_dev(bus, NULL, NULL, dss_disable_device);
 }
 
+static LIST_HEAD(panel_list);
+static DEFINE_MUTEX(panel_list_mutex);
+static int disp_num_counter;
+
+int dss_add_panel(struct omap_dss_device *dssdev)
+{
+	struct omap_dss_driver *drv = dssdev->driver;
+
+	snprintf(dssdev->alias, sizeof(dssdev->alias),
+			"display%d", disp_num_counter++);
+
+	if (drv && drv->get_resolution == NULL)
+		drv->get_resolution = omapdss_default_get_resolution;
+	if (drv && drv->get_recommended_bpp == NULL)
+		drv->get_recommended_bpp = omapdss_default_get_recommended_bpp;
+	if (drv && drv->get_timings == NULL)
+		drv->get_timings = omapdss_default_get_timings;
+
+	mutex_lock(&panel_list_mutex);
+	list_add_tail(&dssdev->panel_list, &panel_list);
+	mutex_unlock(&panel_list_mutex);
+	return 0;
+}
+
+void dss_remove_panel(struct omap_dss_device *dssdev)
+{
+	mutex_lock(&panel_list_mutex);
+	list_del(&dssdev->panel_list);
+	mutex_unlock(&panel_list_mutex);
+}
 
 void omap_dss_get_device(struct omap_dss_device *dssdev)
 {
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index faaf358..5252423 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -489,4 +489,7 @@ static inline void dss_collect_irq_stats(u32 irqstatus, unsigned *irq_arr)
 }
 #endif
 
+int dss_add_panel(struct omap_dss_device *dssdev);
+void dss_remove_panel(struct omap_dss_device *dssdev);
+
 #endif
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 7fe6144..ab4ea37 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -596,6 +596,11 @@ struct omap_dss_output {
 struct omap_dss_device {
 	struct device dev;
 
+	struct list_head panel_list;
+
+	/* alias in the form of "display%d" */
+	char alias[16];
+
 	enum omap_display_type type;
 
 	/* obsolete, to be removed */
-- 
1.7.10.4

