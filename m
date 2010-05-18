From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 01/14] OMAP2: Devkit8000: Cleanup for supplies
Date: Tue, 18 May 2010 14:05:22 +0200
Message-ID: <1274184335-29322-2-git-send-email-weber@corscience.de>
References: <1274184335-29322-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53284 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756378Ab0ERMGB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:06:01 -0400
In-Reply-To: <1274184335-29322-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Thomas Weber <weber@corscience.de>

Corrected the wrong supplies in devkit8000 code.

Add supply for ads7846 to support the new regulator framework for
touchscreen.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |   32 ++++++++++++++++++++++++++------
 1 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 6d910df..887e1a1 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -168,6 +168,10 @@ static struct regulator_consumer_supply devkit8000_vsim_supply = {
 	.supply			= "vmmc_aux",
 };
 
+/* ads7846 on SPI */
+static struct regulator_consumer_supply devkit8000_vio_supplies[] = {
+	REGULATOR_SUPPLY("vcc", "spi2.0")
+};
 
 static struct omap_dss_device devkit8000_lcd_device = {
 	.name                   = "lcd",
@@ -282,7 +286,7 @@ static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 	.setup		= devkit8000_twl_gpio_setup,
 };
 
-static struct regulator_consumer_supply devkit8000_vpll2_supplies[] = {
+static struct regulator_consumer_supply devkit8000_vpll1_supplies[] = {
 	{
 	.supply		= "vdvi",
 	.dev		= &devkit8000_lcd_device.dev,
@@ -337,8 +341,8 @@ static struct regulator_init_data devkit8000_vdac = {
 	.consumer_supplies	= &devkit8000_vdda_dac_supply,
 };
 
-/* VPLL2 for digital video outputs */
-static struct regulator_init_data devkit8000_vpll2 = {
+/* VPLL1 for digital video outputs */
+static struct regulator_init_data devkit8000_vpll1 = {
 	.constraints = {
 		.name			= "VDVI",
 		.min_uV			= 1800000,
@@ -348,8 +352,23 @@ static struct regulator_init_data devkit8000_vpll2 = {
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies	= ARRAY_SIZE(devkit8000_vpll2_supplies),
-	.consumer_supplies	= devkit8000_vpll2_supplies,
+	.num_consumer_supplies	= ARRAY_SIZE(devkit8000_vpll1_supplies),
+	.consumer_supplies	= devkit8000_vpll1_supplies,
+};
+
+/* VAUX4 for ads7846 and nubs */
+static struct regulator_init_data devkit8000_vio = {
+	.constraints = {
+		.min_uV                 = 1800000,
+		.max_uV                 = 1800000,
+		.apply_uV               = true,
+		.valid_modes_mask       = REGULATOR_MODE_NORMAL
+			| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask         = REGULATOR_CHANGE_MODE
+			| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = ARRAY_SIZE(devkit8000_vio_supplies),
+	.consumer_supplies      = devkit8000_vio_supplies,
 };
 
 static struct twl4030_usb_data devkit8000_usb_data = {
@@ -376,7 +395,8 @@ static struct twl4030_platform_data devkit8000_twldata = {
 	.vmmc1		= &devkit8000_vmmc1,
 	.vsim		= &devkit8000_vsim,
 	.vdac		= &devkit8000_vdac,
-	.vpll2		= &devkit8000_vpll2,
+	.vpll1		= &devkit8000_vpll1,
+	.vio		= &devkit8000_vio,
 	.keypad		= &devkit8000_kp_data,
 };
 
-- 
1.6.4.4

