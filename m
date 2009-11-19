From: Gregoire Gentil <gregoire@gentil.com>
Subject: [PATCH 7/8] AI TB: Video driver of Always Innovating OMAP3-based
 Touch Book
Date: Wed, 18 Nov 2009 18:58:03 -0800
Message-ID: <1258599483.8001.38.camel@gregoire-laptop>
References: <1258228079.16065.17.camel@runt>
	 <1258345850.9089.21.camel@gregoire-laptop>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-oG93D5UPp+TFkSb5jFBu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:57673 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758045AbZKSC6A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 21:58:00 -0500
Received: by mail-gx0-f226.google.com with SMTP id 26so1677303gxk.1
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 18:58:06 -0800 (PST)
In-Reply-To: <1258345850.9089.21.camel@gregoire-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Tim Yamin <plasmaroo@gmail.com>


--=-oG93D5UPp+TFkSb5jFBu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Signed-off-by: Gregoire Gentil <gregoire@gentil.com>
---
drivers/video/omap/lcd_omap3touchbook.c |  130
+++++++++++++++++++++++++++++++
1 files changed, 130 insertions(+), 0 deletions(-)
create mode 100644 drivers/video/omap/lcd_omap3touchbook.c

diff --git a/drivers/video/omap/lcd_omap3touchbook.c
b/drivers/video/omap/lcd_omap3touchbook.c
new file mode 100644
index 0000000..5b58703
--- /dev/null
+++ b/drivers/video/omap/lcd_omap3touchbook.c
@@ -0,0 +1,130 @@
+/*
+ * LCD panel support for the Touch Book
+ *
+ * Author: Gregoire Gentil <gregoire@gentil.com>
+ *
+ * Derived from drivers/video/omap/lcd-omap3beagle.c
+ *
+ * This program is free software; you can redistribute it and/or modify
it
+ * under the terms of the GNU General Public License as published by
the
+ * Free Software Foundation; either version 2 of the License, or (at
your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
along
+ * with this program; if not, write to the Free Software Foundation,
Inc.,
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
+#define LCD_PANEL_ENABLE_GPIO       176
+
+static int omap3beagle_panel_init(struct lcd_panel *panel,
+ struct omapfb_device *fbdev)
+{
+ gpio_request(LCD_PANEL_ENABLE_GPIO, "LCD enable");
+ return 0;
+}
+
+static void omap3beagle_panel_cleanup(struct lcd_panel *panel)
+{
+ gpio_free(LCD_PANEL_ENABLE_GPIO);
+}
+
+static int omap3beagle_panel_enable(struct lcd_panel *panel)
+{
+ gpio_set_value(LCD_PANEL_ENABLE_GPIO, 1);
+ return 0;
+}
+
+static void omap3beagle_panel_disable(struct lcd_panel *panel)
+{
+ gpio_set_value(LCD_PANEL_ENABLE_GPIO, 0);
+}
+
+static unsigned long omap3beagle_panel_get_caps(struct lcd_panel
*panel)
+{
+ return 0;
+}
+
+struct lcd_panel omap3beagle_panel = {
+ .name = "omap3beagle",
+ .config = OMAP_LCDC_PANEL_TFT,
+
+ .bpp = 16,
+ .data_lines = 24,
+ .x_res = 1024,
+ .y_res = 600,
+ .hsw = 3,
+ .hfp = 3,
+ .hbp = 39,
+ .vsw = 1,
+ .vfp = 2,
+ .vbp = 7,
+
+ .pixel_clock = 64000,
+
+ .init = omap3touchbook_panel_init,
+ .cleanup = omap3touchbook_panel_cleanup,
+ .enable = omap3touchbook_panel_enable,
+ .disable = omap3touchbook_panel_disable,
+ .get_caps = omap3touchbook_panel_get_caps,
+};
+
+static int omap3touchbook_panel_probe(struct platform_device *pdev)
+{
+ omapfb_register_panel(&omap3beagle_panel);
+ return 0;
+}
+
+static int omap3touchbook_panel_remove(struct platform_device *pdev)
+{
+ return 0;
+}
+
+static int omap3touchbook_panel_suspend(struct platform_device *pdev,
+    pm_message_t mesg)
+{
+ return 0;
+}
+
+static int omap3touchbook_panel_resume(struct platform_device *pdev)
+{
+ return 0;
+}
+
+struct platform_driver omap3touchbook_panel_driver = {
+ .probe = omap3touchbook_panel_probe,
+ .remove = omap3touchbook_panel_remove,
+ .suspend = omap3touchbook_panel_suspend,
+ .resume = omap3touchbook_panel_resume,
+ .driver = {
+ .name = "omap3touchbook_lcd",
+ .owner = THIS_MODULE,
+ },
+};
+
+static int __init omap3touchbook_panel_drv_init(void)
+{
+ return platform_driver_register(&omap3beagle_panel_driver);
+}
+
+static void __exit omap3touchbook_panel_drv_exit(void)
+{
+ platform_driver_unregister(&omap3touchbook_panel_driver);
+}
+
+module_init(omap3touchbook_panel_drv_init);
+module_exit(omap3touchbook_panel_drv_exit);
-- 
1.6.0.4



--=-oG93D5UPp+TFkSb5jFBu
Content-Disposition: attachment; filename*0=0007-Video-driver-of-Always-Innovating-OMAP3-based-Touch.patc; filename*1=h
Content-Type: text/x-patch; name="0007-Video-driver-of-Always-Innovating-OMAP3-based-Touch.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From f5576d74460c00bf82707fc9a2d4db12227b55e0 Mon Sep 17 00:00:00 2001
From: Gregoire Gentil <gregoire@gentil.com>
Date: Wed, 18 Nov 2009 18:34:14 -0800
Subject: [PATCH] Video driver of Always Innovating OMAP3-based Touch Book


Signed-off-by: Gregoire Gentil <gregoire@gentil.com>
---
 drivers/video/omap/lcd_omap3touchbook.c |  130 +++++++++++++++++++++++++++++++
 1 files changed, 130 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap/lcd_omap3touchbook.c

diff --git a/drivers/video/omap/lcd_omap3touchbook.c b/drivers/video/omap/lcd_omap3touchbook.c
new file mode 100644
index 0000000..5b58703
--- /dev/null
+++ b/drivers/video/omap/lcd_omap3touchbook.c
@@ -0,0 +1,130 @@
+/*
+ * LCD panel support for the Touch Book
+ *
+ * Author: Gregoire Gentil <gregoire@gentil.com>
+ *
+ * Derived from drivers/video/omap/lcd-omap3beagle.c
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
+#define LCD_PANEL_ENABLE_GPIO       176
+
+static int omap3beagle_panel_init(struct lcd_panel *panel,
+				struct omapfb_device *fbdev)
+{
+	gpio_request(LCD_PANEL_ENABLE_GPIO, "LCD enable");
+	return 0;
+}
+
+static void omap3beagle_panel_cleanup(struct lcd_panel *panel)
+{
+	gpio_free(LCD_PANEL_ENABLE_GPIO);
+}
+
+static int omap3beagle_panel_enable(struct lcd_panel *panel)
+{
+	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 1);
+	return 0;
+}
+
+static void omap3beagle_panel_disable(struct lcd_panel *panel)
+{
+	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 0);
+}
+
+static unsigned long omap3beagle_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+struct lcd_panel omap3beagle_panel = {
+	.name		= "omap3beagle",
+	.config		= OMAP_LCDC_PANEL_TFT,
+
+	.bpp		= 16,
+	.data_lines	= 24,
+	.x_res		= 1024,
+	.y_res		= 600,
+	.hsw		= 3,
+	.hfp		= 3,
+	.hbp		= 39,
+	.vsw		= 1,
+	.vfp		= 2,
+	.vbp		= 7,
+
+	.pixel_clock	= 64000,
+
+	.init		= omap3touchbook_panel_init,
+	.cleanup	= omap3touchbook_panel_cleanup,
+	.enable		= omap3touchbook_panel_enable,
+	.disable	= omap3touchbook_panel_disable,
+	.get_caps	= omap3touchbook_panel_get_caps,
+};
+
+static int omap3touchbook_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&omap3beagle_panel);
+	return 0;
+}
+
+static int omap3touchbook_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int omap3touchbook_panel_suspend(struct platform_device *pdev,
+				   pm_message_t mesg)
+{
+	return 0;
+}
+
+static int omap3touchbook_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver omap3touchbook_panel_driver = {
+	.probe		= omap3touchbook_panel_probe,
+	.remove		= omap3touchbook_panel_remove,
+	.suspend	= omap3touchbook_panel_suspend,
+	.resume		= omap3touchbook_panel_resume,
+	.driver		= {
+		.name	= "omap3touchbook_lcd",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init omap3touchbook_panel_drv_init(void)
+{
+	return platform_driver_register(&omap3beagle_panel_driver);
+}
+
+static void __exit omap3touchbook_panel_drv_exit(void)
+{
+	platform_driver_unregister(&omap3touchbook_panel_driver);
+}
+
+module_init(omap3touchbook_panel_drv_init);
+module_exit(omap3touchbook_panel_drv_exit);
-- 
1.6.0.4


--=-oG93D5UPp+TFkSb5jFBu
Content-Disposition: attachment; filename*0=0007-Video-driver-of-Always-Innovating-OMAP3-based-Touch.patc; filename*1=h.zip
Content-Type: application/zip; name*0=0007-Video-driver-of-Always-Innovating-OMAP3-based-Touch.patch.zi; name*1=p
Content-Transfer-Encoding: base64

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
S1V4AABQSwUGAAAAAAEAAQB5AAAAOgYAAAAA


--=-oG93D5UPp+TFkSb5jFBu--

