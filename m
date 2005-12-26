From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] I2C: Use struct platform_driver
Date: Sun, 25 Dec 2005 22:13:53 -0800 (PST)
Message-ID: <20051226061353.45936.qmail@web32903.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1624993648-1135577633=:39187"
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

--0-1624993648-1135577633=:39187
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

Attached patch uses "struct platform_driver" and kmalloc->kzalloc.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/


	
		
__________________________________ 
Yahoo! for Good - Make a difference this year. 
http://brand.yahoo.com/cybergivingweek2005/
--0-1624993648-1135577633=:39187
Content-Type: text/plain; name="i2c-pdriver.patch"
Content-Description: 2591886790-i2c-pdriver.patch
Content-Disposition: inline; filename="i2c-pdriver.patch"

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 826b10c..c217d51 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -571,9 +571,8 @@ static void omap_i2c_24xx_enable_clocks(
 #endif
 
 static int
-omap_i2c_probe(struct device *dev)
+omap_i2c_probe(struct platform_device *pdev)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
 	struct omap_i2c_dev	*omap_i2c_dev;
 	struct i2c_adapter	*adap;
 	struct resource		*mem, *irq;
@@ -606,17 +605,16 @@ omap_i2c_probe(struct device *dev)
 	if (own < 1 || own > 0x7f)
 		own = DEFAULT_OWN;
 
-	omap_i2c_dev = kmalloc(sizeof(struct omap_i2c_dev), GFP_KERNEL);
+	omap_i2c_dev = kzalloc(sizeof(struct omap_i2c_dev), GFP_KERNEL);
 	if (!omap_i2c_dev) {
 		r = -ENOMEM;
 		goto do_release_region;
 	}
-	memset(omap_i2c_dev, 0, sizeof(struct omap_i2c_dev));
 
-	omap_i2c_dev->dev = dev;
+	omap_i2c_dev->dev = &pdev->dev;
 	omap_i2c_dev->irq = irq->start;
 	omap_i2c_dev->base = (void __iomem *)IO_ADDRESS(mem->start);
-	dev_set_drvdata(omap_i2c_dev->dev, omap_i2c_dev);
+	platform_set_drvdata(pdev, omap_i2c_dev);
 	init_waitqueue_head(&omap_i2c_dev->cmd_wait);
 
 	if ((r = omap_i2c_24xx_get_clocks(omap_i2c_dev, pdev->id)) != 0)
@@ -648,7 +646,7 @@ omap_i2c_probe(struct device *dev)
 	adap->class = I2C_CLASS_HWMON;
 	strncpy(adap->name, "OMAP I2C adapter", sizeof(adap->name));
 	adap->algo = &omap_i2c_algo;
-	adap->dev.parent = dev;
+	adap->dev.parent = &pdev->dev;
 	/* i2c device drivers may be active on return from add_adapter() */
 	r = i2c_add_adapter(adap);
 	if (r) {
@@ -673,10 +671,9 @@ do_release_region:
 }
 
 static int
-omap_i2c_remove(struct device *dev)
+omap_i2c_remove(struct platform_device *pdev)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
-	struct omap_i2c_dev	*omap_i2c_dev = dev_get_drvdata(dev);
+	struct omap_i2c_dev	*omap_i2c_dev = platform_get_drvdata(pdev);
 	struct resource		*mem;
 
 	omap_i2c_write(omap_i2c_dev, 0, OMAP_I2C_CON);
@@ -690,24 +687,25 @@ omap_i2c_remove(struct device *dev)
 	return 0;
 }
 
-static struct device_driver omap_i2c_driver = {
-	.name		= (char *)driver_name,
-	.bus		= &platform_bus_type,
+static struct platform_driver omap_i2c_driver = {
 	.probe		= omap_i2c_probe,
 	.remove		= omap_i2c_remove,
+	.driver 	= {
+		.name	= (char *)driver_name,
+	},
 };
 
 /* i2c may be needed to bring up other drivers */
 static int __init
 omap_i2c_init_driver(void)
 {
-	return driver_register(&omap_i2c_driver);
+	return platform_driver_register(&omap_i2c_driver);
 }
 subsys_initcall(omap_i2c_init_driver);
 
 static void __exit omap_i2c_exit_driver(void)
 {
-	driver_unregister(&omap_i2c_driver);
+	platform_driver_unregister(&omap_i2c_driver);
 }
 module_exit(omap_i2c_exit_driver);
 

--0-1624993648-1135577633=:39187
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1624993648-1135577633=:39187--
