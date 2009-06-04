From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH 08/20] omapfb: Add support for the OMAP3 EVM LCD
Date: Thu,  4 Jun 2009 20:52:33 +0300
Message-ID: <9139035cc12b22600135677cd5d3096c1dcd286d.1244131952.git.imre.deak@nokia.com>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com>
 <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
 <e7f92ea9f0a823f7be401e34243754141b7f72c1.1244131952.git.imre.deak@nokia.com>
 <e9040774f324311979aebd3fa5fa71d20890d433.1244131952.git.imre.deak@nokia.com>
 <833ed44e61e3d4093eb27b55b97252967e042d41.1244131952.git.imre.deak@nokia.com>
 <5ba715a9dbc88b8c3a8225bc1cfdabd3faffe00f.1244131952.git.imre.deak@nokia.com>
 <646692ce09a12e1a8a2d4072097b4d440b7de5d5.1244131952.git.imre.deak@nokia.com>
 <b0e578438bb53d9fbf333e5bd10d4d33f869b373.1244131952.git.imre.deak@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38574 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbZFDRzq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 13:55:46 -0400
In-Reply-To: <b0e578438bb53d9fbf333e5bd10d4d33f869b373.1244131952.git.imre.deak@nokia.com>
In-Reply-To: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
References: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>, Steve Sakoman <steve@sakoman.com>, Imre Deak <imre.deak@nokia.com>

From: Steve Sakoman <steve@sakoman.com>

Add LCD support for OMAP3 EVM

Backlight support by Arun C <arunedarath@mistralsolutions.com>

Signed-off-by: Steve Sakoman <steve@sakoman.com>
Acked-by: Syed Mohammed Khasim <khasim@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Fixed-by: Jarkko Nikula <jarkko.nikula@gmail.com>
Fixed-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Imre Deak <imre.deak@nokia.com>
---
 drivers/video/omap/Makefile       |    1 +
 drivers/video/omap/lcd_omap3evm.c |  191 +++++++++++++++++++++++++++++++++++++
 2 files changed, 192 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap/lcd_omap3evm.c

diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index 96d2d43..4345157 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -30,6 +30,7 @@ objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
 objs-y$(CONFIG_MACH_OMAP_2430SDP) += lcd_2430sdp.o
 objs-y$(CONFIG_MACH_OMAP_3430SDP) += lcd_2430sdp.o
 objs-y$(CONFIG_MACH_OMAP2EVM) += lcd_omap2evm.o
+objs-y$(CONFIG_MACH_OMAP3EVM) += lcd_omap3evm.o
 objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
 
 omapfb-objs := $(objs-yy)
diff --git a/drivers/video/omap/lcd_omap3evm.c b/drivers/video/omap/lcd_omap3evm.c
new file mode 100644
index 0000000..1c3d814
--- /dev/null
+++ b/drivers/video/omap/lcd_omap3evm.c
@@ -0,0 +1,191 @@
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
+#include <linux/gpio.h>
+#include <linux/i2c/twl4030.h>
+
+#include <mach/mux.h>
+#include <mach/omapfb.h>
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
+#define LCD_PIXCLOCK		26000 /* in kHz  */
+
+#define ENABLE_VDAC_DEDICATED	0x03
+#define ENABLE_VDAC_DEV_GRP	0x20
+#define ENABLE_VPLL2_DEDICATED	0x05
+#define ENABLE_VPLL2_DEV_GRP	0xE0
+
+#define TWL_LED_LEDEN		0x00
+#define TWL_PWMA_PWMAON		0x00
+#define TWL_PWMA_PWMAOFF	0x01
+
+static unsigned int bklight_level;
+
+static int omap3evm_panel_init(struct lcd_panel *panel,
+				struct omapfb_device *fbdev)
+{
+	gpio_request(LCD_PANEL_LR, "LCD lr");
+	gpio_request(LCD_PANEL_UD, "LCD ud");
+	gpio_request(LCD_PANEL_INI, "LCD ini");
+	gpio_request(LCD_PANEL_RESB, "LCD resb");
+	gpio_request(LCD_PANEL_QVGA, "LCD qvga");
+
+	gpio_direction_output(LCD_PANEL_RESB, 1);
+	gpio_direction_output(LCD_PANEL_INI, 1);
+	gpio_direction_output(LCD_PANEL_QVGA, 0);
+	gpio_direction_output(LCD_PANEL_LR, 1);
+	gpio_direction_output(LCD_PANEL_UD, 1);
+
+	twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
+	bklight_level = 100;
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
+	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 0);
+	return 0;
+}
+
+static void omap3evm_panel_disable(struct lcd_panel *panel)
+{
+	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 1);
+}
+
+static unsigned long omap3evm_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+static int omap3evm_bklight_setlevel(struct lcd_panel *panel,
+						unsigned int level)
+{
+	u8 c;
+	if ((level >= 0) && (level <= 100)) {
+		c = (125 * (100 - level)) / 100 + 2;
+		twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
+		bklight_level = level;
+	}
+	return 0;
+}
+
+static unsigned int omap3evm_bklight_getlevel(struct lcd_panel *panel)
+{
+	return bklight_level;
+}
+
+static unsigned int omap3evm_bklight_getmaxlevel(struct lcd_panel *panel)
+{
+	return 100;
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
+	.pixel_clock	= LCD_PIXCLOCK,
+
+	.init		= omap3evm_panel_init,
+	.cleanup	= omap3evm_panel_cleanup,
+	.enable		= omap3evm_panel_enable,
+	.disable	= omap3evm_panel_disable,
+	.get_caps	= omap3evm_panel_get_caps,
+	.set_bklight_level      = omap3evm_bklight_setlevel,
+	.get_bklight_level      = omap3evm_bklight_getlevel,
+	.get_bklight_max        = omap3evm_bklight_getmaxlevel,
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
+				   pm_message_t mesg)
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
-- 
1.6.3.1

