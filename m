From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 3/6] OMAP: 2420SDP: Port the display driver to new DSS2
Date: Mon, 12 Sep 2011 14:20:45 +0300
Message-ID: <1315826448-27891-4-git-send-email-tomi.valkeinen@ti.com>
References: <1315826448-27891-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:49301 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755043Ab1ILLVy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 07:21:54 -0400
Received: by bkar4 with SMTP id r4so3059108bka.29
        for <linux-omap@vger.kernel.org>; Mon, 12 Sep 2011 04:21:04 -0700 (PDT)
In-Reply-To: <1315826448-27891-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Hunyue Yau <hyau@mvista.com>

Port the old omapfb panel driver to DSS2. This patch changes the board
file only, the driver is ported in separate patch.

Cc: Hunyue Yau <hyau@mvista.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |   78 ++++++++++++++++++++++++++++------
 1 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 2028464..6742eef 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -39,6 +39,9 @@
 #include <plat/usb.h>
 #include <plat/gpmc-smc91x.h>
 
+#include <video/omapdss.h>
+#include <video/omap-panel-generic-dpi.h>
+
 #include "mux.h"
 #include "hsmmc.h"
 #include "common-board-devices.h"
@@ -99,20 +102,72 @@ static struct platform_device sdp2430_flash_device = {
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
+	static struct gpio gpios[] __initdata = {
+		{ SDP2430_LCD_PANEL_ENABLE_GPIO, GPIOF_OUT_INIT_LOW,
+			"LCD reset" },
+		{ SDP2430_LCD_PANEL_BACKLIGHT_GPIO, GPIOF_OUT_INIT_LOW,
+			"LCD Backlight" },
+	};
+
+	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
+	if (r) {
+		pr_err("Cannot request LCD GPIOs, error %d\n", r);
+		return;
+	}
+
+	omap_display_init(&sdp2430_dss_data);
+}
+
 #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91x_MODULE)
 
 static struct omap_smc91x_platform_data board_smc91x_data = {
@@ -137,10 +192,6 @@ static inline void board_smc91x_init(void)
 
 #endif
 
-static struct omap_board_config_kernel sdp2430_config[] __initdata = {
-	{OMAP_TAG_LCD, &sdp2430_lcd_config},
-};
-
 static void __init omap_2430sdp_init_early(void)
 {
 	omap2_init_common_infrastructure();
@@ -228,9 +279,6 @@ static void __init omap_2430sdp_init(void)
 {
 	omap2430_mux_init(board_mux, OMAP_PACKAGE_ZAC);
 
-	omap_board_config = sdp2430_config;
-	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
-
 	omap2430_i2c_init();
 
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
@@ -246,6 +294,8 @@ static void __init omap_2430sdp_init(void)
 	/* Turn off secondary LCD backlight */
 	gpio_request_one(SECONDARY_LCD_GPIO, GPIOF_OUT_INIT_LOW,
 			 "Secondary LCD backlight");
+
+	sdp2430_display_init();
 }
 
 static void __init omap_2430sdp_map_io(void)
-- 
1.7.4.1

