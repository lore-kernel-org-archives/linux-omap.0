From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: [PATCH v3 5/6] ARM: OMAP: iommu: add device tree support
Date: Thu, 11 Oct 2012 20:06:14 -0500
Message-ID: <1350003977-32744-10-git-send-email-omar.luna@linaro.org>
References: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Joerg Roedel <joerg.roedel@amd.com>
Cc: Russell King <linux@arm.linux.org.uk>, Omar Ramirez Luna <omar.luna@linaro.org>, Benoit Cousson <b-cousson@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: linux-omap@vger.kernel.org

Adapt driver to use DT if provided.

Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
---
 .../devicetree/bindings/arm/omap/iommu.txt         |   10 +++
 arch/arm/mach-omap2/omap-iommu.c                   |    4 ++
 drivers/iommu/omap-iommu.c                         |   65 +++++++++++++++++++-
 3 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/iommu.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/iommu.txt b/Documentation/devicetree/bindings/arm/omap/iommu.txt
new file mode 100644
index 0000000..2bb780f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/iommu.txt
@@ -0,0 +1,10 @@
+* MMU (Memory Management Unit)
+
+MMU present in OMAP subsystems.
+
+Required properties:
+ compatible : should be "ti,omap3-iommu" for OMAP3 MMUs
+ compatible : should be "ti,omap4-iommu" for OMAP4 MMUs
+
+Optional properties:
+ None
diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index 82a422a..4d6145d 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -29,6 +30,9 @@ static int __init omap_iommu_dev_init(struct omap_hwmod *oh, void *unused)
 	struct omap_mmu_dev_attr *a = (struct omap_mmu_dev_attr *)oh->dev_attr;
 	static int i;
 
+	if (of_have_populated_dt())
+		return 0;
+
 	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index e266ad7..946366f 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -21,12 +21,15 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #include <asm/cacheflush.h>
 
 #include <plat/iommu.h>
 
 #include <plat/iopgtable.h>
+#include <plat/omap_device.h>
+#include <plat/omap_hwmod.h>
 
 #define for_each_iotlb_cr(obj, n, __i, cr)				\
 	for (__i = 0;							\
@@ -916,13 +919,63 @@ static void omap_iommu_detach(struct omap_iommu *obj)
 /*
  *	OMAP Device MMU(IOMMU) detection
  */
+static int __devinit
+iommu_add_platform_data_from_dt(struct platform_device *pdev)
+{
+	struct iommu_platform_data *pdata;
+	struct device_node *node = pdev->dev.of_node;
+	struct omap_hwmod *oh;
+	struct omap_mmu_dev_attr *a;
+	int ret = 0;
+
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	of_property_read_string(node, "ti,hwmods", &pdata->name);
+	oh = omap_hwmod_lookup(pdata->name);
+	if (!oh) {
+		dev_err(&pdev->dev, "Cannot lookup hwmod '%s'\n", pdata->name);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	a = (struct omap_mmu_dev_attr *)oh->dev_attr;
+	pdata->nr_tlb_entries = a->nr_tlb_entries;
+	pdata->da_start = a->da_start;
+	pdata->da_end = a->da_end;
+
+	if (oh->rst_lines_cnt == 1) {
+		pdata->reset_name = oh->rst_lines->name;
+		pdata->assert_reset = omap_device_assert_hardreset;
+		pdata->deassert_reset = omap_device_deassert_hardreset;
+	}
+
+	ret = platform_device_add_data(pdev, pdata, sizeof(*pdata));
+	if (ret)
+		dev_err(&pdev->dev, "Cannot add pdata for %s\n", pdata->name);
+
+out:
+	kfree(pdata);
+
+	return ret;
+}
+
 static int __devinit omap_iommu_probe(struct platform_device *pdev)
 {
 	int err = -ENODEV;
 	int irq;
 	struct omap_iommu *obj;
 	struct resource *res;
-	struct iommu_platform_data *pdata = pdev->dev.platform_data;
+	struct iommu_platform_data *pdata;
+
+	if (of_have_populated_dt()) {
+		err = iommu_add_platform_data_from_dt(pdev);
+		if (err)
+			return err;
+	}
+
+	pdata = pdev->dev.platform_data;
 
 	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
 	if (!obj)
@@ -1031,12 +1084,22 @@ static const struct dev_pm_ops iommu_pm_ops = {
 			   NULL)
 };
 
+#if defined(CONFIG_OF)
+static const struct of_device_id omap_iommu_of_match[] = {
+	{ .compatible = "ti,omap3-iommu" },
+	{ .compatible = "ti,omap4-iommu" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, omap_iommu_of_match);
+#endif
+
 static struct platform_driver omap_iommu_driver = {
 	.probe	= omap_iommu_probe,
 	.remove	= __devexit_p(omap_iommu_remove),
 	.driver	= {
 		.name	= "omap-iommu",
 		.pm	= &iommu_pm_ops,
+		.of_match_table = of_match_ptr(omap_iommu_of_match),
 	},
 };
 
-- 
1.7.9.5

