From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH 1/5] omap1610-ir: Use struct platform_driver and PM updates.
Date: Mon, 28 Nov 2005 08:54:31 -0800 (PST)
Message-ID: <20051128165431.57198.qmail@web32908.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-3120397-1133196871=:56398"
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

--0-3120397-1133196871=:56398
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

Attached patch updated driver model support and removes third argument
from PM functions.

---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________ 
Yahoo! Music Unlimited 
Access over 1 million songs. Try it free. 
http://music.yahoo.com/unlimited/
--0-3120397-1133196871=:56398
Content-Type: text/plain; name="0001-omap1610-ir.patch"
Content-Description: pat1065774268
Content-Disposition: inline; filename="0001-omap1610-ir.patch"

Subject: [PATCH 1/5] omap1610-ir: Use struct platform_driver and PM updates.
Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 drivers/net/irda/omap1610-ir.c |   50 +++++++++++++++++++++-------------------
 1 files changed, 26 insertions(+), 24 deletions(-)

applies-to: 0422ed6804a9f506735f1b298be44d3582ef5caf
87ae62bfbea30452d88f04dedf91f4acc52db103
diff --git a/drivers/net/irda/omap1610-ir.c b/drivers/net/irda/omap1610-ir.c
index 88163b7..da8e703 100644
--- a/drivers/net/irda/omap1610-ir.c
+++ b/drivers/net/irda/omap1610-ir.c
@@ -837,12 +837,12 @@ static int omap1610_irda_set_speed(struc
 /*
  * Suspend the IrDA interface.
  */
-static int omap1610_irda_suspend(struct device *_dev, u32 state, u32 level)
+static int omap1610_irda_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct net_device *dev = dev_get_drvdata(_dev);
+	struct net_device *dev = platform_get_drvdata(pdev);
 	struct omap1610_irda *si = dev->priv;
 
-	if (!dev || level != SUSPEND_DISABLE)
+	if (!dev)
 		return 0;
 
 	if (si->open) {
@@ -859,12 +859,12 @@ static int omap1610_irda_suspend(struct 
 /*
  * Resume the IrDA interface.
  */
-static int omap1610_irda_resume(struct device *_dev, u32 level)
+static int omap1610_irda_resume(struct platform_device *pdev)
 {
-	struct net_device *dev = dev_get_drvdata(_dev);
+	struct net_device *dev = platform_get_drvdata(pdev);
 	struct omap1610_irda *si= dev->priv;
 
-	if (!dev || level != RESUME_ENABLE)
+	if (!dev)
 		return 0;
 
 	if (si->open) {
@@ -897,9 +897,8 @@ static int omap1610_irda_resume(struct d
 #define omap1610_irda_resume	NULL
 #endif
 
-static int omap1610_irda_probe(struct device *_dev)
+static int omap1610_irda_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(_dev);
 	struct net_device *dev;
 	struct omap1610_irda *si;
 	unsigned int baudrate_mask;
@@ -943,47 +942,50 @@ static int omap1610_irda_probe(struct de
 
 	err = register_netdev(dev);
 	if (!err)
-		dev_set_drvdata(&pdev->dev, dev);
+		platform_set_drvdata(pdev, dev);
 	else 
 		free_netdev(dev);
 
-      err_mem_1:
+ err_mem_1:
 	return err;
 }
 
-static int omap1610_irda_remove(struct device *_dev)
+static int omap1610_irda_remove(struct platform_device *pdev)
 {
-	struct net_device *dev = dev_get_drvdata(_dev);
-	
+	struct net_device *dev = platform_get_drvdata(pdev);
+	    
 #ifdef CONFIG_MACH_OMAP_H3
 	if (machine_is_omap_h3())
 		cancel_delayed_work(&set_h3_gpio_expa_work);
 #endif
-	if (dev) {
+	if (pdev) {
 		unregister_netdev(dev);
 		free_netdev(dev);
 	}
 	return 0;
 }
 
-static struct device_driver omap1610ir_driver = {
-	.name = "omap1610-ir",
-	.bus = &platform_bus_type,
-	.probe = omap1610_irda_probe,
-	.remove = omap1610_irda_remove,
-	.suspend = omap1610_irda_suspend,
-	.resume = omap1610_irda_resume,
+static struct platform_driver omap1610ir_driver = {
+	.probe		= omap1610_irda_probe,
+	.remove		= omap1610_irda_remove,
+	.suspend	= omap1610_irda_suspend,
+	.resume		= omap1610_irda_resume,
+	.driver		= {
+		.name	= "omap1610-ir",
+	},
 };
 
+static char __initdata banner[] = "OMAP1610 IrDA driver\n";
+
 static int __init omap1610_irda_init(void)
 {
-	return driver_register(&omap1610ir_driver);
-
+	printk(banner);
+	return platform_driver_register(&omap1610ir_driver);
 }
 
 static void __exit omap1610_irda_exit(void)
 {
-	driver_unregister(&omap1610ir_driver);
+	platform_driver_unregister(&omap1610ir_driver);
 }
 
 module_init(omap1610_irda_init);
---
0.99.9.GIT

--0-3120397-1133196871=:56398
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-3120397-1133196871=:56398--
