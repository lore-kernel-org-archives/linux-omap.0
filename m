From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH 4/5] omapfb: Use struct platform_driver
Date: Mon, 28 Nov 2005 08:55:15 -0800 (PST)
Message-ID: <20051128165515.79572.qmail@web32913.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-243868827-1133196915=:77506"
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

--0-243868827-1133196915=:77506
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony/Imre,

Attached patch updates driver model for fb.

---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________ 
Yahoo! Music Unlimited 
Access over 1 million songs. Try it free. 
http://music.yahoo.com/unlimited/
--0-243868827-1133196915=:77506
Content-Type: text/plain; name="0004-fb.patch"
Content-Description: pat1067135640
Content-Disposition: inline; filename="0004-fb.patch"

Subject: [PATCH 4/5] omapfb: Use struct platform_driver
Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 drivers/video/omap/omapfb_main.c |   40 +++++++++++++++++++-------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

applies-to: 8739922c992039877301da6707c04402a13209be
a083f77ba304d63186b37d41c5a46f642ede99fd
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 58af600..2c4098d 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -1214,9 +1214,8 @@ static void check_required_callbacks(str
  *      start LCD frame transfer
  *   7. register system fb_info structure
  */
-static int omapfb_probe(struct device *dev)
+static int omapfb_probe(struct platform_device *pdev)
 {
-	struct platform_device	*pdev;
 	struct omapfb_device	*fbdev = NULL;
 	struct fb_info		*fbi;
 	int			init_state;
@@ -1228,14 +1227,13 @@ static int omapfb_probe(struct device *d
 
 	init_state = 0;
 
-	pdev = to_platform_device(dev);
 	if (pdev->num_resources != 0) {
 		pr_err("probed for an unknown device\n");
 		r = -ENODEV;
 		goto cleanup;
 	}
 
-	fbi = framebuffer_alloc(sizeof(struct omapfb_device), dev);
+	fbi = framebuffer_alloc(sizeof(struct omapfb_device), &pdev->dev);
 	if (fbi == NULL) {
 		pr_err("unable to allocate memory for device info\n");
 		r = -ENOMEM;
@@ -1245,8 +1243,8 @@ static int omapfb_probe(struct device *d
 
 	fbdev = (struct omapfb_device *)fbi->par;
 	fbdev->fb_info = fbi;
-	fbdev->dev = dev;
-	dev_set_drvdata(dev, fbdev);
+	fbdev->dev = &pdev->dev;
+	platform_set_drvdata(pdev, fbdev);
 
 	init_MUTEX(&fbdev->rqueue_sema);
 
@@ -1348,9 +1346,9 @@ cleanup:
 }
 
 /* Called when the device is being detached from the driver */
-static int omapfb_remove(struct device *dev)
+static int omapfb_remove(struct platform_device *pdev)
 {
-	struct omapfb_device *fbdev = dev_get_drvdata(dev);
+	struct omapfb_device *fbdev = platform_get_drvdata(pdev);
 	enum omapfb_state saved_state = fbdev->state;
 
 	DBGENTER(1);
@@ -1364,9 +1362,9 @@ static int omapfb_remove(struct device *
 }
 
 /* PM suspend */
-static int omapfb_suspend(struct device *dev, pm_message_t mesg)
+static int omapfb_suspend(struct platform_device *pdev, pm_message_t mesg)
 {
-	struct omapfb_device *fbdev = dev_get_drvdata(dev);
+	struct omapfb_device *fbdev = platform_get_drvdata(pdev);
 
 	DBGENTER(1);
 
@@ -1378,9 +1376,9 @@ static int omapfb_suspend(struct device 
 }
 
 /* PM resume */
-static int omapfb_resume(struct device *dev)
+static int omapfb_resume(struct platform_device *pdev)
 {
-	struct omapfb_device *fbdev = dev_get_drvdata(dev);
+	struct omapfb_device *fbdev = platform_get_drvdata(pdev);
 
 	DBGENTER(1);
 
@@ -1390,13 +1388,15 @@ static int omapfb_resume(struct device *
 	return 0;
 }
 
-static struct device_driver omapfb_driver = {
-	.name		= OMAPFB_DRIVER,
-	.bus		= &platform_bus_type,
-	.probe          = omapfb_probe,
-	.remove         = omapfb_remove,
+static struct platform_driver omapfb_driver = {
+	.probe		= omapfb_probe,
+	.remove		= omapfb_remove,
 	.suspend	= omapfb_suspend,
-	.resume		= omapfb_resume
+	.resume		= omapfb_resume,
+	.driver		= {
+		.name	= OMAPFB_DRIVER,
+		.owner	= THIS_MODULE,
+	},
 };
 
 #ifndef MODULE
@@ -1475,7 +1475,7 @@ static int __init omapfb_init(void)
 	}
 #endif
 	/* Register the driver with LDM */
-	if (driver_register(&omapfb_driver)) {
+	if (platform_driver_register(&omapfb_driver)) {
 		pr_err("failed to register omapfb driver\n");
 		r = -ENODEV;
 		goto exit;
@@ -1490,7 +1490,7 @@ static void __exit omapfb_cleanup(void)
 {
 	DBGENTER(1);
 
-	driver_unregister(&omapfb_driver);
+	platform_driver_unregister(&omapfb_driver);
 
 	DBGLEAVE(1);
 }
---
0.99.9.GIT

--0-243868827-1133196915=:77506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-243868827-1133196915=:77506--
