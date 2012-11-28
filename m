From: Andy Green <andy.green@linaro.org>
Subject: [try#1 PATCH 1/7] drivers: base: introduce device assets
Date: Wed, 28 Nov 2012 12:59:34 +0000
Message-ID: <20121128125934.29569.1642.stgit@build.warmcat.com>
References: <20121128124744.29569.52739.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:59170 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754955Ab2K1M7j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 07:59:39 -0500
In-Reply-To: <20121128124744.29569.52739.stgit@build.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rogerq@ti.com, keshava_mgowda@ti.com, balbi@ti.com, stern@rowland.harvard.edu

This patch adds support for a new struct device member "assets"
which may point to an array of struct assets.

The array is terminated by one with a NULL pre_probe callback.

These assets consist of named (in .name) or anonymous object
pointers (.data) operated on by specified callbacks.  A void *
is provided to give configuration data or pointer if needed.

Before device probe, any assets associated with the device have
their pre_probe() callback called, which will typically "enable"
them, and after device removal the post_remove() callback is
called which will typically disable them.

Signed-off-by: Andy Green <andy.green@linaro.org>
---
 drivers/base/dd.c      |   36 ++++++++++++++++++++++++++++++++++++
 include/linux/device.h |   25 +++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index e3bbed8..d37210a 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -261,6 +261,7 @@ static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
 
 static int really_probe(struct device *dev, struct device_driver *drv)
 {
+	struct device_asset *asset;
 	int ret = 0;
 
 	atomic_inc(&probe_count);
@@ -275,6 +276,23 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		goto probe_failed;
 	}
 
+	asset = dev->assets;
+	while (asset && asset->pre_probe) {
+		dev_info(dev, "Enabling pre-probe asset %s\n", asset->name);
+		ret = asset->pre_probe(dev, asset);
+		if (ret) {
+			dev_err(dev, "Error Enabling pre-probe asset %s\n",
+								  asset->name);
+			if (asset != dev->assets)
+				do {
+					asset--;
+					asset->post_remove(dev, asset);
+				} while (asset != dev->assets);
+			goto probe_failed;
+		}
+		asset++;
+	}
+
 	if (dev->bus->probe) {
 		ret = dev->bus->probe(dev);
 		if (ret)
@@ -478,6 +496,7 @@ EXPORT_SYMBOL_GPL(driver_attach);
 static void __device_release_driver(struct device *dev)
 {
 	struct device_driver *drv;
+	struct device_asset *asset;
 
 	drv = dev->driver;
 	if (drv) {
@@ -496,6 +515,23 @@ static void __device_release_driver(struct device *dev)
 			dev->bus->remove(dev);
 		else if (drv->remove)
 			drv->remove(dev);
+
+		asset = dev->assets;
+		if (asset) {
+			/* remove in reverse order */
+			while (asset->pre_probe)
+				asset++;
+
+			if (asset != dev->assets)
+				do {
+					asset--;
+					dev_info(dev,
+					   "Disabling post-remove asset %s\n",
+								  asset->name);
+					asset->post_remove(dev, asset);
+				} while (asset != dev->assets);
+		}
+
 		devres_release_all(dev);
 		dev->driver = NULL;
 		dev_set_drvdata(dev, NULL);
diff --git a/include/linux/device.h b/include/linux/device.h
index 86ef6ab..6eabe1d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -577,6 +577,26 @@ struct device_dma_parameters {
 };
 
 /**
+ * struct device_asset - a prerequisite for this device's probing
+ * @name:	Name of the regulator, clock, etc.  Optional.
+ * @asset:	Pointer to the regulator, clock, etc.  If no name is given,
+ *		this can be set before device probe, otherwise the pre_probe
+ *		handler will dereference the name and store a pointer here
+ * @data:	Optional configuration data the asset may need
+ * @pre_probe:	Called before this device this is associated with gets
+ *		probed.
+ * @post_remove: Called after this device instance gets removed.
+ */
+
+struct device_asset {
+	const char *name;
+	void *asset;
+	void *data;
+	int (*pre_probe)(struct device *device, struct device_asset *asset);
+	void (*post_remove)(struct device *device, struct device_asset *asset);
+};
+
+/**
  * struct device - The basic device structure
  * @parent:	The device's "parent" device, the device to which it is attached.
  * 		In most cases, a parent device is some sort of bus or host
@@ -600,6 +620,9 @@ struct device_dma_parameters {
  * 		variants, which GPIO pins act in what additional roles, and so
  * 		on.  This shrinks the "Board Support Packages" (BSPs) and
  * 		minimizes board-specific #ifdefs in drivers.
+ * @assets:	Pointer to a NULL-pre_probe terminated array of named or
+ *		pointed-to objects that should be enabled for this device
+ *		just before probe and disabled after removal
  * @power:	For device power management.
  * 		See Documentation/power/devices.txt for details.
  * @pm_domain:	Provide callbacks that are executed during system suspend,
@@ -653,6 +676,8 @@ struct device {
 					   device */
 	void		*platform_data;	/* Platform specific data, device
 					   core doesn't touch it */
+	struct device_asset *assets; /* optional assets enabled before probe
+				      * and disabled after removal */
 	struct dev_pm_info	power;
 	struct dev_pm_domain	*pm_domain;
 

