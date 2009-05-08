From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] ARM: OMAP3: Add more devices for omap3430sdp
Date: Fri, 08 May 2009 12:19:02 -0700
Message-ID: <20090508191902.29249.4421.stgit@localhost>
References: <20090508191632.29249.92190.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62993 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759465AbZEHTTE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 15:19:04 -0400
Received: from c-67-160-239-110.hsd1.ca.comcast.net ([67.160.239.110] helo=[127.0.0.1])
	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1M2Vb5-000BF9-70
	for linux-omap@vger.kernel.org; Fri, 08 May 2009 19:19:03 +0000
In-Reply-To: <20090508191632.29249.92190.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add more devices for omap3430sdp

Cc: Imre Deak <imre.deak@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |   10 ++
 arch/arm/mach-omap2/board-2430sdp.c     |    6 +
 drivers/video/omap/Kconfig              |    4 +
 drivers/video/omap/Makefile             |    4 +
 drivers/video/omap/lcd_2430sdp.c        |  199 +++++++++++++++++++++++++++++++
 5 files changed, 223 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap/lcd_2430sdp.c

diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index 8fb918d..2be930c 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -1331,6 +1331,16 @@ CONFIG_DISPLAY_SUPPORT=y
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
 CONFIG_SOUND_OSS_CORE=y
 CONFIG_SND=y
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 2214365..017bebf 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -112,6 +112,11 @@ static struct resource sdp2430_smc91x_resources[] = {
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
@@ -122,6 +127,7 @@ static struct platform_device sdp2430_smc91x_device = {
 static struct platform_device *sdp2430_devices[] __initdata = {
 	&sdp2430_smc91x_device,
 	&sdp2430_flash_device,
+	&sdp2430_lcd_device,
 };
 
 static inline void __init sdp2430_init_smc91x(void)
diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
index 4440885..7ca848c 100644
--- a/drivers/video/omap/Kconfig
+++ b/drivers/video/omap/Kconfig
@@ -7,6 +7,10 @@ config FB_OMAP
 	help
           Frame buffer driver for OMAP based boards.
 
+config FB_OMAP_LCD_VGA
+        bool "Use LCD in VGA mode"
+	  depends on MACH_OMAP_3430SDP
+
 config FB_OMAP_BOOTLOADER_INIT
 	bool "Check bootloader initialization"
 	depends on FB_OMAP
diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index ed13889..e6d52f3 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -8,6 +8,7 @@ objs-yy := omapfb_main.o
 
 objs-y$(CONFIG_ARCH_OMAP1) += lcdc.o
 objs-y$(CONFIG_ARCH_OMAP2) += dispc.o
+objs-y$(CONFIG_ARCH_OMAP3) += dispc.o
 
 objs-$(CONFIG_ARCH_OMAP1)$(CONFIG_FB_OMAP_LCDC_EXTERNAL) += sossi.o
 objs-$(CONFIG_ARCH_OMAP2)$(CONFIG_FB_OMAP_LCDC_EXTERNAL) += rfbi.o
@@ -24,5 +25,8 @@ objs-$(CONFIG_ARCH_OMAP16XX)$(CONFIG_MACH_OMAP_INNOVATOR) += lcd_inn1610.o
 objs-$(CONFIG_ARCH_OMAP15XX)$(CONFIG_MACH_OMAP_INNOVATOR) += lcd_inn1510.o
 objs-y$(CONFIG_MACH_OMAP_OSK) += lcd_osk.o
 
+objs-y$(CONFIG_MACH_OMAP_2430SDP) += lcd_2430sdp.o
+objs-y$(CONFIG_MACH_OMAP_3430SDP) += lcd_2430sdp.o
+
 omapfb-objs := $(objs-yy)
 
diff --git a/drivers/video/omap/lcd_2430sdp.c b/drivers/video/omap/lcd_2430sdp.c
new file mode 100644
index 0000000..a22b452
--- /dev/null
+++ b/drivers/video/omap/lcd_2430sdp.c
@@ -0,0 +1,199 @@
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
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/i2c/twl4030.h>
+
+#include <mach/mux.h>
+#include <mach/omapfb.h>
+#include <asm/mach-types.h>
+
+#define SDP2430_LCD_PANEL_BACKLIGHT_GPIO	91
+#define SDP2430_LCD_PANEL_ENABLE_GPIO		154
+#define SDP3430_LCD_PANEL_BACKLIGHT_GPIO 	24
+#define SDP3430_LCD_PANEL_ENABLE_GPIO 		28
+
+static unsigned backlight_gpio;
+static unsigned enable_gpio;
+
+#define LCD_PIXCLOCK_MAX		5400 /* freq 5.4 MHz */
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
+static int sdp2430_panel_init(struct lcd_panel *panel,
+				struct omapfb_device *fbdev)
+{
+	if (machine_is_omap_3430sdp()) {
+		enable_gpio    = SDP3430_LCD_PANEL_ENABLE_GPIO;
+		backlight_gpio = SDP3430_LCD_PANEL_BACKLIGHT_GPIO;
+	} else {
+		enable_gpio    = SDP2430_LCD_PANEL_ENABLE_GPIO;
+		backlight_gpio = SDP2430_LCD_PANEL_BACKLIGHT_GPIO;
+	}
+
+	gpio_request(enable_gpio, "LCD enable");	/* LCD panel */
+	gpio_request(backlight_gpio, "LCD bl");		/* LCD backlight */
+	gpio_direction_output(enable_gpio, 0);
+	gpio_direction_output(backlight_gpio, 0);
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
+	u8 ded_val, ded_reg;
+	u8 grp_val, grp_reg;
+
+	if (machine_is_omap_3430sdp()) {
+		ded_reg = TWL4030_VAUX3_DEDICATED;
+		ded_val = ENABLE_VAUX3_DEDICATED;
+		grp_reg = TWL4030_VAUX3_DEV_GRP;
+		grp_val = ENABLE_VAUX3_DEV_GRP;
+
+		if (omap_rev() > OMAP3430_REV_ES1_0) {
+			t2_out(PM_RECEIVER, ENABLE_VPLL2_DEDICATED,
+					TWL4030_VPLL2_DEDICATED);
+			t2_out(PM_RECEIVER, ENABLE_VPLL2_DEV_GRP,
+					TWL4030_VPLL2_DEV_GRP);
+		}
+	} else {
+		ded_reg = TWL4030_VAUX2_DEDICATED;
+		ded_val = ENABLE_VAUX2_DEDICATED;
+		grp_reg = TWL4030_VAUX2_DEV_GRP;
+		grp_val = ENABLE_VAUX2_DEV_GRP;
+	}
+		
+	gpio_set_value(enable_gpio, 1);
+	gpio_set_value(backlight_gpio, 1);
+
+	if (0 != t2_out(PM_RECEIVER, ded_val, ded_reg))
+		return -EIO;
+	if (0 != t2_out(PM_RECEIVER, grp_val, grp_reg))
+		return -EIO;
+
+	return 0;
+}
+
+static void sdp2430_panel_disable(struct lcd_panel *panel)
+{
+	gpio_set_value(enable_gpio, 0);
+	gpio_set_value(backlight_gpio, 0);
+	if (omap_rev() > OMAP3430_REV_ES1_0) {
+		t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEDICATED);
+		t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEV_GRP);
+		mdelay(4);
+	}
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
+	.pixel_clock	= LCD_PIXCLOCK_MAX,
+
+	.init		= sdp2430_panel_init,
+	.cleanup	= sdp2430_panel_cleanup,
+	.enable		= sdp2430_panel_enable,
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
+	.suspend	= sdp2430_panel_suspend,
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

