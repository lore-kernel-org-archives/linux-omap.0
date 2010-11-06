From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 5/6] omap: iommu: hwmod device enable/disable routines
Date: Fri,  5 Nov 2010 19:19:55 -0600
Message-ID: <1289006396-27230-6-git-send-email-omar.ramirez@ti.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43053 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157Ab0KFBae (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Nov 2010 21:30:34 -0400
In-Reply-To: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Russell King <linux@arm.linux.org.uk>, Hari Kanigeri <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Charulatha V <charu@ti.com>, Ramesh Gupta <grgupta@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Use omap device enable/disable routines.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap-iommu.c        |   16 +++++++++++-----
 arch/arm/plat-omap/include/plat/iommu.h |    7 +++++--
 arch/arm/plat-omap/iommu.c              |   24 +++++++++++++++---------
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index 65460ef..0a76bce 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -28,14 +28,12 @@ static struct iommu_device omap3_devices[] = {
 	{
 		.pdata = {
 			.name = "isp",
-			.clk_name = "cam_ick",
 		},
 	},
 #if defined(CONFIG_MPU_BRIDGE_IOMMU)
 	{
 		.pdata = {
 			.name = "iva2",
-			.clk_name = "iva2_ck",
 		},
 	},
 #endif
@@ -51,14 +49,12 @@ static struct iommu_device omap4_devices[] = {
 	{
 		.pdata = {
 			.name = "ducati",
-			.clk_name = "ducati_ick",
 		},
 	},
 #if defined(CONFIG_MPU_TESLA_IOMMU)
 	{
 		.pdata = {
 			.name = "tesla",
-			.clk_name = "tesla_ick",
 		},
 	},
 #endif
@@ -69,6 +65,14 @@ static struct iommu_device omap4_devices[] = {
 #define NR_OMAP4_IOMMU_DEVICES	0
 #endif
 
+static struct omap_device_pm_latency iommu_latencies[] = {
+	[0] = {
+		.activate_func = omap_device_enable_clocks,
+		.deactivate_func = omap_device_enable_clocks,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST
+	},
+};
+
 static int __init omap_iommu_init(void)
 {
 	int i;
@@ -94,10 +98,12 @@ static int __init omap_iommu_init(void)
 
 		devices[i].pdata.mmu_attr =
 				(struct omap_mmu_dev_attr *)oh->dev_attr;
+		devices[i].pdata.device_enable = omap_device_enable;
+		devices[i].pdata.device_disable = omap_device_idle;
 
 		od = omap_device_build("omap-iommu", i, oh,
 				&devices[i].pdata, sizeof(devices[i].pdata),
-				NULL, 0,
+				iommu_latencies, ARRAY_SIZE(iommu_latencies),
 				0);
 		if (!od) {
 			pr_err("%s: error device build failed\n", __func__);
diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index 9650309..fd8ffeb 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -13,6 +13,8 @@
 #ifndef __MACH_IOMMU_H
 #define __MACH_IOMMU_H
 
+struct platform_device;
+
 struct iotlb_entry {
 	u32 da;
 	u32 pa;
@@ -28,7 +30,6 @@ struct iotlb_entry {
 struct iommu {
 	const char	*name;
 	struct module	*owner;
-	struct clk	*clk;
 	void __iomem	*regbase;
 	struct device	*dev;
 
@@ -109,8 +110,10 @@ struct omap_mmu_dev_attr {
 
 struct iommu_platform_data {
 	const char *name;
-	const char *clk_name;
 	struct omap_mmu_dev_attr *mmu_attr;
+
+	int (*device_enable)(struct platform_device *pdev);
+	int (*device_disable)(struct platform_device *pdev);
 };
 
 #if defined(CONFIG_ARCH_OMAP1)
diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 0fc9d90..36b1b63 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -100,11 +100,17 @@ EXPORT_SYMBOL_GPL(iommu_arch_version);
 static int iommu_enable(struct iommu *obj)
 {
 	int err;
+	struct iommu_platform_data *pdata;
+	struct platform_device *pdev;
 
 	if (!obj)
 		return -EINVAL;
 
-	clk_enable(obj->clk);
+	pdev = container_of(obj->dev, struct platform_device, dev);
+	pdata = obj->dev->platform_data;
+
+	if (pdata->device_enable)
+		pdata->device_enable(pdev);
 
 	err = arch_iommu->enable(obj);
 
@@ -113,12 +119,19 @@ static int iommu_enable(struct iommu *obj)
 
 static void iommu_disable(struct iommu *obj)
 {
+	struct iommu_platform_data *pdata;
+	struct platform_device *pdev;
+
 	if (!obj)
 		return;
 
 	arch_iommu->disable(obj);
 
-	clk_disable(obj->clk);
+	pdev = container_of(obj->dev, struct platform_device, dev);
+	pdata = obj->dev->platform_data;
+
+	if (pdata->device_enable)
+		pdata->device_disable(pdev);
 }
 
 /*
@@ -886,10 +899,6 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
 	if (!obj)
 		return -ENOMEM;
 
-	obj->clk = clk_get(&pdev->dev, pdata->clk_name);
-	if (IS_ERR(obj->clk))
-		goto err_clk;
-
 	obj->nr_tlb_entries = pdata->mmu_attr->nr_tlb_entries;
 	obj->name = pdata->name;
 	obj->dev = &pdev->dev;
@@ -949,8 +958,6 @@ err_irq:
 	release_mem_region(res->start, resource_size(res));
 	iounmap(obj->regbase);
 err_mem:
-	clk_put(obj->clk);
-err_clk:
 	kfree(obj);
 	return err;
 }
@@ -972,7 +979,6 @@ static int __devexit omap_iommu_remove(struct platform_device *pdev)
 	release_mem_region(res->start, resource_size(res));
 	iounmap(obj->regbase);
 
-	clk_put(obj->clk);
 	dev_info(&pdev->dev, "%s removed\n", obj->name);
 	kfree(obj);
 	return 0;
-- 
1.7.1

