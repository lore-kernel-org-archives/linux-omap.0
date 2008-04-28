From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [PATCH 6/7] OMAP3 EVM: add lcd support
Date: Mon, 28 Apr 2008 16:30:09 -0700
Message-ID: <5e088bd90804281630h38261b78qbd6436cfa7c1a074@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:43564 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893AbYD1XaL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 19:30:11 -0400
Received: by ug-out-1314.google.com with SMTP id z38so953239ugc.16
        for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2008 16:30:09 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Steve Sakoman <steve@sakoman.com>

Add LCD support for OMAP3 EVM

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   15 +++
 drivers/video/omap/Makefile          |    1
 drivers/video/omap/lcd_omap3evm.c    |  168 +++++++++++++++++++++++++++++++++++
 3 files changed, 184 insertions(+)
diff -uprN -X a/Documentation/dontdiff
a/arch/arm/mach-omap2/board-omap3evm.c
b/arch/arm/mach-omap2/board-omap3evm.c
--- a/arch/arm/mach-omap2/board-omap3evm.c	2008-04-28 11:11:51.000000000 -0700
+++ b/arch/arm/mach-omap2/board-omap3evm.c	2008-04-28 11:31:01.000000000 -0700
@@ -51,6 +51,15 @@ static struct omap_mmc_config omap3_evm_
 	},
 };

+static struct platform_device omap3_evm_lcd_device = {
+	.name		= "omap3evm_lcd",
+	.id		= -1,
+};
+
+static struct omap_lcd_config omap3_evm_lcd_config __initdata = {
+	.ctrl_name	= "internal",
+};
+
 static void __init omap3_evm_init_irq(void)
 {
 	omap2_init_common_hw();
@@ -61,10 +70,16 @@ static void __init omap3_evm_init_irq(vo
 static struct omap_board_config_kernel omap3_evm_config[] __initdata = {
 	{ OMAP_TAG_UART,	&omap3_evm_uart_config },
 	{ OMAP_TAG_MMC,		&omap3_evm_mmc_config },
+	{ OMAP_TAG_LCD,		&omap3_evm_lcd_config },
+};
+
+static struct platform_device *omap3_evm_devices[] __initdata = {
+	&omap3_evm_lcd_device,
 };

 static void __init omap3_evm_init(void)
 {
+	platform_add_devices(omap3_evm_devices, ARRAY_SIZE(omap3_evm_devices));
 	omap_board_config = omap3_evm_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
 	omap_serial_init();
diff -uprN -X a/Documentation/dontdiff
a/drivers/video/omap/lcd_omap3evm.c
b/drivers/video/omap/lcd_omap3evm.c
--- a/drivers/video/omap/lcd_omap3evm.c	1969-12-31 16:00:00.000000000 -0800
+++ b/drivers/video/omap/lcd_omap3evm.c	2008-04-28 11:31:01.000000000 -0700
@@ -0,0 +1,168 @@
+/*
+ * LCD panel support for the TI OMAP3 EVM board
+ *
+ * Author: Steve Sakoman <steve@sakoman.com>
+ *
+ * Derived from drivers/video/omap/lcd-apollon.c
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
+#include <linux/i2c/twl4030.h>
+
+#include <asm/arch/gpio.h>
+#include <asm/arch/mux.h>
+#include <asm/arch/omapfb.h>
+#include <asm/mach-types.h>
+
+#define LCD_PANEL_ENABLE_GPIO       153
+#define LCD_PANEL_LR                2
+#define LCD_PANEL_UD                3
+#define LCD_PANEL_INI               152
+#define LCD_PANEL_QVGA              154
+#define LCD_PANEL_RESB              155
+
+#define LCD_XRES	 	480
+#define LCD_YRES 		640
+#define LCD_PIXCLOCK_MAX	41700 /* in pico seconds  */
+#define LCD_PIXCLOCK_MIN	38000 /* in pico seconds */
+
+#define ENABLE_VDAC_DEDICATED	0x03
+#define ENABLE_VDAC_DEV_GRP	0x20	
+#define ENABLE_VPLL2_DEDICATED	0x05
+#define ENABLE_VPLL2_DEV_GRP	0xE0
+
+extern void omap2_disp_replication_enable (void);
+
+static int omap3evm_panel_init(struct lcd_panel *panel,
+				struct omapfb_device *fbdev)
+{
+	omap_request_gpio(LCD_PANEL_LR);
+	omap_request_gpio(LCD_PANEL_UD);
+	omap_request_gpio(LCD_PANEL_INI);
+	omap_request_gpio(LCD_PANEL_RESB);
+	omap_request_gpio(LCD_PANEL_QVGA);
+
+	omap_set_gpio_direction(LCD_PANEL_LR, 0);
+	omap_set_gpio_direction(LCD_PANEL_UD, 0);
+	omap_set_gpio_direction(LCD_PANEL_INI, 0);
+	omap_set_gpio_direction(LCD_PANEL_RESB, 0);
+	omap_set_gpio_direction(LCD_PANEL_QVGA, 0);
+
+	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x7F, 0);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x7F, 1);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PWMB, 0x7F, 0);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PWMB, 0x7F, 1);
+
+	omap_set_gpio_dataout(LCD_PANEL_RESB, 1);
+	omap_set_gpio_dataout(LCD_PANEL_INI, 1);
+	omap_set_gpio_dataout(LCD_PANEL_QVGA, 0);
+	omap_set_gpio_dataout(LCD_PANEL_LR, 1);
+	omap_set_gpio_dataout(LCD_PANEL_UD, 1);
+
+	return 0;
+}
+
+static void omap3evm_panel_cleanup(struct lcd_panel *panel)
+{
+}
+
+static int omap3evm_panel_enable(struct lcd_panel *panel)
+{
+	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 0);
+	return 0;
+}
+
+static void omap3evm_panel_disable(struct lcd_panel *panel)
+{
+	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 1);
+}
+
+static unsigned long omap3evm_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+struct lcd_panel omap3evm_panel = {
+	.name		= "omap3evm",
+	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
+			  OMAP_LCDC_INV_HSYNC,
+
+	.bpp		= 16,
+	.data_lines	= 18,
+	.x_res		= LCD_XRES,
+	.y_res		= LCD_YRES,
+	.hsw		= 3,		/* hsync_len (4) - 1 */
+	.hfp		= 3,		/* right_margin (4) - 1 */
+	.hbp		= 39,		/* left_margin (40) - 1 */
+	.vsw		= 1,		/* vsync_len (2) - 1 */
+	.vfp		= 2,		/* lower_margin */
+	.vbp		= 7,		/* upper_margin (8) - 1 */
+
+	.pixel_clock	= LCD_PIXCLOCK_MAX,
+
+	.init		= omap3evm_panel_init,
+	.cleanup	= omap3evm_panel_cleanup,
+	.enable		= omap3evm_panel_enable,
+	.disable	= omap3evm_panel_disable,
+	.get_caps	= omap3evm_panel_get_caps,
+};
+
+static int omap3evm_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&omap3evm_panel);
+	return 0;
+}
+
+static int omap3evm_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int omap3evm_panel_suspend(struct platform_device *pdev,
pm_message_t mesg)
+{
+	return 0;
+}
+
+static int omap3evm_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver omap3evm_panel_driver = {
+	.probe		= omap3evm_panel_probe,
+	.remove		= omap3evm_panel_remove,
+	.suspend	= omap3evm_panel_suspend,
+	.resume		= omap3evm_panel_resume,
+	.driver		= {
+		.name	= "omap3evm_lcd",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init omap3evm_panel_drv_init(void)
+{
+	return platform_driver_register(&omap3evm_panel_driver);
+}
+
+static void __exit omap3evm_panel_drv_exit(void)
+{
+	platform_driver_unregister(&omap3evm_panel_driver);
+}
+
+module_init(omap3evm_panel_drv_init);
+module_exit(omap3evm_panel_drv_exit);
diff -uprN -X a/Documentation/dontdiff a/drivers/video/omap/Makefile
b/drivers/video/omap/Makefile
--- a/drivers/video/omap/Makefile	2008-04-26 06:32:30.000000000 -0700
+++ b/drivers/video/omap/Makefile	2008-04-28 11:31:01.000000000 -0700
@@ -31,6 +31,7 @@ objs-y$(CONFIG_MACH_SX1) += lcd_sx1.o
 objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
 objs-y$(CONFIG_MACH_OMAP_2430SDP) += lcd_2430sdp.o
 objs-y$(CONFIG_MACH_OMAP_3430SDP) += lcd_2430sdp.o
+objs-y$(CONFIG_MACH_OMAP3EVM) += lcd_omap3evm.o
 objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o

 omapfb-objs := $(objs-yy)
