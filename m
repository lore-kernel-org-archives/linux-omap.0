From: Archit Taneja <archit@ti.com>
Subject: [PATCH 04/33] arm: omap: board-devkit8000: use generic dpi panel's gpio handling
Date: Wed, 13 Feb 2013 19:51:56 +0530
Message-ID: <1360765345-19312-5-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56510 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934024Ab3BMOXZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 09:23:25 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>, Tony Lindgren <tony@atomide.com>

The devkit8000 board file currently requests gpios required to configure the
innolux DPI panel, and provides platform_enable/disable callbacks to configure
them.

These tasks have been moved to the generic dpi panel driver itself and should
be removed from the board files.

Remove the gpio request and the platform callbacks from the board file.
Configure the gpio information in generic dpi panel's platform data so that it's
passed to the panel driver.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/board-devkit8000.c |   27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 019b212..ccef86d 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -102,19 +102,6 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
-static int devkit8000_panel_enable_lcd(struct omap_dss_device *dssdev)
-{
-	if (gpio_is_valid(dssdev->reset_gpio))
-		gpio_set_value_cansleep(dssdev->reset_gpio, 1);
-	return 0;
-}
-
-static void devkit8000_panel_disable_lcd(struct omap_dss_device *dssdev)
-{
-	if (gpio_is_valid(dssdev->reset_gpio))
-		gpio_set_value_cansleep(dssdev->reset_gpio, 0);
-}
-
 static struct regulator_consumer_supply devkit8000_vmmc1_supply[] = {
 	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
 };
@@ -126,8 +113,7 @@ static struct regulator_consumer_supply devkit8000_vio_supply[] = {
 
 static struct panel_generic_dpi_data lcd_panel = {
 	.name			= "innolux_at070tn83",
-	.platform_enable        = devkit8000_panel_enable_lcd,
-	.platform_disable       = devkit8000_panel_disable_lcd,
+	/* gpios filled in code */
 };
 
 static struct omap_dss_device devkit8000_lcd_device = {
@@ -209,8 +195,6 @@ static struct gpio_led gpio_leds[];
 static int devkit8000_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	int ret;
-
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
 	omap_hsmmc_late_init(mmc);
@@ -219,13 +203,8 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
 	/* TWL4030_GPIO_MAX + 0 is "LCD_PWREN" (out, active high) */
-	devkit8000_lcd_device.reset_gpio = gpio + TWL4030_GPIO_MAX + 0;
-	ret = gpio_request_one(devkit8000_lcd_device.reset_gpio,
-			       GPIOF_OUT_INIT_LOW, "LCD_PWREN");
-	if (ret < 0) {
-		devkit8000_lcd_device.reset_gpio = -EINVAL;
-		printk(KERN_ERR "Failed to request GPIO for LCD_PWRN\n");
-	}
+	lcd_panel.num_gpios = 1;
+	lcd_panel.gpios[0] = gpio + TWL4030_GPIO_MAX + 0;
 
 	/* gpio + 7 is "DVI_PD" (out, active low) */
 	dvi_panel.power_down_gpio = gpio + 7;
-- 
1.7.9.5

