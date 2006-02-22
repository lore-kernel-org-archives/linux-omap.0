From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] Apollon LCD support
Date: Wed, 22 Feb 2006 19:10:14 +0900
Message-ID: <0IV300JL62X3NE@mmp2.samsung.com>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
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

Hi

Sync. with OMAP git tree

Regards,
Kyungmin Park

--

diff --git a/drivers/video/omap/lcd_apollon.c
b/drivers/video/omap/lcd_apollon.c
--- a/drivers/video/omap/lcd_apollon.c
+++ b/drivers/video/omap/lcd_apollon.c
@@ -24,6 +24,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/platform_device.h>
 
 #include <asm/arch/gpio.h>
 #include <asm/arch/mux.h>
@@ -105,3 +106,52 @@ struct lcd_panel apollon_panel = {
 	.disable	= apollon_panel_disable,
 	.get_caps	= apollon_panel_get_caps,
 };
+
+static int apollon_panel_probe(struct platform_device *pdev)
+{
+	DBGENTER(1);
+	omapfb_register_panel(&apollon_panel);
+	return 0;
+}
+
+static int apollon_panel_remove(struct platform_device *pdev)
+{
+	DBGENTER(1);
+	return 0;
+}
+
+static int apollon_panel_suspend(struct platform_device *pdev, pm_message_t
mesg)
+{
+	DBGENTER(1);
+	return 0;
+}
+
+static int apollon_panel_resume(struct platform_device *pdev)
+{
+	DBGENTER(1);
+	return 0;
+}
+
+struct platform_driver apollon_panel_driver = {
+	.probe		= apollon_panel_probe,
+	.remove		= apollon_panel_remove,
+	.suspend	= apollon_panel_suspend,
+	.resume		= apollon_panel_resume,
+	.driver		= {
+		.name	= "apollon_lcd",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init apollon_panel_drv_init(void)
+{
+	return platform_driver_register(&apollon_panel_driver);
+}
+
+static void __exit apollon_panel_drv_exit(void)
+{
+	platform_driver_unregister(&apollon_panel_driver);
+}
+
+module_init(apollon_panel_drv_init);
+module_exit(apollon_panel_drv_exit);
