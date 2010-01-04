From: hvaibhav@ti.com
Subject: [PATCH 3/4] OMAP: Enable DSS2 for OMAP3EVM board
Date: Mon,  4 Jan 2010 20:04:16 +0530
Message-ID: <1262615657-22723-4-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34754 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753301Ab0ADOe3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jan 2010 09:34:29 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/configs/omap3_evm_defconfig |   51 +++++++-
 arch/arm/mach-omap2/board-omap3evm.c |  246 ++++++++++++++++++++++++++++++++--
 2 files changed, 285 insertions(+), 12 deletions(-)

diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
index 86cc4be..40ad645 100644
--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -908,7 +908,56 @@ CONFIG_DAB=y
 #
 # CONFIG_VGASTATE is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
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
+# CONFIG_OMAP2_DSS_DEBUG_SUPPORT is not set
+# CONFIG_OMAP2_DSS_RFBI is not set
+CONFIG_OMAP2_DSS_VENC=y
+# CONFIG_OMAP2_DSS_SDI is not set
+# CONFIG_OMAP2_DSS_DSI is not set
+# CONFIG_OMAP2_DSS_FAKE_VSYNC is not set
+CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=4
+CONFIG_FB_OMAP2=y
+# CONFIG_FB_OMAP2_DEBUG_SUPPORT is not set
+# CONFIG_FB_OMAP2_FORCE_AUTO_UPDATE is not set
+CONFIG_FB_OMAP2_NUM_FBS=3
+
+#
+# OMAP2/3 Display Device Drivers
+#
+CONFIG_PANEL_GENERIC=y
+# CONFIG_PANEL_SAMSUNG_LTE430WQ_F0C is not set
+CONFIG_PANEL_SHARP_LS037V7DW01=y
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 34de178..822df79 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -41,6 +41,7 @@
 #include <plat/usb.h>
 #include <plat/common.h>
 #include <plat/mcspi.h>
+#include <plat/display.h>
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -147,6 +148,187 @@ static inline void __init omap3evm_init_smsc911x(void)
 static inline void __init omap3evm_init_smsc911x(void) { return; }
 #endif
 
+/*
+ * OMAP3EVM LCD Panel control signals
+ */
+#define OMAP3EVM_LCD_PANEL_LR		2
+#define OMAP3EVM_LCD_PANEL_UD		3
+#define OMAP3EVM_LCD_PANEL_INI		152
+#define OMAP3EVM_LCD_PANEL_ENVDD	153
+#define OMAP3EVM_LCD_PANEL_QVGA		154
+#define OMAP3EVM_LCD_PANEL_RESB		155
+#define OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO	210
+#define OMAP3EVM_DVI_PANEL_EN_GPIO	199
+
+static int lcd_enabled;
+static int dvi_enabled;
+
+static void __init omap3_evm_display_init(void)
+{
+	int r;
+
+	r = gpio_request(OMAP3EVM_LCD_PANEL_RESB, "lcd_panel_resb");
+	if (r) {
+		printk(KERN_ERR "failed to get lcd_panel_resb\n");
+		return;
+	}
+	gpio_direction_output(OMAP3EVM_LCD_PANEL_RESB, 1);
+
+	r = gpio_request(OMAP3EVM_LCD_PANEL_INI, "lcd_panel_ini");
+	if (r) {
+		printk(KERN_ERR "failed to get lcd_panel_ini\n");
+		goto err_1;
+	}
+	gpio_direction_output(OMAP3EVM_LCD_PANEL_INI, 1);
+
+	r = gpio_request(OMAP3EVM_LCD_PANEL_QVGA, "lcd_panel_qvga");
+	if (r) {
+		printk(KERN_ERR "failed to get lcd_panel_qvga\n");
+		goto err_2;
+	}
+	gpio_direction_output(OMAP3EVM_LCD_PANEL_QVGA, 0);
+
+	r = gpio_request(OMAP3EVM_LCD_PANEL_LR, "lcd_panel_lr");
+	if (r) {
+		printk(KERN_ERR "failed to get lcd_panel_lr\n");
+		goto err_3;
+	}
+	gpio_direction_output(OMAP3EVM_LCD_PANEL_LR, 1);
+
+	r = gpio_request(OMAP3EVM_LCD_PANEL_UD, "lcd_panel_ud");
+	if (r) {
+		printk(KERN_ERR "failed to get lcd_panel_ud\n");
+		goto err_4;
+	}
+	gpio_direction_output(OMAP3EVM_LCD_PANEL_UD, 1);
+
+	r = gpio_request(OMAP3EVM_LCD_PANEL_ENVDD, "lcd_panel_envdd");
+	if (r) {
+		printk(KERN_ERR "failed to get lcd_panel_envdd\n");
+		goto err_5;
+	}
+	gpio_direction_output(OMAP3EVM_LCD_PANEL_ENVDD, 0);
+
+	return;
+
+err_5:
+	gpio_free(OMAP3EVM_LCD_PANEL_UD);
+err_4:
+	gpio_free(OMAP3EVM_LCD_PANEL_LR);
+err_3:
+	gpio_free(OMAP3EVM_LCD_PANEL_QVGA);
+err_2:
+	gpio_free(OMAP3EVM_LCD_PANEL_INI);
+err_1:
+	gpio_free(OMAP3EVM_LCD_PANEL_RESB);
+
+}
+
+static int omap3_evm_enable_lcd(struct omap_dss_device *dssdev)
+{
+	if (dvi_enabled) {
+		printk(KERN_ERR "cannot enable LCD, DVI is enabled\n");
+		return -EINVAL;
+	}
+	gpio_set_value(OMAP3EVM_LCD_PANEL_ENVDD, 0);
+
+	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
+		gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 0);
+	else
+		gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);
+
+	lcd_enabled = 1;
+	return 0;
+}
+
+static void omap3_evm_disable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(OMAP3EVM_LCD_PANEL_ENVDD, 1);
+
+	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
+		gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);
+	else
+		gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 0);
+
+	lcd_enabled = 0;
+}
+
+static struct omap_dss_device omap3_evm_lcd_device = {
+	.name			= "lcd",
+	.driver_name		= "sharp_ls_panel",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.phy.dpi.data_lines	= 18,
+	.platform_enable	= omap3_evm_enable_lcd,
+	.platform_disable	= omap3_evm_disable_lcd,
+};
+
+static int omap3_evm_enable_tv(struct omap_dss_device *dssdev)
+{
+	return 0;
+}
+
+static void omap3_evm_disable_tv(struct omap_dss_device *dssdev)
+{
+}
+
+static struct omap_dss_device omap3_evm_tv_device = {
+	.name			= "tv",
+	.driver_name		= "venc",
+	.type			= OMAP_DISPLAY_TYPE_VENC,
+	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
+	.platform_enable	= omap3_evm_enable_tv,
+	.platform_disable	= omap3_evm_disable_tv,
+};
+
+static int omap3_evm_enable_dvi(struct omap_dss_device *dssdev)
+{
+	if (lcd_enabled) {
+		printk(KERN_ERR "cannot enable DVI, LCD is enabled\n");
+		return -EINVAL;
+	}
+
+	gpio_set_value(OMAP3EVM_DVI_PANEL_EN_GPIO, 1);
+
+	dvi_enabled = 1;
+	return 0;
+}
+
+static void omap3_evm_disable_dvi(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(OMAP3EVM_DVI_PANEL_EN_GPIO, 0);
+
+	dvi_enabled = 0;
+}
+
+static struct omap_dss_device omap3_evm_dvi_device = {
+	.name			= "dvi",
+	.driver_name		= "generic_panel",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.phy.dpi.data_lines	= 24,
+	.platform_enable	= omap3_evm_enable_dvi,
+	.platform_disable	= omap3_evm_disable_dvi,
+};
+
+static struct omap_dss_device *omap3_evm_dss_devices[] = {
+	&omap3_evm_lcd_device,
+	&omap3_evm_tv_device,
+	&omap3_evm_dvi_device,
+};
+
+static struct omap_dss_board_info omap3_evm_dss_data = {
+	.num_devices	= ARRAY_SIZE(omap3_evm_dss_devices),
+	.devices	= omap3_evm_dss_devices,
+	.default_device	= &omap3_evm_lcd_device,
+};
+
+static struct platform_device omap3_evm_dss_device = {
+	.name		= "omapdss",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &omap3_evm_dss_data,
+	},
+};
+
 static struct regulator_consumer_supply omap3evm_vmmc1_supply = {
 	.supply			= "vmmc",
 };
@@ -236,6 +418,14 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 	 * the P2 connector; notably LEDA for the LCD backlight.
 	 */
 
+	/* TWL4030_GPIO_MAX + 0 == ledA, LCD Backlight control */
+	gpio_request(gpio + TWL4030_GPIO_MAX, "EN_LCD_BKL");
+	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+
+	/* gpio + 7 == DVI Enable */
+	gpio_request(gpio + 7, "EN_DVI");
+	gpio_direction_output(gpio + 7, 0);
+
 	/* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
@@ -300,6 +490,47 @@ static struct twl4030_codec_data omap3evm_codec_data = {
 	.audio = &omap3evm_audio_data,
 };
 
+static struct regulator_consumer_supply omap3_evm_vdda_dac_supply = {
+	.supply		= "vdda_dac",
+	.dev		= &omap3_evm_dss_device.dev,
+};
+
+/* VDAC for DSS driving S-Video */
+static struct regulator_init_data omap3_evm_vdac = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &omap3_evm_vdda_dac_supply,
+};
+
+/* VPLL2 for digital video outputs */
+static struct regulator_consumer_supply omap3_evm_vpll2_supply = {
+	.supply		= "vdvi",
+	.dev		= &omap3_evm_lcd_device.dev,
+};
+
+static struct regulator_init_data omap3_evm_vpll2 = {
+	.constraints = {
+		.name			= "VDVI",
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &omap3_evm_vpll2_supply,
+};
+
 static struct twl4030_platform_data omap3evm_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
@@ -310,6 +541,8 @@ static struct twl4030_platform_data omap3evm_twldata = {
 	.usb		= &omap3evm_usb_data,
 	.gpio		= &omap3evm_gpio_data,
 	.codec		= &omap3evm_codec_data,
+	.vdac		= &omap3_evm_vdac,
+	.vpll2		= &omap3_evm_vpll2,
 };
 
 static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
@@ -337,15 +570,6 @@ static int __init omap3_evm_i2c_init(void)
 	return 0;
 }
 
-static struct platform_device omap3_evm_lcd_device = {
-	.name		= "omap3evm_lcd",
-	.id		= -1,
-};
-
-static struct omap_lcd_config omap3_evm_lcd_config __initdata = {
-	.ctrl_name	= "internal",
-};
-
 static void ads7846_dev_init(void)
 {
 	if (gpio_request(OMAP3_EVM_TS_GPIO, "ADS7846 pendown") < 0)
@@ -393,7 +617,6 @@ struct spi_board_info omap3evm_spi_board_info[] = {
 };
 
 static struct omap_board_config_kernel omap3_evm_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&omap3_evm_lcd_config },
 };
 
 static void __init omap3_evm_init_irq(void)
@@ -406,7 +629,7 @@ static void __init omap3_evm_init_irq(void)
 }
 
 static struct platform_device *omap3_evm_devices[] __initdata = {
-	&omap3_evm_lcd_device,
+	&omap3_evm_dss_device,
 };
 
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
@@ -473,6 +696,7 @@ static void __init omap3_evm_init(void)
 	usb_ehci_init(&ehci_pdata);
 	ads7846_dev_init();
 	omap3evm_init_smsc911x();
+	omap3_evm_display_init();
 }
 
 static void __init omap3_evm_map_io(void)
-- 
1.6.2.4

