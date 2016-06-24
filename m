From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 1/5] regulator: tps65217: Enable suspend configuration
Date: Fri, 24 Jun 2016 13:58:07 +0530
Message-ID: <1466756892-17015-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, tony@atomide.com, broonie@kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, russ.dill@ti.com, j-keerthy@ti.com, Russ Dill <Russ.Dill@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Russ Dill <Russ.Dill@ti.com>

The TPS65217 has a pre-defined power-up / power-down sequence which in
a typical application does not need to be changed. However, it is possible
to define custom sequences under I2C control. The power-up sequence is
defined by strobes and delay times. Each output rail is assigned to a
strobe to determine the order in which the rails are enabled.

Every regulator of tps65217 PMIC has sequence registers and every
regulator has a default strobe value and gets disabled when a particular
power down sequence occurs.

To keep a regulator on during suspend we write value 0 to strobe so
that the regulator is out of all sequencers and is not impacted by any
power down sequence. Hence saving the default strobe value during probe
so that when we want to regulator to be enabled during suspend we write 0
to strobe and when we want it to get disabled during suspend we write
the default saved strobe value.

This allows platform data to specify which power rails should be on or off
during RTC only suspend. This is necessary to keep DDR state while in RTC
only suspend.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
[Enhanced commit log and added dynamic allocation for strobes]
Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * Enhanced commit log.
  * Added dynamic allocation for strobes instead of a static array.

 drivers/regulator/tps65217-regulator.c | 69 +++++++++++++++++++++++++++++-----
 include/linux/mfd/tps65217.h           |  1 +
 2 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
index adbe4fc..2d12b9a 100644
--- a/drivers/regulator/tps65217-regulator.c
+++ b/drivers/regulator/tps65217-regulator.c
@@ -28,7 +28,7 @@
 #include <linux/mfd/tps65217.h>
 
 #define TPS65217_REGULATOR(_name, _id, _of_match, _ops, _n, _vr, _vm, _em, \
-                           _t, _lr, _nlr) \
+			   _t, _lr, _nlr,  _sr, _sm)	\
 	{						\
 		.name		= _name,		\
 		.id		= _id,			\
@@ -45,6 +45,8 @@
 		.volt_table	= _t,			\
 		.linear_ranges	= _lr,			\
 		.n_linear_ranges = _nlr,		\
+		.bypass_reg	= _sr,			\
+		.bypass_mask	= _sm,			\
 	}						\
 
 static const unsigned int LDO1_VSEL_table[] = {
@@ -118,6 +120,35 @@ static int tps65217_pmic_set_voltage_sel(struct regulator_dev *dev,
 	return ret;
 }
 
+static int tps65217_pmic_set_suspend_enable(struct regulator_dev *dev)
+{
+	struct tps65217 *tps = rdev_get_drvdata(dev);
+	unsigned int rid = rdev_get_id(dev);
+
+	if (rid < TPS65217_DCDC_1 || rid > TPS65217_LDO_4)
+		return -EINVAL;
+
+	return tps65217_clear_bits(tps, dev->desc->bypass_reg,
+				   dev->desc->bypass_mask,
+				   TPS65217_PROTECT_L1);
+}
+
+static int tps65217_pmic_set_suspend_disable(struct regulator_dev *dev)
+{
+	struct tps65217 *tps = rdev_get_drvdata(dev);
+	unsigned int rid = rdev_get_id(dev);
+
+	if (rid < TPS65217_DCDC_1 || rid > TPS65217_LDO_4)
+		return -EINVAL;
+
+	if (!tps->strobes[rid])
+		return -EINVAL;
+
+	return tps65217_set_bits(tps, dev->desc->bypass_reg,
+				 dev->desc->bypass_mask,
+				 tps->strobes[rid], TPS65217_PROTECT_L1);
+}
+
 /* Operations permitted on DCDCx, LDO2, LDO3 and LDO4 */
 static struct regulator_ops tps65217_pmic_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -127,6 +158,8 @@ static struct regulator_ops tps65217_pmic_ops = {
 	.set_voltage_sel	= tps65217_pmic_set_voltage_sel,
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
+	.set_suspend_enable	= tps65217_pmic_set_suspend_enable,
+	.set_suspend_disable	= tps65217_pmic_set_suspend_disable,
 };
 
 /* Operations permitted on LDO1 */
@@ -138,41 +171,50 @@ static struct regulator_ops tps65217_pmic_ldo1_ops = {
 	.set_voltage_sel	= tps65217_pmic_set_voltage_sel,
 	.list_voltage		= regulator_list_voltage_table,
 	.map_voltage		= regulator_map_voltage_ascend,
+	.set_suspend_enable	= tps65217_pmic_set_suspend_enable,
+	.set_suspend_disable	= tps65217_pmic_set_suspend_disable,
 };
 
 static const struct regulator_desc regulators[] = {
 	TPS65217_REGULATOR("DCDC1", TPS65217_DCDC_1, "dcdc1",
 			   tps65217_pmic_ops, 64, TPS65217_REG_DEFDCDC1,
 			   TPS65217_DEFDCDCX_DCDC_MASK, TPS65217_ENABLE_DC1_EN,
-			   NULL, tps65217_uv1_ranges, 2),
+			   NULL, tps65217_uv1_ranges, 2, TPS65217_REG_SEQ1,
+			   TPS65217_SEQ1_DC1_SEQ_MASK),
 	TPS65217_REGULATOR("DCDC2", TPS65217_DCDC_2, "dcdc2",
 			   tps65217_pmic_ops, 64, TPS65217_REG_DEFDCDC2,
 			   TPS65217_DEFDCDCX_DCDC_MASK, TPS65217_ENABLE_DC2_EN,
 			   NULL, tps65217_uv1_ranges,
-			   ARRAY_SIZE(tps65217_uv1_ranges)),
+			   ARRAY_SIZE(tps65217_uv1_ranges), TPS65217_REG_SEQ1,
+			   TPS65217_SEQ1_DC2_SEQ_MASK),
 	TPS65217_REGULATOR("DCDC3", TPS65217_DCDC_3, "dcdc3",
 			   tps65217_pmic_ops, 64, TPS65217_REG_DEFDCDC3,
 			   TPS65217_DEFDCDCX_DCDC_MASK, TPS65217_ENABLE_DC3_EN,
-			   NULL, tps65217_uv1_ranges, 1),
+			   NULL, tps65217_uv1_ranges, 1, TPS65217_REG_SEQ2,
+			   TPS65217_SEQ2_DC3_SEQ_MASK),
 	TPS65217_REGULATOR("LDO1", TPS65217_LDO_1, "ldo1",
 			   tps65217_pmic_ldo1_ops, 16, TPS65217_REG_DEFLDO1,
 			   TPS65217_DEFLDO1_LDO1_MASK, TPS65217_ENABLE_LDO1_EN,
-			   LDO1_VSEL_table, NULL, 0),
+			   LDO1_VSEL_table, NULL, 0, TPS65217_REG_SEQ2,
+			   TPS65217_SEQ2_LDO1_SEQ_MASK),
 	TPS65217_REGULATOR("LDO2", TPS65217_LDO_2, "ldo2", tps65217_pmic_ops,
 			   64, TPS65217_REG_DEFLDO2,
 			   TPS65217_DEFLDO2_LDO2_MASK, TPS65217_ENABLE_LDO2_EN,
 			   NULL, tps65217_uv1_ranges,
-			   ARRAY_SIZE(tps65217_uv1_ranges)),
+			   ARRAY_SIZE(tps65217_uv1_ranges), TPS65217_REG_SEQ3,
+			   TPS65217_SEQ3_LDO2_SEQ_MASK),
 	TPS65217_REGULATOR("LDO3", TPS65217_LDO_3, "ldo3", tps65217_pmic_ops,
 			   32, TPS65217_REG_DEFLS1, TPS65217_DEFLDO3_LDO3_MASK,
 			   TPS65217_ENABLE_LS1_EN | TPS65217_DEFLDO3_LDO3_EN,
 			   NULL, tps65217_uv2_ranges,
-			   ARRAY_SIZE(tps65217_uv2_ranges)),
+			   ARRAY_SIZE(tps65217_uv2_ranges), TPS65217_REG_SEQ3,
+			   TPS65217_SEQ3_LDO3_SEQ_MASK),
 	TPS65217_REGULATOR("LDO4", TPS65217_LDO_4, "ldo4", tps65217_pmic_ops,
 			   32, TPS65217_REG_DEFLS2, TPS65217_DEFLDO4_LDO4_MASK,
 			   TPS65217_ENABLE_LS2_EN | TPS65217_DEFLDO4_LDO4_EN,
 			   NULL, tps65217_uv2_ranges,
-			   ARRAY_SIZE(tps65217_uv2_ranges)),
+			   ARRAY_SIZE(tps65217_uv2_ranges), TPS65217_REG_SEQ4,
+			   TPS65217_SEQ4_LDO4_SEQ_MASK),
 };
 
 static int tps65217_regulator_probe(struct platform_device *pdev)
@@ -181,13 +223,18 @@ static int tps65217_regulator_probe(struct platform_device *pdev)
 	struct tps65217_board *pdata = dev_get_platdata(tps->dev);
 	struct regulator_dev *rdev;
 	struct regulator_config config = { };
-	int i;
+	int i, ret;
+	unsigned int val;
 
 	if (tps65217_chip_id(tps) != TPS65217) {
 		dev_err(&pdev->dev, "Invalid tps chip version\n");
 		return -ENODEV;
 	}
 
+	/* Allocate memory for strobes */
+	tps->strobes = devm_kzalloc(&pdev->dev, sizeof(u8) *
+				    TPS65217_NUM_REGULATOR, GFP_KERNEL);
+
 	platform_set_drvdata(pdev, tps);
 
 	for (i = 0; i < TPS65217_NUM_REGULATOR; i++) {
@@ -205,6 +252,10 @@ static int tps65217_regulator_probe(struct platform_device *pdev)
 				pdev->name);
 			return PTR_ERR(rdev);
 		}
+
+		/* Store default strobe info */
+		ret = tps65217_reg_read(tps, regulators[i].bypass_reg, &val);
+		tps->strobes[i] = val & regulators[i].bypass_mask;
 	}
 
 	return 0;
diff --git a/include/linux/mfd/tps65217.h b/include/linux/mfd/tps65217.h
index ac7fba4..1c88231 100644
--- a/include/linux/mfd/tps65217.h
+++ b/include/linux/mfd/tps65217.h
@@ -257,6 +257,7 @@ struct tps65217 {
 	unsigned long id;
 	struct regulator_desc desc[TPS65217_NUM_REGULATOR];
 	struct regmap *regmap;
+	u8 *strobes;
 };
 
 static inline struct tps65217 *dev_to_tps65217(struct device *dev)
-- 
1.9.1
