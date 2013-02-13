From: Archit Taneja <archit@ti.com>
Subject: [PATCH 03/33] arm: omap: board-2430: use generic dpi panel's gpio handling
Date: Wed, 13 Feb 2013 19:51:55 +0530
Message-ID: <1360765345-19312-4-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56507 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934024Ab3BMOXW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 09:23:22 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>, Tony Lindgren <tony@atomide.com>

The 2430sdp board file currently requests gpios required to configure the NEC
DPI panel, and provides platform_enable/disable callbacks to configure them.

These tasks have been moved to the generic dpi panel driver itself and shouldn't
be done in the board files.

Remove the gpio requests and the platform callbacks from the board file.
Add the gpio information to generic dpi panel's platform data so that it's
passed to the panel driver.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |   43 +++++------------------------------
 1 file changed, 6 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 13a1a3b..c888a58 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -107,24 +107,13 @@ static struct platform_device *sdp2430_devices[] __initdata = {
 #define SDP2430_LCD_PANEL_BACKLIGHT_GPIO	91
 #define SDP2430_LCD_PANEL_ENABLE_GPIO		154
 
-static int sdp2430_panel_enable_lcd(struct omap_dss_device *dssdev)
-{
-	gpio_direction_output(SDP2430_LCD_PANEL_ENABLE_GPIO, 1);
-	gpio_direction_output(SDP2430_LCD_PANEL_BACKLIGHT_GPIO, 1);
-
-	return 0;
-}
-
-static void sdp2430_panel_disable_lcd(struct omap_dss_device *dssdev)
-{
-	gpio_direction_output(SDP2430_LCD_PANEL_ENABLE_GPIO, 0);
-	gpio_direction_output(SDP2430_LCD_PANEL_BACKLIGHT_GPIO, 0);
-}
-
 static struct panel_generic_dpi_data sdp2430_panel_data = {
 	.name			= "nec_nl2432dr22-11b",
-	.platform_enable	= sdp2430_panel_enable_lcd,
-	.platform_disable	= sdp2430_panel_disable_lcd,
+	.num_gpios		= 2,
+	.gpios			= {
+		SDP2430_LCD_PANEL_ENABLE_GPIO,
+		SDP2430_LCD_PANEL_BACKLIGHT_GPIO,
+	},
 };
 
 static struct omap_dss_device sdp2430_lcd_device = {
@@ -145,26 +134,6 @@ static struct omap_dss_board_info sdp2430_dss_data = {
 	.default_device	= &sdp2430_lcd_device,
 };
 
-static void __init sdp2430_display_init(void)
-{
-	int r;
-
-	static struct gpio gpios[] __initdata = {
-		{ SDP2430_LCD_PANEL_ENABLE_GPIO, GPIOF_OUT_INIT_LOW,
-			"LCD reset" },
-		{ SDP2430_LCD_PANEL_BACKLIGHT_GPIO, GPIOF_OUT_INIT_LOW,
-			"LCD Backlight" },
-	};
-
-	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
-	if (r) {
-		pr_err("Cannot request LCD GPIOs, error %d\n", r);
-		return;
-	}
-
-	omap_display_init(&sdp2430_dss_data);
-}
-
 #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91x_MODULE)
 
 static struct omap_smc91x_platform_data board_smc91x_data = {
@@ -271,7 +240,7 @@ static void __init omap_2430sdp_init(void)
 	gpio_request_one(SECONDARY_LCD_GPIO, GPIOF_OUT_INIT_LOW,
 			 "Secondary LCD backlight");
 
-	sdp2430_display_init();
+	omap_display_init(&sdp2430_dss_data);
 }
 
 MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
-- 
1.7.9.5

