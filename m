From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 2/3] omap3-iommu: split init function into omap_iommu_add
Date: Sat, 16 May 2009 13:05:49 +0300
Message-ID: <1242468350-23190-3-git-send-email-felipe.contreras@gmail.com>
References: <1242468350-23190-1-git-send-email-felipe.contreras@gmail.com>
 <1242468350-23190-2-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:62932 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382AbZEPKF6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 06:05:58 -0400
Received: by fg-out-1718.google.com with SMTP id 16so832813fgg.17
        for <linux-omap@vger.kernel.org>; Sat, 16 May 2009 03:05:57 -0700 (PDT)
In-Reply-To: <1242468350-23190-2-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <hiroshi.doyu@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk, Felipe Contreras <felipe.contreras@gmail.com>

In preparation for external registration.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/omap3-iommu.c |   76 ++++++++++++++++++++++++-------------
 1 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/omap3-iommu.c b/arch/arm/mach-omap2/omap3-iommu.c
index f4232ec..149c624 100644
--- a/arch/arm/mach-omap2/omap3-iommu.c
+++ b/arch/arm/mach-omap2/omap3-iommu.c
@@ -45,43 +45,65 @@ static struct iommu_device devices[] = {
 
 static struct platform_device *omap3_iommu_pdev[NR_IOMMU_DEVICES];
 
-static int __init omap3_iommu_init(void)
+static struct platform_device *omap_iommu_add(const char *name)
 {
-	int i, err;
-
-	for (i = 0; i < NR_IOMMU_DEVICES; i++) {
-		struct platform_device *pdev;
-		const struct iommu_device *d = &devices[i];
-		struct resource res[] = {
-			{ .flags = IORESOURCE_MEM },
-			{ .flags = IORESOURCE_IRQ },
-		};
-
-		pdev = platform_device_alloc("omap-iommu", i + 1);
-		if (!pdev) {
-			err = -ENOMEM;
-			goto err_out;
+	struct platform_device *pdev;
+	const struct iommu_device *d = NULL;
+	struct resource res[] = {
+		{ .flags = IORESOURCE_MEM },
+		{ .flags = IORESOURCE_IRQ },
+	};
+	int err, i;
+
+	for (i = 0; i < ARRAY_SIZE(devices); i++)
+		if (strcmp(devices[i].pdata.name, name) == 0) {
+			d = &devices[i];
+			break;
 		}
 
-		res[0].start = d->base;
-		res[0].end = d->base + MMU_REG_SIZE - 1;
+	if (!d)
+		return NULL;
 
-		res[1].start = d->irq;
+	pdev = platform_device_alloc("omap-iommu", i + 1);
+	if (!pdev)
+		return NULL;
 
-		err = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
-		if (err)
-			goto err_out;
+	res[0].start = d->base;
+	res[0].end = d->base + MMU_REG_SIZE - 1;
 
-		err = platform_device_add_data(pdev, &d->pdata, sizeof(d->pdata));
-		if (err)
-			goto err_out;
+	res[1].start = d->irq;
 
-		err = platform_device_add(pdev);
-		if (err)
-			goto err_out;
+	err = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
+	if (err)
+		goto err_out;
+
+	err = platform_device_add_data(pdev, &d->pdata, sizeof(d->pdata));
+	if (err)
+		goto err_out;
+
+	err = platform_device_add(pdev);
+	if (err)
+		goto err_out;
+
+	return pdev;
 
+err_out:
+	platform_device_put(pdev);
+	return NULL;
+}
+
+static int __init omap3_iommu_init(void)
+{
+	struct platform_device *pdev;
+	int i, err;
+
+	for (i = 0; i < ARRAY_SIZE(devices); i++) {
+		pdev = omap_iommu_add(devices[i].pdata.name);
+		if (!pdev)
+			goto err_out;
 		omap3_iommu_pdev[i] = pdev;
 	}
+
 	return 0;
 
 err_out:
-- 
1.6.3.1

