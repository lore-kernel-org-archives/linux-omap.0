From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/6] ARM: OMAP2+: Populate legacy resources for dma and
 smartreflex
Date: Tue, 29 Aug 2017 10:29:56 -0700
Message-ID: <20170829173001.20358-2-tony@atomide.com>
References: <20170829173001.20358-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170829173001.20358-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Lokesh Vutla <lokeshvutla@ti.com>, Tero Kristo <t-kristo@ti.com>, Marc Zyngier <marc.zyngier@arm.com>, linux-arm-kernel@lists.infradead.org
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

Cc: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_device.c | 114 +++++++++++++++++++++++++++-----------
 arch/arm/mach-omap2/omap_device.h |   4 --
 2 files changed, 83 insertions(+), 35 deletions(-)

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
@@ -521,6 +523,68 @@ void omap_device_delete(struct omap_device *od)
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
+ * call this for omap_device_build_from_dt(), or for any other
+ * device. Any need to do so means SoC has incomplete dts data.
+ */
+static int
+omap_device_copy_resources(struct omap_hwmod *oh,
+			   struct platform_device *pdev)
+{
+	struct device_node *np;
+	struct resource *res;
+	int error, irq;
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
+	error = of_address_to_resource(np, 0, res);
+	if (error)
+		goto free;
+
+	res[0].name = "mpu";
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (!irq)
+		goto free;
+
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
@@ -539,46 +603,25 @@ struct platform_device __init *omap_device_build(const char *pdev_name,
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
@@ -591,7 +634,16 @@ struct platform_device __init *omap_device_build_ss(const char *pdev_name,
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
2.14.1
