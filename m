From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH] omap iommu: support for OMAP4
Date: Mon, 10 May 2010 12:16:05 +0300
Message-ID: <1273482972-5586-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48896 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954Ab0EJJSt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 05:18:49 -0400
In-Reply-To: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Kanigeri, Hari <h-kanigeri2@ti.com>

This patch provides the iommu support for OMAP4 co-processors.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/omap-iommu.c           |   59 +++++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/omap44xx.h |    3 +
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index 416a65d..eb9bee7 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 
 #include <plat/iommu.h>
+#include <plat/irqs.h>
 
 struct iommu_device {
 	resource_size_t base;
@@ -20,9 +21,11 @@ struct iommu_device {
 	struct iommu_platform_data pdata;
 	struct resource res[2];
 };
+static struct iommu_device *devices;
+static int num_iommu_devices;
 
 #ifdef CONFIG_ARCH_OMAP3
-static struct iommu_device devices[] = {
+static struct iommu_device omap3_devices[] = {
 	{
 		.base = 0x480bd400,
 		.irq = 24,
@@ -44,11 +47,46 @@ static struct iommu_device devices[] = {
 	},
 #endif
 };
+#define NR_OMAP3_IOMMU_DEVICES ARRAY_SIZE(omap3_devices)
+static struct platform_device *omap3_iommu_pdev[NR_OMAP3_IOMMU_DEVICES];
+#else
+#define omap3_devices		NULL
+#define NR_OMAP3_IOMMU_DEVICES	0
+#define omap3_iommu_pdev	NULL
 #endif
 
-#define NR_IOMMU_DEVICES ARRAY_SIZE(devices)
+#ifdef CONFIG_ARCH_OMAP4
+static struct iommu_device omap4_devices[] = {
+	{
+		.base = OMAP4_MMU1_BASE,
+		.irq = INT_44XX_DUCATI_MMU_IRQ,
+		.pdata = {
+			.name = "ducati",
+			.nr_tlb_entries = 32,
+			.clk_name = "ducati_ick",
+		},
+	},
+#if defined(CONFIG_MPU_TESLA_IOMMU)
+	{
+		.base = OMAP4_MMU2_BASE,
+		.irq = INT_44XX_DSP_MMU,
+		.pdata = {
+			.name = "tesla",
+			.nr_tlb_entries = 32,
+			.clk_name = "tesla_ick",
+		},
+	},
+#endif
+};
+#define NR_OMAP4_IOMMU_DEVICES ARRAY_SIZE(omap4_devices)
+static struct platform_device *omap4_iommu_pdev[NR_OMAP4_IOMMU_DEVICES];
+#else
+#define omap4_devices		NULL
+#define NR_OMAP4_IOMMU_DEVICES	0
+#define omap4_iommu_pdev	NULL
+#endif
 
-static struct platform_device *omap_iommu_pdev[NR_IOMMU_DEVICES];
+static struct platform_device **omap_iommu_pdev;
 
 static int __init omap_iommu_init(void)
 {
@@ -58,7 +96,18 @@ static int __init omap_iommu_init(void)
 		{ .flags = IORESOURCE_IRQ },
 	};
 
-	for (i = 0; i < NR_IOMMU_DEVICES; i++) {
+	if (cpu_is_omap34xx()) {
+		devices = omap3_devices;
+		omap_iommu_pdev = omap3_iommu_pdev;
+		num_iommu_devices = NR_OMAP3_IOMMU_DEVICES;
+	} else if (cpu_is_omap44xx()) {
+		devices = omap4_devices;
+		omap_iommu_pdev = omap4_iommu_pdev;
+		num_iommu_devices = NR_OMAP4_IOMMU_DEVICES;
+	} else
+		return -ENODEV;
+
+	for (i = 0; i < num_iommu_devices; i++) {
 		struct platform_device *pdev;
 		const struct iommu_device *d = &devices[i];
 
@@ -98,7 +147,7 @@ static void __exit omap_iommu_exit(void)
 {
 	int i;
 
-	for (i = 0; i < NR_IOMMU_DEVICES; i++)
+	for (i = 0; i < num_iommu_devices; i++)
 		platform_device_unregister(omap_iommu_pdev[i]);
 }
 module_exit(omap_iommu_exit);
diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index b3ef1a7..bb94a0b 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -48,5 +48,8 @@
 #define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
 #define OMAP44XX_HSUSB_OTG_BASE		(L4_44XX_BASE + 0xAB000)
 
+#define OMAP4_MMU1_BASE			0x55082000
+#define OMAP4_MMU2_BASE			0x4A066000
+
 #endif /* __ASM_ARCH_OMAP44XX_H */
 
-- 
1.7.1.rc1

