From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 07/10] mtd: onenand: omap2: obtain memory from resource
Date: Wed, 13 Jun 2012 17:03:40 +0530
Message-ID: <e435719549e71235556b1f477feb70d83f30835c.1339586624.git.afzal@ti.com>
References: <cover.1339586624.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49015 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726Ab2FMLtR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 07:49:17 -0400
In-Reply-To: <cover.1339586624.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, artem.bityutskiy@linux.intel.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: ivan.djelic@parrot.com, Afzal Mohammed <afzal@ti.com>

gpmc initialization for onenand done by platform code now provides
onenand address space as memory resource. Hence remove usage of
gpmc_cs_request in onenand driver and obtain memory details from
resource structure.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/mtd/onenand/omap2.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 398a827..3ff893d 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -48,13 +48,13 @@
 
 #define DRIVER_NAME "omap2-onenand"
 
-#define ONENAND_IO_SIZE		SZ_128K
 #define ONENAND_BUFRAM_SIZE	(1024 * 5)
 
 struct omap2_onenand {
 	struct platform_device *pdev;
 	int gpmc_cs;
 	unsigned long phys_base;
+	unsigned int mem_size;
 	int gpio_irq;
 	struct mtd_info mtd;
 	struct onenand_chip onenand;
@@ -626,6 +626,7 @@ static int __devinit omap2_onenand_probe(struct platform_device *pdev)
 	struct omap2_onenand *c;
 	struct onenand_chip *this;
 	int r;
+	struct resource *res;
 
 	pdata = pdev->dev.platform_data;
 	if (pdata == NULL) {
@@ -647,20 +648,24 @@ static int __devinit omap2_onenand_probe(struct platform_device *pdev)
 		c->gpio_irq = 0;
 	}
 
-	r = gpmc_cs_request(c->gpmc_cs, ONENAND_IO_SIZE, &c->phys_base);
-	if (r < 0) {
-		dev_err(&pdev->dev, "Cannot request GPMC CS\n");
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		r = -EINVAL;
+		dev_err(&pdev->dev, "error getting memory resource\n");
 		goto err_kfree;
 	}
 
-	if (request_mem_region(c->phys_base, ONENAND_IO_SIZE,
+	c->phys_base = res->start;
+	c->mem_size = resource_size(res);
+
+	if (request_mem_region(c->phys_base, c->mem_size,
 			       pdev->dev.driver->name) == NULL) {
-		dev_err(&pdev->dev, "Cannot reserve memory region at 0x%08lx, "
-			"size: 0x%x\n",	c->phys_base, ONENAND_IO_SIZE);
+		dev_err(&pdev->dev, "Cannot reserve memory region at 0x%08lx, size: 0x%x\n",
+						c->phys_base, c->mem_size);
 		r = -EBUSY;
-		goto err_free_cs;
+		goto err_kfree;
 	}
-	c->onenand.base = ioremap(c->phys_base, ONENAND_IO_SIZE);
+	c->onenand.base = ioremap(c->phys_base, c->mem_size);
 	if (c->onenand.base == NULL) {
 		r = -ENOMEM;
 		goto err_release_mem_region;
@@ -776,9 +781,7 @@ err_release_gpio:
 err_iounmap:
 	iounmap(c->onenand.base);
 err_release_mem_region:
-	release_mem_region(c->phys_base, ONENAND_IO_SIZE);
-err_free_cs:
-	gpmc_cs_free(c->gpmc_cs);
+	release_mem_region(c->phys_base, c->mem_size);
 err_kfree:
 	kfree(c);
 
@@ -800,7 +803,7 @@ static int __devexit omap2_onenand_remove(struct platform_device *pdev)
 		gpio_free(c->gpio_irq);
 	}
 	iounmap(c->onenand.base);
-	release_mem_region(c->phys_base, ONENAND_IO_SIZE);
+	release_mem_region(c->phys_base, c->mem_size);
 	gpmc_cs_free(c->gpmc_cs);
 	kfree(c);
 
-- 
1.7.10.2

