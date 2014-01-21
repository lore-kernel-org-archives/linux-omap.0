From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 32/41] ARM: OMAP2+: remove pdata quirks for displays
Date: Tue, 21 Jan 2014 12:57:04 +0200
Message-ID: <1390301833-24944-33-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34964 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204AbaAULBR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jan 2014 06:01:17 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Remove pdata quirks for the displays on boards that are now supported
properly with DT.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/dss-common.c   | 224 -------------------------------------
 arch/arm/mach-omap2/pdata-quirks.c |   3 -
 2 files changed, 227 deletions(-)

diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index dadccc91488c..010bb72d2b75 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -33,227 +33,3 @@
 #include "soc.h"
 #include "dss-common.h"
 #include "mux.h"
-
-#define HDMI_GPIO_CT_CP_HPD 60 /* HPD mode enable/disable */
-#define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
-#define HDMI_GPIO_HPD  63 /* Hotplug detect */
-
-#define PANDA_DVI_TFP410_POWER_DOWN_GPIO	0
-
-/* DVI Connector */
-static struct connector_dvi_platform_data omap4_panda_dvi_connector_pdata = {
-	.name                   = "dvi",
-	.source                 = "tfp410.0",
-	.i2c_bus_num            = 2,
-};
-
-static struct platform_device omap4_panda_dvi_connector_device = {
-	.name                   = "connector-dvi",
-	.id                     = 0,
-	.dev.platform_data      = &omap4_panda_dvi_connector_pdata,
-};
-
-/* TFP410 DPI-to-DVI chip */
-static struct encoder_tfp410_platform_data omap4_panda_tfp410_pdata = {
-	.name                   = "tfp410.0",
-	.source                 = "dpi.0",
-	.data_lines             = 24,
-	.power_down_gpio        = PANDA_DVI_TFP410_POWER_DOWN_GPIO,
-};
-
-static struct platform_device omap4_panda_tfp410_device = {
-	.name                   = "tfp410",
-	.id                     = 0,
-	.dev.platform_data      = &omap4_panda_tfp410_pdata,
-};
-
-/* HDMI Connector */
-static struct connector_hdmi_platform_data omap4_panda_hdmi_connector_pdata = {
-	.name                   = "hdmi",
-	.source                 = "tpd12s015.0",
-};
-
-static struct platform_device omap4_panda_hdmi_connector_device = {
-	.name                   = "connector-hdmi",
-	.id                     = 0,
-	.dev.platform_data      = &omap4_panda_hdmi_connector_pdata,
-};
-
-/* TPD12S015 HDMI ESD protection & level shifter chip */
-static struct encoder_tpd12s015_platform_data omap4_panda_tpd_pdata = {
-	.name                   = "tpd12s015.0",
-	.source                 = "hdmi.0",
-
-	.ct_cp_hpd_gpio = HDMI_GPIO_CT_CP_HPD,
-	.ls_oe_gpio = HDMI_GPIO_LS_OE,
-	.hpd_gpio = HDMI_GPIO_HPD,
-};
-
-static struct platform_device omap4_panda_tpd_device = {
-	.name                   = "tpd12s015",
-	.id                     = 0,
-	.dev.platform_data      = &omap4_panda_tpd_pdata,
-};
-
-static struct omap_dss_board_info omap4_panda_dss_data = {
-	.default_display_name = "dvi",
-};
-
-void __init omap4_panda_display_init_of(void)
-{
-	omap_display_init(&omap4_panda_dss_data);
-
-	platform_device_register(&omap4_panda_tfp410_device);
-	platform_device_register(&omap4_panda_dvi_connector_device);
-
-	platform_device_register(&omap4_panda_tpd_device);
-	platform_device_register(&omap4_panda_hdmi_connector_device);
-}
-
-
-/* OMAP4 Blaze display data */
-
-#define DISPLAY_SEL_GPIO	59	/* LCD2/PicoDLP switch */
-#define DLP_POWER_ON_GPIO	40
-
-static struct panel_dsicm_platform_data dsi1_panel = {
-	.name		= "lcd",
-	.source		= "dsi.0",
-	.reset_gpio	= 102,
-	.use_ext_te	= false,
-	.ext_te_gpio	= 101,
-	.pin_config = {
-		.num_pins	= 6,
-		.pins		= { 0, 1, 2, 3, 4, 5 },
-	},
-};
-
-static struct platform_device sdp4430_lcd_device = {
-	.name                   = "panel-dsi-cm",
-	.id                     = 0,
-	.dev.platform_data	= &dsi1_panel,
-};
-
-static struct panel_dsicm_platform_data dsi2_panel = {
-	.name		= "lcd2",
-	.source		= "dsi.1",
-	.reset_gpio	= 104,
-	.use_ext_te	= false,
-	.ext_te_gpio	= 103,
-	.pin_config = {
-		.num_pins	= 6,
-		.pins		= { 0, 1, 2, 3, 4, 5 },
-	},
-};
-
-static struct platform_device sdp4430_lcd2_device = {
-	.name                   = "panel-dsi-cm",
-	.id                     = 1,
-	.dev.platform_data	= &dsi2_panel,
-};
-
-/* HDMI Connector */
-static struct connector_hdmi_platform_data sdp4430_hdmi_connector_pdata = {
-	.name                   = "hdmi",
-	.source                 = "tpd12s015.0",
-};
-
-static struct platform_device sdp4430_hdmi_connector_device = {
-	.name                   = "connector-hdmi",
-	.id                     = 0,
-	.dev.platform_data      = &sdp4430_hdmi_connector_pdata,
-};
-
-/* TPD12S015 HDMI ESD protection & level shifter chip */
-static struct encoder_tpd12s015_platform_data sdp4430_tpd_pdata = {
-	.name                   = "tpd12s015.0",
-	.source                 = "hdmi.0",
-
-	.ct_cp_hpd_gpio = HDMI_GPIO_CT_CP_HPD,
-	.ls_oe_gpio = HDMI_GPIO_LS_OE,
-	.hpd_gpio = HDMI_GPIO_HPD,
-};
-
-static struct platform_device sdp4430_tpd_device = {
-	.name                   = "tpd12s015",
-	.id                     = 0,
-	.dev.platform_data      = &sdp4430_tpd_pdata,
-};
-
-
-static struct omap_dss_board_info sdp4430_dss_data = {
-	.default_display_name = "lcd",
-};
-
-/*
- * we select LCD2 by default (instead of Pico DLP) by setting DISPLAY_SEL_GPIO.
- * Setting DLP_POWER_ON gpio enables the VDLP_2V5 VDLP_1V8 and VDLP_1V0 rails
- * used by picodlp on the 4430sdp platform. Keep this gpio disabled as LCD2 is
- * selected by default
- */
-void __init omap_4430sdp_display_init_of(void)
-{
-	int r;
-
-	r = gpio_request_one(DISPLAY_SEL_GPIO, GPIOF_OUT_INIT_HIGH,
-			"display_sel");
-	if (r)
-		pr_err("%s: Could not get display_sel GPIO\n", __func__);
-
-	r = gpio_request_one(DLP_POWER_ON_GPIO, GPIOF_OUT_INIT_LOW,
-		"DLP POWER ON");
-	if (r)
-		pr_err("%s: Could not get DLP POWER ON GPIO\n", __func__);
-
-	omap_display_init(&sdp4430_dss_data);
-
-	platform_device_register(&sdp4430_lcd_device);
-	platform_device_register(&sdp4430_lcd2_device);
-
-	platform_device_register(&sdp4430_tpd_device);
-	platform_device_register(&sdp4430_hdmi_connector_device);
-}
-
-
-/* OMAP3 IGEPv2 data */
-
-#define IGEP2_DVI_TFP410_POWER_DOWN_GPIO	170
-
-/* DVI Connector */
-static struct connector_dvi_platform_data omap3_igep2_dvi_connector_pdata = {
-	.name                   = "dvi",
-	.source                 = "tfp410.0",
-	.i2c_bus_num            = 2,
-};
-
-static struct platform_device omap3_igep2_dvi_connector_device = {
-	.name                   = "connector-dvi",
-	.id                     = 0,
-	.dev.platform_data      = &omap3_igep2_dvi_connector_pdata,
-};
-
-/* TFP410 DPI-to-DVI chip */
-static struct encoder_tfp410_platform_data omap3_igep2_tfp410_pdata = {
-	.name                   = "tfp410.0",
-	.source                 = "dpi.0",
-	.data_lines             = 24,
-	.power_down_gpio        = IGEP2_DVI_TFP410_POWER_DOWN_GPIO,
-};
-
-static struct platform_device omap3_igep2_tfp410_device = {
-	.name                   = "tfp410",
-	.id                     = 0,
-	.dev.platform_data      = &omap3_igep2_tfp410_pdata,
-};
-
-static struct omap_dss_board_info igep2_dss_data = {
-	.default_display_name = "dvi",
-};
-
-void __init omap3_igep2_display_init_of(void)
-{
-	omap_display_init(&igep2_dss_data);
-
-	platform_device_register(&omap3_igep2_tfp410_device);
-	platform_device_register(&omap3_igep2_dvi_connector_device);
-}
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 39f020c982e8..68e3bca42e60 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -80,7 +80,6 @@ static void __init hsmmc2_internal_input_clk(void)
 
 static void __init omap3_igep0020_legacy_init(void)
 {
-	omap3_igep2_display_init_of();
 }
 
 static void __init omap3_evm_legacy_init(void)
@@ -97,14 +96,12 @@ static void __init omap3_zoom_legacy_init(void)
 #ifdef CONFIG_ARCH_OMAP4
 static void __init omap4_sdp_legacy_init(void)
 {
-	omap_4430sdp_display_init_of();
 	legacy_init_wl12xx(WL12XX_REFCLOCK_26,
 			   WL12XX_TCXOCLOCK_26, 53);
 }
 
 static void __init omap4_panda_legacy_init(void)
 {
-	omap4_panda_display_init_of();
 	legacy_init_ehci_clk("auxclk3_ck");
 	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 53);
 }
-- 
1.8.3.2

