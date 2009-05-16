From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 3/3] omap3-iommu: remote registration
Date: Sat, 16 May 2009 13:05:50 +0300
Message-ID: <1242468350-23190-4-git-send-email-felipe.contreras@gmail.com>
References: <1242468350-23190-1-git-send-email-felipe.contreras@gmail.com>
 <1242468350-23190-2-git-send-email-felipe.contreras@gmail.com>
 <1242468350-23190-3-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:63079 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbZEPKF7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 06:05:59 -0400
Received: by mail-fx0-f158.google.com with SMTP id 2so2342832fxm.37
        for <linux-omap@vger.kernel.org>; Sat, 16 May 2009 03:06:00 -0700 (PDT)
In-Reply-To: <1242468350-23190-3-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <hiroshi.doyu@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk, Felipe Contreras <felipe.contreras@gmail.com>

This allows devices to be registered only when they are used. The
current dsp-bridge driver for example is not using iommu so registering
the iommu iva2 device would conflict. By allowing remote registration
the dsp-bridge can decide when the iommu iva2 device is registered.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/omap3-iommu.c       |   36 +-----------------------------
 arch/arm/plat-omap/include/mach/iommu.h |    2 +
 2 files changed, 4 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-omap2/omap3-iommu.c b/arch/arm/mach-omap2/omap3-iommu.c
index 149c624..8380cd5 100644
--- a/arch/arm/mach-omap2/omap3-iommu.c
+++ b/arch/arm/mach-omap2/omap3-iommu.c
@@ -41,11 +41,8 @@ static struct iommu_device devices[] = {
 		},
 	},
 };
-#define NR_IOMMU_DEVICES ARRAY_SIZE(omap3_iommu_pdata)
 
-static struct platform_device *omap3_iommu_pdev[NR_IOMMU_DEVICES];
-
-static struct platform_device *omap_iommu_add(const char *name)
+struct platform_device *omap_iommu_add(const char *name)
 {
 	struct platform_device *pdev;
 	const struct iommu_device *d = NULL;
@@ -91,36 +88,7 @@ err_out:
 	platform_device_put(pdev);
 	return NULL;
 }
-
-static int __init omap3_iommu_init(void)
-{
-	struct platform_device *pdev;
-	int i, err;
-
-	for (i = 0; i < ARRAY_SIZE(devices); i++) {
-		pdev = omap_iommu_add(devices[i].pdata.name);
-		if (!pdev)
-			goto err_out;
-		omap3_iommu_pdev[i] = pdev;
-	}
-
-	return 0;
-
-err_out:
-	while (i--)
-		platform_device_put(omap3_iommu_pdev[i]);
-	return err;
-}
-module_init(omap3_iommu_init);
-
-static void __exit omap3_iommu_exit(void)
-{
-	int i;
-
-	for (i = 0; i < NR_IOMMU_DEVICES; i++)
-		platform_device_unregister(omap3_iommu_pdev[i]);
-}
-module_exit(omap3_iommu_exit);
+EXPORT_SYMBOL_GPL(omap_iommu_add);
 
 MODULE_AUTHOR("Hiroshi DOYU");
 MODULE_DESCRIPTION("omap iommu: omap3 device registration");
diff --git a/arch/arm/plat-omap/include/mach/iommu.h b/arch/arm/plat-omap/include/mach/iommu.h
index 769b00b..e22a4a4 100644
--- a/arch/arm/plat-omap/include/mach/iommu.h
+++ b/arch/arm/plat-omap/include/mach/iommu.h
@@ -165,4 +165,6 @@ extern int foreach_iommu_device(void *data,
 extern ssize_t iommu_dump_ctx(struct iommu *obj, char *buf);
 extern size_t dump_tlb_entries(struct iommu *obj, char *buf);
 
+struct platform_device *omap_iommu_add(const char *name);
+
 #endif /* __MACH_IOMMU_H */
-- 
1.6.3.1

