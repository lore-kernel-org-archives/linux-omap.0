From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 3/3] omap3-iommu: remote registration
Date: Thu,  7 May 2009 23:11:09 +0300
Message-ID: <1241727069-15168-4-git-send-email-felipe.contreras@gmail.com>
References: <94a0d4530905071302g3510fdabne659a42bd9009909@mail.gmail.com>
 <1241727069-15168-1-git-send-email-felipe.contreras@gmail.com>
 <1241727069-15168-2-git-send-email-felipe.contreras@gmail.com>
 <1241727069-15168-3-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:59902 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbZEGUL1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 16:11:27 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1364924fga.17
        for <linux-omap@vger.kernel.org>; Thu, 07 May 2009 13:11:27 -0700 (PDT)
In-Reply-To: <1241727069-15168-3-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <hiroshi.doyu@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>

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
1.6.3.GIT

