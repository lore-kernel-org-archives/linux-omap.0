From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH] OMAP_LDP: Support LCD display as a FB device on ZOOM MDK
Date: Tue,  4 Nov 2008 11:31:56 +0800
Message-ID: <1225769516-4125-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:60525 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742AbYKDD01 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Nov 2008 22:26:27 -0500
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id mA43QQT9027242
	for <linux-omap@vger.kernel.org>; Mon, 3 Nov 2008 19:26:26 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add glue to control the OMAP_LDP LCD as a frame buffer device
using the existing dispc.c driver under omapfb.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/configs/omap_ldp_defconfig |   51 +++++++++-
 arch/arm/mach-omap2/board-ldp.c     |   11 ++
 drivers/video/omap/Kconfig          |    4 +
 drivers/video/omap/Makefile         |    1 +
 drivers/video/omap/lcd_ldp.c        |  200 +++++++++++++++++++++++++++++++++++
 5 files changed, 265 insertions(+), 2 deletions(-)
 create mode 100644 drivers/video/omap/lcd_ldp.c

diff --git a/arch/arm/configs/omap_ldp_defconfig b/arch/arm/configs/omap_ldp_defconfig
index 0acaee5..b8135d2 100644
--- a/arch/arm/configs/omap_ldp_defconfig
+++ b/arch/arm/configs/omap_ldp_defconfig
@@ -667,8 +667,45 @@ CONFIG_DAB=y
 #
 # CONFIG_VGASTATE is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
-# CONFIG_FB is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+CONFIG_FB=y
+CONFIG_FIRMWARE_EDID=y
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_BOOT_VESA_SUPPORT is not set
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_FOREIGN_ENDIAN is not set
+# CONFIG_FB_SYS_FOPS is not set
+# CONFIG_FB_SVGALIB is not set
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
+CONFIG_FB_MODE_HELPERS=y
+CONFIG_FB_TILEBLITTING=y
+
+#
+# Frame buffer hardware drivers
+#
+# CONFIG_FB_S1D13XXX is not set
+# CONFIG_FB_VIRTUAL is not set
+# CONFIG_FB_METRONOME is not set
+CONFIG_FB_OMAP=y
+CONFIG_FB_OMAP_LCD_VGA=y
+# CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
+# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
+CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=4
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_LCD_CLASS_DEVICE=y
+# CONFIG_LCD_LTV350QV is not set
+# CONFIG_LCD_ILI9320 is not set
+# CONFIG_LCD_TDO24M is not set
+# CONFIG_LCD_VGG2432A4 is not set
+CONFIG_LCD_PLATFORM=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+# CONFIG_BACKLIGHT_CORGI is not set
 
 #
 # Display device support
@@ -680,6 +717,16 @@ CONFIG_VIDEO_OUTPUT_CONTROL=m
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+# CONFIG_FONTS is not set
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+CONFIG_LOGO=y
+CONFIG_LOGO_LINUX_MONO=y
+CONFIG_LOGO_LINUX_VGA16=y
+CONFIG_LOGO_LINUX_CLUT224=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 # CONFIG_SND_SEQUENCER is not set
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index d4d4e90..e046b10 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -168,7 +168,13 @@ static struct spi_board_info ldp_spi_board_info[] __initdata = {
 	},
 };
 
+static struct platform_device ldp_lcd_device = {
+	.name		= "ldp_lcd",
+	.id		= -1,
+};
+
 static struct platform_device *ldp_devices[] __initdata = {
+	&ldp_lcd_device,
 };
 
 static void __init omap_ldp_init_irq(void)
@@ -182,8 +188,13 @@ static struct omap_uart_config ldp_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
+static struct omap_lcd_config ldp_lcd_config __initdata = {
+	.ctrl_name	= "internal",
+};
+
 static struct omap_board_config_kernel ldp_config[] __initdata = {
 	{ OMAP_TAG_UART,	&ldp_uart_config },
+	{ OMAP_TAG_LCD,		&ldp_lcd_config },
 };
 
 static int ldp_batt_table[] = {
diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
index 5ebd591..c355b59 100644
--- a/drivers/video/omap/Kconfig
+++ b/drivers/video/omap/Kconfig
@@ -7,6 +7,10 @@ config FB_OMAP
 	help
           Frame buffer driver for OMAP based boards.
 
+config FB_OMAP_LCD_VGA
+        bool "Use LCD in VGA mode"
+	        depends on MACH_OMAP_3430SDP || MACH_OMAP_LDP
+
 choice
 	depends on FB_OMAP && MACH_OVERO
 	prompt "Screen resolution"
diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index 291c46e..881e87d 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -31,6 +31,7 @@ objs-y$(CONFIG_MACH_SX1) += lcd_sx1.o
 objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
 objs-y$(CONFIG_MACH_OMAP_2430SDP) += lcd_2430sdp.o
 objs-y$(CONFIG_MACH_OMAP_3430SDP) += lcd_2430sdp.o
+objs-y$(CONFIG_MACH_OMAP_LDP) += lcd_ldp.o
 objs-y$(CONFIG_MACH_OMAP2EVM) += lcd_omap2evm.o
 objs-y$(CONFIG_MACH_OMAP3EVM) += lcd_omap3evm.o
 objs-y$(CONFIG_MACH_OMAP3_BEAGLE) += lcd_omap3beagle.o
diff --git a/drivers/video/omap/lcd_ldp.c b/drivers/video/omap/lcd_ldp.c
new file mode 100644
index 0000000..e944166
--- /dev/null
+++ b/drivers/video/omap/lcd_ldp.c
@@ -0,0 +1,200 @@
+/*
+ * LCD panel support for the TI LDP board
+ *
+ * Copyright (C) 2007 WindRiver
+ * Author: Stanley Miao <stanley.miao@windriver.com>
+ *
+ * Derived from drivers/video/omap/lcd-2430sdp.c
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
+#include <mach/omapfb.h>
+#include <asm/mach-types.h>
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
+static int ldp_panel_init(struct lcd_panel *panel,
+				struct omapfb_device *fbdev)
+{
+	omap_request_gpio(LCD_PANEL_RESET_GPIO);
+	omap_request_gpio(LCD_PANEL_QVGA_GPIO);
+	gpio_request(LCD_PANEL_ENABLE_GPIO, "lcd panel");
+	gpio_request(LCD_PANEL_BACKLIGHT_GPIO, "lcd backlight");
+
+	omap_set_gpio_direction(LCD_PANEL_QVGA_GPIO, 0);
+	omap_set_gpio_direction(LCD_PANEL_RESET_GPIO, 0);
+	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
+	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 0);
+
+#ifdef CONFIG_FB_OMAP_LCD_VGA
+	omap_set_gpio_dataout(LCD_PANEL_QVGA_GPIO, 0);
+#else
+	omap_set_gpio_dataout(LCD_PANEL_QVGA_GPIO, 1);
+#endif
+	omap_set_gpio_dataout(LCD_PANEL_RESET_GPIO, 1);
+
+	return 0;
+}
+
+static void ldp_panel_cleanup(struct lcd_panel *panel)
+{
+	omap_free_gpio(LCD_PANEL_RESET_GPIO);
+	omap_free_gpio(LCD_PANEL_QVGA_GPIO);
+	gpio_free(LCD_PANEL_ENABLE_GPIO);
+	gpio_free(LCD_PANEL_BACKLIGHT_GPIO);
+}
+
+static int ldp_panel_enable(struct lcd_panel *panel)
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
+static void ldp_panel_disable(struct lcd_panel *panel)
+{
+	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
+	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 0);
+
+	t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEDICATED);
+	t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEV_GRP);
+	mdelay(4);
+}
+
+static unsigned long ldp_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+struct lcd_panel ldp_panel = {
+	.name		= "ldp",
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
+	.init		= ldp_panel_init,
+	.cleanup	= ldp_panel_cleanup,
+	.enable		= ldp_panel_enable,
+	.disable	= ldp_panel_disable,
+	.get_caps	= ldp_panel_get_caps,
+};
+
+static int ldp_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&ldp_panel);
+	return 0;
+}
+
+static int ldp_panel_remove(struct platform_device *pdev)
+{
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

