From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] OMAP_LDP: Support LCD display as a FB device on ZOOM MDK
Date: Fri, 08 May 2009 12:19:13 -0700
Message-ID: <20090508191913.29249.11467.stgit@localhost>
References: <20090508191632.29249.92190.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51547 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756802AbZEHTTO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 15:19:14 -0400
Received: from c-67-160-239-110.hsd1.ca.comcast.net ([67.160.239.110] helo=[127.0.0.1])
	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1M2VbG-0005kn-Gf
	for linux-omap@vger.kernel.org; Fri, 08 May 2009 19:19:14 +0000
In-Reply-To: <20090508191632.29249.92190.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Stanley Miao <stanley.miao@windriver.com>

Add glue to control the OMAP_LDP LCD as a frame buffer device
using the existing dispc.c driver under omapfb.

Patch updated for mainline kernel. Note that the
drivers/video/omap should be updated to pass omap_lcd_config
in platform_data. The patch should also be updated to compile
if twl4030 is not selected, and eventually to use the regulator
framework.

Cc: Imre Deak <imre.deak@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net
Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap_ldp_defconfig |   63 +++++++++++
 arch/arm/mach-omap2/board-ldp.c     |   11 ++
 drivers/video/omap/Kconfig          |    2 
 drivers/video/omap/Makefile         |    1 
 drivers/video/omap/lcd_ldp.c        |  200 +++++++++++++++++++++++++++++++++++
 5 files changed, 274 insertions(+), 3 deletions(-)
 create mode 100644 drivers/video/omap/lcd_ldp.c

diff --git a/arch/arm/configs/omap_ldp_defconfig b/arch/arm/configs/omap_ldp_defconfig
index 679a4a3..8a979cd 100644
--- a/arch/arm/configs/omap_ldp_defconfig
+++ b/arch/arm/configs/omap_ldp_defconfig
@@ -685,11 +685,16 @@ CONFIG_GPIOLIB=y
 # CONFIG_GPIO_SYSFS is not set
 
 #
+# Memory mapped GPIO expanders:
+#
+
+#
 # I2C GPIO expanders:
 #
 # CONFIG_GPIO_MAX732X is not set
 # CONFIG_GPIO_PCA953X is not set
 # CONFIG_GPIO_PCF857X is not set
+CONFIG_GPIO_TWL4030=y
 
 #
 # PCI GPIO expanders:
@@ -740,12 +745,19 @@ CONFIG_SSB_POSSIBLE=y
 #
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_SM501 is not set
+# CONFIG_MFD_ASIC3 is not set
 # CONFIG_HTC_EGPIO is not set
 # CONFIG_HTC_PASIC3 is not set
+# CONFIG_TPS65010 is not set
+CONFIG_TWL4030_CORE=y
 # CONFIG_MFD_TMIO is not set
 # CONFIG_MFD_T7L66XB is not set
 # CONFIG_MFD_TC6387XB is not set
 # CONFIG_MFD_TC6393XB is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_PCF50633 is not set
 
 #
 # Multimedia devices
@@ -767,8 +779,45 @@ CONFIG_DAB=y
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
@@ -780,6 +829,16 @@ CONFIG_VIDEO_OUTPUT_CONTROL=m
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
index da57b0f..abbbdfc 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -77,8 +77,14 @@ static struct platform_device ldp_smsc911x_device = {
 	},
 };
 
+static struct platform_device ldp_lcd_device = {
+	.name		= "ldp_lcd",
+	.id		= -1,
+};
+
 static struct platform_device *ldp_devices[] __initdata = {
 	&ldp_smsc911x_device,
+	&ldp_lcd_device,
 };
 
 static inline void __init ldp_init_smsc911x(void)
@@ -122,8 +128,13 @@ static struct omap_uart_config ldp_uart_config __initdata = {
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
 
 static struct twl4030_gpio_platform_data ldp_gpio_data = {
diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
index 7ca848c..6c86ec0 100644
--- a/drivers/video/omap/Kconfig
+++ b/drivers/video/omap/Kconfig
@@ -9,7 +9,7 @@ config FB_OMAP
 
 config FB_OMAP_LCD_VGA
         bool "Use LCD in VGA mode"
-	  depends on MACH_OMAP_3430SDP
+	  depends on MACH_OMAP_3430SDP || MACH_OMAP_LDP
 
 config FB_OMAP_BOOTLOADER_INIT
 	bool "Check bootloader initialization"
diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index e6d52f3..6637d9e 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -24,6 +24,7 @@ objs-y$(CONFIG_MACH_OMAP_PALMZ71) += lcd_palmz71.o
 objs-$(CONFIG_ARCH_OMAP16XX)$(CONFIG_MACH_OMAP_INNOVATOR) += lcd_inn1610.o
 objs-$(CONFIG_ARCH_OMAP15XX)$(CONFIG_MACH_OMAP_INNOVATOR) += lcd_inn1510.o
 objs-y$(CONFIG_MACH_OMAP_OSK) += lcd_osk.o
+objs-y$(CONFIG_MACH_OMAP_LDP) += lcd_ldp.o
 
 objs-y$(CONFIG_MACH_OMAP_2430SDP) += lcd_2430sdp.o
 objs-y$(CONFIG_MACH_OMAP_3430SDP) += lcd_2430sdp.o
diff --git a/drivers/video/omap/lcd_ldp.c b/drivers/video/omap/lcd_ldp.c
new file mode 100644
index 0000000..8925230
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
+static void ldp_panel_cleanup(struct lcd_panel *panel)
+{
+	gpio_free(LCD_PANEL_RESET_GPIO);
+	gpio_free(LCD_PANEL_QVGA_GPIO);
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

