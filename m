From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/3] OMAP4: 4430SDP: Add panel support to board file
Date: Thu, 15 Sep 2011 10:17:34 +0300
Message-ID: <1316071055-21494-3-git-send-email-tomi.valkeinen@ti.com>
References: <1316071055-21494-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:51908 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754556Ab1IOHRv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 03:17:51 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so2943181bkb.33
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 00:17:50 -0700 (PDT)
In-Reply-To: <1316071055-21494-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

4430SDP has two Taal DSI panels, connected to DSI 1 and DSI 2 modules.
The panels use a common PWM backlight, which will be implemented later
when the PWM driver has been improved to support the backlight.

Until the PWM driver has been improved, the following hack added to
arch/arm/mach-omap2/board-4430sdp.c can be used to set the backlight to
max:

static int omap_4430sdp_hack_backlight(void)
{
       twl_i2c_write_u8(TWL_MODULE_PWM, 0x7f, LED_PWM2OFF);
       twl_i2c_write_u8(TWL_MODULE_PWM, 0x7f, LED_PWM2ON);
       twl_i2c_write_u8(TWL6030_MODULE_ID1, 0x30, TWL6030_TOGGLE3);
       return 0;
}
late_initcall(omap_4430sdp_hack_backlight);

Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |  141 +++++++++++++++++++++++++++++++---
 1 files changed, 128 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 79c2827..b01ba46 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -38,6 +38,7 @@
 #include <plat/mmc.h>
 #include <plat/omap4-keypad.h>
 #include <video/omapdss.h>
+#include <video/omap-panel-nokia-dsi.h>
 #include <linux/wl12xx.h>
 
 #include "mux.h"
@@ -52,6 +53,7 @@
 #define OMAP4_SFH7741_ENABLE_GPIO		188
 #define HDMI_GPIO_HPD 60 /* Hot plug pin for HDMI */
 #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
+#define DISPLAY_SEL_GPIO	59	/* LCD2/PicoDLP switch */
 
 #define GPIO_WIFI_PMENA		54
 #define GPIO_WIFI_IRQ		53
@@ -340,11 +342,6 @@ static int __init omap_ethernet_init(void)
 	return status;
 }
 
-static struct platform_device sdp4430_lcd_device = {
-	.name		= "sdp4430_lcd",
-	.id		= -1,
-};
-
 static struct regulator_consumer_supply sdp4430_vbat_supply[] = {
 	REGULATOR_SUPPLY("vddvibl", "twl6040-vibra"),
 	REGULATOR_SUPPLY("vddvibr", "twl6040-vibra"),
@@ -374,19 +371,13 @@ static struct platform_device sdp4430_vbat = {
 };
 
 static struct platform_device *sdp4430_devices[] __initdata = {
-	&sdp4430_lcd_device,
 	&sdp4430_gpio_keys_device,
 	&sdp4430_leds_gpio,
 	&sdp4430_leds_pwm,
 	&sdp4430_vbat,
 };
 
-static struct omap_lcd_config sdp4430_lcd_config __initdata = {
-	.ctrl_name	= "internal",
-};
-
 static struct omap_board_config_kernel sdp4430_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&sdp4430_lcd_config },
 };
 
 static void __init omap_4430sdp_init_early(void)
@@ -648,6 +639,119 @@ static void sdp4430_panel_disable_hdmi(struct omap_dss_device *dssdev)
 	gpio_free(HDMI_GPIO_HPD);
 }
 
+static struct nokia_dsi_panel_data dsi1_panel = {
+		.name		= "taal",
+		.reset_gpio	= 102,
+		.use_ext_te	= false,
+		.ext_te_gpio	= 101,
+		.esd_interval	= 0,
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
+
+		.module		= 0,
+	},
+
+	.clocks = {
+		.dispc = {
+			.channel = {
+				/* Logic Clock = 172.8 MHz */
+				.lck_div	= 1,
+				/* Pixel Clock = 34.56 MHz */
+				.pck_div	= 5,
+				.lcd_clk_src	= OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC,
+			},
+			.dispc_fclk_src	= OMAP_DSS_CLK_SRC_FCK,
+		},
+
+		.dsi = {
+			.regn		= 16,	/* Fint = 2.4 MHz */
+			.regm		= 180,	/* DDR Clock = 216 MHz */
+			.regm_dispc	= 5,	/* PLL1_CLK1 = 172.8 MHz */
+			.regm_dsi	= 5,	/* PLL1_CLK2 = 172.8 MHz */
+
+			.lp_clk_div	= 10,	/* LP Clock = 8.64 MHz */
+			.dsi_fclk_src	= OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI,
+		},
+	},
+	.channel		= OMAP_DSS_CHANNEL_LCD,
+};
+
+static struct nokia_dsi_panel_data dsi2_panel = {
+		.name		= "taal",
+		.reset_gpio	= 104,
+		.use_ext_te	= false,
+		.ext_te_gpio	= 103,
+		.esd_interval	= 0,
+};
+
+static struct omap_dss_device sdp4430_lcd2_device = {
+	.name			= "lcd2",
+	.driver_name		= "taal",
+	.type			= OMAP_DISPLAY_TYPE_DSI,
+	.data			= &dsi2_panel,
+	.phy.dsi		= {
+		.clk_lane	= 1,
+		.clk_pol	= 0,
+		.data1_lane	= 2,
+		.data1_pol	= 0,
+		.data2_lane	= 3,
+		.data2_pol	= 0,
+
+		.module		= 1,
+	},
+
+	.clocks = {
+		.dispc = {
+			.channel = {
+				/* Logic Clock = 172.8 MHz */
+				.lck_div	= 1,
+				/* Pixel Clock = 34.56 MHz */
+				.pck_div	= 5,
+				.lcd_clk_src	= OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC,
+			},
+			.dispc_fclk_src	= OMAP_DSS_CLK_SRC_FCK,
+		},
+
+		.dsi = {
+			.regn		= 16,	/* Fint = 2.4 MHz */
+			.regm		= 180,	/* DDR Clock = 216 MHz */
+			.regm_dispc	= 5,	/* PLL1_CLK1 = 172.8 MHz */
+			.regm_dsi	= 5,	/* PLL1_CLK2 = 172.8 MHz */
+
+			.lp_clk_div	= 10,	/* LP Clock = 8.64 MHz */
+			.dsi_fclk_src	= OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI,
+		},
+	},
+	.channel		= OMAP_DSS_CHANNEL_LCD2,
+};
+
+static void sdp4430_lcd_init(void)
+{
+	int r;
+
+	r = gpio_request_one(dsi1_panel.reset_gpio, GPIOF_DIR_OUT,
+		"lcd1_reset_gpio");
+	if (r)
+		pr_err("%s: Could not get lcd1_reset_gpio\n", __func__);
+
+	r = gpio_request_one(dsi2_panel.reset_gpio, GPIOF_DIR_OUT,
+		"lcd2_reset_gpio");
+	if (r)
+		pr_err("%s: Could not get lcd2_reset_gpio\n", __func__);
+}
+
 static struct omap_dss_device sdp4430_hdmi_device = {
 	.name = "hdmi",
 	.driver_name = "hdmi_panel",
@@ -658,17 +762,28 @@ static struct omap_dss_device sdp4430_hdmi_device = {
 };
 
 static struct omap_dss_device *sdp4430_dss_devices[] = {
+	&sdp4430_lcd_device,
+	&sdp4430_lcd2_device,
 	&sdp4430_hdmi_device,
 };
 
 static struct omap_dss_board_info sdp4430_dss_data = {
 	.num_devices	= ARRAY_SIZE(sdp4430_dss_devices),
 	.devices	= sdp4430_dss_devices,
-	.default_device	= &sdp4430_hdmi_device,
+	.default_device	= &sdp4430_lcd_device,
 };
 
-void omap_4430sdp_display_init(void)
+static void omap_4430sdp_display_init(void)
 {
+	int r;
+
+	/* Enable LCD2 by default (instead of Pico DLP) */
+	r = gpio_request_one(DISPLAY_SEL_GPIO, GPIOF_OUT_INIT_HIGH,
+			"display_sel");
+	if (r)
+		pr_err("%s: Could not get display_sel GPIO\n", __func__);
+
+	sdp4430_lcd_init();
 	sdp4430_hdmi_mux_init();
 	omap_display_init(&sdp4430_dss_data);
 }
-- 
1.7.4.1

