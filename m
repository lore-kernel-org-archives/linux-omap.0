From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH 2/5] omap-wdt: Use struct platform_driver
Date: Mon, 28 Nov 2005 08:54:47 -0800 (PST)
Message-ID: <20051128165447.57786.qmail@web32901.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-553926784-1133196887=:57350"
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

--0-553926784-1133196887=:57350
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

Attached patch updates driver model for watchdog.

---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________ 
Yahoo! Music Unlimited 
Access over 1 million songs. Try it free. 
http://music.yahoo.com/unlimited/
--0-553926784-1133196887=:57350
Content-Type: text/plain; name="0002-omap-wdt.patch"
Content-Description: pat109564114
Content-Disposition: inline; filename="0002-omap-wdt.patch"

Subject: [PATCH 2/5] omap-wdt: Use struct platform_driver
Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 drivers/char/watchdog/omap_wdt.c |   45 +++++++++++++++++++-------------------
 1 files changed, 23 insertions(+), 22 deletions(-)

applies-to: 2ccce606488399d85af7f202ba92342a2e2618f7
7b6bbc9a6501f8c7bec88cbeda5dc9aa4c503de7
diff --git a/drivers/char/watchdog/omap_wdt.c b/drivers/char/watchdog/omap_wdt.c
index 16f9b81..9904165 100644
--- a/drivers/char/watchdog/omap_wdt.c
+++ b/drivers/char/watchdog/omap_wdt.c
@@ -238,9 +238,8 @@ static struct miscdevice omap_wdt_miscde
 	.fops = &omap_wdt_fops
 };
 
-static int __init omap_wdt_probe(struct device *dev)
+static int __init omap_wdt_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *res, *mem;
 	int ret;
 
@@ -254,12 +253,12 @@ static int __init omap_wdt_probe(struct 
 	if (mem == NULL)
 		return -EBUSY;
 
-	dev_set_drvdata(dev, mem);
+	platform_set_drvdata(pdev, mem);
 
 	omap_wdt_users = 0;
 
 	if (cpu_is_omap16xx()) {
-		armwdt_ck = clk_get(dev, "armwdt_ck");
+		armwdt_ck = clk_get(&pdev->dev, "armwdt_ck");
 		if (IS_ERR(armwdt_ck)) {
 			ret = PTR_ERR(armwdt_ck);
 			armwdt_ck = NULL;
@@ -268,13 +267,13 @@ static int __init omap_wdt_probe(struct 
 	}
 
 	if (cpu_is_omap24xx()) {
-		mpu_wdt_ick = clk_get(dev, "mpu_wdt_ick");
+		mpu_wdt_ick = clk_get(&pdev->dev, "mpu_wdt_ick");
 		if (IS_ERR(mpu_wdt_ick)) {
 			ret = PTR_ERR(mpu_wdt_ick);
 			mpu_wdt_ick = NULL;
 			goto fail;
 		}
-		mpu_wdt_fck = clk_get(dev, "mpu_wdt_fck");
+		mpu_wdt_fck = clk_get(&pdev->dev, "mpu_wdt_fck");
 		if (IS_ERR(mpu_wdt_fck)) {
 			ret = PTR_ERR(mpu_wdt_fck);
 			mpu_wdt_fck = NULL;
@@ -285,7 +284,7 @@ static int __init omap_wdt_probe(struct 
 	omap_wdt_disable();
 	omap_wdt_adjust_timeout(timer_margin);
 
-	omap_wdt_miscdev.dev = dev;
+	omap_wdt_miscdev.dev = &pdev->dev;
 	ret = misc_register(&omap_wdt_miscdev);
 	if (ret)
 		goto fail;
@@ -307,14 +306,14 @@ fail:
 	return ret;
 }
 
-static void omap_wdt_shutdown(struct device *dev)
+static void omap_wdt_shutdown(struct platform_device *pdev)
 {
 	omap_wdt_disable();
 }
 
-static int __exit omap_wdt_remove(struct device *dev)
+static int omap_wdt_remove(struct platform_device *pdev)
 {
-	struct resource *mem = dev_get_drvdata(dev);
+	struct resource *mem = platform_get_drvdata(pdev);
 	misc_deregister(&omap_wdt_miscdev);
 	release_resource(mem);
 	if (armwdt_ck)
@@ -334,14 +333,14 @@ static int __exit omap_wdt_remove(struct
  * may not play well enough with NOWAYOUT...
  */
 
-static int omap_wdt_suspend(struct device *dev, pm_message_t state)
+static int omap_wdt_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	if (omap_wdt_users)
 		omap_wdt_disable();
 	return 0;
 }
 
-static int omap_wdt_resume(struct device *dev)
+static int omap_wdt_resume(struct platform_device *pdev)
 {
 	if (omap_wdt_users) {
 		omap_wdt_enable();
@@ -355,24 +354,26 @@ static int omap_wdt_resume(struct device
 #define	omap_wdt_resume		NULL
 #endif
 
-static struct device_driver omap_wdt_driver = {
-	.name = "omap_wdt",
-	.bus = &platform_bus_type,
-	.probe = omap_wdt_probe,
-	.shutdown = omap_wdt_shutdown,
-	.remove = __exit_p(omap_wdt_remove),
-	.suspend = omap_wdt_suspend,
-	.resume = omap_wdt_resume,
+static struct platform_driver omap_wdt_driver = {
+	.probe		= omap_wdt_probe,
+	.remove		= omap_wdt_remove,
+	.shutdown	= omap_wdt_shutdown,
+	.suspend	= omap_wdt_suspend,
+	.resume		= omap_wdt_resume,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "omap-wdt",
+	},
 };
 
 static int __init omap_wdt_init(void)
 {
-	return driver_register(&omap_wdt_driver);
+	return platform_driver_register(&omap_wdt_driver);
 }
 
 static void __exit omap_wdt_exit(void)
 {
-	driver_unregister(&omap_wdt_driver);
+	platform_driver_unregister(&omap_wdt_driver);
 }
 
 module_init(omap_wdt_init);
---
0.99.9.GIT

--0-553926784-1133196887=:57350
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-553926784-1133196887=:57350--
