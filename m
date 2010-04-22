From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 1/4][v4] OMAP:iommu renamed omap3-iommu to omap-iommu
Date: Thu, 22 Apr 2010 18:26:08 -0500
Message-ID: <1271978771-26889-2-git-send-email-h-kanigeri2@ti.com>
References: <1271978771-26889-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35270 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753774Ab0DVXIV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Apr 2010 19:08:21 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3MN8KoW017185
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Apr 2010 18:08:20 -0500
In-Reply-To: <1271978771-26889-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap <linux-omap@vger.kernel.org> Tony Lindgren
	<tony@atomide.com> Hiroshi Doyu" <Hiroshi.DOYU@nokia.com>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>

This patch includes changes to omap3-iommu.c file to make it generic
for all OMAPs. Renamed omap3-iommu.c to omap-iommu.c

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/Makefile                       |    4 +--
 .../arm/mach-omap2/{omap3-iommu.c => omap-iommu.c} |   23 +++++++++++--------
 2 files changed, 14 insertions(+), 13 deletions(-)
 rename arch/arm/mach-omap2/{omap3-iommu.c => omap-iommu.c} (79%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index dac3e56..0f616cb 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -88,9 +88,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= remoteproc24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= remoteproc3xxx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= remoteproc44xx.o
 endif
-iommu-y					+= iommu2.o
-iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
-
+iommu-y					+= iommu2.o omap-iommu.o
 obj-$(CONFIG_OMAP_IOMMU)		+= $(iommu-y)
 
 i2c-omap-$(CONFIG_I2C_OMAP)		:= i2c.o
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
1.7.0

