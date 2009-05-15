From: subbu31mani@gmail.com
Subject: [RFC PATCH] OMAP LDP supporting DSS2 lib
Date: Fri, 15 May 2009 16:08:43 -0400
Message-ID: <1242418123-12021-1-git-send-email-subbu31mani@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f129.google.com ([209.85.221.129]:50087 "EHLO
	mail-qy0-f129.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbZEOUIq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 16:08:46 -0400
Received: by qyk35 with SMTP id 35so453829qyk.33
        for <linux-omap@vger.kernel.org>; Fri, 15 May 2009 13:08:46 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: subramani.venkatesh@windriver.com, x0055901@ti.com, nikhil@ti.com

From: Subramani <subramani@subbuv30-laptop.(none)>

This patch adds code in board-ldp to support omapdss platform device
Currently it supports two displays on LDP
LCD and TV.
TV Output is not working due to i2c issues
TV output is tested with other branch, works on NTSC, but PAL has sync
issues.

Signed-off-by: SUbramani Venkatesh <subramani.venkatesh@windriver.com>
---
 arch/arm/mach-omap2/board-ldp.c          |   74 +++++++++++
 drivers/video/omap2/displays/Kconfig     |    5 +
 drivers/video/omap2/displays/Makefile    |    1 +
 drivers/video/omap2/displays/panel-ldp.c |  199 ++++++++++++++++++++++++++++++
 4 files changed, 279 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-ldp.c

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 09c4f4e..faba9b3 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -41,6 +41,7 @@
 #include <asm/io.h>
 #include <asm/delay.h>
 #include <mach/control.h>
+#include <mach/display.h>
 
 #include "mmc-twl4030.h"
 
@@ -312,12 +313,85 @@ static struct spi_board_info ldp_spi_board_info[] __initdata = {
 	},
 };
 
+#ifdef CONFIG_OMAP2_DSS
+static int omap_ldp_panel_enable_tv(struct omap_display *display)
+{
+#define ENABLE_VDAC_DEDICATED           0x03
+#define ENABLE_VDAC_DEV_GRP             0x20
+
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+			ENABLE_VDAC_DEDICATED,
+			TWL4030_VDAC_DEDICATED);
+
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+			ENABLE_VDAC_DEV_GRP, TWL4030_VDAC_DEV_GRP);
+
+	return 0;
+}
+
+static void omap_ldp_panel_disable_tv(struct omap_display *display)
+{
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x00,
+			TWL4030_VDAC_DEDICATED);
+
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x00,
+			TWL4030_VDAC_DEV_GRP);
+
+}
+
+static struct omap_dss_display_config omap_ldp_display_data_tv = {
+	.type = OMAP_DISPLAY_TYPE_VENC,
+	.name = "tv",
+	.u.venc.type = OMAP_DSS_VENC_TYPE_SVIDEO,
+	.panel_enable = omap_ldp_panel_enable_tv,
+	.panel_disable = omap_ldp_panel_disable_tv,
+};
+
+static int omap_ldp_panel_enable_lcd(struct omap_display *display)
+{
+	return 0;
+}
+
+static void omap_ldp_panel_disable_lcd(struct omap_display *display)
+{
+}
+
+static struct omap_dss_display_config omap_ldp_display_data_lcd = {
+	.type = OMAP_DISPLAY_TYPE_DPI,
+	.name = "lcd",
+	.panel_name = "panel-zoom1",
+	.u.dpi.data_lines = 18,
+	.panel_enable = omap_ldp_panel_enable_lcd,
+	.panel_disable = omap_ldp_panel_disable_lcd,
+};
+
+static struct omap_dss_board_info omap_ldp_dss_data = {
+	.num_displays = 2,
+	.displays = {
+		&omap_ldp_display_data_lcd,
+		&omap_ldp_display_data_tv,
+	},
+};
+
+static struct platform_device omap_ldp_dss_device = {
+	.name = "omapdss",
+	.id = -1,
+	.dev = {
+	.platform_data = &omap_ldp_dss_data,
+	},
+};
+#endif
+
+
 static struct platform_device ldp_lcd_device = {
 	.name		= "ldp_lcd",
 	.id		= -1,
 };
 
 static struct platform_device *ldp_devices[] __initdata = {
+#ifdef CONFIG_OMAP2_DSS
+	&omap_ldp_dss_device,
+#endif
 	&ldp_smsc911x_device,
 	&ldp_lcd_device,
 	&ldp_gpio_keys_device,
diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index 3feecee..fab0fa9 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -24,6 +24,11 @@ config PANEL_N800
         help
           N8x0 LCD (hack)
 
+config PANEL_LDP
+        tristate "TI OMAP LDP Panel"
+        help
+          LCD Panel used in the TI OMAP LDP
+
 config CTRL_BLIZZARD
         tristate "Blizzard Controller"
         help
diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
index 9bafcb6..89e59da 100644
--- a/drivers/video/omap2/displays/Makefile
+++ b/drivers/video/omap2/displays/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_CTRL_BLIZZARD) += ctrl-blizzard.o
 obj-$(CONFIG_PANEL_N800) += panel-n800.o
 
 obj-$(CONFIG_PANEL_ACX565AKM) += panel-acx565akm.o
+obj-$(CONFIG_PANEL_LDP) += panel-ldp.o
diff --git a/drivers/video/omap2/displays/panel-ldp.c b/drivers/video/omap2/displays/panel-ldp.c
new file mode 100644
index 0000000..15d91cb
--- /dev/null
+++ b/drivers/video/omap2/displays/panel-ldp.c
@@ -0,0 +1,199 @@
+/*
+ * LCD panel support for the TI LDP board
+ *
+ * Copyright (C) 2007 WindRiver
+ * Author: Stanley Miao <stanley.miao@windriver.com>
+ *
+ * This program is copied the original file
+ * drivers/video/omap/lcd-ldp.c
+ * to support DSS2
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
+#include <linux/delay.h>
+#include <linux/i2c/twl4030.h>
+
+#include <mach/gpio.h>
+#include <mach/mux.h>
+#include <asm/mach-types.h>
+
+#include <mach/display.h>
+
+#define LCD_PANEL_BACKLIGHT_GPIO 	(15 + OMAP_MAX_GPIO_LINES)
+#define LCD_PANEL_ENABLE_GPIO 		(7 + OMAP_MAX_GPIO_LINES)
+
+#define LCD_PANEL_RESET_GPIO		55
+#define LCD_PANEL_QVGA_GPIO		56
+
+#ifdef CONFIG_FB_OMAP_LCD_VGA
+#define LCD_XRES		480
+#define LCD_YRES		640
+#define LCD_PIXCLOCK_MAX	41700
+#else
+#define LCD_XRES		240
+#define LCD_YRES		320
+#define LCD_PIXCLOCK_MAX	185186
+#endif
+
+#define PM_RECEIVER             TWL4030_MODULE_PM_RECEIVER
+#define ENABLE_VAUX2_DEDICATED  0x09
+#define ENABLE_VAUX2_DEV_GRP    0x20
+#define ENABLE_VAUX3_DEDICATED	0x03
+#define ENABLE_VAUX3_DEV_GRP	0x20
+
+#define ENABLE_VPLL2_DEDICATED          0x05
+#define ENABLE_VPLL2_DEV_GRP            0xE0
+#define TWL4030_VPLL2_DEV_GRP           0x33
+#define TWL4030_VPLL2_DEDICATED         0x36
+
+#define t2_out(c, r, v) twl4030_i2c_write_u8(c, r, v)
+
+
+static int ldp_panel_init(struct omap_display *display)
+{
+	gpio_request(LCD_PANEL_RESET_GPIO, "lcd reset");
+	gpio_request(LCD_PANEL_QVGA_GPIO, "lcd qvga");
+	gpio_request(LCD_PANEL_ENABLE_GPIO, "lcd panel");
+	gpio_request(LCD_PANEL_BACKLIGHT_GPIO, "lcd backlight");
+
+	gpio_direction_output(LCD_PANEL_QVGA_GPIO, 0);
+	gpio_direction_output(LCD_PANEL_RESET_GPIO, 0);
+	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
+	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 0);
+
+#ifdef CONFIG_FB_OMAP_LCD_VGA
+	gpio_set_value(LCD_PANEL_QVGA_GPIO, 0);
+#else
+	gpio_set_value(LCD_PANEL_QVGA_GPIO, 1);
+#endif
+	gpio_set_value(LCD_PANEL_RESET_GPIO, 1);
+
+	return 0;
+}
+
+static void ldp_panel_cleanup(struct omap_display *display)
+{
+	gpio_free(LCD_PANEL_RESET_GPIO);
+	gpio_free(LCD_PANEL_QVGA_GPIO);
+	gpio_free(LCD_PANEL_ENABLE_GPIO);
+	gpio_free(LCD_PANEL_BACKLIGHT_GPIO);
+}
+
+static int ldp_panel_enable(struct omap_display *display)
+{
+	if (0 != t2_out(PM_RECEIVER, ENABLE_VPLL2_DEDICATED,
+			TWL4030_VPLL2_DEDICATED))
+		return -EIO;
+	if (0 != t2_out(PM_RECEIVER, ENABLE_VPLL2_DEV_GRP,
+			TWL4030_VPLL2_DEV_GRP))
+		return -EIO;
+
+	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 1);
+	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 1);
+
+	if (0 != t2_out(PM_RECEIVER, ENABLE_VAUX3_DEDICATED,
+				TWL4030_VAUX3_DEDICATED))
+		return -EIO;
+	if (0 != t2_out(PM_RECEIVER, ENABLE_VAUX3_DEV_GRP,
+				TWL4030_VAUX3_DEV_GRP))
+		return -EIO;
+
+	return 0;
+}
+
+static void ldp_panel_disable(struct omap_display *display)
+{
+	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
+	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 0);
+
+	t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEDICATED);
+	t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEV_GRP);
+	mdelay(4);
+}
+
+
+static struct omap_panel ldp_panel = {
+	.owner		= THIS_MODULE,
+	.name		= "panel-zoom1",
+	.init		= ldp_panel_init,
+	.cleanup	= ldp_panel_cleanup,
+	.enable		= ldp_panel_enable,
+	.disable	= ldp_panel_disable,
+
+	.timings = {
+	.x_res		= LCD_XRES,
+	.y_res		= LCD_YRES,
+	.pixel_clock	= LCD_PIXCLOCK_MAX,
+	.hsw		= 3,		/* hsync_len (4) - 1 */
+	.hfp		= 3,		/* right_margin (4) - 1 */
+	.hbp		= 39,		/* left_margin (40) - 1 */
+	.vsw		= 1,		/* vsync_len (2) - 1 */
+	.vfp		= 2,		/* lower_margin */
+	.vbp		= 7,		/* upper_margin (8) - 1 */
+	},
+
+	.config		= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+			  OMAP_DSS_LCD_IHS,
+	.recommended_bpp = 16,
+};
+
+static int ldp_panel_probe(struct platform_device *pdev)
+{
+	omap_dss_register_panel(&ldp_panel);
+	return 0;
+}
+
+static int ldp_panel_remove(struct platform_device *pdev)
+{
+	omap_dss_unregister_panel(&ldp_panel);
+	return 0;
+}
+
+static int ldp_panel_suspend(struct platform_device *pdev, pm_message_t mesg)
+{
+	return 0;
+}
+
+static int ldp_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver ldp_panel_driver = {
+	.probe		= ldp_panel_probe,
+	.remove		= ldp_panel_remove,
+	.suspend	= ldp_panel_suspend,
+	.resume		= ldp_panel_resume,
+	.driver		= {
+		.name	= "ldp_lcd",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init ldp_panel_drv_init(void)
+{
+	return platform_driver_register(&ldp_panel_driver);
+}
+
+static void __exit ldp_panel_drv_exit(void)
+{
+	platform_driver_unregister(&ldp_panel_driver);
+}
+
+module_init(ldp_panel_drv_init);
+module_exit(ldp_panel_drv_exit);
-- 
1.5.6.3

