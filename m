From: Kan-Ru Chen <kanru@0xlab.org>
Subject: [PATCH 2/2] Setup LCD reset for Devkit8000
Date: Wed,  7 Apr 2010 12:09:30 +0800
Message-ID: <1270613370-4135-2-git-send-email-kanru@0xlab.org>
References: <1270613370-4135-1-git-send-email-kanru@0xlab.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cp20.secserverpros.com ([67.220.217.187]:44450 "EHLO
	cp20.secserverpros.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab0DGEdT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 00:33:19 -0400
Received: from 61-30-10-70.static.tfn.net.tw ([61.30.10.70] helo=kanru.info)
	by cp20.secserverpros.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <kanru@kanru.info>)
	id 1NzMa1-0003en-F0
	for linux-omap@vger.kernel.org; Wed, 07 Apr 2010 04:09:30 +0000
In-Reply-To: <1270613370-4135-1-git-send-email-kanru@0xlab.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kan-Ru Chen <kanru@0xlab.org>, Thomas Weber <weber@corscience.de>

This patch corrects the LCD reset pin config

Original code from early devkit8000 patch sets the TWL4030 GPIO_1
to EHCI_nOC and TWL4030_GPIO_MAX+1 to ledA. Indeed these two pins
are both LCD_PWREN. Setup the lcd reset_gpio properly so it can be
disabled when other display is turned on.

Signed-off-by: Kan-Ru Chen <kanru@0xlab.org>
---
 arch/arm/mach-omap2/board-devkit8000.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 2e7a539..b744433 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -135,11 +135,15 @@ static int devkit8000_panel_enable_lcd(struct omap_dss_device *dssdev)
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
@@ -177,9 +181,10 @@ static struct regulator_consumer_supply devkit8000_vsim_supply = {
 
 static struct omap_dss_device devkit8000_lcd_device = {
 	.name                   = "lcd",
-	.driver_name            = "innolux_at_panel",
+	.driver_name            = "generic_panel",
 	.type                   = OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines     = 24,
+	.reset_gpio             = -EINVAL, /* will be replaced */
 	.platform_enable        = devkit8000_panel_enable_lcd,
 	.platform_disable       = devkit8000_panel_disable_lcd,
 };
@@ -275,20 +280,15 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 	devkit8000_vmmc1_supply.dev = mmc[0].dev;
 	devkit8000_vsim_supply.dev = mmc[0].dev;
 
-	/* REVISIT: need ehci-omap hooks for external VBUS
-	 * power switch and overcurrent detect
-	 */
-
-	gpio_request(gpio + 1, "EHCI_nOC");
-	gpio_direction_input(gpio + 1);
-
-	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active low) */
-	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
-	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
-
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
+        /* gpio + 1 is "LCD_PWREN" (out, active low) */
+	devkit8000_lcd_device.reset_gpio = gpio + 1;
+	gpio_request(devkit8000_lcd_device.reset_gpio, "LCD_PWREN");
+	/* Disable until needed */
+	gpio_direction_output(devkit8000_lcd_device.reset_gpio, 1);
+
 	/* gpio + 7 is "DVI_PUD" (out, active low) */
 	devkit8000_dvi_device.reset_gpio = gpio + 7;
 	gpio_request(devkit8000_dvi_device.reset_gpio, "DVI_PUD");
-- 
1.7.0.4

