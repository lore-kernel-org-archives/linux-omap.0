From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/6] OMAP: 2420SDP: Port the display driver to new DSS2
Date: Mon,  9 May 2011 10:36:04 +0300
Message-ID: <1304926567-26814-4-git-send-email-tomi.valkeinen@ti.com>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:32897 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752717Ab1EIHg0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 May 2011 03:36:26 -0400
Received: by mail-ey0-f173.google.com with SMTP id 6so1630422eyb.32
        for <linux-omap@vger.kernel.org>; Mon, 09 May 2011 00:36:24 -0700 (PDT)
In-Reply-To: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Hunyue Yau <hyau@mvista.com>

Port the old omapfb panel driver to DSS2. This patch changes the board
file only, the driver is ported in separate patch.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Hunyue Yau <hyau@mvista.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |   84 +++++++++++++++++++++++++++++------
 1 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 1fa6bb8..9b6e987 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -38,6 +38,8 @@
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 #include <plat/gpmc-smc91x.h>
+#include <plat/display.h>
+#include <plat/panel-generic-dpi.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -98,20 +100,79 @@ static struct platform_device sdp2430_flash_device = {
 	.resource	= &sdp2430_flash_resource,
 };
 
-static struct platform_device sdp2430_lcd_device = {
-	.name		= "sdp2430_lcd",
-	.id		= -1,
-};
-
 static struct platform_device *sdp2430_devices[] __initdata = {
 	&sdp2430_flash_device,
+};
+
+/* LCD */
+#define SDP2430_LCD_PANEL_BACKLIGHT_GPIO	91
+#define SDP2430_LCD_PANEL_ENABLE_GPIO		154
+
+static int sdp2430_panel_enable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_direction_output(SDP2430_LCD_PANEL_ENABLE_GPIO, 1);
+	gpio_direction_output(SDP2430_LCD_PANEL_BACKLIGHT_GPIO, 1);
+
+	return 0;
+}
+
+static void sdp2430_panel_disable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_direction_output(SDP2430_LCD_PANEL_ENABLE_GPIO, 0);
+	gpio_direction_output(SDP2430_LCD_PANEL_BACKLIGHT_GPIO, 0);
+}
+
+static struct panel_generic_dpi_data sdp2430_panel_data = {
+	.name			= "2430sdp",
+	.platform_enable	= sdp2430_panel_enable_lcd,
+	.platform_disable	= sdp2430_panel_disable_lcd,
+};
+
+static struct omap_dss_device sdp2430_lcd_device = {
+	.name			= "lcd",
+	.driver_name		= "generic_dpi_panel",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.phy.dpi.data_lines	= 16,
+	.data			= &sdp2430_panel_data,
+};
+
+static struct omap_dss_device *sdp2430_dss_devices[] = {
 	&sdp2430_lcd_device,
 };
 
-static struct omap_lcd_config sdp2430_lcd_config __initdata = {
-	.ctrl_name	= "internal",
+static struct omap_dss_board_info sdp2430_dss_data = {
+	.num_devices	= ARRAY_SIZE(sdp2430_dss_devices),
+	.devices	= sdp2430_dss_devices,
+	.default_device	= &sdp2430_lcd_device,
 };
 
+static void __init sdp2430_display_init(void)
+{
+	int r;
+
+	r = gpio_request_one(SDP2430_LCD_PANEL_ENABLE_GPIO,
+			GPIOF_OUT_INIT_LOW, "LCD reset");
+	if (r) {
+		printk(KERN_ERR "failed to get LCD reset GPIO\n");
+		goto err0;
+	}
+
+	r = gpio_request_one(SDP2430_LCD_PANEL_BACKLIGHT_GPIO,
+			GPIOF_OUT_INIT_LOW, "LCD Backlight");
+	if (r) {
+		printk(KERN_ERR "failed to get LCD backlight GPIO\n");
+		goto err1;
+	}
+
+	omap_display_init(&sdp2430_dss_data);
+
+	return;
+err1:
+	gpio_free(SDP2430_LCD_PANEL_ENABLE_GPIO);
+err0:
+	return;
+}
+
 #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91x_MODULE)
 
 static struct omap_smc91x_platform_data board_smc91x_data = {
@@ -136,10 +197,6 @@ static inline void board_smc91x_init(void)
 
 #endif
 
-static struct omap_board_config_kernel sdp2430_config[] __initdata = {
-	{OMAP_TAG_LCD, &sdp2430_lcd_config},
-};
-
 static void __init omap_2430sdp_init_early(void)
 {
 	omap2_init_common_infrastructure();
@@ -244,9 +301,6 @@ static void __init omap_2430sdp_init(void)
 
 	omap2430_mux_init(board_mux, OMAP_PACKAGE_ZAC);
 
-	omap_board_config = sdp2430_config;
-	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
-
 	omap2430_i2c_init();
 
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
@@ -263,6 +317,8 @@ static void __init omap_2430sdp_init(void)
 	ret = gpio_request(SECONDARY_LCD_GPIO, "Secondary LCD backlight");
 	if (ret == 0)
 		gpio_direction_output(SECONDARY_LCD_GPIO, 0);
+
+	sdp2430_display_init();
 }
 
 static void __init omap_2430sdp_map_io(void)
-- 
1.7.4.1

