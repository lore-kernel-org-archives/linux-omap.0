From: Kim Botherway <kbotherway@djdvant.com>
Subject: [PATCH 3/4] Add support for DEVKIT8000 LCD
Date: Thu, 12 Nov 2009 21:23:22 +1100
Message-ID: <838d5a2d54d0668ad72fffee7196d595@djdvant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from outbound.icp-qv1-irony-out2.iinet.net.au ([203.59.1.107]:30360
	"EHLO outbound.icp-qv1-irony-out2.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750902AbZKLK0Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Nov 2009 05:26:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org

This patch add support for the Timll DEVKIT8000 LCD panel


diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index b63b198..b906d25 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -33,6 +33,7 @@ objs-y$(CONFIG_MACH_OMAP_LDP) += lcd_ldp.o
 objs-y$(CONFIG_MACH_OMAP2EVM) += lcd_omap2evm.o
 objs-y$(CONFIG_MACH_OMAP3EVM) += lcd_omap3evm.o
 objs-y$(CONFIG_MACH_OMAP3_BEAGLE) += lcd_omap3beagle.o
+objs-y$(CONFIG_MACH_OMAP3_DEVKIT8000) += lcd_omap3devkit8000.o
 objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
 objs-y$(CONFIG_MACH_OVERO) += lcd_overo.o
 
diff --git a/drivers/video/omap/lcd_omap3devkit8000.c
b/drivers/video/omap/lcd_omap3devkit8000.c
new file mode 100644
index 0000000..242cece
--- /dev/null
+++ b/drivers/video/omap/lcd_omap3devkit8000.c
@@ -0,0 +1,132 @@
+/*
+ * LCD panel support for the TI OMAP3 Beagle board
+ *
+ * Author: Koen Kooi <koen@openembedded.org>
+ *
+ * Derived from drivers/video/omap/lcd-omap3evm.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/i2c/twl4030.h>
+
+#include <plat/mux.h>
+#include <plat/omapfb.h>
+#include <asm/mach-types.h>
+
+#define LCD_PANEL_ENABLE_GPIO       170
+
+static int omap3devkit8000_panel_init(struct lcd_panel *panel,
+				struct omapfb_device *fbdev)
+{
+	gpio_request(LCD_PANEL_ENABLE_GPIO, "LCD enable");
+	return 0;
+}
+
+static void omap3devkit8000_panel_cleanup(struct lcd_panel *panel)
+{
+	gpio_free(LCD_PANEL_ENABLE_GPIO);
+}
+
+static int omap3devkit8000_panel_enable(struct lcd_panel *panel)
+{
+	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 1);
+	return 0;
+}
+
+static void omap3devkit8000_panel_disable(struct lcd_panel *panel)
+{
+	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 0);
+}
+
+static unsigned long omap3devkit8000_panel_get_caps(struct lcd_panel
*panel)
+{
+	return 0;
+}
+
+struct lcd_panel omap3devkit8000_panel = {
+	.name		= "omap3devkit8000",
+	.config		= OMAP_LCDC_PANEL_TFT,
+	.bpp		= 16,
+	.data_lines	= 24,
+
+	.name           = "7inch_LCD",
+	.x_res          = 800,
+	.y_res          = 480,
+	.hsw            = 48,	/* hsync_len (4) - 1 */
+	.hfp            = 1,      /* right_margin (4) - 1 */
+	.hbp            = 1,      /* left_margin (40) - 1 */
+	.vsw            = 3,       /* vsync_len (2) - 1 */
+	.vfp            = 12,     /* lower_margin */
+	.vbp            = 25,     /* upper_margin (8) - 1 */
+	.pixel_clock    = 36000,
+
+	.init		= omap3devkit8000_panel_init,
+	.cleanup	= omap3devkit8000_panel_cleanup,
+	.enable		= omap3devkit8000_panel_enable,
+	.disable	= omap3devkit8000_panel_disable,
+	.get_caps	= omap3devkit8000_panel_get_caps,
+
+};
+
+
+static int omap3devkit8000_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&omap3devkit8000_panel);
+	return 0;
+}
+
+static int omap3devkit8000_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int omap3devkit8000_panel_suspend(struct platform_device *pdev,
+				   pm_message_t mesg)
+{
+	return 0;
+}
+
+static int omap3devkit8000_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver omap3devkit8000_panel_driver = {
+	.probe		= omap3devkit8000_panel_probe,
+	.remove		= omap3devkit8000_panel_remove,
+	.suspend	= omap3devkit8000_panel_suspend,
+	.resume		= omap3devkit8000_panel_resume,
+	.driver		= {
+		.name	= "omap3devkit8000_lcd",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init omap3devkit8000_panel_drv_init(void)
+{
+	return platform_driver_register(&omap3devkit8000_panel_driver);
+}
+
+static void __exit omap3devkit8000_panel_drv_exit(void)
+{
+	platform_driver_unregister(&omap3devkit8000_panel_driver);
+}
+
+module_init(omap3devkit8000_panel_drv_init);
+module_exit(omap3devkit8000_panel_drv_exit);
