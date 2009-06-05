From: subbu31mani@gmail.com
Subject: [[[Resend][Patch]]] New OMAP LDP supporting DSS2 device model
Date: Fri,  5 Jun 2009 11:04:59 -0400
Message-ID: <1244214299-14228-1-git-send-email-subbu31mani@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:64574 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210AbZFEPFB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 11:05:01 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1069713qwd.37
        for <linux-omap@vger.kernel.org>; Fri, 05 Jun 2009 08:05:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, hardik.shah@ti.com, x0055901@ti.com, nikhil@ti.com, Subramani Venkatesh <subramani.venkatesh@windriver.com>

From: Subramani Venkatesh <subramani.venkatesh@windriver.com>

This patch adds code in board-ldp to support omapdss platform device
Currently it supports two displays on LDP
LCD and TV.
TV Output is not working due to i2c issues
TV output is tested with other branch, works on NTSC, but PAL has sync
issues.

Signed-off-by: Subramani Venkatesh <subramani.venkatesh@windriver.com>
---
 arch/arm/mach-omap2/board-ldp.c            |  194 ++++++++++++++++++++++++++++
 drivers/video/omap2/displays/Kconfig       |    5 +
 drivers/video/omap2/displays/Makefile      |    1 +
 drivers/video/omap2/displays/panel-zoom1.c |  133 +++++++++++++++++++
 4 files changed, 333 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-zoom1.c

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index b79f989..6dffeb6 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -41,8 +41,29 @@
 #include <asm/io.h>
 #include <asm/delay.h>
 #include <mach/control.h>
+#include <mach/display.h>
 
 #include "mmc-twl4030.h"
+#ifdef CONFIG_OMAP2_DSS
+
+#define LCD_PANEL_BACKLIGHT_GPIO	(15 + OMAP_MAX_GPIO_LINES)
+#define LCD_PANEL_ENABLE_GPIO		(7 + OMAP_MAX_GPIO_LINES)
+#define LCD_PANEL_RESET_GPIO		55
+#define LCD_PANEL_QVGA_GPIO		56
+
+#define PM_RECEIVER			TWL4030_MODULE_PM_RECEIVER
+#define ENABLE_VAUX2_DEDICATED		0x09
+#define ENABLE_VAUX2_DEV_GRP		0x20
+#define ENABLE_VAUX3_DEDICATED		0x03
+#define ENABLE_VAUX3_DEV_GRP		0x20
+
+#define ENABLE_VPLL2_DEDICATED		0x05
+#define ENABLE_VPLL2_DEV_GRP		0xE0
+#define TWL4030_VPLL2_DEV_GRP		0x33
+#define TWL4030_VPLL2_DEDICATED		0x36
+
+#define t2_out(c, r, v)			twl4030_i2c_write_u8(c, r, v)
+#endif
 
 #define LDP_SMSC911X_CS		1
 #define LDP_SMSC911X_GPIO	152
@@ -312,14 +333,165 @@ static struct spi_board_info ldp_spi_board_info[] __initdata = {
 	},
 };
 
+#ifdef CONFIG_OMAP2_DSS
+
+static void omap_ldp_panel_init(void)
+{
+	int r;
+	gpio_request(LCD_PANEL_RESET_GPIO, "lcd reset");
+	gpio_request(LCD_PANEL_QVGA_GPIO, "lcd qvga");
+
+	r = gpio_request(LCD_PANEL_ENABLE_GPIO, "lcd panel");
+	if (r < 0) {
+		printk(KERN_ERR "can't get LCD PANEL ENABLE GPIO\n");
+	}
+	r = gpio_request(LCD_PANEL_BACKLIGHT_GPIO, "lcd backlight");
+	if (r < 0) {
+		printk(KERN_ERR "can't get LCD BACKLIGHT GPIO\n");
+	}
+
+	gpio_direction_output(LCD_PANEL_QVGA_GPIO, 0);
+	gpio_direction_output(LCD_PANEL_RESET_GPIO, 0);
+	r = gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
+	r = gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 0);
+
+#ifdef CONFIG_FB_OMAP_LCD_VGA
+	gpio_set_value(LCD_PANEL_QVGA_GPIO, 0);
+#else
+	gpio_set_value(LCD_PANEL_QVGA_GPIO, 1);
+#endif
+
+	gpio_set_value(LCD_PANEL_RESET_GPIO, 1);
+
+err1:
+	gpio_free(LCD_PANEL_ENABLE_GPIO);
+err0:
+	return;
+
+}
+
+void omap_ldp_panel_cleanup(void)
+{
+	gpio_free(LCD_PANEL_RESET_GPIO);
+	gpio_free(LCD_PANEL_QVGA_GPIO);
+	gpio_free(LCD_PANEL_ENABLE_GPIO);
+	gpio_free(LCD_PANEL_BACKLIGHT_GPIO);
+}
+
+static int omap_ldp_panel_enable_tv(struct omap_dss_device *dssdev)
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
+static void omap_ldp_panel_disable_tv(struct omap_dss_device *dssdev)
+{
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x00,
+			TWL4030_VDAC_DEDICATED);
+
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x00,
+			TWL4030_VDAC_DEV_GRP);
+
+}
+
+static struct omap_dss_device omap_ldp_tv_device = {
+	.type = OMAP_DISPLAY_TYPE_VENC,
+	.name = "tv",
+	.driver_name = "venc",
+	.phy.venc.type = OMAP_DSS_VENC_TYPE_SVIDEO,
+	.platform_enable = omap_ldp_panel_enable_tv,
+	.platform_disable = omap_ldp_panel_disable_tv,
+};
+
+static int omap_ldp_panel_enable_lcd(struct omap_dss_device *dssdev)
+{
+	if (0 != t2_out(PM_RECEIVER, ENABLE_VPLL2_DEDICATED,
+				TWL4030_VPLL2_DEDICATED))
+		return -EIO;
+
+	if (0 != t2_out(PM_RECEIVER, ENABLE_VPLL2_DEV_GRP,
+				TWL4030_VPLL2_DEV_GRP))
+		return -EIO;
+
+	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 1);
+	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 1);
+
+	if (0 != t2_out(PM_RECEIVER, ENABLE_VAUX3_DEDICATED,
+				TWL4030_VAUX3_DEDICATED))
+		return -EIO;
+
+	if (0 != t2_out(PM_RECEIVER, ENABLE_VAUX3_DEV_GRP,
+				TWL4030_VAUX3_DEV_GRP))
+		return -EIO;
+
+	return 0;
+}
+
+static void omap_ldp_panel_disable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
+	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 0);
+
+	t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEDICATED);
+	t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEV_GRP);
+	mdelay(4);
+}
+
+static struct omap_dss_device omap_ldp_lcd_device = {
+	.type = OMAP_DISPLAY_TYPE_DPI,
+	.name = "lcd",
+	.driver_name = "panel-zoom1",
+	.phy.dpi.data_lines = 18,
+	.platform_enable = omap_ldp_panel_enable_lcd,
+	.platform_disable = omap_ldp_panel_disable_lcd,
+};
+
+static struct omap_dss_device *omap_ldp_dss_devices[] = {
+	&omap_ldp_lcd_device,
+	&omap_ldp_tv_device,
+};
+static struct omap_dss_board_info omap_ldp_dss_data = {
+	.num_devices = ARRAY_SIZE(omap_ldp_dss_devices),
+	.devices = omap_ldp_dss_devices,
+	.default_device = &omap_ldp_lcd_device,
+};
+
+static struct platform_device omap_ldp_dss_device = {
+	.name = "omapdss",
+	.id = -1,
+	.dev = {
+		.platform_data = &omap_ldp_dss_data,
+	},
+};
+
+static struct regulator_consumer_supply omap_ldp_vdda_dac_supply = {
+	.supply         = "vdda_dac",
+	.dev            = &omap_ldp_dss_device.dev,
+};
+
+#else
 static struct platform_device ldp_lcd_device = {
 	.name		= "ldp_lcd",
 	.id		= -1,
 };
+#endif
 
 static struct platform_device *ldp_devices[] __initdata = {
 	&ldp_smsc911x_device,
+#ifdef CONFIG_OMAP2_DSS
+	&omap_ldp_dss_device,
+#else
 	&ldp_lcd_device,
+#endif
 	&ldp_gpio_keys_device,
 };
 
@@ -512,6 +684,22 @@ static struct regulator_init_data ldp_vmmc1 = {
 	.num_consumer_supplies	= 1,
 	.consumer_supplies	= &ldp_vmmc1_supply,
 };
+#ifdef CONFIG_OMAP2_DSS
+/* VDAC for DSS driving S-Video */
+static struct regulator_init_data omap_ldp_vdac = {
+	.constraints = {
+		.min_uV                 = 1800000,
+		.max_uV                 = 1800000,
+		.apply_uV               = true,
+		.valid_modes_mask       = REGULATOR_MODE_NORMAL
+						| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask         = REGULATOR_CHANGE_MODE
+						| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = 1,
+	.consumer_supplies      = &omap_ldp_vdda_dac_supply,
+};
+#endif
 
 static struct twl4030_platform_data ldp_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
@@ -525,6 +713,9 @@ static struct twl4030_platform_data ldp_twldata = {
 	.vmmc1		= &ldp_vmmc1,
 	.gpio		= &ldp_gpio_data,
 	.keypad		= &ldp_kp_twl4030_data,
+#ifdef CONFIG_OMAP2_DSS
+	.vdac		= &omap_ldp_vdac,
+#endif
 };
 
 static struct i2c_board_info __initdata ldp_i2c_boardinfo[] = {
@@ -572,6 +763,9 @@ static void __init omap_ldp_init(void)
 	twl4030_mmc_init(mmc);
 	/* link regulators to MMC adapters */
 	ldp_vmmc1_supply.dev = mmc[0].dev;
+#ifdef CONFIG_OMAP2_DSS
+	omap_ldp_panel_init();
+#endif
 }
 
 static void __init omap_ldp_map_io(void)
diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index 3feecee..93ee7e5 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -36,4 +36,9 @@ config PANEL_ACX565AKM
         help
           LCD Panel used in RX51
 
+config PANEL_ZOOM1
+        tristate "TI LDP(Zoom1) Panel"
+        help
+          LCD Panel used in the TI Zoom1
+
 endmenu
diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
index 9bafcb6..c7f45eb 100644
--- a/drivers/video/omap2/displays/Makefile
+++ b/drivers/video/omap2/displays/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_CTRL_BLIZZARD) += ctrl-blizzard.o
 obj-$(CONFIG_PANEL_N800) += panel-n800.o
 
 obj-$(CONFIG_PANEL_ACX565AKM) += panel-acx565akm.o
+obj-$(CONFIG_PANEL_ZOOM1) += panel-zoom1.o
diff --git a/drivers/video/omap2/displays/panel-zoom1.c b/drivers/video/omap2/displays/panel-zoom1.c
new file mode 100644
index 0000000..41da8f8
--- /dev/null
+++ b/drivers/video/omap2/displays/panel-zoom1.c
@@ -0,0 +1,133 @@
+/*
+ * LCD panel support for the TI LDP board
+ *
+ * Copyright (C) 2007 WindRiver
+ * Author: Stanley Miao <stanley.miao@windriver.com>
+ *
+ * This program is copied from the original file
+ * drivers/video/omap/lcd-ldp.c and modified by
+ * Subramani.Venkatesh@windriver.com
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
+#ifdef CONFIG_FB_OMAP_LCD_VGA
+#define LCD_XRES		480
+#define LCD_YRES		640
+#define LCD_PIXCLOCK_MAX	21625
+#else
+#define LCD_XRES		240
+#define LCD_YRES		320
+#define LCD_PIXCLOCK_MAX	185186
+#endif
+
+static int ldp_panel_enable(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+	/* wait couple of vsyncs until enabling the LCD */
+
+	msleep(50);
+	if (dssdev->platform_enable)
+		r = dssdev->platform_enable(dssdev);
+
+	return r;
+}
+
+static void ldp_panel_disable(struct omap_dss_device *dssdev)
+{
+	if (dssdev->platform_enable)
+		dssdev->platform_disable(dssdev);
+
+	/* wait at least 5 vsyncs after disabling the LCD */
+	msleep(100);
+
+}
+
+static struct omap_video_timings omap_zoom1_panel_timings = {
+	/*480*640 Resolution*/
+	.x_res		= LCD_XRES,
+	.y_res		= LCD_YRES,
+	.pixel_clock	= LCD_PIXCLOCK_MAX,
+	.hsw		= 3,		/* hsync_len (4) - 1 */
+	.hfp		= 3,		/* right_margin (4) - 1 */
+	.hbp		= 39,		/* left_margin (40) - 1 */
+	.vsw		= 1,		/* vsync_len (2) - 1 */
+	.vfp		= 2,		/* lower_margin */
+	.vbp		= 7,		/* upper_margin (8) - 1 */
+};
+
+static int ldp_panel_probe(struct omap_dss_device *dssdev)
+{
+	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+				OMAP_DSS_LCD_IHS;
+	dssdev->panel.timings = omap_zoom1_panel_timings;
+	return 0;
+}
+
+static void ldp_panel_remove(struct omap_dss_device *dssdev)
+{
+
+}
+
+static int ldp_panel_suspend(struct omap_dss_device *dssdev)
+{
+	ldp_panel_disable(dssdev);
+	return 0;
+}
+
+static int ldp_panel_resume(struct omap_dss_device *dssdev)
+{
+	ldp_panel_enable(dssdev);
+	return 0;
+}
+
+struct omap_dss_driver ldp_panel_driver = {
+	.probe		= ldp_panel_probe,
+	.remove		= ldp_panel_remove,
+
+	.enable		= ldp_panel_enable,
+	.disable	= ldp_panel_disable,
+	.suspend	= ldp_panel_suspend,
+	.resume		= ldp_panel_resume,
+	.driver		= {
+		.name	= "panel-zoom1",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init ldp_panel_drv_init(void)
+{
+	return omap_dss_register_driver(&ldp_panel_driver);
+}
+
+static void __exit ldp_panel_drv_exit(void)
+{
+	omap_dss_unregister_driver(&ldp_panel_driver);
+}
+
+module_init(ldp_panel_drv_init);
+module_exit(ldp_panel_drv_exit);
-- 
1.5.6.3

