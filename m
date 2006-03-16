From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH 3/6] cbus/retu-rtc.c : Use platform_driver
Date: Thu, 16 Mar 2006 01:01:45 -0800 (PST)
Message-ID: <20060316090145.52330.qmail@web32903.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-162562247-1142499705=:50899"
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

--0-162562247-1142499705=:50899
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
--0-162562247-1142499705=:50899
Content-Type: text/x-patch; name="cbus03.patch"
Content-Description: 3264293203-cbus03.patch
Content-Disposition: inline; filename="cbus03.patch"

diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index 6471e7e..663a008 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -302,7 +302,7 @@ static ssize_t retu_rtc_cal_store(struct
 static DEVICE_ATTR(cal, S_IRUGO | S_IWUSR, retu_rtc_cal_show,
 		   retu_rtc_cal_store);
 
-static struct device_driver retu_rtc_driver;
+static struct platform_driver retu_rtc_driver;
 
 static void retu_rtca_disable(void)
 {
@@ -315,7 +315,7 @@ static void retu_rtca_disable(void)
 static void retu_rtca_expired(void *data)
 {
 	retu_rtca_disable();
-	kobject_uevent(&retu_rtc_driver.kobj, KOBJ_CHANGE);
+	kobject_uevent(&retu_rtc_driver.driver.kobj, KOBJ_CHANGE);
 }
 
 DECLARE_WORK(retu_rtca_work, retu_rtca_expired, NULL);
@@ -360,7 +360,7 @@ static int retu_rtc_init_irq(void)
 }
 
 
-static int __devinit retu_rtc_probe(struct device *dev)
+static int __devinit retu_rtc_probe(struct platform_device *pdev)
 {
 	int r;
 
@@ -379,48 +379,49 @@ static int __devinit retu_rtc_probe(stru
 	else
 		retu_rtc_do_reset();
 
-	if ((r = device_create_file(dev, &dev_attr_time)) != 0)
+	if ((r = device_create_file(&pdev->dev, &dev_attr_time)) != 0)
 		return r;
-	else if ((r = device_create_file(dev, &dev_attr_reset)) != 0)
+	else if ((r = device_create_file(&pdev->dev, &dev_attr_reset)) != 0)
 		goto err_unregister_time;
-	else if ((r = device_create_file(dev, &dev_attr_alarm)) != 0)
+	else if ((r = device_create_file(&pdev->dev, &dev_attr_alarm)) != 0)
 		goto err_unregister_reset;
-	else if ((r = device_create_file(dev, &dev_attr_alarm_expired)) != 0)
+	else if ((r = device_create_file(&pdev->dev, &dev_attr_alarm_expired)) != 0)
 		goto err_unregister_alarm;
-	else if ((r = device_create_file(dev, &dev_attr_cal)) != 0)
+	else if ((r = device_create_file(&pdev->dev, &dev_attr_cal)) != 0)
 		goto err_unregister_alarm_expired;
 	else
 		return r;
 
 err_unregister_alarm_expired:
-	device_remove_file(dev, &dev_attr_alarm_expired);
+	device_remove_file(&pdev->dev, &dev_attr_alarm_expired);
 err_unregister_alarm:
-	device_remove_file(dev, &dev_attr_alarm);
+	device_remove_file(&pdev->dev, &dev_attr_alarm);
 err_unregister_reset:
-	device_remove_file(dev, &dev_attr_reset);
+	device_remove_file(&pdev->dev, &dev_attr_reset);
 err_unregister_time:
-	device_remove_file(dev, &dev_attr_time);
+	device_remove_file(&pdev->dev, &dev_attr_time);
 	return r;
 }
 
-static int __devexit retu_rtc_remove(struct device *dev)
+static int __devexit retu_rtc_remove(struct platform_device *pdev)
 {
 	retu_disable_irq(RETU_INT_RTCS);
 	retu_free_irq(RETU_INT_RTCS);
 	retu_free_irq(RETU_INT_RTCA);
-	device_remove_file(dev, &dev_attr_cal);
-	device_remove_file(dev, &dev_attr_alarm_expired);
-	device_remove_file(dev, &dev_attr_alarm);
-	device_remove_file(dev, &dev_attr_reset);
-	device_remove_file(dev, &dev_attr_time);
+	device_remove_file(&pdev->dev, &dev_attr_cal);
+	device_remove_file(&pdev->dev, &dev_attr_alarm_expired);
+	device_remove_file(&pdev->dev, &dev_attr_alarm);
+	device_remove_file(&pdev->dev, &dev_attr_reset);
+	device_remove_file(&pdev->dev, &dev_attr_time);
 	return 0;
 }
 
-static struct device_driver retu_rtc_driver = {
-	.name		= "retu-rtc",
-	.bus		= &platform_bus_type,
+static struct platform_driver retu_rtc_driver = {
 	.probe		= retu_rtc_probe,
 	.remove		= __devexit_p(retu_rtc_remove),
+	.driver		= {
+		.name	= "retu-rtc",
+	},
 };
 
 static struct platform_device retu_rtc_device = {
@@ -447,7 +448,7 @@ static int __init retu_rtc_init(void)
 
 	init_completion(&retu_rtc_exited);
 
-	if ((ret = driver_register(&retu_rtc_driver)) != 0)
+	if ((ret = platform_driver_register(&retu_rtc_driver)) != 0)
 		return ret;
 
 	if ((ret = platform_device_register(&retu_rtc_device)) != 0)
@@ -456,14 +457,14 @@ static int __init retu_rtc_init(void)
 	return 0;
 
 err_unregister_driver:
-	driver_unregister(&retu_rtc_driver);
+	platform_driver_unregister(&retu_rtc_driver);
 	return ret;
 }
 
 static void __exit retu_rtc_exit(void)
 {
 	platform_device_unregister(&retu_rtc_device);
-	driver_unregister(&retu_rtc_driver);
+	platform_driver_unregister(&retu_rtc_driver);
 
 	wait_for_completion(&retu_rtc_exited);
 }

--0-162562247-1142499705=:50899
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-162562247-1142499705=:50899--
