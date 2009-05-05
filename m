From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 3/6] omap iommu: omap3 iommu device registration
Date: Tue, 05 May 2009 15:47:00 +0300
Message-ID: <20090505124700.4583.69988.stgit@oreo.research.nokia.com>
References: <20090505123905.4583.69865.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38037 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410AbZEEMr3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 May 2009 08:47:29 -0400
In-Reply-To: <20090505123905.4583.69865.stgit@oreo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---

 arch/arm/mach-omap2/omap3-iommu.c |  105 +++++++++++++++++++++++++++++++++++++
 1 files changed, 105 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap3-iommu.c

diff --git a/arch/arm/mach-omap2/omap3-iommu.c b/arch/arm/mach-omap2/omap3-iommu.c
new file mode 100644
index 0000000..367f36a
--- /dev/null
+++ b/arch/arm/mach-omap2/omap3-iommu.c
@@ -0,0 +1,105 @@
+/*
+ * omap iommu: omap3 device registration
+ *
+ * Copyright (C) 2008-2009 Nokia Corporation
+ *
+ * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/platform_device.h>
+
+#include <mach/iommu.h>
+
+#define OMAP3_MMU1_BASE	0x480bd400
+#define OMAP3_MMU2_BASE	0x5d000000
+#define OMAP3_MMU1_IRQ	24
+#define OMAP3_MMU2_IRQ	28
+
+static struct resource omap3_iommu_res[] = {
+	{ /* Camera ISP MMU */
+		.start		= OMAP3_MMU1_BASE,
+		.end		= OMAP3_MMU1_BASE + MMU_REG_SIZE - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP3_MMU1_IRQ,
+		.flags		= IORESOURCE_IRQ,
+	},
+	{ /* IVA2.2 MMU */
+		.start		= OMAP3_MMU2_BASE,
+		.end		= OMAP3_MMU2_BASE + MMU_REG_SIZE - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP3_MMU2_IRQ,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+#define NR_IOMMU_RES (ARRAY_SIZE(omap3_iommu_res) / 2)
+
+static const struct iommu_platform_data omap3_iommu_pdata[] __initconst = {
+	{
+		.name = "isp",
+		.nr_tlb_entries = 8,
+		.clk_name = "cam_ick",
+	},
+	{
+		.name = "iva2",
+		.nr_tlb_entries = 32,
+		.clk_name = "iva2_ck",
+	},
+};
+#define NR_IOMMU_DEVICES ARRAY_SIZE(omap3_iommu_pdata)
+
+static struct platform_device *omap3_iommu_pdev[NR_IOMMU_DEVICES];
+
+static int __init omap3_iommu_init(void)
+{
+	int i, err;
+
+	for (i = 0; i < NR_IOMMU_DEVICES; i++) {
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("omap-iommu", i + 1);
+		if (!pdev) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+		err = platform_device_add_resources(pdev,
+				    &omap3_iommu_res[2 * i], NR_IOMMU_RES);
+		if (err)
+			goto err_out;
+		err = platform_device_add_data(pdev, &omap3_iommu_pdata[i],
+					       sizeof(omap3_iommu_pdata[0]));
+		if (err)
+			goto err_out;
+		err = platform_device_add(pdev);
+		if (err)
+			goto err_out;
+		omap3_iommu_pdev[i] = pdev;
+	}
+	return 0;
+
+err_out:
+	while (i--)
+		platform_device_put(omap3_iommu_pdev[i]);
+	return err;
+}
+module_init(omap3_iommu_init);
+
+static void __exit omap3_iommu_exit(void)
+{
+	int i;
+
+	for (i = 0; i < NR_IOMMU_DEVICES; i++)
+		platform_device_unregister(omap3_iommu_pdev[i]);
+}
+module_exit(omap3_iommu_exit);
+
+MODULE_AUTHOR("Hiroshi DOYU");
+MODULE_DESCRIPTION("omap iommu: omap3 device registration");
+MODULE_LICENSE("GPL v2");

