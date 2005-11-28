From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH 3/5] mmc/omap.c: Use struct platform_driver
Date: Mon, 28 Nov 2005 08:55:00 -0800 (PST)
Message-ID: <20051128165500.43698.qmail@web32915.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1792829697-1133196900=:42197"
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

--0-1792829697-1133196900=:42197
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

Attached patch updates driver model for mmc and fixes mmc_callback
arguments too.

---Komal Shah
http://komalshah.blogspot.com/


	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
--0-1792829697-1133196900=:42197
Content-Type: text/plain; name="0003-mmc.patch"
Content-Description: pat1747620247
Content-Disposition: inline; filename="0003-mmc.patch"

Subject: [PATCH 3/5] mmc/omap.c: Use struct platform_driver
Fixes mmc_callback arguments too.
Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 drivers/i2c/chips/menelaus.c         |    2 +
 drivers/mmc/omap.c                   |   55 +++++++++++++++++-----------------
 include/asm-arm/arch-omap/menelaus.h |    2 +
 3 files changed, 29 insertions(+), 30 deletions(-)

applies-to: cffff84645ee91cc2bd34ee22854c716d4d67854
e891650208465c03842933c3e47eaabe2b982e86
diff --git a/drivers/i2c/chips/menelaus.c b/drivers/i2c/chips/menelaus.c
index f77c9df..48c3e37 100644
--- a/drivers/i2c/chips/menelaus.c
+++ b/drivers/i2c/chips/menelaus.c
@@ -255,7 +255,7 @@ static int menelaus_mmc_cd_work(struct m
 }
 
 /* Initializes MMC slots */
-void menelaus_mmc_register(void (*callback)(u8 card_mask), unsigned long data)
+void menelaus_mmc_register(void (*callback)(unsigned long data, u8 card_mask), unsigned long data)
 {
 	int reg;
 
diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
index 8294008..dc530d6 100644
--- a/drivers/mmc/omap.c
+++ b/drivers/mmc/omap.c
@@ -1163,10 +1163,9 @@ static struct mmc_host_ops mmc_omap_ops 
 	.get_ro		= mmc_omap_get_ro,
 };
 
-static int __init mmc_omap_probe(struct device *dev)
+static int __init mmc_omap_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_mmc_conf *minfo = dev->platform_data;
+	struct omap_mmc_conf *minfo = pdev->dev.platform_data;
 	struct mmc_host *mmc;
 	struct mmc_omap_host *host = NULL;
 	int ret = 0;
@@ -1184,7 +1183,7 @@ static int __init mmc_omap_probe(struct 
 		return -EBUSY;
 	}
 
-	mmc = mmc_alloc_host(sizeof(struct mmc_omap_host), dev);
+	mmc = mmc_alloc_host(sizeof(struct mmc_omap_host), &pdev->dev);
 	if (!mmc) {
 		ret = -ENOMEM;
 		goto out;
@@ -1201,17 +1200,17 @@ static int __init mmc_omap_probe(struct 
 	host->id = pdev->id;
 
 	if (cpu_is_omap24xx()) {
-		host->iclk = clk_get(dev, "mmc_ick");
+		host->iclk = clk_get(&pdev->dev, "mmc_ick");
 		if (IS_ERR(host->iclk))
 			goto out;
 		clk_use(host->iclk);
 	}
 
 	if (!cpu_is_omap24xx())
-		host->fclk = clk_get(dev,
+		host->fclk = clk_get(&pdev->dev,
 				    (host->id == 1) ? "mmc1_ck" : "mmc2_ck");
 	else
-		host->fclk = clk_get(dev, "mmc_fck");
+		host->fclk = clk_get(&pdev->dev, "mmc_fck");
 
 	if (IS_ERR(host->fclk)) {
 		ret = PTR_ERR(host->fclk);
@@ -1261,8 +1260,8 @@ static int __init mmc_omap_probe(struct 
 	if (ret)
 		goto out;
 
-	host->dev = dev;
-	dev_set_drvdata(dev, host);
+	host->dev = &pdev->dev;
+	platform_set_drvdata(pdev, host);
 
 	mmc_add_host(mmc);
 
@@ -1289,11 +1288,11 @@ static int __init mmc_omap_probe(struct 
 			host->switch_pin = -1;
 			goto no_switch;
 		}
-		ret = device_create_file(dev, &dev_attr_cover_switch);
+		ret = device_create_file(&pdev->dev, &dev_attr_cover_switch);
 		if (ret == 0) {
-			ret = device_create_file(dev, &dev_attr_enable_poll);
+			ret = device_create_file(&pdev->dev, &dev_attr_enable_poll);
 			if (ret != 0)
-				device_remove_file(dev, &dev_attr_cover_switch);
+				device_remove_file(&pdev->dev, &dev_attr_cover_switch);
 		}
 		if (ret) {
 			printk(KERN_WARNING "MMC%d: Unable to create sysfs attributes\n", 
@@ -1325,12 +1324,11 @@ out:
 	return ret;
 }
 
-static int __exit mmc_omap_remove(struct device *dev)
+static int mmc_omap_remove(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct mmc_omap_host *host = dev_get_drvdata(dev);
+	struct mmc_omap_host *host = platform_get_drvdata(pdev);
 
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 
 	if (host) {
 		mmc_remove_host(host->mmc);
@@ -1340,8 +1338,8 @@ static int __exit mmc_omap_remove(struct
 		if (host->power_pin >= 0)
 			omap_free_gpio(host->power_pin);
 		if (host->switch_pin >= 0) {
-			device_remove_file(dev, &dev_attr_enable_poll);
-			device_remove_file(dev, &dev_attr_cover_switch);
+			device_remove_file(&pdev->dev, &dev_attr_enable_poll);
+			device_remove_file(&pdev->dev, &dev_attr_cover_switch);
 			free_irq(OMAP_GPIO_IRQ(host->switch_pin), host);
 			omap_free_gpio(host->switch_pin);
 			host->switch_pin = -1;
@@ -1365,10 +1363,10 @@ static int __exit mmc_omap_remove(struct
 }
 
 #ifdef CONFIG_PM
-static int mmc_omap_suspend(struct device *dev, pm_message_t mesg)
+static int mmc_omap_suspend(struct platform_device *pdev, pm_message_t mesg)
 {
 	int ret = 0;
-	struct mmc_omap_host *host = dev_get_drvdata(dev);
+	struct mmc_omap_host *host = platform_get_drvdata(pdev);
 
 	if (host && host->suspended)
 		return 0;
@@ -1384,10 +1382,10 @@ static int mmc_omap_suspend(struct devic
 	return ret;
 }
 
-static int mmc_omap_resume(struct device *dev)
+static int mmc_omap_resume(struct platform_device *pdev)
 {
 	int ret = 0;
-	struct mmc_omap_host *host = dev_get_drvdata(dev);
+	struct mmc_omap_host *host = platform_get_drvdata(pdev);
 
 	if (host && !host->suspended)
 		return 0;
@@ -1405,23 +1403,24 @@ static int mmc_omap_resume(struct device
 #define mmc_omap_resume		NULL
 #endif
 
-static struct device_driver mmc_omap_driver = {
-	.name		= DRIVER_NAME,
-	.bus		= &platform_bus_type,
+static struct platform_driver mmc_omap_driver = {
 	.probe		= mmc_omap_probe,
-	.remove		= __exit_p(mmc_omap_remove),
+	.remove		= mmc_omap_remove,
 	.suspend	= mmc_omap_suspend,
 	.resume		= mmc_omap_resume,
+	.driver		= {
+		.name	= DRIVER_NAME,
+	},
 };
 
 static int __init mmc_omap_init(void)
 {
-	return driver_register(&mmc_omap_driver);
+	return platform_driver_register(&mmc_omap_driver);
 }
 
 static void __exit mmc_omap_exit(void)
 {
-	driver_unregister(&mmc_omap_driver);
+	platform_driver_unregister(&mmc_omap_driver);
 }
 
 module_init(mmc_omap_init);
diff --git a/include/asm-arm/arch-omap/menelaus.h b/include/asm-arm/arch-omap/menelaus.h
index 46be8b8..88cd4c8 100644
--- a/include/asm-arm/arch-omap/menelaus.h
+++ b/include/asm-arm/arch-omap/menelaus.h
@@ -7,7 +7,7 @@
 #ifndef __ASM_ARCH_MENELAUS_H
 #define __ASM_ARCH_MENELAUS_H
 
-extern void menelaus_mmc_register(void (*callback)(u8 card_mask),
+extern void menelaus_mmc_register(void (*callback)(unsigned long data, u8 card_mask),
 				  unsigned long data);
 extern void menelaus_mmc_remove(void);
 extern void menelaus_mmc_opendrain(int enable);
---
0.99.9.GIT

--0-1792829697-1133196900=:42197
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1792829697-1133196900=:42197--
