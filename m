From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 5/5] mtd: nand: omap2: Use devm_ioremap_resource
Date: Fri, 25 Oct 2013 07:17:57 -0300
Message-ID: <1382696277-9063-6-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1382696277-9063-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:54107 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753095Ab3JYKSV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Oct 2013 06:18:21 -0400
In-Reply-To: <1382696277-9063-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Brian Norris <computersforpeace@gmail.com>, Pekon Gupta <pekon@ti.com>, Felipe Balbi <balbi@ti.com>, marek.belisko@gmail.com, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This simplifies the code and makes it less error-prone. In fact,
this commit fixes a missing iounmap() in the cleanup error path.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/omap2.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index d3155b2..2d896da 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1830,6 +1830,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 	unsigned sig;
 	struct resource			*res;
 	struct mtd_part_parser_data	ppdata = {};
+	void __iomem			*base;
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (pdata == NULL) {
@@ -1861,29 +1862,15 @@ static int omap_nand_probe(struct platform_device *pdev)
 #endif
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		err = -EINVAL;
-		dev_err(&pdev->dev, "error getting memory resource\n");
-		goto out_free_info;
-	}
-
-	info->phys_base = res->start;
-	info->mem_size = resource_size(res);
-
-	if (!request_mem_region(info->phys_base, info->mem_size,
-				pdev->dev.driver->name)) {
-		err = -EBUSY;
-		goto out_free_info;
-	}
-
-	info->nand.IO_ADDR_R = ioremap(info->phys_base, info->mem_size);
-	if (!info->nand.IO_ADDR_R) {
-		err = -ENOMEM;
-		goto out_release_mem_region;
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base)) {
+		err = PTR_ERR(base);
+		return err;
 	}
 
 	info->nand.controller = &info->controller;
 
+	info->nand.IO_ADDR_R = base;
 	info->nand.IO_ADDR_W = info->nand.IO_ADDR_R;
 	info->nand.cmd_ctrl  = omap_hwcontrol;
 
@@ -1904,7 +1891,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 
 	err = nand_scan_ident(&info->mtd, 1, NULL);
 	if (err < 0)
-		goto out_release_mem_region;
+		return err;
 
 	switch (pdata->xfer_type) {
 	case NAND_OMAP_PREFETCH_POLLED:
@@ -2065,8 +2052,6 @@ out_release_mem_region:
 		free_irq(info->gpmc_irq_count, info);
 	if (info->gpmc_irq_fifo > 0)
 		free_irq(info->gpmc_irq_fifo, info);
-	release_mem_region(info->phys_base, info->mem_size);
-out_free_info:
 	return err;
 }
 
@@ -2087,8 +2072,6 @@ static int omap_nand_remove(struct platform_device *pdev)
 
 	/* Release NAND device, its internal structures and partitions */
 	nand_release(&info->mtd);
-	iounmap(info->nand.IO_ADDR_R);
-	release_mem_region(info->phys_base, info->mem_size);
 	return 0;
 }
 
-- 
1.8.1.5

