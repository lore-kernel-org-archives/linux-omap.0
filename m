From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 19/20] OMAP: Beagle: Enable DSS2 for Beagle board
Date: Fri,  7 Aug 2009 15:27:57 +0300
Message-ID: <1249648078-7780-20-git-send-email-tomi.valkeinen@nokia.com>
References: <1249648078-7780-1-git-send-email-tomi.valkeinen@nokia.com>
 <1249648078-7780-2-git-send-email-tomi.valkeinen@nokia.com>
 <1249648078-7780-3-git-send-email-tomi.valkeinen@nokia.com>
 <1249648078-7780-4-git-send-email-tomi.valkeinen@nokia.com>
 <1249648078-7780-5-git-send-email-tomi.valkeinen@nokia.com>
 <1249648078-7780-6-git-send-email-tomi.valkeinen@nokia.com>
 <1249648078-7780-7-git-send-email-tomi.valkeinen@nokia.com>
 <1249648078-7780-8-git-send-email-tomi.valkeinen@nokia.com>
 <1249648078-7780-9-git-send-email-tomi.valkeinen@nokia.com>
 <1249648078-7780-10-git-send-email-tomi.valkeinen@nokia.com>
 <1249648078-7780-11-git-send-email-tomi.valkeinen@nokia.com>
 <1249648078-7780-12-git-send-email-tomi.valkeinen@nokia.com>
 <1249648078-7780-13-git-send-email-tomi.valkeinen@nokia.com>
 <1249648078-7780-14-git-send-email-tomi.valkeinen@nokia.com>
 <1249648078-7780-15-git-send-email-tomi.valkeinen@nokia.com>
 <1249648078-7780-16-git-send-email-tomi.valkeinen@nokia.com>
 <1249648078-7780-17-git-send-email-tomi.valkeinen@nokia.com>
 <1249648078-7780-18-git-send-email-tomi.valkeinen@nokia.com>
 <1249648078-7780-19-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30242 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757800AbZHGM3R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 08:29:17 -0400
In-Reply-To: <1249648078-7780-19-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap3_beagle_defconfig |   26 ++++++-
 arch/arm/mach-omap2/board-omap3beagle.c |  119 ++++++++++++++++++++++++-------
 2 files changed, 116 insertions(+), 29 deletions(-)

diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
index c4726f0..1740be3 100644
--- a/arch/arm/configs/omap3_beagle_defconfig
+++ b/arch/arm/configs/omap3_beagle_defconfig
@@ -792,10 +792,30 @@ CONFIG_FB_CFB_IMAGEBLIT=y
 #
 # CONFIG_FB_S1D13XXX is not set
 # CONFIG_FB_VIRTUAL is not set
-CONFIG_FB_OMAP=y
-# CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
+# CONFIG_FB_METRONOME is not set
+# CONFIG_FB_MB862XX is not set
+# CONFIG_FB_BROADSHEET is not set
 # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
-CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
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
+# CONFIG_PANEL_SAMSUNG_LTE430WQ_F0C is not set
+# CONFIG_PANEL_SHARP_LS037V7DW01 is not set
+CONFIG_FB_OMAP2=y
+CONFIG_FB_OMAP2_DEBUG_SUPPORT=y
+# CONFIG_FB_OMAP2_FORCE_AUTO_UPDATE is not set
+CONFIG_FB_OMAP2_NUM_FBS=3
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index b6a68d5..c24dc76 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -30,6 +30,7 @@
 
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/omapfb.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -44,6 +45,7 @@
 #include <mach/mux.h>
 #include <mach/usb.h>
 #include <mach/timer-gp.h>
+#include <mach/display.h>
 
 #include "mmc-twl4030.h"
 
@@ -106,6 +108,92 @@ static struct platform_device omap3beagle_nand_device = {
 	.resource	= &omap3beagle_nand_resource,
 };
 
+/* DSS */
+
+static int beagle_enable_dvi(struct omap_dss_device *dssdev)
+{
+	if (dssdev->reset_gpio != -1)
+		gpio_set_value(dssdev->reset_gpio, 1);
+
+	return 0;
+}
+
+static void beagle_disable_dvi(struct omap_dss_device *dssdev)
+{
+	if (dssdev->reset_gpio != -1)
+		gpio_set_value(dssdev->reset_gpio, 0);
+}
+
+static struct omap_dss_device beagle_dvi_device = {
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.name			= "dvi",
+	.driver_name		= "generic_panel",
+	.phy.dpi.data_lines	= 24,
+	.reset_gpio		= 170,
+	.platform_enable	= beagle_enable_dvi,
+	.platform_disable	= beagle_disable_dvi,
+};
+
+static int beagle_panel_enable_tv(struct omap_dss_device *dssdev)
+{
+	return 0;
+}
+
+static void beagle_panel_disable_tv(struct omap_dss_device *dssdev)
+{
+}
+
+static struct omap_dss_device beagle_tv_device = {
+	.name			= "tv",
+	.driver_name		= "venc",
+	.type			= OMAP_DISPLAY_TYPE_VENC,
+	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
+	.platform_enable	= beagle_panel_enable_tv,
+	.platform_disable	= beagle_panel_disable_tv,
+};
+
+static struct omap_dss_device *beagle_dss_devices[] = {
+	&beagle_dvi_device,
+	&beagle_tv_device,
+};
+
+static struct omap_dss_board_info beagle_dss_data = {
+	.num_devices	= ARRAY_SIZE(beagle_dss_devices),
+	.devices	= beagle_dss_devices,
+	.default_device	= &beagle_dvi_device,
+};
+
+static struct platform_device beagle_dss_device = {
+	.name          = "omapdss",
+	.id            = -1,
+	.dev            = {
+		.platform_data = &beagle_dss_data,
+	},
+};
+
+static struct regulator_consumer_supply beagle_vdda_dac_supply = {
+	.supply		= "vdda_dac",
+	.dev		= &beagle_dss_device.dev,
+};
+
+static struct regulator_consumer_supply beagle_vdds_dsi_supply = {
+	.supply		= "vdds_dsi",
+	.dev		= &beagle_dss_device.dev,
+};
+
+static void __init beagle_display_init(void)
+{
+	int r;
+
+	r = gpio_request(beagle_dvi_device.reset_gpio, "DVI reset");
+	if (r < 0) {
+		printk(KERN_ERR "Unable to get DVI reset GPIO\n");
+		return;
+	}
+
+	gpio_direction_output(beagle_dvi_device.reset_gpio, 0);
+}
+
 #include "sdram-micron-mt46h32m32lf-6.h"
 
 static struct omap_uart_config omap3_beagle_uart_config __initdata = {
@@ -121,15 +209,6 @@ static struct twl4030_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct platform_device omap3_beagle_lcd_device = {
-	.name		= "omap3beagle_lcd",
-	.id		= -1,
-};
-
-static struct omap_lcd_config omap3_beagle_lcd_config __initdata = {
-	.ctrl_name	= "internal",
-};
-
 static struct regulator_consumer_supply beagle_vmmc1_supply = {
 	.supply			= "vmmc",
 };
@@ -180,16 +259,6 @@ static struct twl4030_gpio_platform_data beagle_gpio_data = {
 	.setup		= beagle_twl_gpio_setup,
 };
 
-static struct regulator_consumer_supply beagle_vdac_supply = {
-	.supply		= "vdac",
-	.dev		= &omap3_beagle_lcd_device.dev,
-};
-
-static struct regulator_consumer_supply beagle_vdvi_supply = {
-	.supply		= "vdvi",
-	.dev		= &omap3_beagle_lcd_device.dev,
-};
-
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
 static struct regulator_init_data beagle_vmmc1 = {
 	.constraints = {
@@ -225,13 +294,14 @@ static struct regulator_init_data beagle_vdac = {
 	.constraints = {
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
+		.apply_uV		= true,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &beagle_vdac_supply,
+	.consumer_supplies	= &beagle_vdda_dac_supply,
 };
 
 /* VPLL2 for digital video outputs */
@@ -246,7 +316,7 @@ static struct regulator_init_data beagle_vpll2 = {
 					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &beagle_vdvi_supply,
+	.consumer_supplies	= &beagle_vdds_dsi_supply,
 };
 
 static struct twl4030_platform_data beagle_twldata = {
@@ -345,11 +415,10 @@ static struct platform_device keys_gpio = {
 
 static struct omap_board_config_kernel omap3_beagle_config[] __initdata = {
 	{ OMAP_TAG_UART,	&omap3_beagle_uart_config },
-	{ OMAP_TAG_LCD,		&omap3_beagle_lcd_config },
 };
 
 static struct platform_device *omap3_beagle_devices[] __initdata = {
-	&omap3_beagle_lcd_device,
+	&beagle_dss_device,
 	&leds_gpio,
 	&keys_gpio,
 };
@@ -402,13 +471,11 @@ static void __init omap3_beagle_init(void)
 	omap_serial_init();
 
 	omap_cfg_reg(J25_34XX_GPIO170);
-	gpio_request(170, "DVI_nPD");
-	/* REVISIT leave DVI powered down until it's needed ... */
-	gpio_direction_output(170, true);
 
 	usb_musb_init();
 	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
 	omap3beagle_flash_init();
+	beagle_display_init();
 }
 
 static void __init omap3_beagle_map_io(void)
-- 
1.6.4

