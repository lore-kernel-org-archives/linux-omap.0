From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/27] ARM: OMAP: beagle: use new display drivers
Date: Thu, 30 May 2013 12:36:00 +0300
Message-ID: <1369906580-27585-8-git-send-email-tomi.valkeinen@ti.com>
References: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49884 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030405Ab3E3Jg7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:36:59 -0400
In-Reply-To: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new display drivers for Beagleboard.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c | 56 +++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 04c1165..30724e8 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -225,35 +225,46 @@ static struct mtd_partition omap3beagle_nand_partitions[] = {
 
 /* DSS */
 
-static struct tfp410_platform_data dvi_panel = {
-	.i2c_bus_num = 3,
-	.power_down_gpio = -1,
+static struct connector_dvi_platform_data beagle_dvi_connector_pdata = {
+	.name                   = "dvi",
+	.source                 = "tfp410.0",
+	.i2c_bus_num            = 3,
 };
 
-static struct omap_dss_device beagle_dvi_device = {
-	.type = OMAP_DISPLAY_TYPE_DPI,
-	.name = "dvi",
-	.driver_name = "tfp410",
-	.data = &dvi_panel,
-	.phy.dpi.data_lines = 24,
+static struct platform_device beagle_dvi_connector_device = {
+	.name                   = "connector-dvi",
+	.id                     = 0,
+	.dev.platform_data      = &beagle_dvi_connector_pdata,
 };
 
-static struct omap_dss_device beagle_tv_device = {
+static struct encoder_tfp410_platform_data beagle_tfp410_pdata = {
+	.name                   = "tfp410.0",
+	.source                 = "dpi.0",
+	.data_lines             = 24,
+	.power_down_gpio        = -1,
+};
+
+static struct platform_device beagle_tfp410_device = {
+	.name                   = "tfp410",
+	.id                     = 0,
+	.dev.platform_data      = &beagle_tfp410_pdata,
+};
+
+static struct connector_atv_platform_data beagle_tv_pdata = {
 	.name = "tv",
-	.driver_name = "venc",
-	.type = OMAP_DISPLAY_TYPE_VENC,
-	.phy.venc.type = OMAP_DSS_VENC_TYPE_SVIDEO,
+	.source = "venc.0",
+	.connector_type = OMAP_DSS_VENC_TYPE_SVIDEO,
+	.invert_polarity = false,
 };
 
-static struct omap_dss_device *beagle_dss_devices[] = {
-	&beagle_dvi_device,
-	&beagle_tv_device,
+static struct platform_device beagle_tv_device = {
+	.name                   = "connector-analog-tv",
+	.id                     = 0,
+	.dev.platform_data      = &beagle_tv_pdata,
 };
 
 static struct omap_dss_board_info beagle_dss_data = {
-	.num_devices = ARRAY_SIZE(beagle_dss_devices),
-	.devices = beagle_dss_devices,
-	.default_device = &beagle_dvi_device,
+	.default_display_name = "dvi",
 };
 
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -332,7 +343,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
 		if (gpio_request_one(gpio + 1, GPIOF_IN, "EHCI_nOC"))
 			pr_err("%s: unable to configure EHCI_nOC\n", __func__);
 	}
-	dvi_panel.power_down_gpio = beagle_config.dvi_pd_gpio;
+	beagle_tfp410_pdata.power_down_gpio = beagle_config.dvi_pd_gpio;
 
 	/* TWL4030_GPIO_MAX i.e. LED_GPO controls HS USB Port 2 power */
 	phy_data[0].vcc_gpio = gpio + TWL4030_GPIO_MAX;
@@ -547,6 +558,11 @@ static void __init omap3_beagle_init(void)
 	if (gpio_is_valid(beagle_config.dvi_pd_gpio))
 		omap_mux_init_gpio(beagle_config.dvi_pd_gpio, OMAP_PIN_OUTPUT);
 	omap_display_init(&beagle_dss_data);
+
+	platform_device_register(&beagle_tfp410_device);
+	platform_device_register(&beagle_dvi_connector_device);
+	platform_device_register(&beagle_tv_device);
+
 	omap_serial_init();
 	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
 				  mt46h32m32lf6_sdrc_params);
-- 
1.8.1.2

