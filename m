From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/26] OMAPDSS: Add panel_dev pointer to dssdev
Date: Tue, 26 Mar 2013 15:33:41 +0200
Message-ID: <1364304836-18134-12-git-send-email-tomi.valkeinen@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55865 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934241Ab3CZNer (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 09:34:47 -0400
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We are about to remove the dss bus support, which also means that the
omap_dss_device won't be a real device anymore. This means that the
embedded "dev" struct needs to be removed from omap_dss_device.

After we've finished the removal of the dss bus, we see the following
changes:

- struct omap_dss_device won't be a real Linux device anymore, but more
  like a "display entity".
- struct omap_dss_driver won't be a Linux device driver, but "display
  entity ops".
- The panel devices/drivers won't be omapdss devices/drivers, but
  platform/i2c/spi/etc devices/drivers, whichever fits the control
  mechanism of the panel.
- The panel drivers will create omap_dss_device and omap_dss_driver,
  fill the required fields, and register the omap_dss_device to
  omapdss.
- omap_dss_device won't have an embedded dev struct anymore, but a
  dev pointer to the actual device that manages the omap_dss_device.

The model described above resembles the model that has been discussed
with CDF (common display framework).

For the duration of the conversion, we temporarily have two devs in the
dssdev, the old "dev", which is a full embedded device struct, and the
new "panel_dev", which is a pointer to the device. "dev" will be removed
in the future, and "panel_dev" will be renamed "dev".

For devices belonging to dss bus the panel_dev is initialized to point
to dev. This way all the code can just use the panel_dev, for both old
and new style panels.

Both the new and old style panel drivers work during the conversion, and
only after the dss bus support is removed will the old style panels stop
to compile.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c          |    2 ++
 drivers/video/omap2/dss/display-sysfs.c |    7 ++++---
 drivers/video/omap2/dss/display.c       |    8 ++++----
 include/video/omapdss.h                 |    4 ++++
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 054e980..5a6ac3b 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -400,6 +400,8 @@ struct omap_dss_device *dss_alloc_and_init_device(struct device *parent)
 
 int dss_add_device(struct omap_dss_device *dssdev)
 {
+	dssdev->panel_dev = &dssdev->dev;
+
 	dss_add_panel(dssdev);
 	return device_add(&dssdev->dev);
 }
diff --git a/drivers/video/omap2/dss/display-sysfs.c b/drivers/video/omap2/dss/display-sysfs.c
index 537921b..af90bff 100644
--- a/drivers/video/omap2/dss/display-sysfs.c
+++ b/drivers/video/omap2/dss/display-sysfs.c
@@ -33,7 +33,7 @@ static struct omap_dss_device *to_dss_device_sysfs(struct device *dev)
 	struct omap_dss_device *dssdev = NULL;
 
 	for_each_dss_dev(dssdev) {
-		if (&dssdev->dev == dev) {
+		if (dssdev->panel_dev == dev) {
 			omap_dss_put_device(dssdev);
 			return dssdev;
 		}
@@ -304,7 +304,7 @@ int display_init_sysfs(struct platform_device *pdev)
 	int r;
 
 	for_each_dss_dev(dssdev) {
-		struct kobject *kobj = &dssdev->dev.kobj;
+		struct kobject *kobj = &dssdev->panel_dev->kobj;
 
 		r = sysfs_create_files(kobj, display_sysfs_attrs);
 		if (r) {
@@ -335,6 +335,7 @@ void display_uninit_sysfs(struct platform_device *pdev)
 
 	for_each_dss_dev(dssdev) {
 		sysfs_remove_link(&pdev->dev.kobj, dssdev->alias);
-		sysfs_remove_files(&dssdev->dev.kobj, display_sysfs_attrs);
+		sysfs_remove_files(&dssdev->panel_dev->kobj,
+				display_sysfs_attrs);
 	}
 }
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 85e1cd3..fbadefe 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -158,13 +158,13 @@ void dss_remove_panel(struct omap_dss_device *dssdev)
 
 void omap_dss_get_device(struct omap_dss_device *dssdev)
 {
-	get_device(&dssdev->dev);
+	get_device(dssdev->panel_dev);
 }
 EXPORT_SYMBOL(omap_dss_get_device);
 
 void omap_dss_put_device(struct omap_dss_device *dssdev)
 {
-	put_device(&dssdev->dev);
+	put_device(dssdev->panel_dev);
 }
 EXPORT_SYMBOL(omap_dss_put_device);
 
@@ -243,7 +243,7 @@ int omap_dss_start_device(struct omap_dss_device *dssdev)
 		return -ENODEV;
 	}
 
-	if (!try_module_get(dssdev->dev.driver->owner)) {
+	if (!try_module_get(dssdev->panel_dev->driver->owner)) {
 		return -ENODEV;
 	}
 
@@ -253,7 +253,7 @@ EXPORT_SYMBOL(omap_dss_start_device);
 
 void omap_dss_stop_device(struct omap_dss_device *dssdev)
 {
-	module_put(dssdev->dev.driver->owner);
+	module_put(dssdev->panel_dev->driver->owner);
 }
 EXPORT_SYMBOL(omap_dss_stop_device);
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index ab4ea37..ab36ee3 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -594,8 +594,12 @@ struct omap_dss_output {
 };
 
 struct omap_dss_device {
+	/* old device, to be removed */
 	struct device dev;
 
+	/* new device, pointer to panel device */
+	struct device *panel_dev;
+
 	struct list_head panel_list;
 
 	/* alias in the form of "display%d" */
-- 
1.7.10.4

