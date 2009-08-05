From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 15/15] OMAP: Overo: Enable DSS2 for Overo
Date: Wed,  5 Aug 2009 17:15:41 +0300
Message-ID: <1249481741-14008-16-git-send-email-tomi.valkeinen@nokia.com>
References: <1249481741-14008-1-git-send-email-tomi.valkeinen@nokia.com>
 <1249481741-14008-2-git-send-email-tomi.valkeinen@nokia.com>
 <1249481741-14008-3-git-send-email-tomi.valkeinen@nokia.com>
 <1249481741-14008-4-git-send-email-tomi.valkeinen@nokia.com>
 <1249481741-14008-5-git-send-email-tomi.valkeinen@nokia.com>
 <1249481741-14008-6-git-send-email-tomi.valkeinen@nokia.com>
 <1249481741-14008-7-git-send-email-tomi.valkeinen@nokia.com>
 <1249481741-14008-8-git-send-email-tomi.valkeinen@nokia.com>
 <1249481741-14008-9-git-send-email-tomi.valkeinen@nokia.com>
 <1249481741-14008-10-git-send-email-tomi.valkeinen@nokia.com>
 <1249481741-14008-11-git-send-email-tomi.valkeinen@nokia.com>
 <1249481741-14008-12-git-send-email-tomi.valkeinen@nokia.com>
 <1249481741-14008-13-git-send-email-tomi.valkeinen@nokia.com>
 <1249481741-14008-14-git-send-email-tomi.valkeinen@nokia.com>
 <1249481741-14008-15-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:36852 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934526AbZHEORC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 10:17:02 -0400
In-Reply-To: <1249481741-14008-15-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/configs/overo_defconfig  |  265 ++++++++-----------------------------
 arch/arm/mach-omap2/board-overo.c |  149 +++++++++++++++++++--
 2 files changed, 196 insertions(+), 218 deletions(-)

diff --git a/arch/arm/configs/overo_defconfig b/arch/arm/configs/overo_defconfig
index a57f9e4..93d911c 100644
--- a/arch/arm/configs/overo_defconfig
+++ b/arch/arm/configs/overo_defconfig
@@ -994,225 +994,76 @@ CONFIG_SSB_POSSIBLE=y
 #
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_SM501 is not set
+# CONFIG_MFD_ASIC3 is not set
 # CONFIG_HTC_EGPIO is not set
 # CONFIG_HTC_PASIC3 is not set
-# CONFIG_UCB1400_CORE is not set
+# CONFIG_TPS65010 is not set
+# CONFIG_TWL4030_CORE is not set
 # CONFIG_MFD_TMIO is not set
 # CONFIG_MFD_T7L66XB is not set
 # CONFIG_MFD_TC6387XB is not set
 # CONFIG_MFD_TC6393XB is not set
-
-#
-# Multimedia devices
-#
-
-#
-# Multimedia core support
-#
-CONFIG_VIDEO_DEV=m
-CONFIG_VIDEO_V4L2_COMMON=m
-CONFIG_VIDEO_ALLOW_V4L1=y
-CONFIG_VIDEO_V4L1_COMPAT=y
-CONFIG_DVB_CORE=m
-CONFIG_VIDEO_MEDIA=m
-
-#
-# Multimedia drivers
-#
-CONFIG_MEDIA_ATTACH=y
-CONFIG_MEDIA_TUNER=m
-# CONFIG_MEDIA_TUNER_CUSTOMIZE is not set
-CONFIG_MEDIA_TUNER_SIMPLE=m
-CONFIG_MEDIA_TUNER_TDA8290=m
-CONFIG_MEDIA_TUNER_TDA827X=m
-CONFIG_MEDIA_TUNER_TDA18271=m
-CONFIG_MEDIA_TUNER_TDA9887=m
-CONFIG_MEDIA_TUNER_TEA5761=m
-CONFIG_MEDIA_TUNER_TEA5767=m
-CONFIG_MEDIA_TUNER_MT20XX=m
-CONFIG_MEDIA_TUNER_MT2060=m
-CONFIG_MEDIA_TUNER_MT2266=m
-CONFIG_MEDIA_TUNER_QT1010=m
-CONFIG_MEDIA_TUNER_XC2028=m
-CONFIG_MEDIA_TUNER_XC5000=m
-CONFIG_MEDIA_TUNER_MXL5005S=m
-CONFIG_VIDEO_V4L2=m
-CONFIG_VIDEO_V4L1=m
-CONFIG_VIDEO_TVEEPROM=m
-CONFIG_VIDEO_TUNER=m
-CONFIG_VIDEO_CAPTURE_DRIVERS=y
-# CONFIG_VIDEO_ADV_DEBUG is not set
-CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
-CONFIG_VIDEO_MSP3400=m
-CONFIG_VIDEO_CS53L32A=m
-CONFIG_VIDEO_WM8775=m
-CONFIG_VIDEO_SAA711X=m
-CONFIG_VIDEO_CX25840=m
-CONFIG_VIDEO_CX2341X=m
-# CONFIG_VIDEO_VIVI is not set
-# CONFIG_VIDEO_CPIA is not set
-# CONFIG_VIDEO_CPIA2 is not set
-# CONFIG_VIDEO_SAA5246A is not set
-# CONFIG_VIDEO_SAA5249 is not set
-# CONFIG_TUNER_3036 is not set
-# CONFIG_VIDEO_AU0828 is not set
-CONFIG_V4L_USB_DRIVERS=y
-CONFIG_USB_VIDEO_CLASS=m
-CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
-# CONFIG_USB_GSPCA is not set
-CONFIG_VIDEO_PVRUSB2=m
-CONFIG_VIDEO_PVRUSB2_SYSFS=y
-CONFIG_VIDEO_PVRUSB2_DVB=y
-# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
-# CONFIG_VIDEO_EM28XX is not set
-CONFIG_VIDEO_USBVISION=m
-CONFIG_VIDEO_USBVIDEO=m
-CONFIG_USB_VICAM=m
-CONFIG_USB_IBMCAM=m
-CONFIG_USB_KONICAWC=m
-CONFIG_USB_QUICKCAM_MESSENGER=m
-# CONFIG_USB_ET61X251 is not set
-CONFIG_VIDEO_OVCAMCHIP=m
-CONFIG_USB_W9968CF=m
-CONFIG_USB_OV511=m
-CONFIG_USB_SE401=m
-CONFIG_USB_SN9C102=m
-CONFIG_USB_STV680=m
-# CONFIG_USB_ZC0301 is not set
-CONFIG_USB_PWC=m
-# CONFIG_USB_PWC_DEBUG is not set
-CONFIG_USB_ZR364XX=m
-# CONFIG_USB_STKWEBCAM is not set
-# CONFIG_USB_S2255 is not set
-# CONFIG_SOC_CAMERA is not set
-# CONFIG_VIDEO_SH_MOBILE_CEU is not set
-CONFIG_RADIO_ADAPTERS=y
-# CONFIG_USB_DSBR is not set
-# CONFIG_USB_SI470X is not set
-CONFIG_DVB_CAPTURE_DRIVERS=y
-# CONFIG_TTPCI_EEPROM is not set
-
-#
-# Supported USB Adapters
-#
-CONFIG_DVB_USB=m
-# CONFIG_DVB_USB_DEBUG is not set
-CONFIG_DVB_USB_A800=m
-CONFIG_DVB_USB_DIBUSB_MB=m
-# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
-CONFIG_DVB_USB_DIBUSB_MC=m
-CONFIG_DVB_USB_DIB0700=m
-CONFIG_DVB_USB_UMT_010=m
-CONFIG_DVB_USB_CXUSB=m
-CONFIG_DVB_USB_M920X=m
-CONFIG_DVB_USB_GL861=m
-CONFIG_DVB_USB_AU6610=m
-CONFIG_DVB_USB_DIGITV=m
-CONFIG_DVB_USB_VP7045=m
-CONFIG_DVB_USB_VP702X=m
-CONFIG_DVB_USB_GP8PSK=m
-CONFIG_DVB_USB_NOVA_T_USB2=m
-CONFIG_DVB_USB_TTUSB2=m
-CONFIG_DVB_USB_DTT200U=m
-CONFIG_DVB_USB_OPERA1=m
-CONFIG_DVB_USB_AF9005=m
-CONFIG_DVB_USB_AF9005_REMOTE=m
-# CONFIG_DVB_USB_DW2102 is not set
-# CONFIG_DVB_USB_ANYSEE is not set
-CONFIG_DVB_TTUSB_BUDGET=m
-CONFIG_DVB_TTUSB_DEC=m
-CONFIG_DVB_CINERGYT2=m
-# CONFIG_DVB_CINERGYT2_TUNING is not set
-# CONFIG_DVB_SIANO_SMS1XXX is not set
-
-#
-# Supported FlexCopII (B2C2) Adapters
-#
-# CONFIG_DVB_B2C2_FLEXCOP is not set
-
-#
-# Supported DVB Frontends
-#
-
-#
-# Customise DVB Frontends
-#
-# CONFIG_DVB_FE_CUSTOMISE is not set
-
-#
-# DVB-S (satellite) frontends
-#
-CONFIG_DVB_CX24110=m
-CONFIG_DVB_CX24123=m
-CONFIG_DVB_MT312=m
-CONFIG_DVB_S5H1420=m
-CONFIG_DVB_STV0299=m
-CONFIG_DVB_TDA8083=m
-CONFIG_DVB_TDA10086=m
-CONFIG_DVB_VES1X93=m
-CONFIG_DVB_TUNER_ITD1000=m
-CONFIG_DVB_TDA826X=m
-CONFIG_DVB_TUA6100=m
-
-#
-# DVB-T (terrestrial) frontends
-#
-CONFIG_DVB_SP8870=m
-CONFIG_DVB_SP887X=m
-CONFIG_DVB_CX22700=m
-CONFIG_DVB_CX22702=m
-# CONFIG_DVB_DRX397XD is not set
-CONFIG_DVB_L64781=m
-CONFIG_DVB_TDA1004X=m
-CONFIG_DVB_NXT6000=m
-CONFIG_DVB_MT352=m
-CONFIG_DVB_ZL10353=m
-CONFIG_DVB_DIB3000MB=m
-CONFIG_DVB_DIB3000MC=m
-CONFIG_DVB_DIB7000M=m
-CONFIG_DVB_DIB7000P=m
-CONFIG_DVB_TDA10048=m
-
-#
-# DVB-C (cable) frontends
-#
-CONFIG_DVB_VES1820=m
-CONFIG_DVB_TDA10021=m
-CONFIG_DVB_TDA10023=m
-CONFIG_DVB_STV0297=m
-
-#
-# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
-#
-CONFIG_DVB_NXT200X=m
-# CONFIG_DVB_OR51211 is not set
-# CONFIG_DVB_OR51132 is not set
-CONFIG_DVB_BCM3510=m
-CONFIG_DVB_LGDT330X=m
-CONFIG_DVB_S5H1409=m
-CONFIG_DVB_AU8522=m
-CONFIG_DVB_S5H1411=m
-
-#
-# Digital terrestrial only tuners/PLL
-#
-CONFIG_DVB_PLL=m
-CONFIG_DVB_TUNER_DIB0070=m
-
-#
-# SEC control devices for DVB-S
-#
-CONFIG_DVB_LNBP21=m
-# CONFIG_DVB_ISL6405 is not set
-CONFIG_DVB_ISL6421=m
-# CONFIG_DAB is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_PCF50633 is not set
+# CONFIG_AB3100_CORE is not set
+# CONFIG_EZX_PCAP is not set
+# CONFIG_MEDIA_SUPPORT is not set
 
 #
 # Graphics support
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
+CONFIG_OMAP2_DSS=y
+CONFIG_OMAP2_VRAM_SIZE=6
+CONFIG_OMAP2_DSS_DEBUG_SUPPORT=y
+# CONFIG_OMAP2_DSS_RFBI is not set
+CONFIG_OMAP2_DSS_VENC=y
+# CONFIG_OMAP2_DSS_SDI is not set
+# CONFIG_OMAP2_DSS_DSI is not set
+# CONFIG_OMAP2_DSS_FAKE_VSYNC is not set
+CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=0
+
+#
+# OMAP2/3 Display Device Drivers
+#
+CONFIG_PANEL_GENERIC=y
+CONFIG_PANEL_SAMSUNG_LTE430WQ_F0C=y
+# CONFIG_PANEL_SHARP_LS037V7DW01 is not set
+CONFIG_FB_OMAP2=y
+CONFIG_FB_OMAP2_DEBUG_SUPPORT=y
+# CONFIG_FB_OMAP2_FORCE_AUTO_UPDATE is not set
+CONFIG_FB_OMAP2_NUM_FBS=3
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 501d020..25cbe42 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -40,6 +40,7 @@
 
 #include <mach/board.h>
 #include <mach/common.h>
+#include <mach/display.h>
 #include <mach/gpio.h>
 #include <mach/gpmc.h>
 #include <mach/hardware.h>
@@ -182,6 +183,110 @@ static inline void __init overo_init_smsc911x(void)
 static inline void __init overo_init_smsc911x(void) { return; }
 #endif
 
+/* DSS */
+static int lcd_enabled;
+static int dvi_enabled;
+
+#define OVERO_GPIO_LCD_EN 144
+
+static void __init overo_display_init(void)
+{
+	int r;
+
+	r = gpio_request(OVERO_GPIO_LCD_EN, "display enable");
+	if (r)
+		pr_err("Failed to get LCD_EN gpio\n");
+	r = gpio_direction_output(OVERO_GPIO_LCD_EN, 1);
+	if (r)
+		pr_err("Failed to set LCD_EN gpio direction\n");
+	gpio_export(OVERO_GPIO_LCD_EN, 0);
+}
+
+static int overo_panel_enable_dvi(struct omap_dss_device *dssdev)
+{
+	if (lcd_enabled) {
+		printk(KERN_ERR "cannot enable DVI, LCD is enabled\n");
+		return -EINVAL;
+	}
+	dvi_enabled = 1;
+
+	gpio_set_value(OVERO_GPIO_LCD_EN, 1);
+
+	return 0;
+}
+
+static void overo_panel_disable_dvi(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(OVERO_GPIO_LCD_EN, 0);
+
+	dvi_enabled = 0;
+}
+
+static struct omap_dss_device overo_dvi_device = {
+	.type = OMAP_DISPLAY_TYPE_DPI,
+	.name = "dvi",
+	.driver_name = "generic_panel",
+	.phy.dpi.data_lines = 24,
+	.platform_enable = overo_panel_enable_dvi,
+	.platform_disable = overo_panel_disable_dvi,
+};
+
+static int overo_panel_enable_lcd(struct omap_dss_device *dssdev)
+{
+	if (dvi_enabled) {
+		printk(KERN_ERR "cannot enable LCD, DVI is enabled\n");
+		return -EINVAL;
+	}
+
+	gpio_set_value(OVERO_GPIO_LCD_EN, 1);
+	lcd_enabled = 1;
+	return 0;
+}
+
+static void overo_panel_disable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(OVERO_GPIO_LCD_EN, 0);
+	lcd_enabled = 0;
+}
+
+static struct omap_dss_device overo_lcd_device = {
+	.type = OMAP_DISPLAY_TYPE_DPI,
+	.name = "lcd",
+	.driver_name = "samsung_lte_panel",
+	.phy.dpi.data_lines = 24,
+	.platform_enable = overo_panel_enable_lcd,
+	.platform_disable = overo_panel_disable_lcd,
+};
+
+static struct omap_dss_device *overo_dss_devices[] = {
+	&overo_dvi_device,
+	&overo_lcd_device,
+};
+
+static struct omap_dss_board_info overo_dss_data = {
+	.num_devices = ARRAY_SIZE(overo_dss_devices),
+	.devices = overo_dss_devices,
+	.default_device = &overo_dvi_device,
+};
+
+static struct platform_device overo_dss_device = {
+	.name          = "omapdss",
+	.id            = -1,
+	.dev            = {
+		.platform_data = &overo_dss_data,
+	},
+};
+
+static struct regulator_consumer_supply overo_vdda_dac_supply = {
+	.supply		= "vdda_dac",
+	.dev		= &overo_dss_device.dev,
+};
+
+static struct regulator_consumer_supply overo_vdds_dsi_supply = {
+	.supply		= "vdds_dsi",
+	.dev		= &overo_dss_device.dev,
+};
+
 static struct mtd_partition overo_nand_partitions[] = {
 	{
 		.name           = "xloader",
@@ -231,7 +336,6 @@ static struct platform_device overo_nand_device = {
 	.resource	= &overo_nand_resource,
 };
 
-
 static void __init overo_flash_init(void)
 {
 	u8 cs = 0;
@@ -330,6 +434,35 @@ static struct regulator_init_data overo_vmmc1 = {
 	.consumer_supplies	= &overo_vmmc1_supply,
 };
 
+/* VDAC for DSS driving S-Video (8 mA unloaded, max 65 mA) */
+static struct regulator_init_data overo_vdac = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &overo_vdda_dac_supply,
+};
+
+/* VPLL2 for digital video outputs */
+static struct regulator_init_data overo_vpll2 = {
+	.constraints = {
+		.name			= "VDVI",
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &overo_vdds_dsi_supply,
+};
+
 /* mmc2 (WLAN) and Bluetooth don't use twl4030 regulators */
 
 static struct twl4030_platform_data overo_twldata = {
@@ -338,6 +471,8 @@ static struct twl4030_platform_data overo_twldata = {
 	.gpio		= &overo_gpio_data,
 	.usb		= &overo_usb_data,
 	.vmmc1		= &overo_vmmc1,
+	.vdac		= &overo_vdac,
+	.vpll2		= &overo_vpll2,
 };
 
 static struct i2c_board_info __initdata overo_i2c_boardinfo[] = {
@@ -365,22 +500,13 @@ static void __init overo_init_irq(void)
 	omap_gpio_init();
 }
 
-static struct platform_device overo_lcd_device = {
-	.name		= "overo_lcd",
-	.id		= -1,
-};
-
-static struct omap_lcd_config overo_lcd_config __initdata = {
-	.ctrl_name	= "internal",
-};
 
 static struct omap_board_config_kernel overo_config[] __initdata = {
 	{ OMAP_TAG_UART,	&overo_uart_config },
-	{ OMAP_TAG_LCD,		&overo_lcd_config },
 };
 
 static struct platform_device *overo_devices[] __initdata = {
-	&overo_lcd_device,
+	&overo_dss_device,
 };
 
 static void __init overo_init(void)
@@ -395,6 +521,7 @@ static void __init overo_init(void)
 	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, false, true, 183, -EINVAL);
 	overo_ads7846_init();
 	overo_init_smsc911x();
+	overo_display_init();
 
 	if ((gpio_request(OVERO_GPIO_W2W_NRESET,
 			  "OVERO_GPIO_W2W_NRESET") == 0) &&
-- 
1.6.4

