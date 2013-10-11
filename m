From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v8 6/6] mtd: nand: omap: updated devm_xx for all resource allocation and free calls
Date: Fri, 11 Oct 2013 19:06:43 +0530
Message-ID: <1381498603-15715-7-git-send-email-pekon@ti.com>
References: <1381498603-15715-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45498 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755769Ab3JKNjo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Oct 2013 09:39:44 -0400
In-Reply-To: <1381498603-15715-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mark.rutland@arm.com, robherring2@gmail.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com
Cc: Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Pekon Gupta <pekon@ti.com>

"Managed Device Resource" or devm_xx calls takes care of automatic freeing
of the resource in case of:
- failure during driver probe
- failure during resource allocation
- detaching or unloading of driver module (rmmod)
Reference: Documentation/driver-model/devres.txt

Though OMAP NAND driver handles freeing of resource allocation in most of
the cases, but using devm_xx provides more clean and effortless approach
to handle all such cases.

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/nand/omap2.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index a783dae..0f2b0d1 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1658,7 +1658,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	info = kzalloc(sizeof(struct omap_nand_info), GFP_KERNEL);
+	info = devm_kzalloc(&pdev->dev, sizeof(struct omap_nand_info),
+				GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
@@ -1690,13 +1691,14 @@ static int omap_nand_probe(struct platform_device *pdev)
 	info->phys_base = res->start;
 	info->mem_size = resource_size(res);
 
-	if (!request_mem_region(info->phys_base, info->mem_size,
-				pdev->dev.driver->name)) {
+	if (!devm_request_mem_region(&pdev->dev, info->phys_base,
+				info->mem_size,	pdev->dev.driver->name)) {
 		err = -EBUSY;
 		goto out_free_info;
 	}
 
-	info->nand.IO_ADDR_R = ioremap(info->phys_base, info->mem_size);
+	info->nand.IO_ADDR_R = devm_ioremap(&pdev->dev, info->phys_base,
+						info->mem_size);
 	if (!info->nand.IO_ADDR_R) {
 		err = -ENOMEM;
 		goto out_release_mem_region;
@@ -1799,8 +1801,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 			err = -ENODEV;
 			goto out_release_mem_region;
 		}
-		err = request_irq(info->gpmc_irq_fifo,	omap_nand_irq,
-					IRQF_SHARED, "gpmc-nand-fifo", info);
+		err = devm_request_irq(&pdev->dev, info->gpmc_irq_fifo,
+					omap_nand_irq, IRQF_SHARED,
+					"gpmc-nand-fifo", info);
 		if (err) {
 			dev_err(&pdev->dev, "requesting irq(%d) error:%d",
 						info->gpmc_irq_fifo, err);
@@ -1814,8 +1817,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 			err = -ENODEV;
 			goto out_release_mem_region;
 		}
-		err = request_irq(info->gpmc_irq_count,	omap_nand_irq,
-					IRQF_SHARED, "gpmc-nand-count", info);
+		err = devm_request_irq(&pdev->dev, info->gpmc_irq_count,
+					omap_nand_irq, IRQF_SHARED,
+					"gpmc-nand-count", info);
 		if (err) {
 			dev_err(&pdev->dev, "requesting irq(%d) error:%d",
 						info->gpmc_irq_count, err);
@@ -2031,10 +2035,10 @@ out_release_mem_region:
 	if (info->dma)
 		dma_release_channel(info->dma);
 	if (info->gpmc_irq_count > 0)
-		free_irq(info->gpmc_irq_count, info);
+		devm_free_irq(&pdev->dev, info->gpmc_irq_count, info);
 	if (info->gpmc_irq_fifo > 0)
-		free_irq(info->gpmc_irq_fifo, info);
-	release_mem_region(info->phys_base, info->mem_size);
+		devm_free_irq(&pdev->dev, info->gpmc_irq_fifo, info);
+	devm_release_mem_region(&pdev->dev, info->phys_base, info->mem_size);
 out_free_info:
 #ifdef CONFIG_MTD_NAND_ECC_BCH
 	if (info->nand.ecc.priv) {
@@ -2042,7 +2046,7 @@ out_free_info:
 		info->nand.ecc.priv = NULL;
 	}
 #endif
-	kfree(info);
+	devm_kfree(&pdev->dev, info);
 
 	return err;
 }
@@ -2062,15 +2066,15 @@ static int omap_nand_remove(struct platform_device *pdev)
 		dma_release_channel(info->dma);
 
 	if (info->gpmc_irq_count > 0)
-		free_irq(info->gpmc_irq_count, info);
+		devm_free_irq(&pdev->dev, info->gpmc_irq_count, info);
 	if (info->gpmc_irq_fifo > 0)
-		free_irq(info->gpmc_irq_fifo, info);
+		devm_free_irq(&pdev->dev, info->gpmc_irq_fifo, info);
 
 	/* Release NAND device, its internal structures and partitions */
 	nand_release(&info->mtd);
-	iounmap(info->nand.IO_ADDR_R);
-	release_mem_region(info->phys_base, info->mem_size);
-	kfree(info);
+	devm_iounmap(&pdev->dev, info->nand.IO_ADDR_R);
+	devm_release_mem_region(&pdev->dev, info->phys_base, info->mem_size);
+	devm_kfree(&pdev->dev, info);
 	return 0;
 }
 
-- 
1.8.1

