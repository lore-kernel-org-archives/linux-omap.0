From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 06/10] mtd: nand: omap2: obtain memory from resource
Date: Mon, 4 Jun 2012 12:16:47 +0530
Message-ID: <f0e09142c86496cf628cea94c6b916e98e5a5ed3.1338790117.git.afzal@ti.com>
References: <cover.1338790117.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46126 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198Ab2FDHCp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jun 2012 03:02:45 -0400
In-Reply-To: <cover.1338790117.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, artem.bityutskiy@linux.intel.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: ivan.djelic@parrot.com, Afzal Mohammed <afzal@ti.com>

gpmc initialization done by platform code now updates struct resource
with the address space alloted for nand. Use this interface to obtain
memory rather than relying on platform data field - phys_base.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/plat-omap/include/plat/nand.h |    1 -
 drivers/mtd/nand/omap2.c               |   19 +++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/nand.h b/arch/arm/plat-omap/include/plat/nand.h
index 86e4d9c..290cef5 100644
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -26,7 +26,6 @@ struct omap_nand_platform_data {
 	bool			dev_ready;
 	int			gpmc_irq;
 	enum nand_io		xfer_type;
-	unsigned long		phys_base;
 	int			devsize;
 	enum omap_ecc           ecc_opt;
 	struct gpmc_nand_regs	reg;
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 9241a63..8e2bc9b 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -132,6 +132,7 @@ struct omap_nand_info {
 
 	int				gpmc_cs;
 	unsigned long			phys_base;
+	unsigned long			mem_size;
 	struct completion		comp;
 	int				dma_ch;
 	int				gpmc_irq;
@@ -1282,6 +1283,7 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	struct omap_nand_platform_data	*pdata;
 	int				err;
 	int				i, offset;
+	struct resource			*res;
 
 	pdata = pdev->dev.platform_data;
 	if (pdata == NULL) {
@@ -1301,7 +1303,6 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	info->pdev = pdev;
 
 	info->gpmc_cs		= pdata->cs;
-	info->phys_base		= pdata->phys_base;
 	info->reg		= pdata->reg;
 
 	info->mtd.priv		= &info->nand;
@@ -1314,13 +1315,23 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
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
@@ -1477,7 +1488,7 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	return 0;
 
 out_release_mem_region:
-	release_mem_region(info->phys_base, NAND_IO_SIZE);
+	release_mem_region(info->phys_base, info->mem_size);
 out_free_info:
 	kfree(info);
 
-- 
1.7.10.2

