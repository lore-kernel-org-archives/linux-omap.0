From: Archit Taneja <archit@ti.com>
Subject: [PATCH 08/33] arm: omap: board-ldp: use generic dpi panel's gpio handling
Date: Wed, 13 Feb 2013 19:52:00 +0530
Message-ID: <1360765345-19312-9-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39911 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755963Ab3BMOXi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:23:38 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>, Tony Lindgren <tony@atomide.com>

The ldp board file currently requests gpios required to configure the NEC DPI
panel, and provides platform_enable/disable callbacks to configure them.

These tasks have been moved to the generic dpi panel driver itself and shouldn't
be done in the board files.

Remove the gpio requests and the platform callbacks from the board file.
Configure the gpio information in generic dpi panel's platform data so that it's
passed to the panel driver.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/board-ldp.c |   61 ++++++---------------------------------
 1 file changed, 9 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 68e56f1..c88d01a 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -180,34 +180,13 @@ static inline void __init ldp_init_smsc911x(void)
 
 /* LCD */
 
-static int ldp_backlight_gpio;
-static int ldp_lcd_enable_gpio;
-
 #define LCD_PANEL_RESET_GPIO		55
 #define LCD_PANEL_QVGA_GPIO		56
 
-static int ldp_panel_enable_lcd(struct omap_dss_device *dssdev)
-{
-	if (gpio_is_valid(ldp_lcd_enable_gpio))
-		gpio_direction_output(ldp_lcd_enable_gpio, 1);
-	if (gpio_is_valid(ldp_backlight_gpio))
-		gpio_direction_output(ldp_backlight_gpio, 1);
-
-	return 0;
-}
-
-static void ldp_panel_disable_lcd(struct omap_dss_device *dssdev)
-{
-	if (gpio_is_valid(ldp_lcd_enable_gpio))
-		gpio_direction_output(ldp_lcd_enable_gpio, 0);
-	if (gpio_is_valid(ldp_backlight_gpio))
-		gpio_direction_output(ldp_backlight_gpio, 0);
-}
-
 static struct panel_generic_dpi_data ldp_panel_data = {
 	.name			= "nec_nl2432dr22-11b",
-	.platform_enable	= ldp_panel_enable_lcd,
-	.platform_disable	= ldp_panel_disable_lcd,
+	.num_gpios		= 4,
+	/* gpios filled in code */
 };
 
 static struct omap_dss_device ldp_lcd_device = {
@@ -230,41 +209,19 @@ static struct omap_dss_board_info ldp_dss_data = {
 
 static void __init ldp_display_init(void)
 {
-	int r;
-
-	static struct gpio gpios[] __initdata = {
-		{LCD_PANEL_RESET_GPIO, GPIOF_OUT_INIT_HIGH, "LCD RESET"},
-		{LCD_PANEL_QVGA_GPIO, GPIOF_OUT_INIT_HIGH, "LCD QVGA"},
-	};
-
-	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
-	if (r) {
-		pr_err("Cannot request LCD GPIOs, error %d\n", r);
-		return;
-	}
+	ldp_panel_data.gpios[2] = LCD_PANEL_RESET_GPIO;
+	ldp_panel_data.gpios[3] = LCD_PANEL_QVGA_GPIO;
 
 	omap_display_init(&ldp_dss_data);
 }
 
 static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
 {
-	int r;
-
-	struct gpio gpios[] = {
-		{gpio + 7 , GPIOF_OUT_INIT_LOW, "LCD ENABLE"},
-		{gpio + 15, GPIOF_OUT_INIT_LOW, "LCD BACKLIGHT"},
-	};
-
-	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
-	if (r) {
-		pr_err("Cannot request LCD GPIOs, error %d\n", r);
-		ldp_backlight_gpio = -EINVAL;
-		ldp_lcd_enable_gpio = -EINVAL;
-		return r;
-	}
-
-	ldp_backlight_gpio = gpio + 15;
-	ldp_lcd_enable_gpio = gpio + 7;
+	ldp_panel_data.gpios[0] = gpio + 7;
+	ldp_panel_data.gpio_invert[0] = true;
+
+	ldp_panel_data.gpios[1] = gpio + 15;
+	ldp_panel_data.gpio_invert[1] = true;
 
 	return 0;
 }
-- 
1.7.9.5

