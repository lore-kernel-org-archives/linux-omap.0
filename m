From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v9 9/9] mtd: nand: omap: updated devm_xx for all resource allocation and free calls
Date: Tue, 15 Oct 2013 11:19:57 +0530
Message-ID: <1381816197-20477-10-git-send-email-pekon@ti.com>
References: <1381816197-20477-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35597 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932877Ab3JOFvq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Oct 2013 01:51:46 -0400
In-Reply-To: <1381816197-20477-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mark.rutland@arm.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com, tony@atomide.com, bcousson@baylibre.com
Cc: robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Pekon Gupta <pekon@ti.com>

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
 drivers/mtd/nand/omap2.c | 44 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 769ff65..0ed0d6f 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1642,7 +1642,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	info = kzalloc(sizeof(struct omap_nand_info), GFP_KERNEL);
+	info = devm_kzalloc(&pdev->dev, sizeof(struct omap_nand_info),
+				GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
@@ -1667,19 +1668,20 @@ static int omap_nand_probe(struct platform_device *pdev)
 	if (res == NULL) {
 		err = -EINVAL;
 		dev_err(&pdev->dev, "error getting memory resource\n");
-		goto out_free_info;
+		goto out_release_mem_region;
 	}
 
 	info->phys_base = res->start;
 	info->mem_size = resource_size(res);
 
-	if (!request_mem_region(info->phys_base, info->mem_size,
-				pdev->dev.driver->name)) {
+	if (!devm_request_mem_region(&pdev->dev, info->phys_base,
+				info->mem_size,	pdev->dev.driver->name)) {
 		err = -EBUSY;
-		goto out_free_info;
+		goto out_release_mem_region;
 	}
 
-	nand_chip->IO_ADDR_R = ioremap(info->phys_base, info->mem_size);
+	nand_chip->IO_ADDR_R = devm_ioremap(&pdev->dev, info->phys_base,
+						info->mem_size);
 	if (!nand_chip->IO_ADDR_R) {
 		err = -ENOMEM;
 		goto out_release_mem_region;
@@ -1781,8 +1783,9 @@ static int omap_nand_probe(struct platform_device *pdev)
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
@@ -1796,8 +1799,9 @@ static int omap_nand_probe(struct platform_device *pdev)
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
@@ -2010,45 +2014,25 @@ static int omap_nand_probe(struct platform_device *pdev)
 out_release_mem_region:
 	if (info->dma)
 		dma_release_channel(info->dma);
-	if (info->gpmc_irq_count > 0)
-		free_irq(info->gpmc_irq_count, info);
-	if (info->gpmc_irq_fifo > 0)
-		free_irq(info->gpmc_irq_fifo, info);
-	release_mem_region(info->phys_base, info->mem_size);
-out_free_info:
 	if (info->nand.ecc.priv) {
 		nand_bch_free(info->nand.ecc.priv);
 		info->nand.ecc.priv = NULL;
 	}
-	kfree(info);
-
 	return err;
 }
 
 static int omap_nand_remove(struct platform_device *pdev)
 {
 	struct mtd_info *mtd = platform_get_drvdata(pdev);
-	struct nand_chip *nand_chip = mtd->priv;
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 							mtd);
 	if (info->nand.ecc.priv) {
 		nand_bch_free(info->nand.ecc.priv);
 		info->nand.ecc.priv = NULL;
 	}
-
 	if (info->dma)
 		dma_release_channel(info->dma);
-
-	if (info->gpmc_irq_count > 0)
-		free_irq(info->gpmc_irq_count, info);
-	if (info->gpmc_irq_fifo > 0)
-		free_irq(info->gpmc_irq_fifo, info);
-
-	/* Release NAND device, its internal structures and partitions */
 	nand_release(mtd);
-	iounmap(nand_chip->IO_ADDR_R);
-	release_mem_region(info->phys_base, info->mem_size);
-	kfree(info);
 	return 0;
 }
 
-- 
1.8.1

