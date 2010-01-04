From: hvaibhav@ti.com
Subject: [PATCH 4/4] OMAP: AM3517: Enable DSS2 for AM3517EVM board
Date: Mon,  4 Jan 2010 20:04:17 +0530
Message-ID: <1262615657-22723-5-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34766 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753429Ab0ADOen (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jan 2010 09:34:43 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

This patch is dependent on I2C interface support patch, since both 
the patch series modifies same file (board-am3517evm.c) file. Please refer to
the link - 

http://marc.info/?l=linux-omap&m=126261461106778&w=2

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/configs/am3517_evm_defconfig |   52 ++++++++++++-
 arch/arm/mach-omap2/board-am3517evm.c |  144 +++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/am3517_evm_defconfig b/arch/arm/configs/am3517_evm_defconfig
index abe9966..859f352 100644
--- a/arch/arm/configs/am3517_evm_defconfig
+++ b/arch/arm/configs/am3517_evm_defconfig
@@ -653,7 +653,57 @@ CONFIG_SSB_POSSIBLE=y
 #
 # CONFIG_VGASTATE is not set
 # CONFIG_VIDEO_OUTPUT_CONTROL is not set
-# CONFIG_FB is not set
+CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
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
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
+# CONFIG_FB_ARMCLCD is not set
+# CONFIG_FB_S1D13XXX is not set
+# CONFIG_FB_VIRTUAL is not set
+# CONFIG_FB_METRONOME is not set
+# CONFIG_FB_MB862XX is not set
+# CONFIG_FB_BROADSHEET is not set
+# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
+CONFIG_OMAP2_VRAM=y
+CONFIG_OMAP2_VRFB=y
+CONFIG_OMAP2_DSS=y
+CONFIG_OMAP2_VRAM_SIZE=4
+CONFIG_OMAP2_DSS_DEBUG_SUPPORT=y
+# CONFIG_OMAP2_DSS_RFBI is not set
+CONFIG_OMAP2_DSS_VENC=y
+# CONFIG_OMAP2_DSS_SDI is not set
+# CONFIG_OMAP2_DSS_DSI is not set
+# CONFIG_OMAP2_DSS_FAKE_VSYNC is not set
+CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=4
+CONFIG_FB_OMAP2=y
+CONFIG_FB_OMAP2_DEBUG_SUPPORT=y
+# CONFIG_FB_OMAP2_FORCE_AUTO_UPDATE is not set
+CONFIG_FB_OMAP2_NUM_FBS=3
+
+#
+# OMAP2/3 Display Device Drivers
+#
+CONFIG_PANEL_GENERIC=y
+# CONFIG_PANEL_SHARP_LS037V7DW01 is not set
+CONFIG_PANEL_SHARP_LQ043T1DG01=y
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index e85243e..b924f15 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -32,12 +32,153 @@
 #include <plat/common.h>
 #include <plat/control.h>
 #include <plat/usb.h>
+#include <plat/display.h>
 
 #include <media/tvp514x.h>
 #include <media/ti-media/vpfe_capture.h>
 
 #include "mux.h"
 
+#define LCD_PANEL_PWR		176
+#define LCD_PANEL_BKLIGHT_PWR	182
+#define LCD_PANEL_PWM		181
+
+static int lcd_enabled;
+static int dvi_enabled;
+
+static void __init am3517_evm_display_init(void)
+{
+	int r;
+
+	omap_mux_init_gpio(LCD_PANEL_PWR, OMAP_PIN_INPUT_PULLUP);
+	omap_mux_init_gpio(LCD_PANEL_BKLIGHT_PWR, OMAP_PIN_INPUT_PULLDOWN);
+	omap_mux_init_gpio(LCD_PANEL_PWM, OMAP_PIN_INPUT_PULLDOWN);
+	/*
+	 * Enable GPIO 182 = LCD Backlight Power
+	 */
+	r = gpio_request(LCD_PANEL_BKLIGHT_PWR, "lcd_backlight_pwr");
+	if (r) {
+		printk(KERN_ERR "failed to get lcd_backlight_pwr\n");
+		return;
+	}
+	gpio_direction_output(LCD_PANEL_BKLIGHT_PWR, 1);
+	/*
+	 * Enable GPIO 181 = LCD Panel PWM
+	 */
+	r = gpio_request(LCD_PANEL_PWM, "lcd_pwm");
+	if (r) {
+		printk(KERN_ERR "failed to get lcd_pwm\n");
+		goto err_1;
+	}
+	gpio_direction_output(LCD_PANEL_PWM, 1);
+	/*
+	 * Enable GPIO 176 = LCD Panel Power enable pin
+	 */
+	r = gpio_request(LCD_PANEL_PWR, "lcd_panel_pwr");
+	if (r) {
+		printk(KERN_ERR "failed to get lcd_panel_pwr\n");
+		goto err_2;
+	}
+	gpio_direction_output(LCD_PANEL_PWR, 1);
+
+	printk(KERN_INFO "Display initialized successfully\n");
+	return;
+
+err_2:
+	gpio_free(LCD_PANEL_PWM);
+err_1:
+	gpio_free(LCD_PANEL_BKLIGHT_PWR);
+}
+
+static int am3517_evm_panel_enable_lcd(struct omap_dss_device *dssdev)
+{
+	if (dvi_enabled) {
+		printk(KERN_ERR "cannot enable LCD, DVI is enabled\n");
+		return -EINVAL;
+	}
+	gpio_set_value(LCD_PANEL_PWR, 1);
+	lcd_enabled = 1;
+
+	return 0;
+}
+
+static void am3517_evm_panel_disable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(LCD_PANEL_PWR, 0);
+	lcd_enabled = 0;
+}
+
+static struct omap_dss_device am3517_evm_lcd_device = {
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.name			= "lcd",
+	.driver_name		= "sharp_lq_panel",
+	.phy.dpi.data_lines 	= 16,
+	.platform_enable	= am3517_evm_panel_enable_lcd,
+	.platform_disable	= am3517_evm_panel_disable_lcd,
+};
+
+static int am3517_evm_panel_enable_tv(struct omap_dss_device *dssdev)
+{
+	return 0;
+}
+
+static void am3517_evm_panel_disable_tv(struct omap_dss_device *dssdev)
+{
+}
+
+static struct omap_dss_device am3517_evm_tv_device = {
+	.type 			= OMAP_DISPLAY_TYPE_VENC,
+	.name 			= "tv",
+	.driver_name		= "venc",
+	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
+	.platform_enable	= am3517_evm_panel_enable_tv,
+	.platform_disable	= am3517_evm_panel_disable_tv,
+};
+
+static int am3517_evm_panel_enable_dvi(struct omap_dss_device *dssdev)
+{
+	if (lcd_enabled) {
+		printk(KERN_ERR "cannot enable DVI, LCD is enabled\n");
+		return -EINVAL;
+	}
+	dvi_enabled = 1;
+
+	return 0;
+}
+
+static void am3517_evm_panel_disable_dvi(struct omap_dss_device *dssdev)
+{
+	dvi_enabled = 0;
+}
+
+static struct omap_dss_device am3517_evm_dvi_device = {
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.name			= "dvi",
+	.driver_name		= "generic_panel",
+	.phy.dpi.data_lines	= 24,
+	.platform_enable	= am3517_evm_panel_enable_dvi,
+	.platform_disable	= am3517_evm_panel_disable_dvi,
+};
+
+static struct omap_dss_device *am3517_evm_dss_devices[] = {
+	&am3517_evm_lcd_device,
+	&am3517_evm_tv_device,
+	&am3517_evm_dvi_device,
+};
+
+static struct omap_dss_board_info am3517_evm_dss_data = {
+	.num_devices	= ARRAY_SIZE(am3517_evm_dss_devices),
+	.devices	= am3517_evm_dss_devices,
+	.default_device	= &am3517_evm_lcd_device,
+};
+
+struct platform_device am3517_evm_dss_device = {
+	.name		= "omapdss",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &am3517_evm_dss_data,
+	},
+};
 
 /*
  * VPFE - Video Decoder interface
@@ -269,6 +410,7 @@ static struct omap_board_config_kernel am3517_evm_config[] __initdata = {
 static struct platform_device *am3517_evm_devices[] __initdata = {
 	&dm644x_ccdc_dev,
 	&vpfe_capture_dev,
+	&am3517_evm_dss_device,
 };
 
 static void __init am3517_evm_init_irq(void)
@@ -327,6 +469,8 @@ static void __init am3517_evm_init(void)
 
 	i2c_register_board_info(1, am3517evm_i2c_boardinfo,
 				ARRAY_SIZE(am3517evm_i2c_boardinfo));
+	/* DSS */
+	am3517_evm_display_init();
 }
 
 static void __init am3517_evm_map_io(void)
-- 
1.6.2.4

