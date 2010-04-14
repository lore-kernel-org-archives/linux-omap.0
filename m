From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH 04/12] AM3517: Add platform init code for regulator driver
Date: Wed, 14 Apr 2010 16:30:17 +0800
Message-ID: <1271233822-27286-5-git-send-email-stanley.miao@windriver.com>
References: <1271233822-27286-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:34889 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027Ab0DNIVu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Apr 2010 04:21:50 -0400
In-Reply-To: <1271233822-27286-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com

Add platform init code for regulator driver.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |  122 +++++++++++++++++++++++++++++++++
 1 files changed, 122 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 5abf333..2d7fd08 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -22,6 +22,7 @@
 #include <linux/gpio.h>
 #include <linux/davinci_emac.h>
 #include <linux/i2c/pca953x.h>
+#include <linux/regulator/machine.h>
 
 #include <mach/hardware.h>
 #include <mach/am35xx.h>
@@ -159,6 +160,122 @@ static struct i2c_board_info __initdata am3517evm_i2c1_boardinfo[] = {
 	},
 };
 
+/* TPS65023 specific initialization */
+/* VDCDC1 -> VDD_CORE */
+static struct regulator_consumer_supply am3517_evm_vdcdc1_supplies[] = {
+	{
+		.supply = "vdd_core",
+	},
+};
+
+/* VDCDC2 -> VDDSHV */
+static struct regulator_consumer_supply am3517_evm_vdcdc2_supplies[] = {
+	{
+		.supply = "vddshv",
+	},
+};
+
+/* VDCDC2 |-> VDDS
+	   |-> VDDS_SRAM_CORE_BG
+	   |-> VDDS_SRAM_MPU */
+static struct regulator_consumer_supply am3517_evm_vdcdc3_supplies[] = {
+	{
+		.supply = "vdds",
+	},
+	{
+		.supply = "vdds_sram_core_bg",
+	},
+	{
+		.supply = "vdds_sram_mpu",
+	},
+};
+
+/* LDO1 |-> VDDA1P8V_USBPHY
+	 |-> VDDA_DAC */
+static struct regulator_consumer_supply am3517_evm_ldo1_supplies[] = {
+	{
+		.supply = "vdda1p8v_usbphy",
+	},
+	{
+		.supply = "vdda_dac",
+	},
+};
+
+/* LDO2 -> VDDA3P3V_USBPHY */
+static struct regulator_consumer_supply am3517_evm_ldo2_supplies[] = {
+	{
+		.supply = "vdda3p3v_usbphy",
+	},
+};
+
+static struct regulator_init_data am3517_evm_regulator_data[] = {
+	/* DCDC1 */
+	{
+		.constraints = {
+			.min_uV = 1200000,
+			.max_uV = 1200000,
+			.valid_modes_mask = REGULATOR_MODE_NORMAL,
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+			.always_on = true,
+			.apply_uV = false,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(am3517_evm_vdcdc1_supplies),
+		.consumer_supplies = am3517_evm_vdcdc1_supplies,
+	},
+	/* DCDC2 */
+	{
+		.constraints = {
+			.min_uV = 3300000,
+			.max_uV = 3300000,
+			.valid_modes_mask = REGULATOR_MODE_NORMAL,
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+			.always_on = true,
+			.apply_uV = false,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(am3517_evm_vdcdc2_supplies),
+		.consumer_supplies = am3517_evm_vdcdc2_supplies,
+	},
+	/* DCDC3 */
+	{
+		.constraints = {
+			.min_uV = 1800000,
+			.max_uV = 1800000,
+			.valid_modes_mask = REGULATOR_MODE_NORMAL,
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+			.always_on = true,
+			.apply_uV = false,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(am3517_evm_vdcdc3_supplies),
+		.consumer_supplies = am3517_evm_vdcdc3_supplies,
+	},
+	/* LDO1 */
+	{
+		.constraints = {
+			.min_uV = 1800000,
+			.max_uV = 1800000,
+			.valid_modes_mask = REGULATOR_MODE_NORMAL,
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+			.always_on = false,
+			.apply_uV = false,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(am3517_evm_ldo1_supplies),
+		.consumer_supplies = am3517_evm_ldo1_supplies,
+	},
+	/* LDO2 */
+	{
+		.constraints = {
+			.min_uV = 3300000,
+			.max_uV = 3300000,
+			.valid_modes_mask = REGULATOR_MODE_NORMAL,
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+			.always_on = false,
+			.apply_uV = false,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(am3517_evm_ldo2_supplies),
+		.consumer_supplies = am3517_evm_ldo2_supplies,
+	},
+};
+
 /*
  * RTC - S35390A
  */
@@ -216,6 +333,11 @@ static struct i2c_board_info __initdata am3517evm_i2c3_boardinfo[] = {
 		I2C_BOARD_INFO("tca6416", 0x21),
 		.platform_data = &am3517evm_ui_gpio_expander_info_2,
 	},
+	{
+		I2C_BOARD_INFO("tps65023", 0x48),
+		.flags = I2C_CLIENT_WAKE,
+		.platform_data = &am3517_evm_regulator_data[0],
+	},
 };
 
 static int __init am3517_evm_i2c_init(void)
-- 
1.5.4.3

