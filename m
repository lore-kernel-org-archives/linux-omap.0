From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 3/3] Regulator: Added board-dependent code for TPS65023
Date: Fri,  8 May 2009 20:42:16 +0530
Message-ID: <1241795536-15758-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56455 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754485AbZEHPMX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 May 2009 11:12:23 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n48FCIQh004741
	for <linux-omap@vger.kernel.org>; Fri, 8 May 2009 10:12:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>

Added OMAP3 EVM specific code for TPS65023 in pmic.c file.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 drivers/regulator/pmic.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/pmic.c b/drivers/regulator/pmic.c
index 36ed341..6e7276a 100644
--- a/drivers/regulator/pmic.c
+++ b/drivers/regulator/pmic.c
@@ -29,6 +29,96 @@
 /*
  * Definitions specific to TPS65023
  */
+#if defined(CONFIG_OMAP3EVM_TPS65023)
+/* MPU voltage regulator of DCDC type */
+struct regulator_consumer_supply tps65023_mpu_consumers = {
+	.supply = "vdd1",
+};
+
+/* CORE voltage regulator of DCDC type */
+struct regulator_consumer_supply tps65023_core_consumers = {
+	.supply = "vdd2",
+};
+
+/* SRAM/MEM/WKUP_BG voltage regulator of DCDC type */
+struct regulator_consumer_supply tps65023_vdds_consumers = {
+	.supply = "vdds",
+};
+
+/* DPLL voltage regulator of LDO type */
+struct regulator_consumer_supply tps65023_dpll_consumers = {
+	.supply = "dpll",
+};
+
+/* MMC voltage regulator of LDO type */
+struct regulator_consumer_supply tps65023_mmc_consumers = {
+	.supply = "mmc",
+};
+
+struct regulator_init_data tps65023_regulator_data[] = {
+	{
+		.constraints = {
+			.min_uV = 800000,
+			.max_uV = 1600000,
+			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
+				REGULATOR_CHANGE_STATUS),
+			.boot_on = 1,
+		},
+		.num_consumer_supplies  = 1,
+		.consumer_supplies      = &tps65023_mpu_consumers,
+	},
+	{
+		.constraints = {
+			.min_uV = 1800000,
+			.max_uV = 3300000,
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+			.boot_on = 1,
+		},
+		.num_consumer_supplies  = 1,
+		.consumer_supplies      = &tps65023_core_consumers,
+	},
+	{
+		.constraints = {
+			.min_uV = 1800000,
+			.max_uV = 3300000,
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+			.boot_on = 1,
+		},
+		.num_consumer_supplies  = 1,
+		.consumer_supplies      = &tps65023_vdds_consumers,
+	},
+	{
+		.constraints = {
+			.min_uV = 1000000,
+			.max_uV = 3150000,
+			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
+				REGULATOR_CHANGE_STATUS),
+			.boot_on = 1,
+		},
+		.num_consumer_supplies  = 1,
+		.consumer_supplies      = &tps65023_dpll_consumers,
+	},
+	{
+		.constraints = {
+			.min_uV = 1050000,
+			.max_uV = 3300000,
+			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
+				REGULATOR_CHANGE_STATUS),
+			.boot_on = 1,
+		},
+		.num_consumer_supplies  = 1,
+		.consumer_supplies      = &tps65023_mmc_consumers,
+	},
+};
+
+static struct i2c_board_info __initdata board_tps65023_instances[] = {
+	{
+		I2C_BOARD_INFO("tps65023", 0x48),
+		.flags = I2C_CLIENT_WAKE,
+		.platform_data = &tps65023_regulator_data[0],
+	},
+};
+#endif

 static int flag_pmic_twl4030;
 static int flag_pmic_tps6235x;
@@ -96,6 +186,8 @@ int pmic_init(void)

 #if defined(CONFIG_OMAP3EVM_TPS65023)
 	/* do stuff specific to TPS65023 */
+	omap_register_i2c_bus(1, 400, board_tps65023_instances,
+		ARRAY_SIZE(board_tps65023_instances));
 #endif

 	return 0;
--
1.6.2.4

