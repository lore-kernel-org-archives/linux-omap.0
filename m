From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 4/6] Devkit8000: Using the REGULATOR_SUPPLY macro
Date: Sat,  8 May 2010 06:31:21 +0200
Message-ID: <1273293083-24063-5-git-send-email-weber@corscience.de>
References: <1273293083-24063-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:50649 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab0EHEbs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 May 2010 00:31:48 -0400
In-Reply-To: <1273293083-24063-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>

Replacing the supplies with the REGULATOR_SUPPLY macro.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |   27 ++++++++++-----------------
 1 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 85adf54..c0905b0 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -165,9 +165,8 @@ static struct regulator_consumer_supply devkit8000_vmmc1_supply = {
 };
 
 /* ads7846 on SPI */
-static struct regulator_consumer_supply devkit8000_vio_supplies[] = {
-	REGULATOR_SUPPLY("vcc", "spi2.0")
-};
+static struct regulator_consumer_supply devkit8000_vio_supply =
+	REGULATOR_SUPPLY("vcc", "spi2.0");
 
 static struct omap_dss_device devkit8000_lcd_device = {
 	.name                   = "lcd",
@@ -216,10 +215,8 @@ static struct platform_device devkit8000_dss_device = {
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
@@ -281,12 +278,8 @@ static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
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
@@ -327,8 +320,8 @@ static struct regulator_init_data devkit8000_vpll1 = {
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies	= ARRAY_SIZE(devkit8000_vpll1_supplies),
-	.consumer_supplies	= devkit8000_vpll1_supplies,
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &devkit8000_vpll1_supply,
 };
 
 /* VAUX4 for ads7846 and nubs */
@@ -342,8 +335,8 @@ static struct regulator_init_data devkit8000_vio = {
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

