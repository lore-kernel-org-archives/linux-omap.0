From: Nikita Kiryanov <nikita@compulab.co.il>
Subject: [PATCH] regulator: tps65218: add support for LS3 current regulator
Date: Wed, 25 Nov 2015 13:59:04 +0200
Message-ID: <1448452744-17126-1-git-send-email-nikita@compulab.co.il>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Nikita Kiryanov <nikita@compulab.co.il>, Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

Add support for TPS65218 LS3 current regulator, which is capable of 4
current input limit modes: 100, 200, 500, and 1000 uA.

Signed-off-by: Nikita Kiryanov <nikita@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/tps65218-regulator.c | 137 +++++++++++++++++++++++++--------
 include/linux/mfd/tps65218.h           |   7 +-
 include/linux/regulator/driver.h       |   2 +
 3 files changed, 115 insertions(+), 31 deletions(-)

diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index 7f97223..d88eb57 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -27,19 +27,22 @@
 #include <linux/regulator/machine.h>
 #include <linux/mfd/tps65218.h>
 
-enum tps65218_regulators { DCDC1, DCDC2, DCDC3, DCDC4, DCDC5, DCDC6, LDO1 };
+enum tps65218_regulators { DCDC1, DCDC2, DCDC3, DCDC4,
+			   DCDC5, DCDC6, LDO1, LS3 };
 
-#define TPS65218_REGULATOR(_name, _id, _ops, _n, _vr, _vm, _er, _em, \
-			    _lr, _nlr, _delay, _fuv)		\
+#define TPS65218_REGULATOR(_name, _id, _type, _ops, _n, _vr, _vm, _er, _em, \
+			    _cr, _cm, _lr, _nlr, _delay, _fuv)		\
 	{							\
 		.name			= _name,		\
 		.id			= _id,			\
 		.ops			= &_ops,		\
 		.n_voltages		= _n,			\
-		.type			= REGULATOR_VOLTAGE,	\
+		.type			= _type,	\
 		.owner			= THIS_MODULE,		\
 		.vsel_reg		= _vr,			\
 		.vsel_mask		= _vm,			\
+		.csel_reg		= _cr,			\
+		.csel_mask		= _cm,			\
 		.enable_reg		= _er,			\
 		.enable_mask		= _em,			\
 		.volt_table		= NULL,			\
@@ -80,6 +83,7 @@ static struct tps_info tps65218_pmic_regs[] = {
 	TPS65218_INFO(DCDC5, "DCDC5", 1000000, 1000000),
 	TPS65218_INFO(DCDC6, "DCDC6", 1800000, 1800000),
 	TPS65218_INFO(LDO1, "LDO1", 900000, 3400000),
+	TPS65218_INFO(LS3, "LS3", -1, -1),
 };
 
 #define TPS65218_OF_MATCH(comp, label) \
@@ -96,6 +100,7 @@ static const struct of_device_id tps65218_of_match[] = {
 	TPS65218_OF_MATCH("ti,tps65218-dcdc5", tps65218_pmic_regs[DCDC5]),
 	TPS65218_OF_MATCH("ti,tps65218-dcdc6", tps65218_pmic_regs[DCDC6]),
 	TPS65218_OF_MATCH("ti,tps65218-ldo1", tps65218_pmic_regs[LDO1]),
+	TPS65218_OF_MATCH("ti,tps65218-ls3", tps65218_pmic_regs[LS3]),
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tps65218_of_match);
@@ -175,6 +180,68 @@ static struct regulator_ops tps65218_ldo1_dcdc34_ops = {
 	.map_voltage		= regulator_map_voltage_linear_range,
 };
 
+static const int ls3_currents[] = { 100, 200, 500, 1000 };
+
+static int tps65218_pmic_set_input_current_lim(struct regulator_dev *dev,
+					       int lim_uA)
+{
+	unsigned int index = 0;
+	unsigned int num_currents = ARRAY_SIZE(ls3_currents);
+	struct tps65218 *tps = rdev_get_drvdata(dev);
+
+	while (index < num_currents && ls3_currents[index] != lim_uA)
+		index++;
+
+	if (index == num_currents)
+		return -EINVAL;
+
+	return tps65218_set_bits(tps, dev->desc->csel_reg, dev->desc->csel_mask,
+				 index << 2, TPS65218_PROTECT_L1);
+}
+
+static int tps65218_pmic_set_current_limit(struct regulator_dev *dev,
+					   int min_uA, int max_uA)
+{
+	int index = 0;
+	unsigned int num_currents = ARRAY_SIZE(ls3_currents);
+	struct tps65218 *tps = rdev_get_drvdata(dev);
+
+	while (index < num_currents && ls3_currents[index] < max_uA)
+		index++;
+
+	index--;
+
+	if (index < 0 || ls3_currents[index] < min_uA)
+		return -EINVAL;
+
+	return tps65218_set_bits(tps, dev->desc->csel_reg, dev->desc->csel_mask,
+				 index << 2, TPS65218_PROTECT_L1);
+}
+
+static int tps65218_pmic_get_current_limit(struct regulator_dev *dev)
+{
+	int retval;
+	unsigned int index;
+	struct tps65218 *tps = rdev_get_drvdata(dev);
+
+	retval = tps65218_reg_read(tps, dev->desc->csel_reg, &index);
+	if (retval < 0)
+		return retval;
+
+	index = (index & dev->desc->csel_mask) >> 2;
+
+	return ls3_currents[index];
+}
+
+static struct regulator_ops tps65218_ls3_ops = {
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= tps65218_pmic_enable,
+	.disable		= tps65218_pmic_disable,
+	.set_input_current_limit = tps65218_pmic_set_input_current_lim,
+	.set_current_limit	= tps65218_pmic_set_current_limit,
+	.get_current_limit	= tps65218_pmic_get_current_limit,
+};
+
 /* Operations permitted on DCDC5, DCDC6 */
 static struct regulator_ops tps65218_dcdc56_pmic_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -183,36 +250,46 @@ static struct regulator_ops tps65218_dcdc56_pmic_ops = {
 };
 
 static const struct regulator_desc regulators[] = {
-	TPS65218_REGULATOR("DCDC1", TPS65218_DCDC_1, tps65218_dcdc12_ops, 64,
-			   TPS65218_REG_CONTROL_DCDC1,
-			   TPS65218_CONTROL_DCDC1_MASK,
-			   TPS65218_REG_ENABLE1, TPS65218_ENABLE1_DC1_EN,
-			   dcdc1_dcdc2_ranges, 2, 4000, 0),
-	TPS65218_REGULATOR("DCDC2", TPS65218_DCDC_2, tps65218_dcdc12_ops, 64,
-			   TPS65218_REG_CONTROL_DCDC2,
-			   TPS65218_CONTROL_DCDC2_MASK,
-			   TPS65218_REG_ENABLE1, TPS65218_ENABLE1_DC2_EN,
-			   dcdc1_dcdc2_ranges, 2, 4000, 0),
-	TPS65218_REGULATOR("DCDC3", TPS65218_DCDC_3, tps65218_ldo1_dcdc34_ops,
-			   64, TPS65218_REG_CONTROL_DCDC3,
+	TPS65218_REGULATOR("DCDC1", TPS65218_DCDC_1, REGULATOR_VOLTAGE,
+			   tps65218_dcdc12_ops, 64, TPS65218_REG_CONTROL_DCDC1,
+			   TPS65218_CONTROL_DCDC1_MASK, TPS65218_REG_ENABLE1,
+			   TPS65218_ENABLE1_DC1_EN, 0, 0, dcdc1_dcdc2_ranges,
+			   2, 4000, 0),
+	TPS65218_REGULATOR("DCDC2", TPS65218_DCDC_2, REGULATOR_VOLTAGE,
+			   tps65218_dcdc12_ops, 64, TPS65218_REG_CONTROL_DCDC2,
+			   TPS65218_CONTROL_DCDC2_MASK, TPS65218_REG_ENABLE1,
+			   TPS65218_ENABLE1_DC2_EN, 0, 0, dcdc1_dcdc2_ranges,
+			   2, 4000, 0),
+	TPS65218_REGULATOR("DCDC3", TPS65218_DCDC_3, REGULATOR_VOLTAGE,
+			   tps65218_ldo1_dcdc34_ops, 64,
+			   TPS65218_REG_CONTROL_DCDC3,
 			   TPS65218_CONTROL_DCDC3_MASK, TPS65218_REG_ENABLE1,
-			   TPS65218_ENABLE1_DC3_EN, ldo1_dcdc3_ranges, 2, 0, 0),
-	TPS65218_REGULATOR("DCDC4", TPS65218_DCDC_4, tps65218_ldo1_dcdc34_ops,
-			   53, TPS65218_REG_CONTROL_DCDC4,
-			   TPS65218_CONTROL_DCDC4_MASK,
-			   TPS65218_REG_ENABLE1, TPS65218_ENABLE1_DC4_EN,
-			   dcdc4_ranges, 2, 0, 0),
-	TPS65218_REGULATOR("DCDC5", TPS65218_DCDC_5, tps65218_dcdc56_pmic_ops,
-			   1, -1, -1, TPS65218_REG_ENABLE1,
-			   TPS65218_ENABLE1_DC5_EN, NULL, 0, 0, 1000000),
-	TPS65218_REGULATOR("DCDC6", TPS65218_DCDC_6, tps65218_dcdc56_pmic_ops,
-			   1, -1, -1, TPS65218_REG_ENABLE1,
-			   TPS65218_ENABLE1_DC6_EN, NULL, 0, 0, 1800000),
-	TPS65218_REGULATOR("LDO1", TPS65218_LDO_1, tps65218_ldo1_dcdc34_ops, 64,
+			   TPS65218_ENABLE1_DC3_EN, 0, 0, ldo1_dcdc3_ranges, 2,
+			   0, 0),
+	TPS65218_REGULATOR("DCDC4", TPS65218_DCDC_4, REGULATOR_VOLTAGE,
+			   tps65218_ldo1_dcdc34_ops, 53,
+			   TPS65218_REG_CONTROL_DCDC4,
+			   TPS65218_CONTROL_DCDC4_MASK, TPS65218_REG_ENABLE1,
+			   TPS65218_ENABLE1_DC4_EN, 0, 0, dcdc4_ranges, 2,
+			   0, 0),
+	TPS65218_REGULATOR("DCDC5", TPS65218_DCDC_5, REGULATOR_VOLTAGE,
+			   tps65218_dcdc56_pmic_ops, 1, -1, -1,
+			   TPS65218_REG_ENABLE1, TPS65218_ENABLE1_DC5_EN, 0, 0,
+			   NULL, 0, 0, 1000000),
+	TPS65218_REGULATOR("DCDC6", TPS65218_DCDC_6, REGULATOR_VOLTAGE,
+			   tps65218_dcdc56_pmic_ops, 1, -1, -1,
+			   TPS65218_REG_ENABLE1, TPS65218_ENABLE1_DC6_EN, 0, 0,
+			   NULL, 0, 0, 1800000),
+	TPS65218_REGULATOR("LDO1", TPS65218_LDO_1, REGULATOR_VOLTAGE,
+			   tps65218_ldo1_dcdc34_ops, 64,
 			   TPS65218_REG_CONTROL_LDO1,
 			   TPS65218_CONTROL_LDO1_MASK, TPS65218_REG_ENABLE2,
-			   TPS65218_ENABLE2_LDO1_EN, ldo1_dcdc3_ranges,
+			   TPS65218_ENABLE2_LDO1_EN, 0, 0, ldo1_dcdc3_ranges,
 			   2, 0, 0),
+	TPS65218_REGULATOR("LS3", TPS65218_LS_3, REGULATOR_CURRENT,
+			   tps65218_ls3_ops, 0, 0, 0, TPS65218_REG_ENABLE2,
+			   TPS65218_ENABLE2_LS3_EN, TPS65218_REG_CONFIG2,
+			   TPS65218_CONFIG2_LS3ILIM_MASK, NULL, 0, 0, 0),
 };
 
 static int tps65218_regulator_probe(struct platform_device *pdev)
diff --git a/include/linux/mfd/tps65218.h b/include/linux/mfd/tps65218.h
index 2f9b593..d58f3b5 100644
--- a/include/linux/mfd/tps65218.h
+++ b/include/linux/mfd/tps65218.h
@@ -200,6 +200,8 @@ enum tps65218_regulator_id {
 	TPS65218_DCDC_4,
 	TPS65218_DCDC_5,
 	TPS65218_DCDC_6,
+	/* LS's */
+	TPS65218_LS_3,
 	/* LDOs */
 	TPS65218_LDO_1,
 };
@@ -210,8 +212,11 @@ enum tps65218_regulator_id {
 #define TPS65218_NUM_DCDC		6
 /* Number of LDO voltage regulators available */
 #define TPS65218_NUM_LDO		1
+/* Number of total LS current regulators available */
+#define TPS65218_NUM_LS			1
 /* Number of total regulators available */
-#define TPS65218_NUM_REGULATOR		(TPS65218_NUM_DCDC + TPS65218_NUM_LDO)
+#define TPS65218_NUM_REGULATOR		(TPS65218_NUM_DCDC + TPS65218_NUM_LDO \
+					 + TPS65218_NUM_LS)
 
 /* Define the TPS65218 IRQ numbers */
 enum tps65218_irqs {
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 4db9fbe..fe77709 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -299,6 +299,8 @@ struct regulator_desc {
 
 	unsigned int vsel_reg;
 	unsigned int vsel_mask;
+	unsigned int csel_reg;
+	unsigned int csel_mask;
 	unsigned int apply_reg;
 	unsigned int apply_bit;
 	unsigned int enable_reg;
-- 
1.9.1
