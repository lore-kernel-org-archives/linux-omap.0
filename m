From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 25/26] ARM: OMAP: Overo: use new TFP410 platform driver
Date: Tue, 26 Mar 2013 15:33:55 +0200
Message-ID: <1364304836-18134-26-git-send-email-tomi.valkeinen@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35079 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934393Ab3CZNfG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Mar 2013 09:35:06 -0400
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new TFP410 platform driver instead of the old omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-overo.c |   32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 86bab51..e3cd2bd 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -157,6 +157,20 @@ static struct gpio overo_dss_gpios[] __initdata = {
 	{ OVERO_GPIO_LCD_BL, GPIOF_OUT_INIT_HIGH, "OVERO_GPIO_LCD_BL" },
 };
 
+static struct tfp410_platform_data dvi_panel = {
+	.name			= "dvi",
+	.source			= "dpi.0",
+	.data_lines		= 24,
+	.i2c_bus_num		= 3,
+	.power_down_gpio	= -1,
+};
+
+static struct platform_device overo_dvi_device = {
+	.name			= "tfp410",
+	.id			= 0,
+	.dev.platform_data	= &dvi_panel,
+};
+
 static void __init overo_display_init(void)
 {
 	if (gpio_request_array(overo_dss_gpios, ARRAY_SIZE(overo_dss_gpios))) {
@@ -166,20 +180,9 @@ static void __init overo_display_init(void)
 
 	gpio_export(OVERO_GPIO_LCD_EN, 0);
 	gpio_export(OVERO_GPIO_LCD_BL, 0);
-}
 
-static struct tfp410_platform_data dvi_panel = {
-	.i2c_bus_num		= 3,
-	.power_down_gpio	= -1,
-};
-
-static struct omap_dss_device overo_dvi_device = {
-	.name			= "dvi",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "tfp410",
-	.data			= &dvi_panel,
-	.phy.dpi.data_lines	= 24,
-};
+	platform_device_register(&overo_dvi_device);
+}
 
 static struct omap_dss_device overo_tv_device = {
 	.name = "tv",
@@ -235,7 +238,6 @@ static struct omap_dss_device overo_lcd35_device = {
 #endif
 
 static struct omap_dss_device *overo_dss_devices[] = {
-	&overo_dvi_device,
 	&overo_tv_device,
 #if defined(CONFIG_PANEL_LGPHILIPS_LB035Q02) || \
 	defined(CONFIG_PANEL_LGPHILIPS_LB035Q02_MODULE)
@@ -247,7 +249,7 @@ static struct omap_dss_device *overo_dss_devices[] = {
 static struct omap_dss_board_info overo_dss_data = {
 	.num_devices	= ARRAY_SIZE(overo_dss_devices),
 	.devices	= overo_dss_devices,
-	.default_device	= &overo_dvi_device,
+	.default_display_name = "dvi",
 };
 
 static struct mtd_partition overo_nand_partitions[] = {
-- 
1.7.10.4

