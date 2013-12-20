From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 1/2] regulator: tps65910: Add backup battery regulator
Date: Fri, 20 Dec 2013 12:43:27 +0100
Message-ID: <1387539808-24910-2-git-send-email-mpa@pengutronix.de>
References: <1387539808-24910-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42999 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957Ab3LTLnl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Dec 2013 06:43:41 -0500
In-Reply-To: <1387539808-24910-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

tps65910 has a backup battery charger with a configurable voltage. This
patch adds a regulator for the backup battery.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 Documentation/devicetree/bindings/mfd/tps65910.txt |  4 +-
 drivers/regulator/tps65910-regulator.c             | 56 +++++++++++++++++++++-
 include/linux/mfd/tps65910.h                       |  3 +-
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/tps65910.txt b/Documentation/devicetree/bindings/mfd/tps65910.txt
index 2e33048..b4bd98a 100644
--- a/Documentation/devicetree/bindings/mfd/tps65910.txt
+++ b/Documentation/devicetree/bindings/mfd/tps65910.txt
@@ -21,7 +21,7 @@ Required properties:
 
   The valid regulator-compatible values are:
   tps65910: vrtc, vio, vdd1, vdd2, vdd3, vdig1, vdig2, vpll, vdac, vaux1,
-            vaux2, vaux33, vmmc
+            vaux2, vaux33, vmmc, vbb
   tps65911: vrtc, vio, vdd1, vdd3, vddctrl, ldo1, ldo2, ldo3, ldo4, ldo5,
             ldo6, ldo7, ldo8
 
@@ -38,7 +38,7 @@ Required properties:
 	vcc4-supply: VAUX1 and VAUX2 input.
 	vcc5-supply: VPLL and VDAC input.
 	vcc6-supply: VDIG1 and VDIG2 input.
-	vcc7-supply: VRTC input.
+	vcc7-supply: VRTC and VBB input.
 	vccio-supply: VIO input.
   tps65911:
 	vcc1-supply: VDD1 input.
diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index a00132e..979ea0a 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -88,6 +88,11 @@ static const unsigned int VMMC_VSEL_table[] = {
 	1800000, 2800000, 3000000, 3300000,
 };
 
+/* supported BBCH voltages in microvolts */
+static const unsigned int VBB_VSEL_table[] = {
+	3000000, 2520000, 3150000, 5000000,
+};
+
 struct tps_info {
 	const char *name;
 	const char *vin_name;
@@ -183,6 +188,12 @@ static struct tps_info tps65910_regs[] = {
 		.voltage_table = VMMC_VSEL_table,
 		.enable_time_us = 100,
 	},
+	{
+		.name = "vbb",
+		.vin_name = "vcc7",
+		.n_voltages = ARRAY_SIZE(VBB_VSEL_table),
+		.voltage_table = VBB_VSEL_table,
+	},
 };
 
 static struct tps_info tps65911_regs[] = {
@@ -339,6 +350,8 @@ static int tps65910_get_ctrl_register(int id)
 		return TPS65910_VAUX33;
 	case TPS65910_REG_VMMC:
 		return TPS65910_VMMC;
+	case TPS65910_REG_VBB:
+		return TPS65910_BBCH;
 	default:
 		return -EINVAL;
 	}
@@ -528,6 +541,10 @@ static int tps65910_get_voltage_sel(struct regulator_dev *dev)
 		value &= LDO_SEL_MASK;
 		value >>= LDO_SEL_SHIFT;
 		break;
+	case TPS65910_REG_VBB:
+		value &= BBCH_BBSEL_MASK;
+		value >>= BBCH_BBSEL_SHIFT;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -638,6 +655,9 @@ static int tps65910_set_voltage_sel(struct regulator_dev *dev,
 	case TPS65910_REG_VMMC:
 		return tps65910_reg_update_bits(pmic->mfd, reg, LDO_SEL_MASK,
 						selector << LDO_SEL_SHIFT);
+	case TPS65910_REG_VBB:
+		return tps65910_reg_update_bits(pmic->mfd, reg, BBCH_BBSEL_MASK,
+						selector << BBCH_BBSEL_SHIFT);
 	}
 
 	return -EINVAL;
@@ -669,6 +689,9 @@ static int tps65911_set_voltage_sel(struct regulator_dev *dev,
 	case TPS65910_REG_VIO:
 		return tps65910_reg_update_bits(pmic->mfd, reg, LDO_SEL_MASK,
 						selector << LDO_SEL_SHIFT);
+	case TPS65910_REG_VBB:
+		return tps65910_reg_update_bits(pmic->mfd, reg, BBCH_BBSEL_MASK,
+						selector << BBCH_BBSEL_SHIFT);
 	}
 
 	return -EINVAL;
@@ -762,6 +785,18 @@ static struct regulator_ops tps65910_ops_vdd3 = {
 	.map_voltage		= regulator_map_voltage_ascend,
 };
 
+static struct regulator_ops tps65910_ops_vbb = {
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.set_mode		= tps65910_set_mode,
+	.get_mode		= tps65910_get_mode,
+	.get_voltage_sel	= tps65910_get_voltage_sel,
+	.set_voltage_sel	= tps65910_set_voltage_sel,
+	.list_voltage		= regulator_list_voltage_table,
+	.map_voltage		= regulator_map_voltage_iterate,
+};
+
 static struct regulator_ops tps65910_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
@@ -944,6 +979,7 @@ static struct of_regulator_match tps65910_matches[] = {
 	{ .name = "vaux2",	.driver_data = (void *) &tps65910_regs[10] },
 	{ .name = "vaux33",	.driver_data = (void *) &tps65910_regs[11] },
 	{ .name = "vmmc",	.driver_data = (void *) &tps65910_regs[12] },
+	{ .name = "vbb",	.driver_data = (void *) &tps65910_regs[13] },
 };
 
 static struct of_regulator_match tps65911_matches[] = {
@@ -1145,6 +1181,10 @@ static int tps65910_probe(struct platform_device *pdev)
 				pmic->desc[i].ops = &tps65910_ops_dcdc;
 				pmic->desc[i].ramp_delay = 5000;
 			}
+		} else if (i == TPS65910_REG_VBB &&
+				tps65910_chip_id(tps65910) == TPS65910) {
+			pmic->desc[i].ops = &tps65910_ops_vbb;
+			pmic->desc[i].volt_table = info->voltage_table;
 		} else {
 			if (tps65910_chip_id(tps65910) == TPS65910) {
 				pmic->desc[i].ops = &tps65910_ops;
@@ -1167,7 +1207,21 @@ static int tps65910_probe(struct platform_device *pdev)
 		pmic->desc[i].type = REGULATOR_VOLTAGE;
 		pmic->desc[i].owner = THIS_MODULE;
 		pmic->desc[i].enable_reg = pmic->get_ctrl_reg(i);
-		pmic->desc[i].enable_mask = TPS65910_SUPPLY_STATE_ENABLED;
+
+		switch (i) {
+		case TPS65910_REG_VBB:
+			if (tps65910_chip_id(tps65910) == TPS65910)
+				pmic->desc[i].enable_mask = BBCH_BBCHEN_MASK;
+			else
+				pmic->desc[i].enable_mask =
+					TPS65910_SUPPLY_STATE_ENABLED;
+			break;
+
+		default:
+			pmic->desc[i].enable_mask =
+				TPS65910_SUPPLY_STATE_ENABLED;
+			break;
+		}
 
 		config.dev = tps65910->dev;
 		config.init_data = reg_data;
diff --git a/include/linux/mfd/tps65910.h b/include/linux/mfd/tps65910.h
index 20e433e..1adeee1 100644
--- a/include/linux/mfd/tps65910.h
+++ b/include/linux/mfd/tps65910.h
@@ -833,6 +833,7 @@
 #define TPS65910_REG_VAUX2				10
 #define TPS65910_REG_VAUX33				11
 #define TPS65910_REG_VMMC				12
+#define TPS65910_REG_VBB				13
 
 #define TPS65911_REG_VDDCTRL				4
 #define TPS65911_REG_LDO1				5
@@ -845,7 +846,7 @@
 #define TPS65911_REG_LDO8				12
 
 /* Max number of TPS65910/11 regulators */
-#define TPS65910_NUM_REGS				13
+#define TPS65910_NUM_REGS				14
 
 /* External sleep controls through EN1/EN2/EN3/SLEEP inputs */
 #define TPS65910_SLEEP_CONTROL_EXT_INPUT_EN1		0x1
-- 
1.8.5.1

