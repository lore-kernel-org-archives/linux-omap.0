From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 04/14] OMAP2: Devkit8000: Setup LCD reset
Date: Tue, 18 May 2010 14:05:25 +0200
Message-ID: <1274184335-29322-5-git-send-email-weber@corscience.de>
References: <1274184335-29322-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:56252 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757420Ab0ERMGI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:06:08 -0400
In-Reply-To: <1274184335-29322-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Kan-Ru Chen <kanru@0xlab.org>, Thomas Weber <weber@corscience.de>

From: Kan-Ru Chen <kanru@0xlab.org>

This patch corrects the LCD reset pin config.

Original code from early devkit8000 patch sets the TWL4030 GPIO_1
to EHCI_nOC and TWL4030_GPIO_MAX+1 to ledA. Indeed these two pins
are both LCD_PWREN. Setup the lcd reset_gpio properly so it can be
disabled when other display is turned on.

Signed-off-by: Kan-Ru Chen <kanru@0xlab.org>
Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index c6b9ed4..37b047e 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -134,11 +134,15 @@ static int devkit8000_panel_enable_lcd(struct omap_dss_device *dssdev)
 	twl_i2c_write_u8(TWL4030_MODULE_GPIO, 0x80, REG_GPIODATADIR1);
 	twl_i2c_write_u8(TWL4030_MODULE_LED, 0x0, 0x0);
 
+	if (dssdev->reset_gpio != -EINVAL)
+		gpio_set_value(dssdev->reset_gpio, 1);
 	return 0;
 }
 
 static void devkit8000_panel_disable_lcd(struct omap_dss_device *dssdev)
 {
+	if (dssdev->reset_gpio != -EINVAL)
+		gpio_set_value(dssdev->reset_gpio, 0);
 }
 
 static int devkit8000_panel_enable_dvi(struct omap_dss_device *dssdev)
@@ -183,6 +187,7 @@ static struct omap_dss_device devkit8000_lcd_device = {
 	.driver_name            = "generic_panel",
 	.type                   = OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines     = 24,
+	.reset_gpio             = -EINVAL, /* will be replaced */
 	.platform_enable        = devkit8000_panel_enable_lcd,
 	.platform_disable       = devkit8000_panel_disable_lcd,
 };
@@ -281,6 +286,12 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
+        /* gpio + 1 is "LCD_PWREN" (out, active high) */
+	devkit8000_lcd_device.reset_gpio = gpio + 1;
+	gpio_request(devkit8000_lcd_device.reset_gpio, "LCD_PWREN");
+	/* Disable until needed */
+	gpio_direction_output(devkit8000_lcd_device.reset_gpio, 0);
+
 	/* gpio + 7 is "DVI_PD" (out, active low) */
 	devkit8000_dvi_device.reset_gpio = gpio + 7;
 	gpio_request(devkit8000_dvi_device.reset_gpio, "DVI PowerDown");
-- 
1.6.4.4

