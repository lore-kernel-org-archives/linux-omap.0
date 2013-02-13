From: Archit Taneja <archit@ti.com>
Subject: [PATCH 14/33] arm: omap: board-sdp3430: use sharp panel's gpio handling
Date: Wed, 13 Feb 2013 19:52:06 +0530
Message-ID: <1360765345-19312-15-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60094 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934095Ab3BMOX5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:23:57 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>, Tony Lindgren <tony@atomide.com>

The omap3430sdp board file currently requests gpios required by the sharp_ls dpi
panel, and provides platform_enable/disable callbacks to configure them.

These tasks have been moved to the sharp_ls panel driver itself and shouldn't
be done in the board files.

Remove the gpio requests and the platform callbacks from the board file.
Add the gpio information to panel_sharp_ls037v7dw01_data so that it's
passed to the panel driver.

Out of sharp panel's configurable pins, all apart from resb_gpio are managed by
a CPLD on the display and set to a default value. Only the configurable pin is
passed to platform data.

The backlight GPIO doesn't go directly to the sharp panel, it is used to set up
a voltage supply which goes to the LED+ pin of the panel, hence it isn't passed
to panel as platform data, and configured in the board file itself. The
backlight used to previously toggle through the platform_enable/disable
callbacks, but now it is always on. This needs to be revisited.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   42 +++++++++++++++--------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index fb75a81..13f1431 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -106,34 +106,22 @@ static struct twl4030_keypad_data sdp3430_kp_data = {
 #define SDP3430_LCD_PANEL_BACKLIGHT_GPIO	8
 #define SDP3430_LCD_PANEL_ENABLE_GPIO		5
 
-static struct gpio sdp3430_dss_gpios[] __initdata = {
-	{SDP3430_LCD_PANEL_ENABLE_GPIO,    GPIOF_OUT_INIT_LOW, "LCD reset"    },
-	{SDP3430_LCD_PANEL_BACKLIGHT_GPIO, GPIOF_OUT_INIT_LOW, "LCD Backlight"},
-};
-
 static void __init sdp3430_display_init(void)
 {
 	int r;
 
-	r = gpio_request_array(sdp3430_dss_gpios,
-			       ARRAY_SIZE(sdp3430_dss_gpios));
+	/*
+	 * the backlight GPIO doesn't directly go to the panel, it enables
+	 * an internal circuit on 3430sdp to create the signal V_BKL_28V,
+	 * this is connected to LED+ pin of the sharp panel. This GPIO
+	 * is left enabled in the board file, and not passed to the panel
+	 * as platform_data.
+	 */
+	r = gpio_request_one(SDP3430_LCD_PANEL_BACKLIGHT_GPIO,
+				GPIOF_OUT_INIT_HIGH, "LCD Backlight");
 	if (r)
-		printk(KERN_ERR "failed to get LCD control GPIOs\n");
-
-}
-
-static int sdp3430_panel_enable_lcd(struct omap_dss_device *dssdev)
-{
-	gpio_direction_output(SDP3430_LCD_PANEL_ENABLE_GPIO, 1);
-	gpio_direction_output(SDP3430_LCD_PANEL_BACKLIGHT_GPIO, 1);
-
-	return 0;
-}
+		pr_err("failed to get LCD Backlight GPIO\n");
 
-static void sdp3430_panel_disable_lcd(struct omap_dss_device *dssdev)
-{
-	gpio_direction_output(SDP3430_LCD_PANEL_ENABLE_GPIO, 0);
-	gpio_direction_output(SDP3430_LCD_PANEL_BACKLIGHT_GPIO, 0);
 }
 
 static int sdp3430_panel_enable_tv(struct omap_dss_device *dssdev)
@@ -145,14 +133,20 @@ static void sdp3430_panel_disable_tv(struct omap_dss_device *dssdev)
 {
 }
 
+static struct panel_sharp_ls037v7dw01_data sdp3430_lcd_data = {
+	.resb_gpio = SDP3430_LCD_PANEL_ENABLE_GPIO,
+	.ini_gpio = -1,
+	.mo_gpio = -1,
+	.lr_gpio = -1,
+	.ud_gpio = -1,
+};
 
 static struct omap_dss_device sdp3430_lcd_device = {
 	.name			= "lcd",
 	.driver_name		= "sharp_ls_panel",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines	= 16,
-	.platform_enable	= sdp3430_panel_enable_lcd,
-	.platform_disable	= sdp3430_panel_disable_lcd,
+	.data			= &sdp3430_lcd_data,
 };
 
 static struct tfp410_platform_data dvi_panel = {
-- 
1.7.9.5

