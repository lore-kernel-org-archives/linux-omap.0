From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [RFC/PATCH 09/14] dt: omap: prepare hwmod to support dt
Date: Tue, 09 Aug 2011 19:10:27 +0500
Message-ID: <1312897232-4792-10-git-send-email-manjugk@ti.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [117.192.76.145] ([117.192.76.145]:51063 "EHLO manju-desktop"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751565Ab1HINy3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Aug 2011 09:54:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca


The omap dt requires new omap hwmod api to be added for in order
to support omap dt.

The new api is added and new parameter "np" is added for existing
api. The users of hwmod api is changed accrodingly.

Build and boot tested on omap3 beagle for both dt and not dt build.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/mach-omap2/devices.c                 |    2 +-
 arch/arm/mach-omap2/mcbsp.c                   |    2 +-
 arch/arm/plat-omap/include/plat/omap_device.h |   11 +++++-
 arch/arm/plat-omap/omap_device.c              |   53 ++++++++++++++++++++++---
 4 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 458f7be..d7ff1ae 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -92,7 +92,7 @@ static int __init omap4_l3_init(void)
 			pr_err("could not look up %s\n", oh_name);
 	}
 
-	pdev = omap_device_build_ss("omap_l3_noc", 0, oh, 3, NULL,
+	pdev = omap_device_build_ss(NULL, "omap_l3_noc", 0, oh, 3, NULL,
 						     0, NULL, 0, 0);
 
 	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 7a42f32..98eb95d 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -144,7 +144,7 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 		(struct omap_mcbsp_dev_attr *)(oh->dev_attr))->sidetone);
 		count++;
 	}
-	pdev = omap_device_build_ss(name, id, oh_device, count, pdata,
+	pdev = omap_device_build_ss(NULL, name, id, oh_device, count, pdata,
 				sizeof(*pdata), omap2_mcbsp_latency,
 				ARRAY_SIZE(omap2_mcbsp_latency), false);
 	kfree(pdata);
diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 7a3ec4f..5e2424b 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -33,6 +33,7 @@
 
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 #include <plat/omap_hwmod.h>
 
@@ -89,12 +90,20 @@ struct platform_device *omap_device_build(const char *pdev_name, int pdev_id,
 				      struct omap_device_pm_latency *pm_lats,
 				      int pm_lats_cnt, int is_early_device);
 
-struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
+struct platform_device *omap_device_build_ss(struct device_node *np,
+					 const char *pdev_name, int pdev_id,
 					 struct omap_hwmod **oh, int oh_cnt,
 					 void *pdata, int pdata_len,
 					 struct omap_device_pm_latency *pm_lats,
 					 int pm_lats_cnt, int is_early_device);
 
+struct platform_device *omap_device_build_dt(struct device_node *np,
+				      const char *pdev_name, int pdev_id,
+				      struct omap_hwmod *oh, void *pdata,
+				      int pdata_len,
+				      struct omap_device_pm_latency *pm_lats,
+				      int pm_lats_cnt, int is_early_device);
+
 void __iomem *omap_device_get_rt_va(struct omap_device *od);
 
 /* OMAP PM interface */
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 7d5e76b..fa49168 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -85,6 +85,7 @@
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/pm_runtime.h>
+#include <linux/of_device.h>
 
 #include <plat/omap_device.h>
 #include <plat/omap_hwmod.h>
@@ -377,6 +378,7 @@ static int omap_device_fill_resources(struct omap_device *od,
 /**
  * omap_device_build - build and register an omap_device with one omap_hwmod
  * @pdev_name: name of the platform_device driver to use
+ * @np: device node pointer for attaching it to of_node pointer
  * @pdev_id: this platform_device's connection ID
  * @oh: ptr to the single omap_hwmod that backs this omap_device
  * @pdata: platform_data ptr to associate with the platform_device
@@ -391,7 +393,8 @@ static int omap_device_fill_resources(struct omap_device *od,
  * information.  Returns ERR_PTR(-EINVAL) if @oh is NULL; otherwise,
  * passes along the return value of omap_device_build_ss().
  */
-struct platform_device *omap_device_build(const char *pdev_name, int pdev_id,
+struct platform_device *omap_device_build_dt(struct device_node *np,
+				      const char *pdev_name, int pdev_id,
 				      struct omap_hwmod *oh, void *pdata,
 				      int pdata_len,
 				      struct omap_device_pm_latency *pm_lats,
@@ -402,12 +405,44 @@ struct platform_device *omap_device_build(const char *pdev_name, int pdev_id,
 	if (!oh)
 		return ERR_PTR(-EINVAL);
 
-	return omap_device_build_ss(pdev_name, pdev_id, ohs, 1, pdata,
+	return omap_device_build_ss(np, pdev_name, pdev_id, ohs, 1, pdata,
 				    pdata_len, pm_lats, pm_lats_cnt,
 				    is_early_device);
 }
 
 /**
+ * omap_device_build - build and register an omap_device with one omap_hwmod
+ * @pdev_name: name of the platform_device driver to use
+ * @pdev_id: this platform_device's connection ID
+ * @oh: ptr to the single omap_hwmod that backs this omap_device
+ * @pdata: platform_data ptr to associate with the platform_device
+ * @pdata_len: amount of memory pointed to by @pdata
+ * @pm_lats: pointer to a omap_device_pm_latency array for this device
+ * @pm_lats_cnt: ARRAY_SIZE() of @pm_lats
+ * @is_early_device: should the device be registered as an early device or not
+ *
+ * Convenience function for building and registering a single
+ * omap_device record, which in turn builds and registers a
+ * platform_device record.  See omap_device_build_ss() for more
+ * information.  Returns ERR_PTR(-EINVAL) if @oh is NULL; otherwise,
+ * passes along the return value of omap_device_build_ss().
+ */
+struct platform_device *omap_device_build(const char *pdev_name, int pdev_id,
+				      struct omap_hwmod *oh, void *pdata,
+				      int pdata_len,
+				      struct omap_device_pm_latency *pm_lats,
+				      int pm_lats_cnt, int is_early_device)
+{
+	struct omap_hwmod *ohs[] = { oh };
+
+	if (!oh)
+		return ERR_PTR(-EINVAL);
+
+	return omap_device_build_ss(NULL, pdev_name, pdev_id, ohs, 1, pdata,
+			pdata_len, pm_lats, pm_lats_cnt, is_early_device);
+}
+
+/**
  * omap_device_build_ss - build and register an omap_device with multiple hwmods
  * @pdev_name: name of the platform_device driver to use
  * @pdev_id: this platform_device's connection ID
@@ -424,7 +459,8 @@ struct platform_device *omap_device_build(const char *pdev_name, int pdev_id,
  * platform_device record.  Returns an ERR_PTR() on error, or passes
  * along the return value of omap_device_register().
  */
-struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
+struct platform_device *omap_device_build_ss(struct device_node *np,
+					 const char *pdev_name, int pdev_id,
 					 struct omap_hwmod **ohs, int oh_cnt,
 					 void *pdata, int pdata_len,
 					 struct omap_device_pm_latency *pm_lats,
@@ -436,6 +472,7 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	struct resource *res = NULL;
 	int i, res_count;
 	struct omap_hwmod **hwmods;
+	struct platform_device *pdev;
 
 	if (!ohs || oh_cnt == 0 || !pdev_name)
 		return ERR_PTR(-EINVAL);
@@ -450,6 +487,7 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	if (!od)
 		return ERR_PTR(-ENOMEM);
 
+	pdev = &od->pdev;
 	od->hwmods_cnt = oh_cnt;
 
 	hwmods = kzalloc(sizeof(struct omap_hwmod *) * oh_cnt,
@@ -465,8 +503,11 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 		goto odbs_exit2;
 	strcpy(pdev_name2, pdev_name);
 
-	od->pdev.name = pdev_name2;
-	od->pdev.id = pdev_id;
+#ifdef CONFIG_OF_DEVICE
+	pdev->dev.of_node = of_node_get(np);
+#endif
+	pdev->name = pdev_name2;
+	pdev->id = pdev_id;
 
 	res_count = omap_device_count_resources(od);
 	if (res_count > 0) {
@@ -499,7 +540,7 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	if (ret)
 		goto odbs_exit4;
 
-	return &od->pdev;
+	return pdev;
 
 odbs_exit4:
 	kfree(res);
-- 
1.7.1

