From: Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v7 6/6] mtd: nand: omap: updated devm_xx for all resource allocation and free calls
Date: Sat, 5 Oct 2013 01:19:48 +0530
Message-ID: <1380916188-24206-7-git-send-email-pekon@ti.com>
References: <1380916188-24206-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380916188-24206-1-git-send-email-pekon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mark.rutland-5wv7dgnIgG8@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Pawel.Moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, avinashphilipk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

"Managed Device Resource" or devm_xx calls takes care of automatic freeing
of the resource in case of:
- failure during driver probe
- failure during resource allocation
- detaching or unloading of driver module (rmmod)
Reference: Documentation/driver-model/devres.txt

Though OMAP NAND driver handles freeing of resource allocation in most of
the cases, but using devm_xx provides more clean and effortless approach
to handle all such cases.

Signed-off-by: Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
