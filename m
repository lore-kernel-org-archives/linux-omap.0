From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 13/15] OMAPDSS: DSS: remove legacy dss bus support
Date: Thu, 29 Aug 2013 16:31:58 +0300
Message-ID: <1377783120-14001-14-git-send-email-tomi.valkeinen@ti.com>
References: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48901 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754636Ab3H2Nc1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:32:27 -0400
In-Reply-To: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

With all the old panels removed and all the old panel model APIs removed
from the DSS encoders, we can now remove the custom omapdss-bus which
was used in the old panel model.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c | 279 +----------------------------------------
 drivers/video/omap2/dss/dss.h  |   9 --
 include/video/omapdss.h        |   6 -
 3 files changed, 3 insertions(+), 291 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 71e6a77..54f3320 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -248,235 +248,6 @@ static struct platform_driver omap_dss_driver = {
 	},
 };
 
-/* BUS */
-static int dss_bus_match(struct device *dev, struct device_driver *driver)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-
-	DSSDBG("bus_match. dev %s/%s, drv %s\n",
-			dev_name(dev), dssdev->driver_name, driver->name);
-
-	return strcmp(dssdev->driver_name, driver->name) == 0;
-}
-
-static struct bus_type dss_bus_type = {
-	.name = "omapdss",
-	.match = dss_bus_match,
-};
-
-static void dss_bus_release(struct device *dev)
-{
-	DSSDBG("bus_release\n");
-}
-
-static struct device dss_bus = {
-	.release = dss_bus_release,
-};
-
-struct bus_type *dss_get_bus(void)
-{
-	return &dss_bus_type;
-}
-
-/* DRIVER */
-static int dss_driver_probe(struct device *dev)
-{
-	int r;
-	struct omap_dss_driver *dssdrv = to_dss_driver(dev->driver);
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-
-	DSSDBG("driver_probe: dev %s/%s, drv %s\n",
-				dev_name(dev), dssdev->driver_name,
-				dssdrv->driver.name);
-
-	r = dssdrv->probe(dssdev);
-
-	if (r) {
-		DSSERR("driver probe failed: %d\n", r);
-		return r;
-	}
-
-	DSSDBG("probe done for device %s\n", dev_name(dev));
-
-	dssdev->driver = dssdrv;
-
-	return 0;
-}
-
-static int dss_driver_remove(struct device *dev)
-{
-	struct omap_dss_driver *dssdrv = to_dss_driver(dev->driver);
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-
-	DSSDBG("driver_remove: dev %s/%s\n", dev_name(dev),
-			dssdev->driver_name);
-
-	dssdrv->remove(dssdev);
-
-	dssdev->driver = NULL;
-
-	return 0;
-}
-
-static int omapdss_default_connect(struct omap_dss_device *dssdev)
-{
-	struct omap_dss_device *out;
-	struct omap_overlay_manager *mgr;
-	int r;
-
-	out = dssdev->output;
-
-	if (out == NULL)
-		return -ENODEV;
-
-	mgr = omap_dss_get_overlay_manager(out->dispc_channel);
-	if (!mgr)
-		return -ENODEV;
-
-	r = dss_mgr_connect(mgr, out);
-	if (r)
-		return r;
-
-	return 0;
-}
-
-static void omapdss_default_disconnect(struct omap_dss_device *dssdev)
-{
-	struct omap_dss_device *out;
-	struct omap_overlay_manager *mgr;
-
-	out = dssdev->output;
-
-	if (out == NULL)
-		return;
-
-	mgr = out->manager;
-
-	if (mgr == NULL)
-		return;
-
-	dss_mgr_disconnect(mgr, out);
-}
-
-int omap_dss_register_driver(struct omap_dss_driver *dssdriver)
-{
-	dssdriver->driver.bus = &dss_bus_type;
-	dssdriver->driver.probe = dss_driver_probe;
-	dssdriver->driver.remove = dss_driver_remove;
-
-	if (dssdriver->get_resolution == NULL)
-		dssdriver->get_resolution = omapdss_default_get_resolution;
-	if (dssdriver->get_recommended_bpp == NULL)
-		dssdriver->get_recommended_bpp =
-			omapdss_default_get_recommended_bpp;
-	if (dssdriver->get_timings == NULL)
-		dssdriver->get_timings = omapdss_default_get_timings;
-	if (dssdriver->connect == NULL)
-		dssdriver->connect = omapdss_default_connect;
-	if (dssdriver->disconnect == NULL)
-		dssdriver->disconnect = omapdss_default_disconnect;
-
-	return driver_register(&dssdriver->driver);
-}
-EXPORT_SYMBOL(omap_dss_register_driver);
-
-void omap_dss_unregister_driver(struct omap_dss_driver *dssdriver)
-{
-	driver_unregister(&dssdriver->driver);
-}
-EXPORT_SYMBOL(omap_dss_unregister_driver);
-
-/* DEVICE */
-
-static void omap_dss_dev_release(struct device *dev)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	kfree(dssdev);
-}
-
-static int disp_num_counter;
-
-struct omap_dss_device *dss_alloc_and_init_device(struct device *parent)
-{
-	struct omap_dss_device *dssdev;
-
-	dssdev = kzalloc(sizeof(*dssdev), GFP_KERNEL);
-	if (!dssdev)
-		return NULL;
-
-	dssdev->old_dev.bus = &dss_bus_type;
-	dssdev->old_dev.parent = parent;
-	dssdev->old_dev.release = omap_dss_dev_release;
-	dev_set_name(&dssdev->old_dev, "display%d", disp_num_counter++);
-
-	device_initialize(&dssdev->old_dev);
-
-	return dssdev;
-}
-
-int dss_add_device(struct omap_dss_device *dssdev)
-{
-	dssdev->dev = &dssdev->old_dev;
-
-	omapdss_register_display(dssdev);
-	return device_add(&dssdev->old_dev);
-}
-
-void dss_put_device(struct omap_dss_device *dssdev)
-{
-	put_device(&dssdev->old_dev);
-}
-
-void dss_unregister_device(struct omap_dss_device *dssdev)
-{
-	device_unregister(&dssdev->old_dev);
-	omapdss_unregister_display(dssdev);
-}
-
-static int dss_unregister_dss_dev(struct device *dev, void *data)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	dss_unregister_device(dssdev);
-	return 0;
-}
-
-void dss_unregister_child_devices(struct device *parent)
-{
-	device_for_each_child(parent, NULL, dss_unregister_dss_dev);
-}
-
-void dss_copy_device_pdata(struct omap_dss_device *dst,
-		const struct omap_dss_device *src)
-{
-	u8 *d = (u8 *)dst;
-	u8 *s = (u8 *)src;
-	size_t dsize = sizeof(struct device);
-
-	memcpy(d + dsize, s + dsize, sizeof(struct omap_dss_device) - dsize);
-}
-
-/* BUS */
-static int __init omap_dss_bus_register(void)
-{
-	int r;
-
-	r = bus_register(&dss_bus_type);
-	if (r) {
-		DSSERR("bus register failed\n");
-		return r;
-	}
-
-	dev_set_name(&dss_bus, "omapdss");
-	r = device_register(&dss_bus);
-	if (r) {
-		DSSERR("bus driver register failed\n");
-		bus_unregister(&dss_bus_type);
-		return r;
-	}
-
-	return 0;
-}
-
 /* INIT */
 static int (*dss_output_drv_reg_funcs[])(void) __initdata = {
 #ifdef CONFIG_OMAP2_DSS_DSI
@@ -553,6 +324,8 @@ static int __init omap_dss_register_drivers(void)
 			dss_output_drv_loaded[i] = true;
 	}
 
+	dss_initialized = true;
+
 	return 0;
 
 err_dispc:
@@ -578,64 +351,18 @@ static void __exit omap_dss_unregister_drivers(void)
 	platform_driver_unregister(&omap_dss_driver);
 }
 
-#ifdef CONFIG_OMAP2_DSS_MODULE
-static void omap_dss_bus_unregister(void)
-{
-	device_unregister(&dss_bus);
-
-	bus_unregister(&dss_bus_type);
-}
-
 static int __init omap_dss_init(void)
 {
-	int r;
-
-	r = omap_dss_bus_register();
-	if (r)
-		return r;
-
-	r = omap_dss_register_drivers();
-	if (r) {
-		omap_dss_bus_unregister();
-		return r;
-	}
-
-	dss_initialized = true;
-
-	return 0;
+	return omap_dss_register_drivers();
 }
 
 static void __exit omap_dss_exit(void)
 {
 	omap_dss_unregister_drivers();
-
-	omap_dss_bus_unregister();
 }
 
 module_init(omap_dss_init);
 module_exit(omap_dss_exit);
-#else
-static int __init omap_dss_init(void)
-{
-	return omap_dss_bus_register();
-}
-
-static int __init omap_dss_init2(void)
-{
-	int r;
-
-	r = omap_dss_register_drivers();
-	if (r)
-		return r;
-
-	dss_initialized = true;
-
-	return 0;
-}
-
-core_initcall(omap_dss_init);
-device_initcall(omap_dss_init2);
-#endif
 
 MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@nokia.com>");
 MODULE_DESCRIPTION("OMAP2/3 Display Subsystem");
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 68dd27f..e172531 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -163,20 +163,11 @@ struct platform_device;
 
 /* core */
 struct platform_device *dss_get_core_pdev(void);
-struct bus_type *dss_get_bus(void);
 int dss_dsi_enable_pads(int dsi_id, unsigned lane_mask);
 void dss_dsi_disable_pads(int dsi_id, unsigned lane_mask);
 int dss_set_min_bus_tput(struct device *dev, unsigned long tput);
 int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *));
 
-struct omap_dss_device *dss_alloc_and_init_device(struct device *parent);
-int dss_add_device(struct omap_dss_device *dssdev);
-void dss_unregister_device(struct omap_dss_device *dssdev);
-void dss_unregister_child_devices(struct device *parent);
-void dss_put_device(struct omap_dss_device *dssdev);
-void dss_copy_device_pdata(struct omap_dss_device *dst,
-		const struct omap_dss_device *src);
-
 /* display */
 int dss_suspend_all_devices(void);
 int dss_resume_all_devices(void);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index ca04b56..763b11b 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -703,10 +703,6 @@ struct omapdss_dsi_ops {
 };
 
 struct omap_dss_device {
-	/* old device, to be removed */
-	struct device old_dev;
-
-	/* new device, pointer to panel device */
 	struct device *dev;
 
 	struct module *owner;
@@ -808,8 +804,6 @@ struct omap_dss_hdmi_data
 };
 
 struct omap_dss_driver {
-	struct device_driver driver;
-
 	int (*probe)(struct omap_dss_device *);
 	void (*remove)(struct omap_dss_device *);
 
-- 
1.8.1.2

