From: Afzal Mohammed <afzal@ti.com>
Subject: [RFC][PATCH 4/5] mtd: nand: omap2: obtain memory from resource
Date: Fri, 23 Mar 2012 12:07:03 +0530
Message-ID: <1332484623-22070-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47809 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005Ab2CWGy7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 02:54:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

gpmc being converted to driver, provides drivers
of peripheral connected memory space used by the
peripheral as memory resource.

Modify nand omap driver to obtain memory detials
from resource structure.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/plat-omap/include/plat/nand.h |    1 -
 drivers/mtd/nand/omap2.c               |   19 +++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/nand.h b/arch/arm/plat-omap/include/plat/nand.h
index d2daeba..fa49fc4 100644
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -26,7 +26,6 @@ struct omap_nand_platform_data {
 	bool			dev_ready;
 	int			gpmc_irq;
 	enum nand_io		xfer_type;
-	unsigned long		phys_base;
 	int			devsize;
 	enum omap_ecc           ecc_opt;
 };
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index b3a883e..f6c018e 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -118,6 +118,7 @@ struct omap_nand_info {
 
 	int				gpmc_cs;
 	unsigned long			phys_base;
+	unsigned long			mem_size;
 	struct completion		comp;
 	int				dma_ch;
 	int				gpmc_irq;
@@ -931,6 +932,7 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	struct omap_nand_platform_data	*pdata;
 	int				err;
 	int				i, offset;
+	struct resource			*res;
 
 	pdata = pdev->dev.platform_data;
 	if (pdata == NULL) {
@@ -950,7 +952,6 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	info->pdev = pdev;
 
 	info->gpmc_cs		= pdata->cs;
-	info->phys_base		= pdata->phys_base;
 
 	info->mtd.priv		= &info->nand;
 	info->mtd.name		= dev_name(&pdev->dev);
@@ -962,13 +963,23 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	/* NAND write protect off */
 	gpmc_cs_configure(info->gpmc_cs, GPMC_CONFIG_WP, 0);
 
-	if (!request_mem_region(info->phys_base, NAND_IO_SIZE,
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		err = -EINVAL;
+		dev_err(&pdev->dev, "error getting memory resource\n");
+		goto out_free_info;
+	}
+
+	info->phys_base = res->start;
+	info->mem_size = resource_size(res);
+
+	if (!request_mem_region(info->phys_base, info->mem_size,
 				pdev->dev.driver->name)) {
 		err = -EBUSY;
 		goto out_free_info;
 	}
 
-	info->nand.IO_ADDR_R = ioremap(info->phys_base, NAND_IO_SIZE);
+	info->nand.IO_ADDR_R = ioremap(info->phys_base, info->mem_size);
 	if (!info->nand.IO_ADDR_R) {
 		err = -ENOMEM;
 		goto out_release_mem_region;
@@ -1109,7 +1120,7 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	return 0;
 
 out_release_mem_region:
-	release_mem_region(info->phys_base, NAND_IO_SIZE);
+	release_mem_region(info->phys_base, info->mem_size);
 out_free_info:
 	kfree(info);
 
-- 
1.7.9.3

