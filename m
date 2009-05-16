From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 1/3] omap3-iommu: reorganize
Date: Sat, 16 May 2009 13:05:48 +0300
Message-ID: <1242468350-23190-2-git-send-email-felipe.contreras@gmail.com>
References: <1242468350-23190-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:57507 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096AbZEPKFz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 06:05:55 -0400
Received: by fxm2 with SMTP id 2so2342840fxm.37
        for <linux-omap@vger.kernel.org>; Sat, 16 May 2009 03:05:55 -0700 (PDT)
In-Reply-To: <1242468350-23190-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <hiroshi.doyu@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk, Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 arch/arm/mach-omap2/omap3-iommu.c |   72 ++++++++++++++++++------------------
 1 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap2/omap3-iommu.c b/arch/arm/mach-omap2/omap3-iommu.c
index 367f36a..f4232ec 100644
--- a/arch/arm/mach-omap2/omap3-iommu.c
+++ b/arch/arm/mach-omap2/omap3-iommu.c
@@ -14,43 +14,31 @@
 
 #include <mach/iommu.h>
 
-#define OMAP3_MMU1_BASE	0x480bd400
-#define OMAP3_MMU2_BASE	0x5d000000
-#define OMAP3_MMU1_IRQ	24
-#define OMAP3_MMU2_IRQ	28
-
-static struct resource omap3_iommu_res[] = {
-	{ /* Camera ISP MMU */
-		.start		= OMAP3_MMU1_BASE,
-		.end		= OMAP3_MMU1_BASE + MMU_REG_SIZE - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.start		= OMAP3_MMU1_IRQ,
-		.flags		= IORESOURCE_IRQ,
-	},
-	{ /* IVA2.2 MMU */
-		.start		= OMAP3_MMU2_BASE,
-		.end		= OMAP3_MMU2_BASE + MMU_REG_SIZE - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.start		= OMAP3_MMU2_IRQ,
-		.flags		= IORESOURCE_IRQ,
-	},
+struct iommu_device {
+	resource_size_t base;
+	resource_size_t irq;
+	struct iommu_platform_data pdata;
+	struct resource res[2];
 };
-#define NR_IOMMU_RES (ARRAY_SIZE(omap3_iommu_res) / 2)
 
-static const struct iommu_platform_data omap3_iommu_pdata[] __initconst = {
+static struct iommu_device devices[] = {
 	{
-		.name = "isp",
-		.nr_tlb_entries = 8,
-		.clk_name = "cam_ick",
+		.base = 0x480bd400,
+		.irq = 24,
+		.pdata = {
+			.name = "isp",
+			.nr_tlb_entries = 8,
+			.clk_name = "cam_ick",
+		},
 	},
 	{
-		.name = "iva2",
-		.nr_tlb_entries = 32,
-		.clk_name = "iva2_ck",
+		.base = 0x5d000000,
+		.irq = 28,
+		.pdata = {
+			.name = "iva2",
+			.nr_tlb_entries = 32,
+			.clk_name = "iva2_ck",
+		},
 	},
 };
 #define NR_IOMMU_DEVICES ARRAY_SIZE(omap3_iommu_pdata)
@@ -63,23 +51,35 @@ static int __init omap3_iommu_init(void)
 
 	for (i = 0; i < NR_IOMMU_DEVICES; i++) {
 		struct platform_device *pdev;
+		const struct iommu_device *d = &devices[i];
+		struct resource res[] = {
+			{ .flags = IORESOURCE_MEM },
+			{ .flags = IORESOURCE_IRQ },
+		};
 
 		pdev = platform_device_alloc("omap-iommu", i + 1);
 		if (!pdev) {
 			err = -ENOMEM;
 			goto err_out;
 		}
-		err = platform_device_add_resources(pdev,
-				    &omap3_iommu_res[2 * i], NR_IOMMU_RES);
+
+		res[0].start = d->base;
+		res[0].end = d->base + MMU_REG_SIZE - 1;
+
+		res[1].start = d->irq;
+
+		err = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
 		if (err)
 			goto err_out;
-		err = platform_device_add_data(pdev, &omap3_iommu_pdata[i],
-					       sizeof(omap3_iommu_pdata[0]));
+
+		err = platform_device_add_data(pdev, &d->pdata, sizeof(d->pdata));
 		if (err)
 			goto err_out;
+
 		err = platform_device_add(pdev);
 		if (err)
 			goto err_out;
+
 		omap3_iommu_pdev[i] = pdev;
 	}
 	return 0;
-- 
1.6.3.1

