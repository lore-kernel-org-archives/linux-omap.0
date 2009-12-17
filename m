From: hvaibhav@ti.com
Subject: [PATCH 4/5] AM3517: Enable DSS2 for AM3517EVM board
Date: Thu, 17 Dec 2009 20:49:21 +0530
Message-ID: <1261063161-20059-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43479 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965079AbZLQPTm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Dec 2009 10:19:42 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>


Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/configs/am3517_evm_defconfig |   53 ++++++++++++-
 arch/arm/mach-omap2/board-am3517evm.c |  142 +++++++++++++++++++++++++++++++++
 2 files changed, 194 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/am3517_evm_defconfig b/arch/arm/configs/am3517_evm_defconfig
index ad54e92..c4ba4bb 100644
--- a/arch/arm/configs/am3517_evm_defconfig
+++ b/arch/arm/configs/am3517_evm_defconfig
@@ -654,7 +654,58 @@ CONFIG_SSB_POSSIBLE=y
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
+CONFIG_OMAP2_VENC_OUT_TYPE_SVIDEO=y
+# CONFIG_OMAP2_VENC_OUT_TYPE_COMPOSITE is not set
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
index 415a13d..8f6d1d6 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -29,6 +29,145 @@
 #include <plat/board.h>
 #include <plat/common.h>
 #include <plat/usb.h>
+#include <plat/display.h>
+
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
  * Board initialization
@@ -37,6 +176,7 @@ static struct omap_board_config_kernel am3517_evm_config[] __initdata = {
 };
 
 static struct platform_device *am3517_evm_devices[] __initdata = {
+	&am3517_evm_dss_device,
 };
 
 static void __init am3517_evm_init_irq(void)
@@ -67,6 +207,8 @@ static void __init am3517_evm_init(void)
 
 	omap_serial_init();
 	usb_ehci_init(&ehci_pdata);
+
+	am3517_evm_display_init();
 }
 
 static void __init am3517_evm_map_io(void)
-- 
1.6.2.4

