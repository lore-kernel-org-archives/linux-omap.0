From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 3/4] mtd: nand: omap2: obtain memory from resource
Date: Mon, 14 May 2012 15:09:23 +0530
Message-ID: <82b93b66affd517a54c7454dbd031b77c9eb15a4.1336985941.git.afzal@ti.com>
References: <cover.1336985941.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43652 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841Ab2ENJz5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 05:55:57 -0400
In-Reply-To: <cover.1336985941.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, dwmw2@infradead.org, artem.bityutskiy@linux.intel.com, dedekind1@gmail.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
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
index 25f930c..f69ecc1 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -128,6 +128,7 @@ struct omap_nand_info {
 
 	int				gpmc_cs;
 	unsigned long			phys_base;
+	unsigned long			mem_size;
 	struct completion		comp;
 	int				dma_ch;
 	int				gpmc_irq;
@@ -1049,6 +1050,7 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	struct omap_nand_platform_data	*pdata;
 	int				err;
 	int				i, offset;
+	struct resource			*res;
 
 	pdata = pdev->dev.platform_data;
 	if (pdata == NULL) {
@@ -1068,7 +1070,6 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	info->pdev = pdev;
 
 	info->gpmc_cs		= pdata->cs;
-	info->phys_base		= pdata->phys_base;
 	info->reg		= pdata->reg;
 
 	info->mtd.priv		= &info->nand;
@@ -1081,13 +1082,23 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
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
@@ -1229,7 +1240,7 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	return 0;
 
 out_release_mem_region:
-	release_mem_region(info->phys_base, NAND_IO_SIZE);
+	release_mem_region(info->phys_base, info->mem_size);
 out_free_info:
 	kfree(info);
 
-- 
1.7.10

