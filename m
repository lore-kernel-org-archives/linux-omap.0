From: Archit Taneja <archit@ti.com>
Subject: [PATCH] OMAP4: DSS2: Add Panel Taal device struct in 4430sdp board file
Date: Tue, 29 Mar 2011 14:56:38 +0530
Message-ID: <1301390798-22951-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37216 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab1C2JXN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Mar 2011 05:23:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com, Archit Taneja <archit@ti.com>

Panel Taal is a DSI panel connected to the DSI1 lanes on 4430sdp and Blaze.
Add omap_dss_device struct for Panel Taal in the 4430sdp board file. This
represents the primary lcd device on 4430sdp board and Blaze board. The
following things are done:
-Add regulator consumers (vdds_dsi) for the VCXIO supply. VCXIO on blaze and
4430sdp is a regulator supply for dsi, csi2, usb otg, and the DPLLs of mpu, iva
and audio core. Since VCXIO has no consumers declared and the mpu's DPLL is also
powered by it, set the always_on flag for the regulator so that VCXIO is never
shut off accidentally.
-Remove dummy lcd platform_device.
-Add dsi_set_backlight() routine, original routine was written by Vikram Pandita.
-Mux settings for DSI1 lanes, GPIO initialisations for Taal reset and Backlight.

Signed-off-by: Archit Taneja <archit@ti.com>
---
Note:
Can be tested with the tree:
http://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone

 arch/arm/mach-omap2/board-4430sdp.c |  132 +++++++++++++++++++++++++++++++---
 1 files changed, 120 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index f5fcc5f..045c0be 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -37,6 +37,7 @@
 #include <plat/mmc.h>
 #include <plat/omap4-keypad.h>
 #include <plat/display.h>
+#include <plat/nokia-dsi-panel.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -50,6 +51,11 @@
 #define OMAP4_SFH7741_ENABLE_GPIO		188
 #define HDMI_GPIO_HPD 60 /* Hot plug pin for HDMI */
 #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
+#define LCD_BL_GPIO		27	/* LCD Backlight GPIO */
+/* PWM2 and TOGGLE3 register offsets */
+#define LED_PWM2ON		0x03
+#define LED_PWM2OFF		0x04
+#define TWL6030_TOGGLE3		0x92
 
 static const int sdp4430_keymap[] = {
 	KEY(0, 0, KEY_E),
@@ -306,24 +312,13 @@ error1:
 	return status;
 }
 
-static struct platform_device sdp4430_lcd_device = {
-	.name		= "sdp4430_lcd",
-	.id		= -1,
-};
-
 static struct platform_device *sdp4430_devices[] __initdata = {
-	&sdp4430_lcd_device,
 	&sdp4430_gpio_keys_device,
 	&sdp4430_leds_gpio,
 	&sdp4430_leds_pwm,
 };
 
-static struct omap_lcd_config sdp4430_lcd_config __initdata = {
-	.ctrl_name	= "internal",
-};
-
 static struct omap_board_config_kernel sdp4430_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&sdp4430_lcd_config },
 };
 
 static void __init omap_4430sdp_init_early(void)
@@ -377,6 +372,10 @@ static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
 		.dev_name = "omap_hsmmc.0",
 	},
 };
+static struct regulator_consumer_supply sdp4430_vcxio_supply[] = {
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dss"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+};
 
 static int omap4_twl6030_hsmmc_late_init(struct device *dev)
 {
@@ -523,7 +522,10 @@ static struct regulator_init_data sdp4430_vcxio = {
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask	 = REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
+		.always_on	= true,
 	},
+	.num_consumer_supplies	= ARRAY_SIZE(sdp4430_vcxio_supply),
+	.consumer_supplies	= sdp4430_vcxio_supply,
 };
 
 static struct regulator_init_data sdp4430_vdac = {
@@ -623,6 +625,73 @@ static void __init omap_sfh7741prox_init(void)
 	}
 }
 
+static int dsi1_panel_set_backlight(struct omap_dss_device *dssdev, int level)
+{
+	int r;
+
+	r = twl_i2c_write_u8(TWL_MODULE_PWM, 0x7F, LED_PWM2OFF);
+	if (r)
+		return r;
+
+	if (level > 1) {
+		if (level == 255)
+			level = 0x7F;
+		else
+			level = (~(level/2)) & 0x7F;
+
+		r = twl_i2c_write_u8(TWL_MODULE_PWM, level, LED_PWM2ON);
+		if (r)
+			return r;
+		r = twl_i2c_write_u8(TWL6030_MODULE_ID1, 0x30, TWL6030_TOGGLE3);
+		if (r)
+			return r;
+	} else if (level <= 1) {
+		r = twl_i2c_write_u8(TWL6030_MODULE_ID1, 0x08, TWL6030_TOGGLE3);
+		if (r)
+			return r;
+		r = twl_i2c_write_u8(TWL6030_MODULE_ID1, 0x28, TWL6030_TOGGLE3);
+		if (r)
+			return r;
+		r = twl_i2c_write_u8(TWL6030_MODULE_ID1, 0x00, TWL6030_TOGGLE3);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+static struct nokia_dsi_panel_data dsi1_panel;
+
+static void sdp4430_lcd_init(void)
+{
+	u32 reg;
+	int status;
+
+	/* Enable DSI1 Lanes */
+	reg = omap4_ctrl_pad_readl(OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_DSIPHY);
+	reg |= OMAP4_DSI1_PIPD_MASK | OMAP4_DSI1_LANEENABLE_MASK;
+	omap4_ctrl_pad_writel(reg, OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_DSIPHY);
+
+	/* Panel Taal reset and backlight GPIO init */
+	status = gpio_request_one(dsi1_panel.reset_gpio, GPIOF_DIR_OUT,
+		"lcd_reset_gpio");
+	if (status)
+		pr_err("%s: Could not get lcd_reset_gpio\n", __func__);
+
+	if (dsi1_panel.use_ext_te) {
+		status = omap_mux_init_signal("gpmc_ncs4.gpio_101",
+				OMAP_PIN_INPUT_PULLUP);
+		if (status)
+			pr_err("%s: Could not get ext_te gpio\n", __func__);
+	}
+
+	status = gpio_request_one(LCD_BL_GPIO, GPIOF_DIR_OUT, "lcd_bl_gpio");
+	if (status)
+		pr_err("%s: Could not get lcd_bl_gpio\n", __func__);
+
+	gpio_set_value(LCD_BL_GPIO, 0);
+}
+
 static void sdp4430_hdmi_mux_init(void)
 {
 	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
@@ -668,6 +737,43 @@ static void sdp4430_panel_disable_hdmi(struct omap_dss_device *dssdev)
 	gpio_free(HDMI_GPIO_HPD);
 }
 
+static struct nokia_dsi_panel_data dsi1_panel = {
+		.name		= "taal",
+		.reset_gpio	= 102,
+		.use_ext_te	= false,
+		.ext_te_gpio	= 101,
+		.use_esd_check	= false,
+		.set_backlight	= dsi1_panel_set_backlight,
+};
+
+static struct omap_dss_device sdp4430_lcd_device = {
+	.name			= "lcd",
+	.driver_name		= "taal",
+	.type			= OMAP_DISPLAY_TYPE_DSI,
+	.data			= &dsi1_panel,
+	.phy.dsi		= {
+		.clk_lane	= 1,
+		.clk_pol	= 0,
+		.data1_lane	= 2,
+		.data1_pol	= 0,
+		.data2_lane	= 3,
+		.data2_pol	= 0,
+		.div		= {
+			.regn		= 16,	/* Fint = 2.4 MHz */
+			.regm		= 180,	/* DDR Clock = 216 MHz */
+			.regm_dispc	= 5,	/* PLL1_CLK1 = 172.8 MHz */
+			.regm_dsi	= 5,	/* PLL1_CLK2 = 172.8 MHz */
+
+			.lp_clk_div	= 10,	/* LP Clock = 8.64 MHz */
+
+			.lck_div	= 1,	/* Logic Clock = 172.8 MHz */
+			.pck_div	= 5,	/* Pixel Clock = 34.56 MHz */
+
+		},
+	},
+	.channel		= OMAP_DSS_CHANNEL_LCD,
+};
+
 static struct omap_dss_device sdp4430_hdmi_device = {
 	.name = "hdmi",
 	.driver_name = "hdmi_panel",
@@ -678,17 +784,19 @@ static struct omap_dss_device sdp4430_hdmi_device = {
 };
 
 static struct omap_dss_device *sdp4430_dss_devices[] = {
+	&sdp4430_lcd_device,
 	&sdp4430_hdmi_device,
 };
 
 static struct omap_dss_board_info sdp4430_dss_data = {
 	.num_devices	= ARRAY_SIZE(sdp4430_dss_devices),
 	.devices	= sdp4430_dss_devices,
-	.default_device	= &sdp4430_hdmi_device,
+	.default_device	= &sdp4430_lcd_device,
 };
 
 void omap_4430sdp_display_init(void)
 {
+	sdp4430_lcd_init();
 	sdp4430_hdmi_mux_init();
 	omap_display_init(&sdp4430_dss_data);
 }
-- 
1.7.1

