From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 3/6] omap iommu: omap3 iommu device registration
Date: Mon, 18 May 2009 17:26:13 +0300 (EEST)
Message-ID: <20090518.172613.116355729.Hiroshi.DOYU@nokia.com>
References: <20090505124700.4583.69988.stgit@oreo.research.nokia.com>
	<20090516092036.GD15328@n2100.arm.linux.org.uk>
	<20090516095514.GJ15328@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Mon_May_18_17_26_13_2009_484)--"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23298 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbZERO06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 10:26:58 -0400
In-Reply-To: <20090516095514.GJ15328@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

----Next_Part(Mon_May_18_17_26_13_2009_484)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/6] omap iommu: omap3 iommu device registration
Date: Sat, 16 May 2009 11:55:14 +0200

> On Sat, May 16, 2009 at 10:20:36AM +0100, Russell King - ARM Linux wrote:
> > This looks all very convoluted.  Why not do something like:
> > 
> > static unsigned long iommu_base[] = {
> > 	OMAP3_MMU1_BASE,
> > 	OMAP3_MMU2_BASE,
> > };
> > 
> > static int iommu_irq[] = {
> > 	OMAP3_MMU1_IRQ,
> > 	OMAP3_MMU2_IRQ,
> > };
> 
> BTW, both of these can be __initdata.

Attached the updated one.

----Next_Part(Mon_May_18_17_26_13_2009_484)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0003-omap-iommu-omap3-iommu-device-registration.patch"

>From 2bfdb4130433708dc04e1c30aa5099d48de408e0 Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Wed, 28 Jan 2009 21:32:04 +0200
Subject: [PATCH 3/6] omap iommu: omap3 iommu device registration

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/omap3-iommu.c |  103 +++++++++++++++++++++++++++++++++++++
 1 files changed, 103 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap3-iommu.c

diff --git a/arch/arm/mach-omap2/omap3-iommu.c b/arch/arm/mach-omap2/omap3-iommu.c
new file mode 100644
index 0000000..91ee38a
--- /dev/null
+++ b/arch/arm/mach-omap2/omap3-iommu.c
@@ -0,0 +1,103 @@
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
+
+static unsigned long iommu_base[] __initdata = {
+	OMAP3_MMU1_BASE,
+	OMAP3_MMU2_BASE,
+};
+
+static int iommu_irq[] __initdata = {
+	OMAP3_MMU1_IRQ,
+	OMAP3_MMU2_IRQ,
+};
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
+		struct resource res[2];
+
+		pdev = platform_device_alloc("omap-iommu", i);
+		if (!pdev) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+
+		memset(res, 0,  sizeof(res));
+		res[0].start = iommu_base[i];
+		res[0].end = iommu_base[i] + MMU_REG_SIZE - 1;
+		res[0].flags = IORESOURCE_MEM;
+		res[1].start = res[1].end = iommu_irq[i];
+		res[1].flags = IORESOURCE_IRQ;
+
+		err = platform_device_add_resources(pdev, res,
+						    ARRAY_SIZE(res));
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
-- 
1.6.0.4


----Next_Part(Mon_May_18_17_26_13_2009_484)----
