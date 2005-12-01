From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] RTC: Use struct platform driver
Date: Thu, 1 Dec 2005 02:50:31 -0800 (PST)
Message-ID: <20051201105031.38262.qmail@web32915.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-551961155-1133434231=:35981"
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

--0-551961155-1133434231=:35981
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
--0-551961155-1133434231=:35981
Content-Type: text/plain; name="0006-omap-rtc-Use-struct-platform_driver.txt"
Content-Description: pat685316842
Content-Disposition: inline;
	filename="0006-omap-rtc-Use-struct-platform_driver.txt"

Subject: [PATCH 6/10] omap-rtc: Use struct platform_driver
Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 drivers/char/omap-rtc.c |   38 +++++++++++++++++++++-----------------
 1 files changed, 21 insertions(+), 17 deletions(-)

applies-to: e1192a5294efa7ee40005d30c987d322f0085d22
08c35fee18efaa841137a4ba8938f719f1634948
diff --git a/drivers/char/omap-rtc.c b/drivers/char/omap-rtc.c
index 63ad322..d0e0014 100644
--- a/drivers/char/omap-rtc.c
+++ b/drivers/char/omap-rtc.c
@@ -439,9 +439,8 @@ static struct miscdevice rtc_dev = {
 	.fops		= &rtc_fops,
 };
 
-static int __init omap_rtc_probe(struct device *dev)
+static int __init omap_rtc_probe(struct platform_device *pdev)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
 	struct resource		*res, *mem;
 
 	/* find the IRQs */
@@ -470,7 +469,7 @@ static int __init omap_rtc_probe(struct 
 			pdev->name, OMAP_RTC_BASE);
 		return -EBUSY;
 	}
-	dev_set_drvdata(dev, mem);
+	platform_set_drvdata(pdev, mem);
 
 	if (CMOS_READ(OMAP_RTC_STATUS_REG) & OMAP_RTC_STATUS_POWER_UP) {
 		pr_info("%s: RTC power up reset detected.\n",
@@ -519,7 +518,7 @@ fail:
 	return -EIO;
 }
 
-static int __exit omap_rtc_remove(struct device *dev)
+static int omap_rtc_remove(struct platform_device *pdev)
 {
 	free_irq (omap_rtc_timer, NULL);
 	free_irq (omap_rtc_alarm, NULL);
@@ -527,7 +526,7 @@ static int __exit omap_rtc_remove(struct
 	remove_proc_entry ("driver/rtc", NULL);
 	misc_deregister(&rtc_dev);
 
-	release_resource(dev_get_drvdata(dev));
+	release_resource(platform_get_drvdata(pdev));
 	return 0;
 }
 
@@ -726,7 +725,7 @@ static void set_rtc_irq_bit(unsigned cha
 #ifdef CONFIG_PM
 static struct timespec rtc_delta;
 
-static int rtc_suspend(struct device *dev, pm_message_t state)
+static int omap_rtc_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct rtc_time rtc_tm;
 	struct timespec time;
@@ -740,7 +739,7 @@ static int rtc_suspend(struct device *de
 	return 0;
 }
 
-static int rtc_resume(struct device *dev)
+static int omap_rtc_resume(struct platform_device *pdev)
 {
 	struct rtc_time rtc_tm;
 	struct timespec time;
@@ -754,27 +753,32 @@ static int rtc_resume(struct device *dev
 	return 0;
 }
 #else
-#define rtc_suspend NULL
-#define rtc_resume  NULL
+#define omap_rtc_suspend NULL
+#define omap_rtc_resume  NULL
 #endif
 
-static struct device_driver omap_rtc_driver = {
-	.name		= "omap_rtc",
-	.bus		= &platform_bus_type,
+static struct platform_driver omap_rtc_driver = {
 	.probe		= omap_rtc_probe,
-	.remove		= __exit_p(omap_rtc_remove),
-	.suspend	= rtc_suspend,
-	.resume		= rtc_resume,
+	.remove		= omap_rtc_remove,
+	.suspend	= omap_rtc_suspend,
+	.resume		= omap_rtc_resume,
+	.driver		= {
+		.name	= "omap_rtc",
+		.owner	= THIS_MODULE,
+	},
 };
 
+static char __initdata banner[] = KERN_INFO "OMAP RTC Driver\n";
+
 static int __init rtc_init(void)
 {
-	return driver_register(&omap_rtc_driver);
+	printk(banner);
+	return platform_driver_register(&omap_rtc_driver);
 }
 
 static void __exit rtc_exit(void)
 {
-	driver_unregister(&omap_rtc_driver);
+	platform_driver_unregister(&omap_rtc_driver);
 }
 
 module_init(rtc_init);
---
0.99.9.GIT

--0-551961155-1133434231=:35981
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-551961155-1133434231=:35981--
