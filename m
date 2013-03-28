From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 13/28] ARM: OMAP: Beagle: use new TFP410 platform driver
Date: Thu, 28 Mar 2013 14:49:07 +0200
Message-ID: <1364474962-20439-14-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44550 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756040Ab3C1MuB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:50:01 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new TFP410 platform driver instead of the old omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index c3558f9..1b65e92 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -224,17 +224,18 @@ static struct mtd_partition omap3beagle_nand_partitions[] = {
 
 /* DSS */
 
-static struct tfp410_platform_data dvi_panel = {
-	.i2c_bus_num = 3,
-	.power_down_gpio = -1,
+static struct tfp410_platform_data omap4_tfp410_pdata = {
+	.name			= "dvi",
+	.source			= "dpi.0",
+	.i2c_bus_num		= 3,
+	.data_lines		= 24,
+	.power_down_gpio	= -1,
 };
 
-static struct omap_dss_device beagle_dvi_device = {
-	.type = OMAP_DISPLAY_TYPE_DPI,
-	.name = "dvi",
-	.driver_name = "tfp410",
-	.data = &dvi_panel,
-	.phy.dpi.data_lines = 24,
+static struct platform_device omap4_panda_tfp410_device = {
+	.name			= "tfp410",
+	.id			= 0,
+	.dev.platform_data	= &omap4_tfp410_pdata,
 };
 
 static struct omap_dss_device beagle_tv_device = {
@@ -245,14 +246,13 @@ static struct omap_dss_device beagle_tv_device = {
 };
 
 static struct omap_dss_device *beagle_dss_devices[] = {
-	&beagle_dvi_device,
 	&beagle_tv_device,
 };
 
 static struct omap_dss_board_info beagle_dss_data = {
 	.num_devices = ARRAY_SIZE(beagle_dss_devices),
 	.devices = beagle_dss_devices,
-	.default_device = &beagle_dvi_device,
+	.default_display_name = "dvi",
 };
 
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -316,7 +316,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
 		if (gpio_request_one(gpio + 1, GPIOF_IN, "EHCI_nOC"))
 			pr_err("%s: unable to configure EHCI_nOC\n", __func__);
 	}
-	dvi_panel.power_down_gpio = beagle_config.dvi_pd_gpio;
+	omap4_tfp410_pdata.power_down_gpio = beagle_config.dvi_pd_gpio;
 
 	gpio_request_one(gpio + TWL4030_GPIO_MAX, beagle_config.usb_pwr_level,
 			"nEN_USB_PWR");
@@ -450,6 +450,7 @@ static struct platform_device *omap3_beagle_devices[] __initdata = {
 	&keys_gpio,
 	&madc_hwmon,
 	&leds_pwm,
+	&omap4_panda_tfp410_device,
 };
 
 static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
-- 
1.7.10.4

