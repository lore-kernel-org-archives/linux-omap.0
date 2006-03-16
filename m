From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH 5/6] cbus/retu-wdt.c: Use platform_driver
Date: Thu, 16 Mar 2006 01:08:10 -0800 (PST)
Message-ID: <20060316090810.7049.qmail@web32906.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-738584399-1142500090=:4900"
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

--0-738584399-1142500090=:4900
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Use platform_driver

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-738584399-1142500090=:4900
Content-Type: text/x-patch; name="cbus05.patch"
Content-Description: 768641723-cbus05.patch
Content-Disposition: inline; filename="cbus05.patch"

diff --git a/drivers/cbus/retu-wdt.c b/drivers/cbus/retu-wdt.c
index 9739907..629affc 100644
--- a/drivers/cbus/retu-wdt.c
+++ b/drivers/cbus/retu-wdt.c
@@ -103,29 +103,29 @@ static DEVICE_ATTR(period, S_IRUGO | S_I
                    retu_wdt_period_store);
 static DEVICE_ATTR(counter, S_IRUGO, retu_wdt_counter_show, NULL);
 
-static int __devinit retu_wdt_probe(struct device *dev)
+static int __devinit retu_wdt_probe(struct platform_device *pdev)
 {
 	int ret;
 
-	ret = device_create_file(dev, &dev_attr_period);
+	ret = device_create_file(&pdev->dev, &dev_attr_period);
 	if (ret) {
 		printk(KERN_ERR "retu_wdt_probe: Error creating sys device file: period\n");
 		return ret;
 	}
 
-	ret = device_create_file(dev, &dev_attr_counter);
+	ret = device_create_file(&pdev->dev, &dev_attr_counter);
 	if (ret) {
-		device_remove_file(dev, &dev_attr_period);
+		device_remove_file(&pdev->dev, &dev_attr_period);
 		printk(KERN_ERR "retu_wdt_probe: Error creating sys device file: counter\n");
 	}
 
 	return ret;
 }
 
-static int __devexit retu_wdt_remove(struct device *dev)
+static int __devexit retu_wdt_remove(struct platform_device *pdev)
 {
-	device_remove_file(dev, &dev_attr_period);
-	device_remove_file(dev, &dev_attr_counter);
+	device_remove_file(&pdev->dev, &dev_attr_period);
+	device_remove_file(&pdev->dev, &dev_attr_counter);
 	return 0;
 }
 
@@ -142,20 +142,23 @@ static struct platform_device retu_wdt_d
 	},
 };
 
-static struct device_driver retu_wdt_driver = {
-	.name = "retu-watchdog",
-	.bus = &platform_bus_type,
-	.probe = retu_wdt_probe,
-	.remove = __devexit_p(retu_wdt_remove),
+static struct platform_driver retu_wdt_driver = {
+	.probe 		= retu_wdt_probe,
+	.remove 	= __devexit_p(retu_wdt_remove),
+	.driver 	= {
+		.name = "retu-watchdog",
+	},
 };
 
+static char banner[] __initdata = KERN_INFO "Retu watchdog driver initialized\n";
+
 static int __init retu_wdt_init(void)
 {
 	int ret;
 
 	init_completion(&retu_wdt_completion);
 
-	ret = driver_register(&retu_wdt_driver);
+	ret = platform_driver_register(&retu_wdt_driver);
 	if (ret)
 		return ret;
 
@@ -170,12 +173,12 @@ static int __init retu_wdt_init(void)
 		printk(KERN_INFO
 		       "retu_wdt_init: Intializing to default value\n");
 	}
-
-	printk(KERN_INFO "Retu watchdog driver initialized\n");
+	
+	printk(banner);
 	return ret;
 
 exit1:
-	driver_unregister(&retu_wdt_driver);
+	platform_driver_unregister(&retu_wdt_driver);
 	wait_for_completion(&retu_wdt_completion);
 
 	return ret;

--0-738584399-1142500090=:4900
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-738584399-1142500090=:4900--
