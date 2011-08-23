From: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Subject: [RFC/PATCH v2 01/13] OMAP: omap_device: Add device tree node pointer
Date: Tue, 23 Aug 2011 10:03:29 +0500
Message-ID: <1314074021-25186-2-git-send-email-manjugk@ti.com>
References: <1314074021-25186-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


The omap_device requires new omap_device api to be added in order
to support omap dt.

The new api is added and new parameter device node pointer "np" is added
to existing api. The users of omap_device api is changed accordingly.

Build and boot tested on omap3 beagle for both dt and not dt build.

Signed-off-by: G, Manjunath Kondaiah <manjugk-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/devices.c                 |    2 +-
 arch/arm/mach-omap2/mcbsp.c                   |    2 +-
 arch/arm/plat-omap/include/plat/omap_device.h |   11 +++++-
 arch/arm/plat-omap/omap_device.c              |   46 +++++++++++++++++++++++--
 4 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 10adf66..d23e4bc 100644
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
index d4d9b96..37c231d 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -33,6 +33,7 @@
 
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 #include <plat/omap_hwmod.h>
 
@@ -94,12 +95,20 @@ struct platform_device *omap_device_build(const char *pdev_name, int pdev_id,
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
index d8f2299..3347115 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -85,6 +85,7 @@
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/pm_runtime.h>
+#include <linux/of_device.h>
 
 #include <plat/omap_device.h>
 #include <plat/omap_hwmod.h>
@@ -391,6 +392,7 @@ static int omap_device_fill_resources(struct omap_device *od,
 /**
  * omap_device_build - build and register an omap_device with one omap_hwmod
  * @pdev_name: name of the platform_device driver to use
+ * @np: device node pointer for attaching it to of_node pointer
  * @pdev_id: this platform_device's connection ID
  * @oh: ptr to the single omap_hwmod that backs this omap_device
  * @pdata: platform_data ptr to associate with the platform_device
@@ -405,7 +407,8 @@ static int omap_device_fill_resources(struct omap_device *od,
  * information.  Returns ERR_PTR(-EINVAL) if @oh is NULL; otherwise,
  * passes along the return value of omap_device_build_ss().
  */
-struct platform_device *omap_device_build(const char *pdev_name, int pdev_id,
+struct platform_device *omap_device_build_dt(struct device_node *np,
+				      const char *pdev_name, int pdev_id,
 				      struct omap_hwmod *oh, void *pdata,
 				      int pdata_len,
 				      struct omap_device_pm_latency *pm_lats,
@@ -416,12 +419,44 @@ struct platform_device *omap_device_build(const char *pdev_name, int pdev_id,
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
@@ -438,7 +473,8 @@ struct platform_device *omap_device_build(const char *pdev_name, int pdev_id,
  * platform_device record.  Returns an ERR_PTR() on error, or passes
  * along the return value of omap_device_register().
  */
-struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
+struct platform_device *omap_device_build_ss(struct device_node *np,
+					 const char *pdev_name, int pdev_id,
 					 struct omap_hwmod **ohs, int oh_cnt,
 					 void *pdata, int pdata_len,
 					 struct omap_device_pm_latency *pm_lats,
@@ -497,6 +533,10 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 			goto odbs_exit3;
 	}
 
+#ifdef CONFIG_OF_DEVICE
+	pdev->dev.of_node = of_node_get(np);
+#endif
+
 	ret = platform_device_add_data(pdev, pdata, pdata_len);
 	if (ret)
 		goto odbs_exit3;
-- 
1.7.4.1
