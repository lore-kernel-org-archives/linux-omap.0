From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 4/6] omap: iommu: intial hwmod support
Date: Fri,  5 Nov 2010 19:19:54 -0600
Message-ID: <1289006396-27230-5-git-send-email-omar.ramirez@ti.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50215 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752950Ab0KFBab (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Nov 2010 21:30:31 -0400
In-Reply-To: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Russell King <linux@arm.linux.org.uk>, Hari Kanigeri <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Charulatha V <charu@ti.com>, Ramesh Gupta <grgupta@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Use the defined hwmod data according to the devices
present on omap3 and omap4.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap-iommu.c        |   77 ++++++++-----------------------
 arch/arm/plat-omap/include/plat/iommu.h |    2 +-
 arch/arm/plat-omap/iommu.c              |    2 +-
 3 files changed, 21 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index f5a1aad..65460ef 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -14,12 +14,11 @@
 
 #include <plat/iommu.h>
 #include <plat/irqs.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 
 struct iommu_device {
-	resource_size_t base;
-	int irq;
 	struct iommu_platform_data pdata;
-	struct resource res[2];
 };
 static struct iommu_device *devices;
 static int num_iommu_devices;
@@ -27,128 +26,90 @@ static int num_iommu_devices;
 #ifdef CONFIG_ARCH_OMAP3
 static struct iommu_device omap3_devices[] = {
 	{
-		.base = 0x480bd400,
-		.irq = 24,
 		.pdata = {
 			.name = "isp",
-			.nr_tlb_entries = 8,
 			.clk_name = "cam_ick",
 		},
 	},
 #if defined(CONFIG_MPU_BRIDGE_IOMMU)
 	{
-		.base = 0x5d000000,
-		.irq = 28,
 		.pdata = {
 			.name = "iva2",
-			.nr_tlb_entries = 32,
 			.clk_name = "iva2_ck",
 		},
 	},
 #endif
 };
 #define NR_OMAP3_IOMMU_DEVICES ARRAY_SIZE(omap3_devices)
-static struct platform_device *omap3_iommu_pdev[NR_OMAP3_IOMMU_DEVICES];
 #else
 #define omap3_devices		NULL
 #define NR_OMAP3_IOMMU_DEVICES	0
-#define omap3_iommu_pdev	NULL
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
 static struct iommu_device omap4_devices[] = {
 	{
-		.base = OMAP4_MMU1_BASE,
-		.irq = OMAP44XX_IRQ_DUCATI_MMU,
 		.pdata = {
 			.name = "ducati",
-			.nr_tlb_entries = 32,
 			.clk_name = "ducati_ick",
 		},
 	},
 #if defined(CONFIG_MPU_TESLA_IOMMU)
 	{
-		.base = OMAP4_MMU2_BASE,
-		.irq = INT_44XX_DSP_MMU,
 		.pdata = {
 			.name = "tesla",
-			.nr_tlb_entries = 32,
 			.clk_name = "tesla_ick",
 		},
 	},
 #endif
 };
 #define NR_OMAP4_IOMMU_DEVICES ARRAY_SIZE(omap4_devices)
-static struct platform_device *omap4_iommu_pdev[NR_OMAP4_IOMMU_DEVICES];
 #else
 #define omap4_devices		NULL
 #define NR_OMAP4_IOMMU_DEVICES	0
-#define omap4_iommu_pdev	NULL
 #endif
 
-static struct platform_device **omap_iommu_pdev;
-
 static int __init omap_iommu_init(void)
 {
-	int i, err;
-	struct resource res[] = {
-		{ .flags = IORESOURCE_MEM },
-		{ .flags = IORESOURCE_IRQ },
-	};
+	int i;
 
 	if (cpu_is_omap34xx()) {
 		devices = omap3_devices;
-		omap_iommu_pdev = omap3_iommu_pdev;
 		num_iommu_devices = NR_OMAP3_IOMMU_DEVICES;
 	} else if (cpu_is_omap44xx()) {
 		devices = omap4_devices;
-		omap_iommu_pdev = omap4_iommu_pdev;
 		num_iommu_devices = NR_OMAP4_IOMMU_DEVICES;
 	} else
 		return -ENODEV;
 
 	for (i = 0; i < num_iommu_devices; i++) {
-		struct platform_device *pdev;
-		const struct iommu_device *d = &devices[i];
+		struct omap_hwmod *oh;
+		struct omap_device *od;
 
-		pdev = platform_device_alloc("omap-iommu", i);
-		if (!pdev) {
-			err = -ENOMEM;
-			goto err_out;
+		oh = omap_hwmod_lookup(devices[i].pdata.name);
+		if (!oh) {
+			pr_err("%s: hwmod not found\n", __func__);
+			return -ENODEV;
 		}
 
-		res[0].start = d->base;
-		res[0].end = d->base + MMU_REG_SIZE - 1;
-		res[1].start = res[1].end = d->irq;
+		devices[i].pdata.mmu_attr =
+				(struct omap_mmu_dev_attr *)oh->dev_attr;
 
-		err = platform_device_add_resources(pdev, res,
-						    ARRAY_SIZE(res));
-		if (err)
-			goto err_out;
-		err = platform_device_add_data(pdev, &d->pdata,
-					       sizeof(d->pdata));
-		if (err)
-			goto err_out;
-		err = platform_device_add(pdev);
-		if (err)
-			goto err_out;
-		omap_iommu_pdev[i] = pdev;
+		od = omap_device_build("omap-iommu", i, oh,
+				&devices[i].pdata, sizeof(devices[i].pdata),
+				NULL, 0,
+				0);
+		if (!od) {
+			pr_err("%s: error device build failed\n", __func__);
+			return -EPERM;
+		}
 	}
 	return 0;
-
-err_out:
-	while (i--)
-		platform_device_put(omap_iommu_pdev[i]);
-	return err;
 }
 module_init(omap_iommu_init);
 
 static void __exit omap_iommu_exit(void)
 {
-	int i;
-
-	for (i = 0; i < num_iommu_devices; i++)
-		platform_device_unregister(omap_iommu_pdev[i]);
 }
 module_exit(omap_iommu_exit);
 
diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index 91a75a5..9650309 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -110,7 +110,7 @@ struct omap_mmu_dev_attr {
 struct iommu_platform_data {
 	const char *name;
 	const char *clk_name;
-	const int nr_tlb_entries;
+	struct omap_mmu_dev_attr *mmu_attr;
 };
 
 #if defined(CONFIG_ARCH_OMAP1)
diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index de992c8..0fc9d90 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -890,7 +890,7 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
 	if (IS_ERR(obj->clk))
 		goto err_clk;
 
-	obj->nr_tlb_entries = pdata->nr_tlb_entries;
+	obj->nr_tlb_entries = pdata->mmu_attr->nr_tlb_entries;
 	obj->name = pdata->name;
 	obj->dev = &pdev->dev;
 	obj->ctx = (void *)obj + sizeof(*obj);
-- 
1.7.1

