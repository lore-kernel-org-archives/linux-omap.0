From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 04/27] ARM: OMAP: dss-common: use new display drivers
Date: Thu, 30 May 2013 12:35:57 +0300
Message-ID: <1369906580-27585-5-git-send-email-tomi.valkeinen@ti.com>
References: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41432 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030397Ab3E3Jgy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:36:54 -0400
In-Reply-To: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new display drivers for OMAP4 Panda and OMAP4 SDP boards.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/dss-common.c | 185 +++++++++++++++++++++++----------------
 1 file changed, 108 insertions(+), 77 deletions(-)

diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index 393aeef..17e0a08 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -25,6 +25,7 @@
 
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <linux/platform_device.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
@@ -37,53 +38,76 @@
 #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
 #define HDMI_GPIO_HPD  63 /* Hotplug detect */
 
-/* Display DVI */
 #define PANDA_DVI_TFP410_POWER_DOWN_GPIO	0
 
-/* Using generic display panel */
-static struct tfp410_platform_data omap4_dvi_panel = {
-	.i2c_bus_num		= 3,
-	.power_down_gpio	= PANDA_DVI_TFP410_POWER_DOWN_GPIO,
+/* DVI Connector */
+static struct connector_dvi_platform_data omap4_panda_dvi_connector_pdata = {
+	.name                   = "dvi",
+	.source                 = "tfp410.0",
+	.i2c_bus_num            = 3,
 };
 
-static struct omap_dss_device omap4_panda_dvi_device = {
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.name			= "dvi",
-	.driver_name		= "tfp410",
-	.data			= &omap4_dvi_panel,
-	.phy.dpi.data_lines	= 24,
-	.channel		= OMAP_DSS_CHANNEL_LCD2,
+static struct platform_device omap4_panda_dvi_connector_device = {
+	.name                   = "connector-dvi",
+	.id                     = 0,
+	.dev.platform_data      = &omap4_panda_dvi_connector_pdata,
+};
+
+/* TFP410 DPI-to-DVI chip */
+static struct encoder_tfp410_platform_data omap4_panda_tfp410_pdata = {
+	.name                   = "tfp410.0",
+	.source                 = "dpi.0",
+	.data_lines             = 24,
+	.power_down_gpio        = PANDA_DVI_TFP410_POWER_DOWN_GPIO,
+};
+
+static struct platform_device omap4_panda_tfp410_device = {
+	.name                   = "tfp410",
+	.id                     = 0,
+	.dev.platform_data      = &omap4_panda_tfp410_pdata,
 };
 
-static struct omap_dss_hdmi_data omap4_panda_hdmi_data = {
+/* HDMI Connector */
+static struct connector_hdmi_platform_data omap4_panda_hdmi_connector_pdata = {
+	.name                   = "hdmi",
+	.source                 = "tpd12s015.0",
+};
+
+static struct platform_device omap4_panda_hdmi_connector_device = {
+	.name                   = "connector-hdmi",
+	.id                     = 0,
+	.dev.platform_data      = &omap4_panda_hdmi_connector_pdata,
+};
+
+/* TPD12S015 HDMI ESD protection & level shifter chip */
+static struct encoder_tpd12s015_platform_data omap4_panda_tpd_pdata = {
+	.name                   = "tpd12s015.0",
+	.source                 = "hdmi.0",
+
 	.ct_cp_hpd_gpio = HDMI_GPIO_CT_CP_HPD,
 	.ls_oe_gpio = HDMI_GPIO_LS_OE,
 	.hpd_gpio = HDMI_GPIO_HPD,
 };
 
-static struct omap_dss_device  omap4_panda_hdmi_device = {
-	.name = "hdmi",
-	.driver_name = "hdmi_panel",
-	.type = OMAP_DISPLAY_TYPE_HDMI,
-	.channel = OMAP_DSS_CHANNEL_DIGIT,
-	.data = &omap4_panda_hdmi_data,
-};
-
-static struct omap_dss_device *omap4_panda_dss_devices[] = {
-	&omap4_panda_dvi_device,
-	&omap4_panda_hdmi_device,
+static struct platform_device omap4_panda_tpd_device = {
+	.name                   = "tpd12s015",
+	.id                     = 0,
+	.dev.platform_data      = &omap4_panda_tpd_pdata,
 };
 
 static struct omap_dss_board_info omap4_panda_dss_data = {
-	.num_devices	= ARRAY_SIZE(omap4_panda_dss_devices),
-	.devices	= omap4_panda_dss_devices,
-	.default_device	= &omap4_panda_dvi_device,
+	.default_display_name = "dvi",
 };
 
 void __init omap4_panda_display_init(void)
 {
 	omap_display_init(&omap4_panda_dss_data);
 
+	platform_device_register(&omap4_panda_tfp410_device);
+	platform_device_register(&omap4_panda_dvi_connector_device);
+
+	platform_device_register(&omap4_panda_tpd_device);
+	platform_device_register(&omap4_panda_hdmi_connector_device);
 	/*
 	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and
 	 * later have external pull up on the HDMI I2C lines
@@ -109,67 +133,71 @@ void __init omap4_panda_display_init_of(void)
 #define DISPLAY_SEL_GPIO	59	/* LCD2/PicoDLP switch */
 #define DLP_POWER_ON_GPIO	40
 
-static struct nokia_dsi_panel_data dsi1_panel = {
-		.name		= "taal",
-		.reset_gpio	= 102,
-		.use_ext_te	= false,
-		.ext_te_gpio	= 101,
-		.esd_interval	= 0,
-		.pin_config = {
-			.num_pins	= 6,
-			.pins		= { 0, 1, 2, 3, 4, 5 },
-		},
-};
-
-static struct omap_dss_device sdp4430_lcd_device = {
-	.name			= "lcd",
-	.driver_name		= "taal",
-	.type			= OMAP_DISPLAY_TYPE_DSI,
-	.data			= &dsi1_panel,
-	.phy.dsi		= {
-		.module		= 0,
+static struct panel_dsicm_platform_data dsi1_panel = {
+	.name		= "lcd",
+	.source		= "dsi.0",
+	.reset_gpio	= 102,
+	.use_ext_te	= false,
+	.ext_te_gpio	= 101,
+	.pin_config = {
+		.num_pins	= 6,
+		.pins		= { 0, 1, 2, 3, 4, 5 },
 	},
-	.channel		= OMAP_DSS_CHANNEL_LCD,
 };
 
-static struct nokia_dsi_panel_data dsi2_panel = {
-		.name		= "taal",
-		.reset_gpio	= 104,
-		.use_ext_te	= false,
-		.ext_te_gpio	= 103,
-		.esd_interval	= 0,
-		.pin_config = {
-			.num_pins	= 6,
-			.pins		= { 0, 1, 2, 3, 4, 5 },
-		},
+static struct platform_device sdp4430_lcd_device = {
+	.name                   = "panel-dsi-cm",
+	.id                     = 0,
+	.dev.platform_data	= &dsi1_panel,
 };
 
-static struct omap_dss_device sdp4430_lcd2_device = {
-	.name			= "lcd2",
-	.driver_name		= "taal",
-	.type			= OMAP_DISPLAY_TYPE_DSI,
-	.data			= &dsi2_panel,
-	.phy.dsi		= {
-
-		.module		= 1,
+static struct panel_dsicm_platform_data dsi2_panel = {
+	.name		= "lcd2",
+	.source		= "dsi.1",
+	.reset_gpio	= 104,
+	.use_ext_te	= false,
+	.ext_te_gpio	= 103,
+	.pin_config = {
+		.num_pins	= 6,
+		.pins		= { 0, 1, 2, 3, 4, 5 },
 	},
-	.channel		= OMAP_DSS_CHANNEL_LCD2,
 };
 
-static struct omap_dss_hdmi_data sdp4430_hdmi_data = {
+static struct platform_device sdp4430_lcd2_device = {
+	.name                   = "panel-dsi-cm",
+	.id                     = 1,
+	.dev.platform_data	= &dsi2_panel,
+};
+
+/* HDMI Connector */
+static struct connector_hdmi_platform_data sdp4430_hdmi_connector_pdata = {
+	.name                   = "hdmi",
+	.source                 = "tpd12s015.0",
+};
+
+static struct platform_device sdp4430_hdmi_connector_device = {
+	.name                   = "connector-hdmi",
+	.id                     = 0,
+	.dev.platform_data      = &sdp4430_hdmi_connector_pdata,
+};
+
+/* TPD12S015 HDMI ESD protection & level shifter chip */
+static struct encoder_tpd12s015_platform_data sdp4430_tpd_pdata = {
+	.name                   = "tpd12s015.0",
+	.source                 = "hdmi.0",
+
 	.ct_cp_hpd_gpio = HDMI_GPIO_CT_CP_HPD,
 	.ls_oe_gpio = HDMI_GPIO_LS_OE,
 	.hpd_gpio = HDMI_GPIO_HPD,
 };
 
-static struct omap_dss_device sdp4430_hdmi_device = {
-	.name = "hdmi",
-	.driver_name = "hdmi_panel",
-	.type = OMAP_DISPLAY_TYPE_HDMI,
-	.channel = OMAP_DSS_CHANNEL_DIGIT,
-	.data = &sdp4430_hdmi_data,
+static struct platform_device sdp4430_tpd_device = {
+	.name                   = "tpd12s015",
+	.id                     = 0,
+	.dev.platform_data      = &sdp4430_tpd_pdata,
 };
 
+
 static struct picodlp_panel_data sdp4430_picodlp_pdata = {
 	.picodlp_adapter_id	= 2,
 	.emu_done_gpio		= 44,
@@ -186,16 +214,13 @@ static struct omap_dss_device sdp4430_picodlp_device = {
 };
 
 static struct omap_dss_device *sdp4430_dss_devices[] = {
-	&sdp4430_lcd_device,
-	&sdp4430_lcd2_device,
-	&sdp4430_hdmi_device,
 	&sdp4430_picodlp_device,
 };
 
 static struct omap_dss_board_info sdp4430_dss_data = {
 	.num_devices	= ARRAY_SIZE(sdp4430_dss_devices),
 	.devices	= sdp4430_dss_devices,
-	.default_device	= &sdp4430_lcd_device,
+	.default_display_name = "lcd",
 };
 
 /*
@@ -231,6 +256,12 @@ void __init omap_4430sdp_display_init(void)
 	omap_mux_init_gpio(HDMI_GPIO_LS_OE, OMAP_PIN_OUTPUT);
 	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
 	omap_mux_init_gpio(HDMI_GPIO_HPD, OMAP_PIN_INPUT_PULLDOWN);
+
+	platform_device_register(&sdp4430_lcd_device);
+	platform_device_register(&sdp4430_lcd2_device);
+
+	platform_device_register(&sdp4430_tpd_device);
+	platform_device_register(&sdp4430_hdmi_connector_device);
 }
 
 void __init omap_4430sdp_display_init_of(void)
-- 
1.8.1.2

