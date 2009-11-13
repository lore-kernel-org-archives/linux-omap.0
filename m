From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/14] omap: iommu: reorganize
Date: Thu, 12 Nov 2009 16:08:12 -0800
Message-ID: <20091113000812.9034.16880.stgit@localhost>
References: <20091113000444.9034.41293.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51907 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239AbZKMAII (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 19:08:08 -0500
In-Reply-To: <20091113000444.9034.41293.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org

From: Felipe Contreras <felipe.contreras@gmail.com>

This way it's more object oriented and easier to see what is happening.
No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap3-iommu.c |   62 +++++++++++++++++++------------------
 1 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap2/omap3-iommu.c b/arch/arm/mach-omap2/omap3-iommu.c
index 6a9bf4f..fbbcb5c 100644
--- a/arch/arm/mach-omap2/omap3-iommu.c
+++ b/arch/arm/mach-omap2/omap3-iommu.c
@@ -14,47 +14,50 @@
 
 #include <plat/iommu.h>
 
-#define OMAP3_MMU1_BASE	0x480bd400
-#define OMAP3_MMU2_BASE	0x5d000000
-#define OMAP3_MMU1_IRQ	24
-#define OMAP3_MMU2_IRQ	28
-
-
-static unsigned long iommu_base[] __initdata = {
-	OMAP3_MMU1_BASE,
-	OMAP3_MMU2_BASE,
-};
-
-static int iommu_irq[] __initdata = {
-	OMAP3_MMU1_IRQ,
-	OMAP3_MMU2_IRQ,
+struct iommu_device {
+	resource_size_t base;
+	int irq;
+	struct iommu_platform_data pdata;
+	struct resource res[2];
 };
 
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
 #if defined(CONFIG_MPU_BRIDGE_IOMMU)
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
 #endif
 };
-#define NR_IOMMU_DEVICES ARRAY_SIZE(omap3_iommu_pdata)
+#define NR_IOMMU_DEVICES ARRAY_SIZE(devices)
 
 static struct platform_device *omap3_iommu_pdev[NR_IOMMU_DEVICES];
 
 static int __init omap3_iommu_init(void)
 {
 	int i, err;
+	struct resource res[] = {
+		{ .flags = IORESOURCE_MEM },
+		{ .flags = IORESOURCE_IRQ },
+	};
 
 	for (i = 0; i < NR_IOMMU_DEVICES; i++) {
 		struct platform_device *pdev;
-		struct resource res[2];
+		const struct iommu_device *d = &devices[i];
 
 		pdev = platform_device_alloc("omap-iommu", i);
 		if (!pdev) {
@@ -62,19 +65,16 @@ static int __init omap3_iommu_init(void)
 			goto err_out;
 		}
 
-		memset(res, 0,  sizeof(res));
-		res[0].start = iommu_base[i];
-		res[0].end = iommu_base[i] + MMU_REG_SIZE - 1;
-		res[0].flags = IORESOURCE_MEM;
-		res[1].start = res[1].end = iommu_irq[i];
-		res[1].flags = IORESOURCE_IRQ;
+		res[0].start = d->base;
+		res[0].end = d->base + MMU_REG_SIZE - 1;
+		res[1].start = res[1].end = d->irq;
 
 		err = platform_device_add_resources(pdev, res,
 						    ARRAY_SIZE(res));
 		if (err)
 			goto err_out;
-		err = platform_device_add_data(pdev, &omap3_iommu_pdata[i],
-					       sizeof(omap3_iommu_pdata[0]));
+		err = platform_device_add_data(pdev, &d->pdata,
+					       sizeof(d->pdata));
 		if (err)
 			goto err_out;
 		err = platform_device_add(pdev);

