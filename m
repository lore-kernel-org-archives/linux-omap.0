From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] arm: plat-omap: iommu: fix request_mem_region() error path
Date: Mon, 14 Mar 2011 14:28:32 +0200
Message-ID: <1300105712-12656-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:63611 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754227Ab1CNMY3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Mar 2011 08:24:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, Hiroshi.DOYU@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>

request_mem_region() error exit will leak ioremapped memory. Fix this
by moving the ioremap() after request_mem_region(), which is the proper
order to do this anyway.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/plat-omap/iommu.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index b1107c0..50be5e7 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -957,11 +957,6 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
 		err = -ENODEV;
 		goto err_mem;
 	}
-	obj->regbase = ioremap(res->start, resource_size(res));
-	if (!obj->regbase) {
-		err = -ENOMEM;
-		goto err_mem;
-	}
 
 	res = request_mem_region(res->start, resource_size(res),
 				 dev_name(&pdev->dev));
@@ -970,6 +965,12 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
 		goto err_mem;
 	}
 
+	obj->regbase = ioremap(res->start, resource_size(res));
+	if (!obj->regbase) {
+		err = -ENOMEM;
+		goto err_ioremap;
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		err = -ENODEV;
@@ -998,8 +999,9 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
 err_pgd:
 	free_irq(irq, obj);
 err_irq:
-	release_mem_region(res->start, resource_size(res));
 	iounmap(obj->regbase);
+err_ioremap:
+	release_mem_region(res->start, resource_size(res));
 err_mem:
 	clk_put(obj->clk);
 err_clk:
-- 
1.5.6.5

