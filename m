From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCHv2] OMAP: pandora: add DSS2 support and related regulators
Date: Wed, 13 Jan 2010 23:19:07 +0200
Message-ID: <1263417547-24575-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:58412 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932087Ab0AMVTN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 16:19:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Grazvydas Ignotas <notasas@gmail.com>

This patch adds configuration data for DSS2 and sets up
display related regulators.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |  109 ++++++++++++++++++++++++++++++
 1 files changed, 109 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index ef17cf1..bd3e577 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -40,6 +40,7 @@
 #include <mach/hardware.h>
 #include <plat/mcspi.h>
 #include <plat/usb.h>
+#include <plat/display.h>
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -192,6 +193,61 @@ static struct twl4030_keypad_data pandora_kp_data = {
 	.rep		= 1,
 };
 
+static struct omap_dss_device pandora_lcd_device = {
+	.name			= "lcd",
+	.driver_name		= "tpo_td043mtea1_panel",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.phy.dpi.data_lines	= 24,
+	.reset_gpio		= 157,
+};
+
+static struct omap_dss_device pandora_tv_device = {
+	.name			= "tv",
+	.driver_name		= "venc",
+	.type			= OMAP_DISPLAY_TYPE_VENC,
+	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
+};
+
+static struct omap_dss_device *pandora_dss_devices[] = {
+	&pandora_lcd_device,
+	&pandora_tv_device,
+};
+
+static struct omap_dss_board_info pandora_dss_data = {
+	.num_devices	= ARRAY_SIZE(pandora_dss_devices),
+	.devices	= pandora_dss_devices,
+	.default_device	= &pandora_lcd_device,
+};
+
+static struct platform_device pandora_dss_device = {
+	.name		= "omapdss",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &pandora_dss_data,
+	},
+};
+
+static struct regulator_consumer_supply pandora_vcc_lcd_supply = {
+	.supply		= "vcc",
+	.dev		= &pandora_lcd_device.dev,
+};
+
+static struct regulator_consumer_supply pandora_vdda_dac_supply = {
+	.supply		= "vdda_dac",
+	.dev		= &pandora_dss_device.dev,
+};
+
+static struct regulator_consumer_supply pandora_vdds_supplies[] = {
+	{
+		.supply		= "vdds_sdi",
+		.dev		= &pandora_dss_device.dev,
+	},
+	{
+		.supply		= "vdds_dsi",
+		.dev		= &pandora_dss_device.dev,
+	},
+};
+
 static struct twl4030_hsmmc_info omap3pandora_mmc[] = {
 	{
 		.mmc		= 1,
@@ -277,6 +333,49 @@ static struct regulator_init_data pandora_vmmc2 = {
 	.consumer_supplies	= &pandora_vmmc2_supply,
 };
 
+/* VDAC for DSS driving S-Video */
+static struct regulator_init_data pandora_vdac = {
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
+	.consumer_supplies	= &pandora_vdda_dac_supply,
+};
+
+/* VPLL2 for digital video outputs */
+static struct regulator_init_data pandora_vpll2 = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(pandora_vdds_supplies),
+	.consumer_supplies	= pandora_vdds_supplies,
+};
+
+/* VAUX1 for LCD */
+static struct regulator_init_data pandora_vaux1 = {
+	.constraints = {
+		.min_uV			= 3000000,
+		.max_uV			= 3000000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
+		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &pandora_vcc_lcd_supply,
+};
+
 static struct twl4030_usb_data omap3pandora_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
@@ -298,6 +397,9 @@ static struct twl4030_platform_data omap3pandora_twldata = {
 	.codec		= &omap3pandora_codec_data,
 	.vmmc1		= &pandora_vmmc1,
 	.vmmc2		= &pandora_vmmc2,
+	.vdac		= &pandora_vdac,
+	.vpll2		= &pandora_vpll2,
+	.vaux1		= &pandora_vaux1,
 	.keypad		= &pandora_kp_data,
 };
 
@@ -365,6 +467,12 @@ static struct spi_board_info omap3pandora_spi_board_info[] __initdata = {
 		.controller_data	= &ads7846_mcspi_config,
 		.irq			= OMAP_GPIO_IRQ(OMAP3_PANDORA_TS_GPIO),
 		.platform_data		= &ads7846_config,
+	}, {
+		.modalias		= "tpo_td043mtea1_panel_spi",
+		.bus_num		= 1,
+		.chip_select		= 1,
+		.max_speed_hz		= 375000,
+		.platform_data		= &pandora_lcd_device,
 	}
 };
 
@@ -379,6 +487,7 @@ static void __init omap3pandora_init_irq(void)
 static struct platform_device *omap3pandora_devices[] __initdata = {
 	&pandora_leds_gpio,
 	&pandora_keys_gpio,
+	&pandora_dss_device,
 };
 
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
-- 
1.6.3.3

