From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/7] OMAP: LDP: Port the display driver to new DSS2
Date: Wed,  4 May 2011 15:27:37 +0300
Message-ID: <1304512059-10372-6-git-send-email-tomi.valkeinen@ti.com>
References: <1304512059-10372-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:33585 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753150Ab1EDM2L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 08:28:11 -0400
In-Reply-To: <1304512059-10372-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Stanley Miao <stanley.miao@windriver.com>

Port the old omapfb panel driver to DSS2 and change the board file
accordingly.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Stanley Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap2/board-ldp.c |   73 ++++++++++++--
 drivers/video/omap/Makefile     |    1 -
 drivers/video/omap/lcd_ldp.c    |  201 ---------------------------------------
 3 files changed, 63 insertions(+), 212 deletions(-)
 delete mode 100644 drivers/video/omap/lcd_ldp.c

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index e2ba779..2fdfd7f 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -43,6 +43,8 @@
 
 #include <asm/delay.h>
 #include <plat/usb.h>
+#include <plat/display.h>
+#include <plat/panel-generic-dpi.h>
 
 #include "board-flash.h"
 #include "mux.h"
@@ -275,19 +277,71 @@ static inline void __init ldp_init_smsc911x(void)
 	gpio_direction_input(eth_gpio);
 }
 
-static struct platform_device ldp_lcd_device = {
-	.name		= "ldp_lcd",
-	.id		= -1,
+/* LCD */
+
+#define LCD_PANEL_BACKLIGHT_GPIO	(15 + OMAP_MAX_GPIO_LINES)
+#define LCD_PANEL_ENABLE_GPIO		(7 + OMAP_MAX_GPIO_LINES)
+#define LCD_PANEL_RESET_GPIO		55
+#define LCD_PANEL_QVGA_GPIO		56
+
+static int ldp_panel_enable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 1);
+	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 1);
+
+	return 0;
+}
+
+static void ldp_panel_disable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
+	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 0);
+}
+
+static struct panel_generic_dpi_data ldp_panel_data = {
+	.name			= "2430sdp",
+	.platform_enable	= ldp_panel_enable_lcd,
+	.platform_disable	= ldp_panel_disable_lcd,
 };
 
-static struct omap_lcd_config ldp_lcd_config __initdata = {
-	.ctrl_name	= "internal",
+static struct omap_dss_device ldp_lcd_device = {
+	.name			= "lcd",
+	.driver_name		= "generic_dpi_panel",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.phy.dpi.data_lines	= 16,
+	.data			= &ldp_panel_data,
 };
 
-static struct omap_board_config_kernel ldp_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&ldp_lcd_config },
+static struct omap_dss_device *ldp_dss_devices[] = {
+	&ldp_lcd_device,
+};
+
+static struct omap_dss_board_info ldp_dss_data = {
+	.num_devices	= ARRAY_SIZE(ldp_dss_devices),
+	.devices	= ldp_dss_devices,
+	.default_device	= &ldp_lcd_device,
 };
 
+static void __init ldp_display_init(void)
+{
+	int r;
+
+	struct gpio gpios[] = {
+		{LCD_PANEL_RESET_GPIO, GPIOF_OUT_INIT_HIGH, "LCD RESET"},
+		{LCD_PANEL_QVGA_GPIO, GPIOF_OUT_INIT_HIGH, "LCD QVGA"},
+		{LCD_PANEL_ENABLE_GPIO, GPIOF_OUT_INIT_LOW, "LCD ENABLE"},
+		{LCD_PANEL_BACKLIGHT_GPIO, GPIOF_OUT_INIT_LOW, "LCD BACKLIGHT"},
+	};
+
+	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
+	if (r) {
+		pr_err("Cannot request LCD GPIOs, error %d\n", r);
+		return;
+	}
+
+	omap_display_init(&ldp_dss_data);
+}
+
 static void __init omap_ldp_init_early(void)
 {
 	omap2_init_common_infrastructure();
@@ -390,7 +444,6 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 
 static struct platform_device *ldp_devices[] __initdata = {
 	&ldp_smsc911x_device,
-	&ldp_lcd_device,
 	&ldp_gpio_keys_device,
 };
 
@@ -441,8 +494,6 @@ static struct mtd_partition ldp_nand_partitions[] = {
 static void __init omap_ldp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	omap_board_config = ldp_config;
-	omap_board_config_size = ARRAY_SIZE(ldp_config);
 	ldp_init_smsc911x();
 	omap_i2c_init();
 	platform_add_devices(ldp_devices, ARRAY_SIZE(ldp_devices));
@@ -459,6 +510,8 @@ static void __init omap_ldp_init(void)
 	omap2_hsmmc_init(mmc);
 	/* link regulators to MMC adapters */
 	ldp_vmmc1_supply.dev = mmc[0].dev;
+
+	ldp_display_init();
 }
 
 MACHINE_START(OMAP_LDP, "OMAP LDP board")
diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index f654ba0..43eb64a 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -27,7 +27,6 @@ objs-$(CONFIG_ARCH_OMAP15XX)$(CONFIG_MACH_OMAP_INNOVATOR) += lcd_inn1510.o
 objs-y$(CONFIG_MACH_OMAP_OSK) += lcd_osk.o
 
 objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
-objs-y$(CONFIG_MACH_OMAP_LDP) += lcd_ldp.o
 objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
 objs-y$(CONFIG_MACH_HERALD) += lcd_htcherald.o
 
diff --git a/drivers/video/omap/lcd_ldp.c b/drivers/video/omap/lcd_ldp.c
deleted file mode 100644
index 0f5952c..0000000
--- a/drivers/video/omap/lcd_ldp.c
+++ /dev/null
@@ -1,201 +0,0 @@
-/*
- * LCD panel support for the TI LDP board
- *
- * Copyright (C) 2007 WindRiver
- * Author: Stanley Miao <stanley.miao@windriver.com>
- *
- * Derived from drivers/video/omap/lcd-2430sdp.c
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- */
-
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/delay.h>
-#include <linux/i2c/twl.h>
-
-#include <mach/gpio.h>
-#include <plat/mux.h>
-#include <asm/mach-types.h>
-
-#include "omapfb.h"
-
-#define LCD_PANEL_BACKLIGHT_GPIO	(15 + OMAP_MAX_GPIO_LINES)
-#define LCD_PANEL_ENABLE_GPIO		(7 + OMAP_MAX_GPIO_LINES)
-
-#define LCD_PANEL_RESET_GPIO		55
-#define LCD_PANEL_QVGA_GPIO		56
-
-#ifdef CONFIG_FB_OMAP_LCD_VGA
-#define LCD_XRES		480
-#define LCD_YRES		640
-#define LCD_PIXCLOCK_MAX	41700
-#else
-#define LCD_XRES		240
-#define LCD_YRES		320
-#define LCD_PIXCLOCK_MAX	185186
-#endif
-
-#define PM_RECEIVER             TWL4030_MODULE_PM_RECEIVER
-#define ENABLE_VAUX2_DEDICATED  0x09
-#define ENABLE_VAUX2_DEV_GRP    0x20
-#define ENABLE_VAUX3_DEDICATED	0x03
-#define ENABLE_VAUX3_DEV_GRP	0x20
-
-#define ENABLE_VPLL2_DEDICATED          0x05
-#define ENABLE_VPLL2_DEV_GRP            0xE0
-#define TWL4030_VPLL2_DEV_GRP           0x33
-#define TWL4030_VPLL2_DEDICATED         0x36
-
-#define t2_out(c, r, v) twl_i2c_write_u8(c, r, v)
-
-
-static int ldp_panel_init(struct lcd_panel *panel,
-				struct omapfb_device *fbdev)
-{
-	gpio_request(LCD_PANEL_RESET_GPIO, "lcd reset");
-	gpio_request(LCD_PANEL_QVGA_GPIO, "lcd qvga");
-	gpio_request(LCD_PANEL_ENABLE_GPIO, "lcd panel");
-	gpio_request(LCD_PANEL_BACKLIGHT_GPIO, "lcd backlight");
-
-	gpio_direction_output(LCD_PANEL_QVGA_GPIO, 0);
-	gpio_direction_output(LCD_PANEL_RESET_GPIO, 0);
-	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
-	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 0);
-
-#ifdef CONFIG_FB_OMAP_LCD_VGA
-	gpio_set_value(LCD_PANEL_QVGA_GPIO, 0);
-#else
-	gpio_set_value(LCD_PANEL_QVGA_GPIO, 1);
-#endif
-	gpio_set_value(LCD_PANEL_RESET_GPIO, 1);
-
-	return 0;
-}
-
-static void ldp_panel_cleanup(struct lcd_panel *panel)
-{
-	gpio_free(LCD_PANEL_BACKLIGHT_GPIO);
-	gpio_free(LCD_PANEL_ENABLE_GPIO);
-	gpio_free(LCD_PANEL_QVGA_GPIO);
-	gpio_free(LCD_PANEL_RESET_GPIO);
-}
-
-static int ldp_panel_enable(struct lcd_panel *panel)
-{
-	if (0 != t2_out(PM_RECEIVER, ENABLE_VPLL2_DEDICATED,
-			TWL4030_VPLL2_DEDICATED))
-		return -EIO;
-	if (0 != t2_out(PM_RECEIVER, ENABLE_VPLL2_DEV_GRP,
-			TWL4030_VPLL2_DEV_GRP))
-		return -EIO;
-
-	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 1);
-	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 1);
-
-	if (0 != t2_out(PM_RECEIVER, ENABLE_VAUX3_DEDICATED,
-				TWL4030_VAUX3_DEDICATED))
-		return -EIO;
-	if (0 != t2_out(PM_RECEIVER, ENABLE_VAUX3_DEV_GRP,
-				TWL4030_VAUX3_DEV_GRP))
-		return -EIO;
-
-	return 0;
-}
-
-static void ldp_panel_disable(struct lcd_panel *panel)
-{
-	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
-	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 0);
-
-	t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEDICATED);
-	t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEV_GRP);
-	msleep(4);
-}
-
-static unsigned long ldp_panel_get_caps(struct lcd_panel *panel)
-{
-	return 0;
-}
-
-struct lcd_panel ldp_panel = {
-	.name		= "ldp",
-	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
-			  OMAP_LCDC_INV_HSYNC,
-
-	.bpp		= 16,
-	.data_lines	= 18,
-	.x_res		= LCD_XRES,
-	.y_res		= LCD_YRES,
-	.hsw		= 3,		/* hsync_len (4) - 1 */
-	.hfp		= 3,		/* right_margin (4) - 1 */
-	.hbp		= 39,		/* left_margin (40) - 1 */
-	.vsw		= 1,		/* vsync_len (2) - 1 */
-	.vfp		= 2,		/* lower_margin */
-	.vbp		= 7,		/* upper_margin (8) - 1 */
-
-	.pixel_clock	= LCD_PIXCLOCK_MAX,
-
-	.init		= ldp_panel_init,
-	.cleanup	= ldp_panel_cleanup,
-	.enable		= ldp_panel_enable,
-	.disable	= ldp_panel_disable,
-	.get_caps	= ldp_panel_get_caps,
-};
-
-static int ldp_panel_probe(struct platform_device *pdev)
-{
-	omapfb_register_panel(&ldp_panel);
-	return 0;
-}
-
-static int ldp_panel_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static int ldp_panel_suspend(struct platform_device *pdev, pm_message_t mesg)
-{
-	return 0;
-}
-
-static int ldp_panel_resume(struct platform_device *pdev)
-{
-	return 0;
-}
-
-struct platform_driver ldp_panel_driver = {
-	.probe		= ldp_panel_probe,
-	.remove		= ldp_panel_remove,
-	.suspend	= ldp_panel_suspend,
-	.resume		= ldp_panel_resume,
-	.driver		= {
-		.name	= "ldp_lcd",
-		.owner	= THIS_MODULE,
-	},
-};
-
-static int __init ldp_panel_drv_init(void)
-{
-	return platform_driver_register(&ldp_panel_driver);
-}
-
-static void __exit ldp_panel_drv_exit(void)
-{
-	platform_driver_unregister(&ldp_panel_driver);
-}
-
-module_init(ldp_panel_drv_init);
-module_exit(ldp_panel_drv_exit);
-- 
1.7.4.1

