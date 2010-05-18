From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 08/14] OMAP2: Devkit8000: Use the REGULATOR_SUPPLY macro
Date: Tue, 18 May 2010 14:05:29 +0200
Message-ID: <1274184335-29322-9-git-send-email-weber@corscience.de>
References: <1274184335-29322-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:50406 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757409Ab0ERMGF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:06:05 -0400
In-Reply-To: <1274184335-29322-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Thomas Weber <weber@corscience.de>

Replacing the supplies with the REGULATOR_SUPPLY macro.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |   36 +++++++++++--------------------
 1 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 543becc..4a633f8 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -158,14 +158,13 @@ static void devkit8000_panel_disable_dvi(struct omap_dss_device *dssdev)
 		gpio_set_value(dssdev->reset_gpio, 0);
 }
 
-static struct regulator_consumer_supply devkit8000_vmmc1_supply = {
-	.supply			= "vmmc",
-};
+static struct regulator_consumer_supply devkit8000_vmmc1_supply =
+	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.0");
+
 
 /* ads7846 on SPI */
-static struct regulator_consumer_supply devkit8000_vio_supplies[] = {
-	REGULATOR_SUPPLY("vcc", "spi2.0")
-};
+static struct regulator_consumer_supply devkit8000_vio_supply =
+	REGULATOR_SUPPLY("vcc", "spi2.0");
 
 static struct omap_dss_device devkit8000_lcd_device = {
 	.name                   = "lcd",
@@ -214,10 +213,8 @@ static struct platform_device devkit8000_dss_device = {
 	},
 };
 
-static struct regulator_consumer_supply devkit8000_vdda_dac_supply = {
-	.supply = "vdda_dac",
-	.dev	= &devkit8000_dss_device.dev,
-};
+static struct regulator_consumer_supply devkit8000_vdda_dac_supply =
+	REGULATOR_SUPPLY("vdda_dac", "omapdss");
 
 static int board_keymap[] = {
 	KEY(0, 0, KEY_1),
@@ -262,9 +259,6 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 	mmc[0].gpio_cd = gpio + 0;
 	omap2_hsmmc_init(mmc);
 
-	/* link regulators to MMC adapters */
-	devkit8000_vmmc1_supply.dev = mmc[0].dev;
-
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
@@ -294,12 +288,8 @@ static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 	.setup		= devkit8000_twl_gpio_setup,
 };
 
-static struct regulator_consumer_supply devkit8000_vpll1_supplies[] = {
-	{
-	.supply		= "vdds_dsi",
-	.dev		= &devkit8000_dss_device.dev,
-	}
-};
+static struct regulator_consumer_supply devkit8000_vpll1_supply =
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss");
 
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
 static struct regulator_init_data devkit8000_vmmc1 = {
@@ -340,8 +330,8 @@ static struct regulator_init_data devkit8000_vpll1 = {
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies	= ARRAY_SIZE(devkit8000_vpll1_supplies),
-	.consumer_supplies	= devkit8000_vpll1_supplies,
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &devkit8000_vpll1_supply,
 };
 
 /* VAUX4 for ads7846 and nubs */
@@ -355,8 +345,8 @@ static struct regulator_init_data devkit8000_vio = {
 		.valid_ops_mask         = REGULATOR_CHANGE_MODE
 			| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies  = ARRAY_SIZE(devkit8000_vio_supplies),
-	.consumer_supplies      = devkit8000_vio_supplies,
+	.num_consumer_supplies  = 1,
+	.consumer_supplies      = &devkit8000_vio_supply,
 };
 
 static struct twl4030_usb_data devkit8000_usb_data = {
-- 
1.6.4.4

