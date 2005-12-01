From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] NAND: Use struct platform driver
Date: Thu, 1 Dec 2005 02:48:18 -0800 (PST)
Message-ID: <20051201104818.35757.qmail@web32901.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1483568814-1133434098=:34544"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--0-1483568814-1133434098=:34544
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

Attached patch uses struct platform_driver.

---Komal Shah
http://komalshah.blogspot.com/


	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
--0-1483568814-1133434098=:34544
Content-Type: text/plain; name="0009-NAND-Use-struct-platform_driver.txt"
Content-Description: pat137000140
Content-Disposition: inline;
	filename="0009-NAND-Use-struct-platform_driver.txt"

Subject: [PATCH 9/10] NAND: Use struct platform_driver
Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 drivers/mtd/nand/omap-nand-flash.c |   29 ++++++++++++++---------------
 1 files changed, 14 insertions(+), 15 deletions(-)

applies-to: a636ae3c991eb1e05edf1f56444a2bc6d79281bc
2d772374547f8a1ee4b8c49f68e910233f0c939d
diff --git a/drivers/mtd/nand/omap-nand-flash.c b/drivers/mtd/nand/omap-nand-flash.c
index 3799be0..35a3408 100644
--- a/drivers/mtd/nand/omap-nand-flash.c
+++ b/drivers/mtd/nand/omap-nand-flash.c
@@ -68,10 +68,9 @@ static int omap_nand_dev_ready(struct mt
 	return info->pdata->dev_ready(info->pdata);
 }
 
-static int __devinit omap_nand_probe(struct device *dev)
+static int __devinit omap_nand_probe(struct platform_device *pdev)
 {
 	struct omap_nand_info		*info;
-	struct platform_device		*pdev = to_platform_device(dev);
 	struct nand_platform_data	*pdata = pdev->dev.platform_data;
 	struct resource			*res = pdev->resource;
 	unsigned long			size = res->end - res->start + 1;
@@ -83,7 +82,7 @@ static int __devinit omap_nand_probe(str
 
 	memset(info, 0, sizeof(struct omap_nand_info));
 
-	if (!request_mem_region(res->start, size, dev->driver->name)) {
+	if (!request_mem_region(res->start, size, pdev->dev.driver->name)) {
 		err = -EBUSY;
 		goto out_free_info;
 	}
@@ -129,7 +128,7 @@ static int __devinit omap_nand_probe(str
 #endif
 		add_mtd_device(&info->mtd);
 
-	dev_set_drvdata(&pdev->dev, info);
+	platform_set_drvdata(pdev, info);
 
 	return 0;
 
@@ -143,12 +142,11 @@ out_free_info:
 	return err;
 }
 
-static int __devexit omap_nand_remove(struct device *dev)
+static int omap_nand_remove(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_nand_info *info = dev_get_drvdata(&pdev->dev);
+	struct omap_nand_info *info = platform_get_drvdata(pdev);
 
-	dev_set_drvdata(&pdev->dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 	/* Release NAND device, its internal structures and partitions */
 	nand_release(&info->mtd);
 	iounmap(info->nand.IO_ADDR_R);
@@ -156,22 +154,23 @@ static int __devexit omap_nand_remove(st
 	return 0;
 }
 
-static struct device_driver omap_nand_driver = {
-	.name	= DRIVER_NAME,
-	.bus	= &platform_bus_type,
-	.probe	= omap_nand_probe,
-	.remove	= __devexit_p(omap_nand_remove),
+static struct platform_driver omap_nand_driver = {
+	.probe		= omap_nand_probe,
+	.remove		= omap_nand_remove,
+	.driver		= {
+		.name	= DRIVER_NAME,
+	},
 };
 MODULE_ALIAS(DRIVER_NAME);
 
 static int __init omap_nand_init(void)
 {
-	return driver_register(&omap_nand_driver);
+	return platform_driver_register(&omap_nand_driver);
 }
 
 static void __exit omap_nand_exit(void)
 {
-	driver_unregister(&omap_nand_driver);
+	platform_driver_unregister(&omap_nand_driver);
 }
 
 module_init(omap_nand_init);
---
0.99.9.GIT

--0-1483568814-1133434098=:34544
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1483568814-1133434098=:34544--
