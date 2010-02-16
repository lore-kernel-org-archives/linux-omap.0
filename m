From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 14/19] OMAP: HWMOD: Add support for early device register into
	omap device layer
Date: Mon, 15 Feb 2010 18:24:58 -0700
Message-ID: <20100216012455.1101.2409.stgit@localhost.localdomain>
References: <20100216011942.1101.14348.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57435 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932473Ab0BPB07 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 20:26:59 -0500
In-Reply-To: <20100216011942.1101.14348.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Thara Gopinath <thara@ti.com>

From: Thara Gopinath <thara@ti.com>

This patch adds support in omap device layer to register devices
as early platform devices. Certain devices needed during system boot up
like timers, gpio etc can be registered as early devices. This will
allow for them to be probed very early on during system boot up.
This patch adds a parameter is_early_device in omap_device_build.
Depending on this parameter a call to early_platform_add_devices
or platform_register_device is made.

Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    5 ++--
 arch/arm/plat-omap/omap_device.c              |   33 ++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 4677ff7..3694b62 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -90,15 +90,16 @@ struct omap_device *omap_device_build(const char *pdev_name, int pdev_id,
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
index c739a04..5904358 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -307,6 +307,7 @@ int omap_device_fill_resources(struct omap_device *od, struct resource *res)
  * @pdata_len: amount of memory pointed to by @pdata
  * @pm_lats: pointer to a omap_device_pm_latency array for this device
  * @pm_lats_cnt: ARRAY_SIZE() of @pm_lats
+ * @is_early_device: should the device be registered as an early device or not
  *
  * Convenience function for building and registering a single
  * omap_device record, which in turn builds and registers a
@@ -318,7 +319,7 @@ struct omap_device *omap_device_build(const char *pdev_name, int pdev_id,
 				      struct omap_hwmod *oh, void *pdata,
 				      int pdata_len,
 				      struct omap_device_pm_latency *pm_lats,
-				      int pm_lats_cnt)
+				      int pm_lats_cnt, int is_early_device)
 {
 	struct omap_hwmod *ohs[] = { oh };
 
@@ -326,7 +327,8 @@ struct omap_device *omap_device_build(const char *pdev_name, int pdev_id,
 		return ERR_PTR(-EINVAL);
 
 	return omap_device_build_ss(pdev_name, pdev_id, ohs, 1, pdata,
-				    pdata_len, pm_lats, pm_lats_cnt);
+				    pdata_len, pm_lats, pm_lats_cnt,
+				    is_early_device);
 }
 
 /**
@@ -338,6 +340,7 @@ struct omap_device *omap_device_build(const char *pdev_name, int pdev_id,
  * @pdata_len: amount of memory pointed to by @pdata
  * @pm_lats: pointer to a omap_device_pm_latency array for this device
  * @pm_lats_cnt: ARRAY_SIZE() of @pm_lats
+ * @is_early_device: should the device be registered as an early device or not
  *
  * Convenience function for building and registering an omap_device
  * subsystem record.  Subsystem records consist of multiple
@@ -349,7 +352,7 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 					 struct omap_hwmod **ohs, int oh_cnt,
 					 void *pdata, int pdata_len,
 					 struct omap_device_pm_latency *pm_lats,
-					 int pm_lats_cnt)
+					 int pm_lats_cnt, int is_early_device)
 {
 	int ret = -ENOMEM;
 	struct omap_device *od;
@@ -407,7 +410,11 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 
 	od->magic = OMAP_DEVICE_MAGIC;
 
-	ret = omap_device_register(od);
+	if (is_early_device)
+		ret = omap_early_device_register(od);
+	else
+		ret = omap_device_register(od);
+
 	if (ret)
 		goto odbs_exit4;
 
@@ -428,6 +435,24 @@ odbs_exit1:
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


