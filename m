From: Kan-Ru Chen <kanru@0xlab.org>
Subject: [PATCH 1/2] Enable DVI-D output for Devkit8000
Date: Wed,  7 Apr 2010 16:34:26 +0800
Message-ID: <1270629267-27068-1-git-send-email-kanru@0xlab.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cp20.secserverpros.com ([67.220.217.187]:57413 "EHLO
	cp20.secserverpros.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab0DGIeM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 04:34:12 -0400
Received: from 61-30-10-70.static.tfn.net.tw ([61.30.10.70] helo=kanru.info)
	by cp20.secserverpros.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <kanru@kanru.info>)
	id 1NzQi7-0005Ii-Tw
	for linux-omap@vger.kernel.org; Wed, 07 Apr 2010 08:34:11 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kan-Ru Chen <kanru@0xlab.org>, Thomas Weber <weber@corscience.de>

This patch corrects the DVI-D output setup of Devkit8000

Devkit8000 has different DVI reset pin with the BeagleBoard. On Devkit8000
the TWL4030 GPIO_7 is assigned to do the job.

Signed-off-by: Kan-Ru Chen <kanru@0xlab.org>
---
 arch/arm/mach-omap2/board-devkit8000.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 5bfc13b..fd4454a 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -141,13 +141,18 @@ static int devkit8000_panel_enable_lcd(struct omap_dss_device *dssdev)
 static void devkit8000_panel_disable_lcd(struct omap_dss_device *dssdev)
 {
 }
+
 static int devkit8000_panel_enable_dvi(struct omap_dss_device *dssdev)
 {
+	if (dssdev->reset_gpio != -EINVAL)
+		gpio_set_value(dssdev->reset_gpio, 1);
 	return 0;
 }
 
 static void devkit8000_panel_disable_dvi(struct omap_dss_device *dssdev)
 {
+	if (dssdev->reset_gpio != -EINVAL)
+		gpio_set_value(dssdev->reset_gpio, 0);
 }
 
 static int devkit8000_panel_enable_tv(struct omap_dss_device *dssdev)
@@ -183,6 +188,7 @@ static struct omap_dss_device devkit8000_dvi_device = {
 	.driver_name            = "generic_panel",
 	.type                   = OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines     = 24,
+	.reset_gpio             = -EINVAL, /* will be replaced */
 	.platform_enable        = devkit8000_panel_enable_dvi,
 	.platform_disable       = devkit8000_panel_disable_dvi,
 };
@@ -283,6 +289,12 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
+	/* gpio + 7 is "DVI_PD" (out, active low) */
+	devkit8000_dvi_device.reset_gpio = gpio + 7;
+	gpio_request(devkit8000_dvi_device.reset_gpio, "DVI PowerDown");
+	/* Disable until needed */
+	gpio_direction_output(devkit8000_dvi_device.reset_gpio, 0);
+
 	return 0;
 }
 
@@ -303,7 +315,7 @@ static struct regulator_consumer_supply devkit8000_vpll2_supplies[] = {
 	.dev		= &devkit8000_lcd_device.dev,
 	},
 	{
-	.supply		= "vdss_dsi",
+	.supply		= "vdds_dsi",
 	.dev		= &devkit8000_dss_device.dev,
 	}
 };
@@ -665,12 +677,6 @@ static void __init devkit8000_init(void)
 
 	devkit8000_ads7846_init();
 
-	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
-
-	gpio_request(170, "DVI_nPD");
-	/* REVISIT leave DVI powered down until it's needed ... */
-	gpio_direction_output(170, true);
-
 	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
 	devkit8000_flash_init();
-- 
1.7.0.4

