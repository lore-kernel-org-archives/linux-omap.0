From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 1/5] Regulator: Removing regulator f/w related code from board-omap3evm.c
Date: Thu,  5 Nov 2009 22:09:14 +0530
Message-ID: <1257439154-28009-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53835 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757578AbZKEQjR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Nov 2009 11:39:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

Regulator framework related code is being moved to a new file
board-omap35x-pmic.c. This file will contain specific information for
different regulators and platforms.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   45 ----------------------------------
 1 files changed, 0 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b9b0f4c..d526fa5 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -94,44 +94,6 @@ static inline void __init omap3evm_init_smc911x(void)
 	gpio_direction_input(OMAP3EVM_ETHR_GPIO_IRQ);
 }
 
-static struct regulator_consumer_supply omap3evm_vmmc1_supply = {
-	.supply			= "vmmc",
-};
-
-static struct regulator_consumer_supply omap3evm_vsim_supply = {
-	.supply			= "vmmc_aux",
-};
-
-/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
-static struct regulator_init_data omap3evm_vmmc1 = {
-	.constraints = {
-		.min_uV			= 1850000,
-		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &omap3evm_vmmc1_supply,
-};
-
-/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card == max 50 mA) */
-static struct regulator_init_data omap3evm_vsim = {
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
-	.consumer_supplies	= &omap3evm_vsim_supply,
-};
-
 static struct twl4030_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -165,7 +127,6 @@ static struct platform_device leds_gpio = {
 	},
 };
 
-
 static int omap3evm_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
@@ -174,10 +135,6 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 	mmc[0].gpio_cd = gpio + 0;
 	twl4030_mmc_init(mmc);
 
-	/* link regulators to MMC adapters */
-	omap3evm_vmmc1_supply.dev = mmc[0].dev;
-	omap3evm_vsim_supply.dev = mmc[0].dev;
-
 	/*
 	 * Most GPIOs are for USB OTG.  Some are mostly sent to
 	 * the P2 connector; notably LEDA for the LCD backlight.
@@ -247,8 +204,6 @@ static struct twl4030_platform_data omap3evm_twldata = {
 	.madc		= &omap3evm_madc_data,
 	.usb		= &omap3evm_usb_data,
 	.gpio		= &omap3evm_gpio_data,
-	.vmmc1		= &omap3evm_vmmc1,
-	.vsim		= &omap3evm_vsim,
 };
 
 static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
-- 
1.6.2.4

