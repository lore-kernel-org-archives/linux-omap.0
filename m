From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/7] ARM: OMAP2+: Populate legacy resources for dma and smartreflex
Date: Fri, 29 Sep 2017 15:34:07 -0700
Message-ID: <20170929223411.9691-4-tony@atomide.com>
References: <20170929223411.9691-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170929223411.9691-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

We can populate the legacy resources needed by dma and smartreflex
from device tree in omap_device_build().

There should be no need to do this for other devices, and eventually
these two remaining users will be gone too. The legacy dma will be
dropped when the remaining users have been converted to use the
dmaengine driver, and smartreflex can now become just a regular
device driver with a few pdata callbacks.

This is needed in order to remove remaining device dma, irq and io
resources from the interconnect code.

And while at it, let's simplify things by removing otherwise
unused omap_device_build_ss() as we will never call it for more
than one hwmod.

Cc: "Benoît Cousson" <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/mach-omap2/omap_device.c | 137 +++++++++++++++++++++++++++++---------
 arch/arm/mach-omap2/omap_device.h |   4 --
 2 files changed, 106 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -35,6 +35,8 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/notifier.h>
 
 #include "common.h"
@@ -521,6 +523,91 @@ void omap_device_delete(struct omap_device *od)
 	kfree(od);
 }
 
+/**
+ * omap_device_copy_resources - Add legacy IO and IRQ resources
+ * @oh: interconnect target module
+ * @pdev: platform device to copy resources to
+ *
+ * We still have legacy DMA and smartreflex needing resources.
+ * Let's populate what they need until we can eventually just
+ * remove this function. Note that there should be no need to
+ * call this from omap_device_build_from_dt(), nor should there
+ * be any need to call it for other devices.
+ */
+static int
+omap_device_copy_resources(struct omap_hwmod *oh,
+			   struct platform_device *pdev)
+{
+	struct device_node *np, *child;
+	struct property *prop;
+	struct resource *res;
+	const char *name;
+	int error, irq = 0;
+
+	if (!oh || !oh->od || !oh->od->pdev) {
+		error = -EINVAL;
+		goto error;
+	}
+
+	np = oh->od->pdev->dev.of_node;
+	if (!np) {
+		error = -ENODEV;
+		goto error;
+	}
+
+	res = kzalloc(sizeof(*res) * 2, GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	/* Do we have a dts range for the interconnect target module? */
+	error = omap_hwmod_parse_module_range(oh, np, res);
+
+	/* No ranges, rely on device reg entry */
+	if (error)
+		error = of_address_to_resource(np, 0, res);
+	if (error)
+		goto free;
+
+	/* SmartReflex needs first IO resource name to be "mpu" */
+	res[0].name = "mpu";
+
+	/*
+	 * We may have a configured "ti,sysc" interconnect target with a
+	 * dts child with the interrupt. If so use the first child's
+	 * first interrupt for "ti-hwmods" legacy support.
+	 */
+	of_property_for_each_string(np, "compatible", prop, name)
+		if (!strncmp("ti,sysc-", name, 8))
+			break;
+
+	child = of_get_next_available_child(np, NULL);
+
+	if (name)
+		irq = irq_of_parse_and_map(child, 0);
+	if (!irq)
+		irq = irq_of_parse_and_map(np, 0);
+	if (!irq)
+		goto free;
+
+	/* Legacy DMA code needs interrupt name to be "0" */
+	res[1].start = irq;
+	res[1].end = irq;
+	res[1].flags = IORESOURCE_IRQ;
+	res[1].name = "0";
+
+	error = platform_device_add_resources(pdev, res, 2);
+
+free:
+	kfree(res);
+
+error:
+	WARN(error, "%s: %s device %s failed: %i\n",
+	     __func__, oh->name, dev_name(&pdev->dev),
+	     error);
+
+	return error;
+}
+
 /**
  * omap_device_build - build and register an omap_device with one omap_hwmod
  * @pdev_name: name of the platform_device driver to use
@@ -539,46 +626,25 @@ struct platform_device __init *omap_device_build(const char *pdev_name,
 						 int pdev_id,
 						 struct omap_hwmod *oh,
 						 void *pdata, int pdata_len)
-{
-	struct omap_hwmod *ohs[] = { oh };
-
-	if (!oh)
-		return ERR_PTR(-EINVAL);
-
-	return omap_device_build_ss(pdev_name, pdev_id, ohs, 1, pdata,
-				    pdata_len);
-}
-
-/**
- * omap_device_build_ss - build and register an omap_device with multiple hwmods
- * @pdev_name: name of the platform_device driver to use
- * @pdev_id: this platform_device's connection ID
- * @oh: ptr to the single omap_hwmod that backs this omap_device
- * @pdata: platform_data ptr to associate with the platform_device
- * @pdata_len: amount of memory pointed to by @pdata
- *
- * Convenience function for building and registering an omap_device
- * subsystem record.  Subsystem records consist of multiple
- * omap_hwmods.  This function in turn builds and registers a
- * platform_device record.  Returns an ERR_PTR() on error, or passes
- * along the return value of omap_device_register().
- */
-struct platform_device __init *omap_device_build_ss(const char *pdev_name,
-						    int pdev_id,
-						    struct omap_hwmod **ohs,
-						    int oh_cnt, void *pdata,
-						    int pdata_len)
 {
 	int ret = -ENOMEM;
 	struct platform_device *pdev;
 	struct omap_device *od;
 
-	if (!ohs || oh_cnt == 0 || !pdev_name)
+	if (!oh || !pdev_name)
 		return ERR_PTR(-EINVAL);
 
 	if (!pdata && pdata_len > 0)
 		return ERR_PTR(-EINVAL);
 
+	if (strncmp(oh->name, "smartreflex", 11) &&
+	    strncmp(oh->name, "dma", 3)) {
+		pr_warn("%s need to update %s to probe with dt\na",
+			__func__, pdev_name);
+		ret = -ENODEV;
+		goto odbs_exit;
+	}
+
 	pdev = platform_device_alloc(pdev_name, pdev_id);
 	if (!pdev) {
 		ret = -ENOMEM;
@@ -591,7 +657,16 @@ struct platform_device __init *omap_device_build_ss(const char *pdev_name,
 	else
 		dev_set_name(&pdev->dev, "%s", pdev->name);
 
-	od = omap_device_alloc(pdev, ohs, oh_cnt);
+	/*
+	 * Must be called before omap_device_alloc() as oh->od
+	 * only contains the currently registered omap_device
+	 * and will get overwritten by omap_device_alloc().
+	 */
+	ret = omap_device_copy_resources(oh, pdev);
+	if (ret)
+		goto odbs_exit1;
+
+	od = omap_device_alloc(pdev, &oh, 1);
 	if (IS_ERR(od))
 		goto odbs_exit1;
 
diff --git a/arch/arm/mach-omap2/omap_device.h b/arch/arm/mach-omap2/omap_device.h
--- a/arch/arm/mach-omap2/omap_device.h
+++ b/arch/arm/mach-omap2/omap_device.h
@@ -75,10 +75,6 @@ struct platform_device *omap_device_build(const char *pdev_name, int pdev_id,
 					  struct omap_hwmod *oh, void *pdata,
 					  int pdata_len);
 
-struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
-					 struct omap_hwmod **oh, int oh_cnt,
-					 void *pdata, int pdata_len);
-
 struct omap_device *omap_device_alloc(struct platform_device *pdev,
 				      struct omap_hwmod **ohs, int oh_cnt);
 void omap_device_delete(struct omap_device *od);
-- 
2.14.2
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
