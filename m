From: Daniel Morsing <daniel.morsing@gmail.com>
Subject: [PATCH 3/3] omap3: devkit8000: Use generic gpio for second lcd enable
Date: Fri, 14 Jan 2011 01:03:29 +0100
Message-ID: <1294963409-29891-4-git-send-email-daniel.morsing@gmail.com>
References: <1294963409-29891-1-git-send-email-daniel.morsing@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54592 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757359Ab1ANAD1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jan 2011 19:03:27 -0500
Received: by ewy5 with SMTP id 5so1230888ewy.19
        for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 16:03:26 -0800 (PST)
In-Reply-To: <1294963409-29891-1-git-send-email-daniel.morsing@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Thomas Weber <weber@corscience.de>, Daniel Morsing <daniel.morsing@gmail.com>

The Devkit8000 uses 2 gpios for the lcd enable line. twl4030_gpio1 and
twl4030_ledA, with ledA configured as an output only gpio. gpio1 is used
through the generic gpio functions while ledA is used via low level
twl4030 calls. Remove the low level calls and use the generic gpio
functions for initialization and use of ledA.

This also fixes a bug where the lcd would not power down when blanking.

Signed-off-by: Daniel Morsing <daniel.morsing@gmail.com>
---
 arch/arm/mach-omap2/board-devkit8000.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 8dc7a24..c1fdb1e 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -112,10 +112,16 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
+/* This board uses 2 gpios for the lcd reset line, so use
+ * omap_dss_device.reset_gpio for storing one and this variable
+ * for storing the other.
+ */
+static int lcd_enable_gpio = -EINVAL; /* will be replaced */
+
 static int devkit8000_panel_enable_lcd(struct omap_dss_device *dssdev)
 {
-	twl_i2c_write_u8(TWL4030_MODULE_GPIO, 0x80, REG_GPIODATADIR1);
-	twl_i2c_write_u8(TWL4030_MODULE_LED, 0x0, 0x0);
+	if (gpio_is_valid(lcd_enable_gpio))
+		gpio_set_value_cansleep(lcd_enable_gpio, 1);
 
 	if (gpio_is_valid(dssdev->reset_gpio))
 		gpio_set_value_cansleep(dssdev->reset_gpio, 1);
@@ -124,6 +130,9 @@ static int devkit8000_panel_enable_lcd(struct omap_dss_device *dssdev)
 
 static void devkit8000_panel_disable_lcd(struct omap_dss_device *dssdev)
 {
+	if (gpio_is_valid(lcd_enable_gpio))
+		gpio_set_value_cansleep(lcd_enable_gpio, 0);
+
 	if (gpio_is_valid(dssdev->reset_gpio))
 		gpio_set_value_cansleep(dssdev->reset_gpio, 0);
 }
@@ -251,6 +260,12 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 	/* Disable until needed */
 	gpio_direction_output(devkit8000_lcd_device.reset_gpio, 0);
 
+	/* TWL4030_GPIO_MAX + 0 == ledA which is also "LCD_PWREN" */
+	lcd_enable_gpio = gpio + TWL4030_GPIO_MAX + 0;
+	gpio_request(lcd_enable_gpio, "LCD_PWREN");
+	/* Disable until needed */
+	gpio_direction_output(lcd_enable_gpio, 0);
+
 	/* gpio + 7 is "DVI_PD" (out, active low) */
 	devkit8000_dvi_device.reset_gpio = gpio + 7;
 	gpio_request(devkit8000_dvi_device.reset_gpio, "DVI PowerDown");
-- 
1.7.3.4

