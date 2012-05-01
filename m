From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 18/39] mtd: onenand: omap: obtain memory from resource
Date: Tue, 1 May 2012 17:51:43 +0530
Message-ID: <0566ad486a0127288f8670b415249c008780c5ce.1335874494.git.afzal@ti.com>
References: <cover.1335874494.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1335874494.git.afzal-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, vimal.newwork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

gpmc being converted to driver, provides drivers of peripheral
connected memory space used by the peripheral as memory resource.
Modify nand omap driver to obtain memory detials from resource
structure. And so remove usage of gpmc exported symbols.

Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
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
1.7.10

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
