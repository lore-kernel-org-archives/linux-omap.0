From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH 5/5] dsp_core.c: Use struct platform_driver
Date: Mon, 28 Nov 2005 08:56:24 -0800 (PST)
Message-ID: <20051128165624.57987.qmail@web32908.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-860871086-1133196984=:57236"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--0-860871086-1133196984=:57236
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony/Toshihiro-san,

Attached patch updates driver model and adjustment of #ifdef CONFIG_PM.

---Komal Shah
http://komalshah.blogspot.com/


	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
--0-860871086-1133196984=:57236
Content-Type: text/plain; name="0005-dsp.patch"
Content-Description: pat1686335160
Content-Disposition: inline; filename="0005-dsp.patch"

Subject: [PATCH 5/5] dsp_core.c: Use struct platform_driver
Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 arch/arm/plat-omap/dsp/dsp_core.c |   40 +++++++++++++++++++------------------
 1 files changed, 21 insertions(+), 19 deletions(-)

applies-to: 76a87a72f8766eb762aefcd68303dd8d6b91d6fc
a0aede602b9c14ba4eb3d63d879bd0eb72442176
diff --git a/arch/arm/plat-omap/dsp/dsp_core.c b/arch/arm/plat-omap/dsp/dsp_core.c
index d5d8c22..f7aa2b8 100644
--- a/arch/arm/plat-omap/dsp/dsp_core.c
+++ b/arch/arm/plat-omap/dsp/dsp_core.c
@@ -588,7 +588,7 @@ static void dsp_dev_release(struct devic
 #	define INT_D2A_MB2 INT_DSP_MAILBOX1
 #endif
 
-static int __init dsp_drv_probe(struct device *dev)
+static int __init dsp_drv_probe(struct platform_device *pdev)
 {
 	int ret;
 
@@ -611,7 +611,7 @@ static int __init dsp_drv_probe(struct d
 	 * mailbox interrupt handlers registration
 	 */
 	ret = request_irq(INT_D2A_MB1, mbx1_interrupt, SA_INTERRUPT, "dsp",
-			  dev);
+			  &pdev->dev);
 	if (ret) {
 		printk(KERN_ERR
 		       "failed to register mailbox1 interrupt: %d\n", ret);
@@ -619,7 +619,7 @@ static int __init dsp_drv_probe(struct d
 	}
 
 	ret = request_irq(INT_D2A_MB2, mbx2_interrupt, SA_INTERRUPT, "dsp",
-			  dev);
+			  &pdev->dev);
 	if (ret) {
 		printk(KERN_ERR
 		       "failed to register mailbox2 interrupt: %d\n", ret);
@@ -627,7 +627,7 @@ static int __init dsp_drv_probe(struct d
 	}
 
 	ret = request_irq(INT_DSP_MMU, dsp_mmu_interrupt, SA_INTERRUPT, "dsp",
-			  dev);
+			  &pdev->dev);
 	if (ret) {
 		printk(KERN_ERR
 		       "failed to register DSP MMU interrupt: %d\n", ret);
@@ -649,9 +649,9 @@ static int __init dsp_drv_probe(struct d
 	return 0;
 
 fail6:
-	free_irq(INT_D2A_MB2, dev);
+	free_irq(INT_D2A_MB2, &pdev->dev);
 fail5:
-	free_irq(INT_D2A_MB1, dev);
+	free_irq(INT_D2A_MB1, &pdev->dev);
 fail4:
 	dsp_taskmod_exit();
 fail3:
@@ -667,16 +667,16 @@ fail1:
 	return ret;
 }
 
-static int dsp_drv_remove(struct device *dev)
+static int dsp_drv_remove(struct platform_device *pdev)
 {
 	dsp_cpustat_request(CPUSTAT_RESET);
 
 #if 0
 	free_irq(INT_MPUIO, dev);
 #endif
-	free_irq(INT_DSP_MMU, dev);
-	free_irq(INT_D2A_MB2, dev);
-	free_irq(INT_D2A_MB1, dev);
+	free_irq(INT_DSP_MMU, &pdev->dev);
+	free_irq(INT_D2A_MB2, &pdev->dev);
+	free_irq(INT_D2A_MB1, &pdev->dev);
 
 	/* recover disable_depth */
 	enable_irq(INT_DSP_MMU);
@@ -696,19 +696,22 @@ static int dsp_drv_remove(struct device 
 }
 
 #ifdef CONFIG_PM
-static int dsp_drv_suspend(struct device *dev, pm_message_t state)
+static int dsp_drv_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	dsp_suspend();
 
 	return 0;
 }
 
-static int dsp_drv_resume(struct device *dev)
+static int dsp_drv_resume(struct platform_device *pdev)
 {
 	dsp_resume();
 
 	return 0;
 }
+#else
+#define dsp_drv_suspend		NULL
+#define dsp_drv_resume		NULL
 #endif /* CONFIG_PM */
 
 static struct resource dsp_resources[] = {
@@ -736,15 +739,14 @@ struct platform_device dsp_device = {
 	.resource	= dsp_resources,
 };
 
-static struct device_driver dsp_driver = {
-	.name		= "dsp",
-	.bus		= &platform_bus_type,
+static struct platform_driver dsp_driver = {
 	.probe		= dsp_drv_probe,
 	.remove		= dsp_drv_remove,
-#ifdef CONFIG_PM
 	.suspend	= dsp_drv_suspend,
 	.resume		= dsp_drv_resume,
-#endif
+	.driver		= {
+		.name	= "dsp",
+	},
 };
 
 static int __init omap_dsp_mod_init(void)
@@ -757,7 +759,7 @@ static int __init omap_dsp_mod_init(void
 		goto fail1;
 	}
 
-	ret = driver_register(&dsp_driver);
+	ret = platform_driver_register(&dsp_driver);
 	if (ret) {
 		printk(KERN_ERR "failed to register the DSP driver: %d\n", ret);
 		goto fail2;
@@ -773,7 +775,7 @@ fail1:
 
 static void __exit omap_dsp_mod_exit(void)
 {
-	driver_unregister(&dsp_driver);
+	platform_driver_unregister(&dsp_driver);
 	platform_device_unregister(&dsp_device);
 }
 
---
0.99.9.GIT

--0-860871086-1133196984=:57236
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-860871086-1133196984=:57236--
