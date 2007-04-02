From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.21-rc5-git] omap_cf oops-in-suspend fix
Date: Mon, 2 Apr 2007 12:51:47 -0700
Message-ID: <200704021251.48245.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-pcmcia@lists.infradead.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Convert omap_cf into a platform_driver ... this resolves oopsing during
suspend/resume.

Evidently folk haven't tried suspend/resume on an OSK (the main platform
for this driver) since September or so, which is when platform_device
learned about suspend_late()/resume_early() and stopped being able to
suspend/resume without a having a real platform_driver.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Could I get an ACK if this gets merged via linux-pcmcia?  The last time
I submitted a patch it didn't get merged, so I'm wondering if that list
is functioning for patch submission.

--- osk2.orig/drivers/pcmcia/omap_cf.c	2007-03-17 21:00:49.000000000 -0700
+++ osk2/drivers/pcmcia/omap_cf.c	2007-04-01 22:05:16.000000000 -0700
@@ -202,15 +202,14 @@ static struct pccard_operations omap_cf_
  * "what chipselect is used".  Boards could want more.
  */
 
-static int __devinit omap_cf_probe(struct device *dev)
+static int __init omap_cf_probe(struct platform_device *pdev)
 {
 	unsigned		seg;
 	struct omap_cf_socket	*cf;
-	struct platform_device	*pdev = to_platform_device(dev);
 	int			irq;
 	int			status;
 
-	seg = (int) dev->platform_data;
+	seg = (int) pdev->dev.platform_data;
 	if (seg == 0 || seg > 3)
 		return -ENODEV;
 
@@ -227,7 +226,7 @@ static int __devinit omap_cf_probe(struc
 	cf->timer.data = (unsigned long) cf;
 
 	cf->pdev = pdev;
-	dev_set_drvdata(dev, cf);
+	platform_set_drvdata(pdev, cf);
 
 	/* this primarily just shuts up irq handling noise */
 	status = request_irq(irq, omap_cf_irq, IRQF_SHARED,
@@ -291,7 +290,7 @@ static int __devinit omap_cf_probe(struc
 		omap_cf_present() ? "present" : "(not present)");
 
 	cf->socket.owner = THIS_MODULE;
-	cf->socket.dev.parent = dev;
+	cf->socket.dev.parent = &pdev->dev;
 	cf->socket.ops = &omap_cf_ops;
 	cf->socket.resource_ops = &pccard_static_ops;
 	cf->socket.features = SS_CAP_PCCARD | SS_CAP_STATIC_MAP
@@ -318,9 +317,9 @@ fail0:
 	return status;
 }
 
-static int __devexit omap_cf_remove(struct device *dev)
+static int __exit omap_cf_remove(struct platform_device *pdev)
 {
-	struct omap_cf_socket *cf = dev_get_drvdata(dev);
+	struct omap_cf_socket *cf = platform_get_drvdata(pdev);
 
 	cf->active = 0;
 	pcmcia_unregister_socket(&cf->socket);
@@ -332,26 +331,36 @@ static int __devexit omap_cf_remove(stru
 	return 0;
 }
 
-static struct device_driver omap_cf_driver = {
-	.name		= (char *) driver_name,
-	.bus		= &platform_bus_type,
-	.probe		= omap_cf_probe,
-	.remove		= __devexit_p(omap_cf_remove),
-	.suspend	= pcmcia_socket_dev_suspend,
-	.resume		= pcmcia_socket_dev_resume,
+static int omap_cf_suspend(struct platform_device *pdev, pm_message_t mesg)
+{
+	return pcmcia_socket_dev_suspend(&pdev->dev, mesg);
+}
+
+static int omap_cf_resume(struct platform_device *pdev)
+{
+	return pcmcia_socket_dev_resume(&pdev->dev);
+}
+
+static struct platform_driver omap_cf_driver = {
+	.driver = {
+		.name	= (char *) driver_name,
+	},
+	.remove		= __exit_p(omap_cf_remove),
+	.suspend	= omap_cf_suspend,
+	.resume		= omap_cf_resume,
 };
 
 static int __init omap_cf_init(void)
 {
 	if (cpu_is_omap16xx())
-		return driver_register(&omap_cf_driver);
+		return platform_driver_probe(&omap_cf_driver, omap_cf_probe);
 	return -ENODEV;
 }
 
 static void __exit omap_cf_exit(void)
 {
 	if (cpu_is_omap16xx())
-		driver_unregister(&omap_cf_driver);
+		platform_driver_unregister(&omap_cf_driver);
 }
 
 module_init(omap_cf_init);
