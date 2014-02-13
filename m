From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv2 01/16] iommu/omap: convert to devm_* interfaces
Date: Thu, 13 Feb 2014 12:15:32 -0600
Message-ID: <1392315347-32967-2-git-send-email-s-anna@ti.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41952 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752199AbaBMSRN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Feb 2014 13:17:13 -0500
In-Reply-To: <1392315347-32967-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Tony Lindgren <tony@atomide.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Use the various devm_ interfaces to simplify the cleanup in
probe and remove functions.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/iommu/omap-iommu.c | 52 +++++++++-------------------------------------
 1 file changed, 10 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index bcd78a7..fff2ffd 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -941,7 +941,7 @@ static int omap_iommu_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct iommu_platform_data *pdata = pdev->dev.platform_data;
 
-	obj = kzalloc(sizeof(*obj) + MMU_REG_SIZE, GFP_KERNEL);
+	obj = devm_kzalloc(&pdev->dev, sizeof(*obj) + MMU_REG_SIZE, GFP_KERNEL);
 	if (!obj)
 		return -ENOMEM;
 
@@ -958,33 +958,18 @@ static int omap_iommu_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&obj->mmap);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		err = -ENODEV;
-		goto err_mem;
-	}
-
-	res = request_mem_region(res->start, resource_size(res),
-				 dev_name(&pdev->dev));
-	if (!res) {
-		err = -EIO;
-		goto err_mem;
-	}
-
-	obj->regbase = ioremap(res->start, resource_size(res));
-	if (!obj->regbase) {
-		err = -ENOMEM;
-		goto err_ioremap;
-	}
+	obj->regbase = devm_ioremap_resource(obj->dev, res);
+	if (IS_ERR(obj->regbase))
+		return PTR_ERR(obj->regbase);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		err = -ENODEV;
-		goto err_irq;
-	}
-	err = request_irq(irq, iommu_fault_handler, IRQF_SHARED,
-			  dev_name(&pdev->dev), obj);
+	if (irq < 0)
+		return -ENODEV;
+
+	err = devm_request_irq(obj->dev, irq, iommu_fault_handler, IRQF_SHARED,
+			       dev_name(obj->dev), obj);
 	if (err < 0)
-		goto err_irq;
+		return err;
 	platform_set_drvdata(pdev, obj);
 
 	pm_runtime_irq_safe(obj->dev);
@@ -992,34 +977,17 @@ static int omap_iommu_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "%s registered\n", obj->name);
 	return 0;
-
-err_irq:
-	iounmap(obj->regbase);
-err_ioremap:
-	release_mem_region(res->start, resource_size(res));
-err_mem:
-	kfree(obj);
-	return err;
 }
 
 static int omap_iommu_remove(struct platform_device *pdev)
 {
-	int irq;
-	struct resource *res;
 	struct omap_iommu *obj = platform_get_drvdata(pdev);
 
 	iopgtable_clear_entry_all(obj);
 
-	irq = platform_get_irq(pdev, 0);
-	free_irq(irq, obj);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-	iounmap(obj->regbase);
-
 	pm_runtime_disable(obj->dev);
 
 	dev_info(&pdev->dev, "%s removed\n", obj->name);
-	kfree(obj);
 	return 0;
 }
 
-- 
1.8.5.3

