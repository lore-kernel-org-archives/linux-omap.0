From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH] ARM: OMAP: omap_device: Add omap_device_{alloc, delete, register}_ss
Date: Wed,  5 Oct 2011 18:54:53 +0200
Message-ID: <1317833693-21105-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39582 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934948Ab1JEQzU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 12:55:20 -0400
Received: by bkbzt4 with SMTP id zt4so2377964bkb.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Oct 2011 09:55:19 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Benoit Cousson <b-cousson@ti.com>

Split omap_device_build_ss() into two smaller functions:
1. omap_device_alloc_ss() - allocates the omap_device and its
associated pdev, but doesn't register the pdev yet
2. omap_device_register_ss() - registers the aforementioned pdev

In addition, a third omap_device_delete_ss() method is introduced
in case omap_device_register_ss() fails.

This approach allows users, which need to manipulate an archdata member
of a device before it is registered, to do so.

The immediate use case for this is to set the private iommu archdata
member, which binds a device to its associated iommu controller.
This way, generic code will be able to attach omap devices to their
iommus, without calling any omap-specific API.

This patch is considered an interim solution until DT fully materializes
for omap; at that point, this functionality will be removed.

Tested on OMAP4 with a generic remoteproc that doesn't use any
omap-specific IOMMU API anymore.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
Based on Kevin's for_3.2/omap_device-2 branch

 arch/arm/plat-omap/include/plat/omap_device.h |    9 ++
 arch/arm/plat-omap/omap_device.c              |  110 +++++++++++++++++++++----
 2 files changed, 104 insertions(+), 15 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 12c5b0c..bc957d6 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -100,6 +100,15 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 					 struct omap_device_pm_latency *pm_lats,
 					 int pm_lats_cnt, int is_early_device);
 
+struct platform_device *omap_device_alloc_ss(const char *pdev_name, int pdev_id,
+					 struct omap_hwmod **ohs, int oh_cnt,
+					 void *pdata, int pdata_len,
+					 struct omap_device_pm_latency *pm_lats,
+					 int pm_lats_cnt);
+
+void omap_device_delete_ss(struct platform_device *pdev);
+int omap_device_register_ss(struct platform_device *pdev, int is_early_device);
+
 void __iomem *omap_device_get_rt_va(struct omap_device *od);
 struct device *omap_device_get_by_hwmod_name(const char *oh_name);
 
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index cd90bed..f53e7f7 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -635,7 +635,7 @@ struct platform_device *omap_device_build(const char *pdev_name, int pdev_id,
 }
 
 /**
- * omap_device_build_ss - build and register an omap_device with multiple hwmods
+ * omap_device_alloc_ss - build an omap_device with multiple hwmods
  * @pdev_name: name of the platform_device driver to use
  * @pdev_id: this platform_device's connection ID
  * @oh: ptr to the single omap_hwmod that backs this omap_device
@@ -643,19 +643,19 @@ struct platform_device *omap_device_build(const char *pdev_name, int pdev_id,
  * @pdata_len: amount of memory pointed to by @pdata
  * @pm_lats: pointer to a omap_device_pm_latency array for this device
  * @pm_lats_cnt: ARRAY_SIZE() of @pm_lats
- * @is_early_device: should the device be registered as an early device or not
  *
- * Convenience function for building and registering an omap_device
+ * Convenience function for building (only) an omap_device
  * subsystem record.  Subsystem records consist of multiple
- * omap_hwmods.  This function in turn builds and registers a
- * platform_device record.  Returns an ERR_PTR() on error, or passes
- * along the return value of omap_device_register().
+ * omap_hwmods.  This function in turn builds (but doesn't register) a
+ * platform_device record, so callers can manipulate it (typically by
+ * setting one or more archdata members) before it's registered.
+ * Returns an ERR_PTR() on error, or the allocated pdev on success.
  */
-struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
+struct platform_device *omap_device_alloc_ss(const char *pdev_name, int pdev_id,
 					 struct omap_hwmod **ohs, int oh_cnt,
 					 void *pdata, int pdata_len,
 					 struct omap_device_pm_latency *pm_lats,
-					 int pm_lats_cnt, int is_early_device)
+					 int pm_lats_cnt)
 {
 	int ret = -ENOMEM;
 	struct platform_device *pdev;
@@ -687,13 +687,6 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	if (ret)
 		goto odbs_exit2;
 
-	if (is_early_device)
-		ret = omap_early_device_register(pdev);
-	else
-		ret = omap_device_register(pdev);
-	if (ret)
-		goto odbs_exit2;
-
 	return pdev;
 
 odbs_exit2:
@@ -708,6 +701,93 @@ odbs_exit:
 }
 
 /**
+ * omap_device_delete_ss - free an omap_device-based platform device
+ * @pdev: platform_device that represents this omap_device
+ *
+ * Convenience function for freeing a platform_device record, which
+ * is based on an omap_device subsystem record.
+ *
+ * Use this function only if @pdev was created using omap_device_alloc_ss(),
+ * most commonly after a subsequent call to omap_device_register_ss() failed.
+ */
+void omap_device_delete_ss(struct platform_device *pdev)
+{
+	struct omap_device *od = to_omap_device(pdev);
+
+	omap_device_delete(od);
+	platform_device_put(pdev);
+}
+
+/**
+ * omap_device_register_ss - register an omap_device-based platform device
+ * @pdev: platform_device that represents this omap_device
+ * @is_early_device: should the device be registered as an early device or not
+ *
+ * Convenience function for registering a platform_device record, which
+ * is based on an omap_device subsystem record, created using
+ * omap_device_alloc_ss().
+ *
+ * Returns 0 on success, or an appropriate error value otherwise (essentially
+ * by returning the value of platform_device_register())
+ */
+int omap_device_register_ss(struct platform_device *pdev, int is_early_device)
+{
+	int ret;
+
+	if (is_early_device)
+		ret = omap_early_device_register(pdev);
+	else
+		ret = omap_device_register(pdev);
+
+	return ret;
+}
+
+/**
+ * omap_device_build_ss - build and register an omap_device with multiple hwmods
+ * @pdev_name: name of the platform_device driver to use
+ * @pdev_id: this platform_device's connection ID
+ * @oh: ptr to the single omap_hwmod that backs this omap_device
+ * @pdata: platform_data ptr to associate with the platform_device
+ * @pdata_len: amount of memory pointed to by @pdata
+ * @pm_lats: pointer to a omap_device_pm_latency array for this device
+ * @pm_lats_cnt: ARRAY_SIZE() of @pm_lats
+ * @is_early_device: should the device be registered as an early device or not
+ *
+ * Convenience function for building and registering an omap_device
+ * subsystem record.  Subsystem records consist of multiple
+ * omap_hwmods.  This function in turn builds and registers a
+ * platform_device record.  Returns an ERR_PTR() on error, or passes
+ * along the built pdev on success.
+ */
+struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
+					 struct omap_hwmod **ohs, int oh_cnt,
+					 void *pdata, int pdata_len,
+					 struct omap_device_pm_latency *pm_lats,
+					 int pm_lats_cnt, int is_early_device)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	pdev = omap_device_alloc_ss(pdev_name, pdev_id, ohs, oh_cnt, pdata,
+			pdata_len, pm_lats, pm_lats_cnt);
+
+	if (IS_ERR(pdev))
+		goto out;
+
+	ret = omap_device_register_ss(pdev, is_early_device);
+	if (ret) {
+		pdev = ERR_PTR(ret);
+		goto delete_od;
+	}
+
+	return pdev;
+delete_od:
+	omap_device_delete_ss(pdev);
+out:
+	return pdev;
+}
+
+/**
  * omap_early_device_register - register an omap_device as an early platform
  * device.
  * @od: struct omap_device * to register
-- 
1.7.4.1

