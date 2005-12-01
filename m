From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] TOUCHSCREEN: Use struct platform driver
Date: Thu, 1 Dec 2005 02:47:53 -0800 (PST)
Message-ID: <20051201104753.53524.qmail@web32913.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1664476457-1133434073=:53001"
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

--0-1664476457-1133434073=:53001
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

Attached patch uses struct platform_driver.

---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________ 
Yahoo! Music Unlimited 
Access over 1 million songs. Try it free. 
http://music.yahoo.com/unlimited/
--0-1664476457-1133434073=:53001
Content-Type: text/plain;
	name="0010-TOUCHSCREEN-Use-struct-platform_driver.txt"
Content-Description: 2398843653-0010-TOUCHSCREEN-Use-struct-platform_driver.txt
Content-Disposition: inline;
	filename="0010-TOUCHSCREEN-Use-struct-platform_driver.txt"

Subject: [PATCH 10/10] TOUCHSCREEN: Use struct platform_driver
Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 drivers/input/touchscreen/omap/omap_ts.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

applies-to: 1c1a4bfdba89748152c43b246529278a9b91743e
3ee0596ff55e629669fa917d6cfe2923bfba21a7
diff --git a/drivers/input/touchscreen/omap/omap_ts.c b/drivers/input/touchscreen/omap/omap_ts.c
index a7fa016..bfc9b59 100644
--- a/drivers/input/touchscreen/omap/omap_ts.c
+++ b/drivers/input/touchscreen/omap/omap_ts.c
@@ -128,7 +128,7 @@ static irqreturn_t omap_ts_handler(int i
 	return IRQ_HANDLED;
 }
 
-static int __init omap_ts_probe(struct device *dev)
+static int __init omap_ts_probe(struct platform_device *pdev)
 {
 	int i;
 	int status = -ENODEV;
@@ -170,7 +170,7 @@ static int __init omap_ts_probe(struct d
 
 	init_input_dev(&(ts_omap.inputdevice));
 	ts_omap.inputdevice.name = OMAP_TS_NAME;
-	ts_omap.inputdevice.dev = dev;
+	ts_omap.inputdevice.dev = &pdev->dev;
 	ts_omap.inputdevice.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 	ts_omap.inputdevice.keybit[LONG(BTN_TOUCH)] |= BIT(BTN_TOUCH);
 	ts_omap.inputdevice.absbit[0] =
@@ -184,7 +184,7 @@ static int __init omap_ts_probe(struct d
 	return 0;
 }
 
-static int __exit omap_ts_remove(struct device *dev)
+static int omap_ts_remove(struct platform_device *pdev)
 {
 	ts_omap.dev->disable();
 	input_unregister_device(&ts_omap.inputdevice);
@@ -196,13 +196,13 @@ static int __exit omap_ts_remove(struct 
 	return 0;
 }
 
-static int omap_ts_suspend(struct device *dev, pm_message_t state)
+static int omap_ts_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	ts_omap.dev->disable();
 	return 0;
 }
 
-static int omap_ts_resume(struct device *dev)
+static int omap_ts_resume(struct platform_device *pdev)
 {
 	ts_omap.dev->enable();
 	return 0;
@@ -212,14 +212,14 @@ static void omap_ts_device_release(struc
 {
 	/* Nothing */
 }
-
-static struct device_driver omap_ts_driver = {
-	.name 		= OMAP_TS_NAME,
-	.bus 		= &platform_bus_type,
+static struct platform_driver omap_ts_driver = {
 	.probe 		= omap_ts_probe,
-	.remove 	= __exit_p(omap_ts_remove),
+	.remove 	= omap_ts_remove,
 	.suspend 	= omap_ts_suspend,
 	.resume 	= omap_ts_resume,
+	.driver {
+		.name	= OMAP_TS_NAME,
+	},
 };
 
 static struct platform_device omap_ts_device = {
@@ -238,7 +238,7 @@ static int __init omap_ts_init(void)
 	if (ret != 0)
 		return -ENODEV;
 
-	ret = driver_register(&omap_ts_driver);
+	ret = platform_driver_register(&omap_ts_driver);
 	if (ret != 0) {
 		platform_device_unregister(&omap_ts_device);
 		return -ENODEV;
@@ -249,7 +249,7 @@ static int __init omap_ts_init(void)
 
 static void __exit omap_ts_exit(void)
 {
-	driver_unregister(&omap_ts_driver);
+	platform_driver_unregister(&omap_ts_driver);
 	platform_device_unregister(&omap_ts_device);
 }
 
---
0.99.9.GIT

--0-1664476457-1133434073=:53001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1664476457-1133434073=:53001--
