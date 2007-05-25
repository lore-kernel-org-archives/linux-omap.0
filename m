From: Hunyue Yau <hyau@mvista.com>
Subject: [PATCH] OMAP: 2430SDP: Support LCD display as a FB device
Date: Fri, 25 May 2007 15:18:12 -0700
Message-ID: <200705251518.13137.hyau@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Add glue to control the 2430SDP LCD as a frame buffer device 
using the existing dispc.c driver under omapfb.

Signed-off-by: Hunyue Yau <hyau@mvista.com>
Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
diff -Nurd --exclude=Image --exclude=uImage --exclude zImage --exclude vmlinux --exclude System.map --exclude Module.symvers --exclude .version --exclude asm-offsets.h --exclude mach-types.h --exclude .config --exclude .config.old --exclude bzImage --exclude autoconf.h --exclude keywords.c --exclude 'lex.*' --exclude parse.c --exclude parse.h --exclude 'zconf.*' --exclude '*.d' --exclude auto.conf --exclude kernel.release --exclude compile.h --exclude utsrelease.h --exclude version.h --exclude crc32table.h --exclude consolemap_deftbl.c --exclude defkeymap.c --exclude clut_vga16.c --exclude 'logo_*.c' --exclude '*.tmp' --exclude '.tmp_*' --exclude '.missing-*' --exclude '*.gz' --exclude='vmlinux.*' --exclude '*.s' --exclude='*.o' --exclude='*.o.cmd' --exclude '*.a' --exclude '*.ko' --exclude '*.cmd' --exclude '*.mod.c' linux-omap-2.6.orig/arch/arm/mach-omap2/board-2430sdp.c linux-omap-2.6
 /arch/arm/mach-omap2/board-2430sdp.c
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-2430sdp.c	2007-05-17 11:54:02.000000000 -0700
+++ linux-omap-2.6/arch/arm/mach-omap2/board-2430sdp.c	2007-05-22 14:45:26.000000000 -0700
@@ -113,6 +113,11 @@
 	},
 };
 
+static struct platform_device sdp2430_lcd_device = {
+	.name		= "sdp2430_lcd",
+	.id		= -1,
+};
+
 static struct platform_device sdp2430_smc91x_device = {
 	.name		= "smc91x",
 	.id		= -1,
@@ -123,6 +128,7 @@
 static struct platform_device *sdp2430_devices[] __initdata = {
 	&sdp2430_smc91x_device,
 	&sdp2430_flash_device,
+	&sdp2430_lcd_device,
 };
 
 static struct tsc2046_platform_data tsc2046_config = {
@@ -135,6 +141,10 @@
 	.single_channel = 0,  /* 0: slave, 1: master */
 };
 
+static struct omap_lcd_config sdp2430_lcd_config __initdata = {
+	.ctrl_name	= "internal",
+};
+
 static struct spi_board_info sdp2430_spi_board_info[] __initdata = {
 	[0] = {
 		/*
@@ -221,6 +231,7 @@
 
 static struct omap_board_config_kernel sdp2430_config[] = {
 	{OMAP_TAG_UART, &sdp2430_uart_config},
+	{OMAP_TAG_LCD, &sdp2430_lcd_config},
 };
 
 #if	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
diff -Nurd --exclude=Image --exclude=uImage --exclude zImage --exclude vmlinux --exclude System.map --exclude Module.symvers --exclude .version --exclude asm-offsets.h --exclude mach-types.h --exclude .config --exclude .config.old --exclude bzImage --exclude autoconf.h --exclude keywords.c --exclude 'lex.*' --exclude parse.c --exclude parse.h --exclude 'zconf.*' --exclude '*.d' --exclude auto.conf --exclude kernel.release --exclude compile.h --exclude utsrelease.h --exclude version.h --exclude crc32table.h --exclude consolemap_deftbl.c --exclude defkeymap.c --exclude clut_vga16.c --exclude 'logo_*.c' --exclude '*.tmp' --exclude '.tmp_*' --exclude '.missing-*' --exclude '*.gz' --exclude='vmlinux.*' --exclude '*.s' --exclude='*.o' --exclude='*.o.cmd' --exclude '*.a' --exclude '*.ko' --exclude '*.cmd' --exclude '*.mod.c' linux-omap-2.6.orig/drivers/video/omap/Makefile linux-omap-2.6/drivers
 /video/omap/Makefile
--- linux-omap-2.6.orig/drivers/video/omap/Makefile	2007-05-17 11:54:35.000000000 -0700
+++ linux-omap-2.6/drivers/video/omap/Makefile	2007-05-25 12:38:05.000000000 -0700
@@ -28,6 +28,7 @@
 objs-y$(CONFIG_MACH_OMAP_OSK) += lcd_osk.o
 objs-y$(CONFIG_MACH_OMAP_PERSEUS2) += lcd_p2.o
 objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
+objs-y$(CONFIG_MACH_OMAP_2430SDP) += lcd_2430sdp.o
 
 objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
 
diff -Nurd --exclude=Image --exclude=uImage --exclude zImage --exclude vmlinux --exclude System.map --exclude Module.symvers --exclude .version --exclude asm-offsets.h --exclude mach-types.h --exclude .config --exclude .config.old --exclude bzImage --exclude autoconf.h --exclude keywords.c --exclude 'lex.*' --exclude parse.c --exclude parse.h --exclude 'zconf.*' --exclude '*.d' --exclude auto.conf --exclude kernel.release --exclude compile.h --exclude utsrelease.h --exclude version.h --exclude crc32table.h --exclude consolemap_deftbl.c --exclude defkeymap.c --exclude clut_vga16.c --exclude 'logo_*.c' --exclude '*.tmp' --exclude '.tmp_*' --exclude '.missing-*' --exclude '*.gz' --exclude='vmlinux.*' --exclude '*.s' --exclude='*.o' --exclude='*.o.cmd' --exclude '*.a' --exclude '*.ko' --exclude '*.cmd' --exclude '*.mod.c' linux-omap-2.6.orig/drivers/video/omap/lcd_2430sdp.c linux-omap-2.6/dr
 ivers/video/omap/lcd_2430sdp.c
--- linux-omap-2.6.orig/drivers/video/omap/lcd_2430sdp.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-omap-2.6/drivers/video/omap/lcd_2430sdp.c	2007-05-24 18:32:24.000000000 -0700
@@ -0,0 +1,154 @@
+/*
+ * LCD panel support for the TI 2430SDP board
+ *
+ * Copyright (C) 2007 MontaVista 
+ * Author: Hunyue Yau <hyau@mvista.com>
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
+
+#include <asm/arch/gpio.h>
+#include <asm/arch/mux.h>
+#include <asm/arch/omapfb.h>
+#include <asm/arch/twl4030.h>
+
+#define LCD_PANEL_BACKLIGHT_GPIO	91
+#define LCD_PANEL_ENABLE_GPIO		154
+#define H4_LCD_PIXCLOCK_MAX		185186 /* freq 5.4 MHz */
+#define PM_RECEIVER             TWL4030_MODULE_PM_RECIEVER
+#define ENABLE_VAUX2_DEDICATED  0x09
+#define ENABLE_VAUX2_DEV_GRP    0x20
+#define TWL4030_VAUX2_DEV_GRP           0x1B 
+#define TWL4030_VAUX2_DEDICATED         0x1E
+#define TWL4030_MODULE_PM_RECIEVER  0x13
+
+
+
+#define t2_out(c, r, v) twl4030_i2c_write_u8(c, r, v)
+
+
+static int sdp2430_panel_init(struct lcd_panel *panel,
+				struct omapfb_device *fbdev)
+{
+	omap_request_gpio(LCD_PANEL_ENABLE_GPIO);	/* LCD panel */
+	omap_request_gpio(LCD_PANEL_BACKLIGHT_GPIO);	/* LCD backlight */
+	omap_set_gpio_direction(LCD_PANEL_ENABLE_GPIO, 0);	/* output */
+	omap_set_gpio_direction(LCD_PANEL_BACKLIGHT_GPIO, 0);	/* output */
+
+	return 0;
+}
+
+static void sdp2430_panel_cleanup(struct lcd_panel *panel)
+{
+}
+
+static int sdp2430_panel_enable(struct lcd_panel *panel)
+{
+	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 1);
+	omap_set_gpio_dataout(LCD_PANEL_BACKLIGHT_GPIO, 1);
+
+	if(0!= t2_out(PM_RECEIVER, ENABLE_VAUX2_DEDICATED,
+                      TWL4030_VAUX2_DEDICATED)) return -EIO;
+	if(0!= t2_out(PM_RECEIVER, ENABLE_VAUX2_DEV_GRP,
+                      TWL4030_VAUX2_DEV_GRP)) return -EIO;
+
+	return 0;
+}
+
+static void sdp2430_panel_disable(struct lcd_panel *panel)
+{
+	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 0);
+        omap_set_gpio_dataout(LCD_PANEL_BACKLIGHT_GPIO, 0);
+}
+
+static unsigned long sdp2430_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+struct lcd_panel sdp2430_panel = {
+	.name		= "sdp2430",
+	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
+			  OMAP_LCDC_INV_HSYNC,
+
+	.bpp		= 16,
+	.data_lines	= 16,
+	.x_res		= 240,
+	.y_res		= 320,
+	.hsw		= 3,		/* hsync_len (4) - 1 */
+	.hfp		= 3,		/* right_margin (4) - 1 */
+	.hbp		= 39,		/* left_margin (40) - 1 */
+	.vsw		= 1,		/* vsync_len (2) - 1 */
+	.vfp		= 2,		/* lower_margin */
+	.vbp		= 7,		/* upper_margin (8) - 1 */
+
+	.pixel_clock	= H4_LCD_PIXCLOCK_MAX,
+
+	.init		= sdp2430_panel_init,
+	.cleanup	= sdp2430_panel_cleanup,
+	.enable	= sdp2430_panel_enable,
+	.disable	= sdp2430_panel_disable,
+	.get_caps	= sdp2430_panel_get_caps,
+};
+
+static int sdp2430_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&sdp2430_panel);
+	return 0;
+}
+
+static int sdp2430_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int sdp2430_panel_suspend(struct platform_device *pdev, pm_message_t mesg)
+{
+	return 0;
+}
+
+static int sdp2430_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver sdp2430_panel_driver = {
+	.probe		= sdp2430_panel_probe,
+	.remove		= sdp2430_panel_remove,
+	.suspend		= sdp2430_panel_suspend,
+	.resume		= sdp2430_panel_resume,
+	.driver		= {
+		.name	= "sdp2430_lcd",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init sdp2430_panel_drv_init(void)
+{
+	return platform_driver_register(&sdp2430_panel_driver);
+}
+
+static void __exit sdp2430_panel_drv_exit(void)
+{
+	platform_driver_unregister(&sdp2430_panel_driver);
+}
+
+module_init(sdp2430_panel_drv_init);
+module_exit(sdp2430_panel_drv_exit);
