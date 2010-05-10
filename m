From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH] omap iommu: renamed omap3-iommu to omap-iommu
Date: Mon, 10 May 2010 12:16:04 +0300
Message-ID: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28296 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525Ab0EJJSi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 05:18:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Kanigeri, Hari <h-kanigeri2@ti.com>

This patch includes changes to omap3-iommu.c file to make it generic
for all OMAPs. Renamed omap3-iommu.c to omap-iommu.c

[Hiroshi DOYU: Remove unnecessary "iommy-y" in Makefile]

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/Makefile                       |    5 +---
 .../arm/mach-omap2/{omap3-iommu.c => omap-iommu.c} |   23 +++++++++++--------
 2 files changed, 14 insertions(+), 14 deletions(-)
 rename arch/arm/mach-omap2/{omap3-iommu.c => omap-iommu.c} (79%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4b9fc57..7d2cf0f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -89,10 +89,7 @@ obj-$(CONFIG_OMAP3_EMU)			+= emu.o
 obj-$(CONFIG_OMAP_MBOX_FWK)		+= mailbox_mach.o
 mailbox_mach-objs			:= mailbox.o
 
-iommu-y					+= iommu2.o
-iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
-
-obj-$(CONFIG_OMAP_IOMMU)		+= $(iommu-y)
+obj-$(CONFIG_OMAP_IOMMU)		:= iommu2.o omap-iommu.o
 
 i2c-omap-$(CONFIG_I2C_OMAP)		:= i2c.o
 obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
diff --git a/arch/arm/mach-omap2/omap3-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
similarity index 79%
rename from arch/arm/mach-omap2/omap3-iommu.c
rename to arch/arm/mach-omap2/omap-iommu.c
index fbbcb5c..416a65d 100644
--- a/arch/arm/mach-omap2/omap3-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -1,5 +1,5 @@
 /*
- * omap iommu: omap3 device registration
+ * omap iommu: omap device registration
  *
  * Copyright (C) 2008-2009 Nokia Corporation
  *
@@ -21,6 +21,7 @@ struct iommu_device {
 	struct resource res[2];
 };
 
+#ifdef CONFIG_ARCH_OMAP3
 static struct iommu_device devices[] = {
 	{
 		.base = 0x480bd400,
@@ -43,11 +44,13 @@ static struct iommu_device devices[] = {
 	},
 #endif
 };
+#endif
+
 #define NR_IOMMU_DEVICES ARRAY_SIZE(devices)
 
-static struct platform_device *omap3_iommu_pdev[NR_IOMMU_DEVICES];
+static struct platform_device *omap_iommu_pdev[NR_IOMMU_DEVICES];
 
-static int __init omap3_iommu_init(void)
+static int __init omap_iommu_init(void)
 {
 	int i, err;
 	struct resource res[] = {
@@ -80,26 +83,26 @@ static int __init omap3_iommu_init(void)
 		err = platform_device_add(pdev);
 		if (err)
 			goto err_out;
-		omap3_iommu_pdev[i] = pdev;
+		omap_iommu_pdev[i] = pdev;
 	}
 	return 0;
 
 err_out:
 	while (i--)
-		platform_device_put(omap3_iommu_pdev[i]);
+		platform_device_put(omap_iommu_pdev[i]);
 	return err;
 }
-module_init(omap3_iommu_init);
+module_init(omap_iommu_init);
 
-static void __exit omap3_iommu_exit(void)
+static void __exit omap_iommu_exit(void)
 {
 	int i;
 
 	for (i = 0; i < NR_IOMMU_DEVICES; i++)
-		platform_device_unregister(omap3_iommu_pdev[i]);
+		platform_device_unregister(omap_iommu_pdev[i]);
 }
-module_exit(omap3_iommu_exit);
+module_exit(omap_iommu_exit);
 
 MODULE_AUTHOR("Hiroshi DOYU");
-MODULE_DESCRIPTION("omap iommu: omap3 device registration");
+MODULE_DESCRIPTION("omap iommu: omap device registration");
 MODULE_LICENSE("GPL v2");
-- 
1.7.1.rc1

