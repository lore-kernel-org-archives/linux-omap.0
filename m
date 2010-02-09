From: Thara Gopinath <thara@ti.com>
Subject: [PATCH] OMAP: HWMOD: Add support for early device register into omap device layer
Date: Tue,  9 Feb 2010 08:47:02 +0530
Message-ID: <1265685422-14351-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44866 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150Ab0BIDRN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Feb 2010 22:17:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Paul Walmsley <paul@pwsan.com>

This patch adds support in omap device layer to register devices
as early platform devices. Certain devices needed during system boot up
like timers, gpio etc can be registered as early devices. This will
allow for them to be probed very early on during system boot up.
This patch adds a parameter is_early_device in omap_device_build.
Depending on this parameter a call to early_platform_add_devices
or platform_register_device is made.

Signed-off-by: Thara Gopinath <thara@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    5 ++-
 arch/arm/plat-omap/omap_device.c              |   33 ++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 76d4917..9cc12c2 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -88,15 +88,16 @@ struct omap_device *omap_device_build(const char *pdev_name, int pdev_id,
 				      struct omap_hwmod *oh, void *pdata,
 				      int pdata_len,
 				      struct omap_device_pm_latency *pm_lats,
-				      int pm_lats_cnt);
+				      int pm_lats_cnt, int is_early_device);
 
 struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 					 struct omap_hwmod **oh, int oh_cnt,
 					 void *pdata, int pdata_len,
 					 struct omap_device_pm_latency *pm_lats,
-					 int pm_lats_cnt);
+					 int pm_lats_cnt, int is_early_device);
 
 int omap_device_register(struct omap_device *od);
+int omap_early_device_register(struct omap_device *od);
 
 /* OMAP PM interface */
 int omap_device_align_pm_lat(struct platform_device *pdev,
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 5195dbb..83a97aa 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -305,6 +305,7 @@ int omap_device_fill_resources(struct omap_device *od, struct resource *res)
  * @pdata_len: amount of memory pointed to by @pdata
  * @pm_lats: pointer to a omap_device_pm_latency array for this device
  * @pm_lats_cnt: ARRAY_SIZE() of @pm_lats
+ * @is_early_device: should the device be registered as an early device or not
  *
  * Convenience function for building and registering a single
  * omap_device record, which in turn builds and registers a
@@ -316,7 +317,7 @@ struct omap_device *omap_device_build(const char *pdev_name, int pdev_id,
 				      struct omap_hwmod *oh, void *pdata,
 				      int pdata_len,
 				      struct omap_device_pm_latency *pm_lats,
-				      int pm_lats_cnt)
+				      int pm_lats_cnt, int is_early_device)
 {
 	struct omap_hwmod *ohs[] = { oh };
 
@@ -324,7 +325,8 @@ struct omap_device *omap_device_build(const char *pdev_name, int pdev_id,
 		return ERR_PTR(-EINVAL);
 
 	return omap_device_build_ss(pdev_name, pdev_id, ohs, 1, pdata,
-				    pdata_len, pm_lats, pm_lats_cnt);
+				    pdata_len, pm_lats, pm_lats_cnt,
+				    is_early_device);
 }
 
 /**
@@ -336,6 +338,7 @@ struct omap_device *omap_device_build(const char *pdev_name, int pdev_id,
  * @pdata_len: amount of memory pointed to by @pdata
  * @pm_lats: pointer to a omap_device_pm_latency array for this device
  * @pm_lats_cnt: ARRAY_SIZE() of @pm_lats
+ * @is_early_device: should the device be registered as an early device or not
  *
  * Convenience function for building and registering an omap_device
  * subsystem record.  Subsystem records consist of multiple
@@ -347,7 +350,7 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 					 struct omap_hwmod **ohs, int oh_cnt,
 					 void *pdata, int pdata_len,
 					 struct omap_device_pm_latency *pm_lats,
-					 int pm_lats_cnt)
+					 int pm_lats_cnt, int is_early_device)
 {
 	int ret = -ENOMEM;
 	struct omap_device *od;
@@ -403,7 +406,11 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	od->pm_lats = pm_lats;
 	od->pm_lats_cnt = pm_lats_cnt;
 
-	ret = omap_device_register(od);
+	if (is_early_device)
+		ret = omap_early_device_register(od);
+	else
+		ret = omap_device_register(od);
+
 	if (ret)
 		goto odbs_exit4;
 
@@ -424,6 +431,24 @@ odbs_exit1:
 }
 
 /**
+ * omap_early_device_register - register an omap_device as an early platform
+ * device.
+ * @od: struct omap_device * to register
+ *
+ * Register the omap_device structure.  This currently just calls
+ * platform_early_add_device() on the underlying platform_device.
+ * Returns 0 by default.
+ */
+int omap_early_device_register(struct omap_device *od)
+{
+	struct platform_device *devices[1];
+
+	devices[0] = &(od->pdev);
+	early_platform_add_devices(devices, 1);
+	return 0;
+}
+
+/**
  * omap_device_register - register an omap_device with one omap_hwmod
  * @od: struct omap_device * to register
  *
-- 
1.7.0.rc1.33.g07cf0f

