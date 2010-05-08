From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 3/6] Devkit8000: Remove nonexisting vsim
Date: Sat,  8 May 2010 06:31:20 +0200
Message-ID: <1273293083-24063-4-git-send-email-weber@corscience.de>
References: <1273293083-24063-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:46206 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab0EHEbr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 May 2010 00:31:47 -0400
In-Reply-To: <1273293083-24063-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>

The Devkit8000 uses the cost reduced variant tps65930 of the
twl4030. The TPS65930 only has vdd1, vdd2, vpll1, vio, vmmc1,
vdac and vaux2. Vaux2 is not used on Devkit8000 board.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |   21 ---------------------
 1 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index e557bae..85adf54 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -164,10 +164,6 @@ static struct regulator_consumer_supply devkit8000_vmmc1_supply = {
 	.supply			= "vmmc",
 };
 
-static struct regulator_consumer_supply devkit8000_vsim_supply = {
-	.supply			= "vmmc_aux",
-};
-
 /* ads7846 on SPI */
 static struct regulator_consumer_supply devkit8000_vio_supplies[] = {
 	REGULATOR_SUPPLY("vcc", "spi2.0")
@@ -270,7 +266,6 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 
 	/* link regulators to MMC adapters */
 	devkit8000_vmmc1_supply.dev = mmc[0].dev;
-	devkit8000_vsim_supply.dev = mmc[0].dev;
 
 	return 0;
 }
@@ -308,21 +303,6 @@ static struct regulator_init_data devkit8000_vmmc1 = {
 	.consumer_supplies	= &devkit8000_vmmc1_supply,
 };
 
-/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card == max 50 mA) */
-static struct regulator_init_data devkit8000_vsim = {
-	.constraints = {
-		.min_uV			= 1800000,
-		.max_uV			= 3000000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &devkit8000_vsim_supply,
-};
-
 /* VDAC for DSS driving S-Video (8 mA unloaded, max 65 mA) */
 static struct regulator_init_data devkit8000_vdac = {
 	.constraints = {
@@ -388,7 +368,6 @@ static struct twl4030_platform_data devkit8000_twldata = {
 	.gpio		= &devkit8000_gpio_data,
 	.codec		= &devkit8000_codec_data,
 	.vmmc1		= &devkit8000_vmmc1,
-	.vsim		= &devkit8000_vsim,
 	.vdac		= &devkit8000_vdac,
 	.vpll1		= &devkit8000_vpll1,
 	.vio		= &devkit8000_vio,
-- 
1.6.4.4

