From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps65218: Enable suspend configuration" to the regulator tree
Date: Mon, 27 Jun 2016 18:00:49 +0100
Message-ID: <E1bHZtx-0006Ea-6p@debutante>
References: <1466412218-5906-4-git-send-email-j-keerthy@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466412218-5906-4-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Keerthy <j-keerthy@ti.com>, Mark Brown <broonie@kernel.org>, tony@atomide.combroonie@kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, russ.dill@ti.com, robh+dt@kernel.org, mark.rutland@arm.comj-keerthy@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: tps65218: Enable suspend configuration

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b9a0d359413d7f4e078d81cd59f9d851a6febb7a Mon Sep 17 00:00:00 2001
From: Tero Kristo <t-kristo@ti.com>
Date: Fri, 24 Jun 2016 13:58:08 +0530
Subject: [PATCH] regulator: tps65218: Enable suspend configuration

TPS65218 has a pre-defined power-up / power-down sequence which in
a typical application does not need to be changed. However, it is possible
to define custom sequences under I2C control. The power-up sequence is
defined by strobes and delay times. Each output rail is assigned to a
strobe to determine the order in which the rails are enabled.

Every regulator has sequence registers and every regulator has a default
strobe value and gets disabled when a particular power down sequence
occurs.

To keep a regulator on during suspend we write value 0 to strobe so
that the regulator is out of all sequencers and is not impacted by any
power down sequence. Hence saving the default strobe value during probe
so that when we want to regulator to be enabled during suspend we write 0
to strobe and when we want it to get disabled during suspend we write
the default saved strobe value.
This allows platform data to specify which power rails should be on or off
during RTC only suspend. This is necessary to keep DDR state while in RTC
only suspend.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps65218-regulator.c | 72 ++++++++++++++++++++++++++++------
 include/linux/mfd/tps65218.h           |  2 +
 2 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index a5e5634eeb9e..8eca1eb4f219 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -31,7 +31,7 @@ enum tps65218_regulators { DCDC1, DCDC2, DCDC3, DCDC4,
 			   DCDC5, DCDC6, LDO1, LS3 };
 
 #define TPS65218_REGULATOR(_name, _id, _type, _ops, _n, _vr, _vm, _er, _em, \
-			    _cr, _cm, _lr, _nlr, _delay, _fuv)		\
+			   _cr, _cm, _lr, _nlr, _delay, _fuv, _sr, _sm)	\
 	{							\
 		.name			= _name,		\
 		.id			= _id,			\
@@ -49,7 +49,9 @@ enum tps65218_regulators { DCDC1, DCDC2, DCDC3, DCDC4,
 		.linear_ranges		= _lr,			\
 		.n_linear_ranges	= _nlr,			\
 		.ramp_delay		= _delay,		\
-		.fixed_uV		= _fuv			\
+		.fixed_uV		= _fuv,			\
+		.bypass_reg	= _sr,				\
+		.bypass_mask	= _sm,				\
 	}							\
 
 #define TPS65218_INFO(_id, _nm, _min, _max)	\
@@ -157,6 +159,36 @@ static int tps65218_pmic_disable(struct regulator_dev *dev)
 				   dev->desc->enable_mask, TPS65218_PROTECT_L1);
 }
 
+static int tps65218_pmic_set_suspend_enable(struct regulator_dev *dev)
+{
+	struct tps65218 *tps = rdev_get_drvdata(dev);
+	unsigned int rid = rdev_get_id(dev);
+
+	if (rid < TPS65218_DCDC_1 || rid > TPS65218_LDO_1)
+		return -EINVAL;
+
+	return tps65218_clear_bits(tps, dev->desc->bypass_reg,
+				   dev->desc->bypass_mask,
+				   TPS65218_PROTECT_L1);
+}
+
+static int tps65218_pmic_set_suspend_disable(struct regulator_dev *dev)
+{
+	struct tps65218 *tps = rdev_get_drvdata(dev);
+	unsigned int rid = rdev_get_id(dev);
+
+	if (rid < TPS65218_DCDC_1 || rid > TPS65218_LDO_1)
+		return -EINVAL;
+
+	if (!tps->info[rid]->strobe)
+		return -EINVAL;
+
+	return tps65218_set_bits(tps, dev->desc->bypass_reg,
+				 dev->desc->bypass_mask,
+				 tps->info[rid]->strobe,
+				 TPS65218_PROTECT_L1);
+}
+
 /* Operations permitted on DCDC1, DCDC2 */
 static struct regulator_ops tps65218_dcdc12_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -167,6 +199,8 @@ static struct regulator_ops tps65218_dcdc12_ops = {
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
+	.set_suspend_enable	= tps65218_pmic_set_suspend_enable,
+	.set_suspend_disable	= tps65218_pmic_set_suspend_disable,
 };
 
 /* Operations permitted on DCDC3, DCDC4 and LDO1 */
@@ -178,6 +212,8 @@ static struct regulator_ops tps65218_ldo1_dcdc34_ops = {
 	.set_voltage_sel	= tps65218_pmic_set_voltage_sel,
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
+	.set_suspend_enable	= tps65218_pmic_set_suspend_enable,
+	.set_suspend_disable	= tps65218_pmic_set_suspend_disable,
 };
 
 static const int ls3_currents[] = { 100, 200, 500, 1000 };
@@ -247,6 +283,8 @@ static struct regulator_ops tps65218_dcdc56_pmic_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65218_pmic_enable,
 	.disable		= tps65218_pmic_disable,
+	.set_suspend_enable	= tps65218_pmic_set_suspend_enable,
+	.set_suspend_disable	= tps65218_pmic_set_suspend_disable,
 };
 
 static const struct regulator_desc regulators[] = {
@@ -254,42 +292,47 @@ static const struct regulator_desc regulators[] = {
 			   tps65218_dcdc12_ops, 64, TPS65218_REG_CONTROL_DCDC1,
 			   TPS65218_CONTROL_DCDC1_MASK, TPS65218_REG_ENABLE1,
 			   TPS65218_ENABLE1_DC1_EN, 0, 0, dcdc1_dcdc2_ranges,
-			   2, 4000, 0),
+			   2, 4000, 0, TPS65218_REG_SEQ3,
+			   TPS65218_SEQ3_DC1_SEQ_MASK),
 	TPS65218_REGULATOR("DCDC2", TPS65218_DCDC_2, REGULATOR_VOLTAGE,
 			   tps65218_dcdc12_ops, 64, TPS65218_REG_CONTROL_DCDC2,
 			   TPS65218_CONTROL_DCDC2_MASK, TPS65218_REG_ENABLE1,
 			   TPS65218_ENABLE1_DC2_EN, 0, 0, dcdc1_dcdc2_ranges,
-			   2, 4000, 0),
+			   2, 4000, 0, TPS65218_REG_SEQ3,
+			   TPS65218_SEQ3_DC2_SEQ_MASK),
 	TPS65218_REGULATOR("DCDC3", TPS65218_DCDC_3, REGULATOR_VOLTAGE,
 			   tps65218_ldo1_dcdc34_ops, 64,
 			   TPS65218_REG_CONTROL_DCDC3,
 			   TPS65218_CONTROL_DCDC3_MASK, TPS65218_REG_ENABLE1,
 			   TPS65218_ENABLE1_DC3_EN, 0, 0, ldo1_dcdc3_ranges, 2,
-			   0, 0),
+			   0, 0, TPS65218_REG_SEQ4, TPS65218_SEQ4_DC3_SEQ_MASK),
 	TPS65218_REGULATOR("DCDC4", TPS65218_DCDC_4, REGULATOR_VOLTAGE,
 			   tps65218_ldo1_dcdc34_ops, 53,
 			   TPS65218_REG_CONTROL_DCDC4,
 			   TPS65218_CONTROL_DCDC4_MASK, TPS65218_REG_ENABLE1,
 			   TPS65218_ENABLE1_DC4_EN, 0, 0, dcdc4_ranges, 2,
-			   0, 0),
+			   0, 0, TPS65218_REG_SEQ4, TPS65218_SEQ4_DC4_SEQ_MASK),
 	TPS65218_REGULATOR("DCDC5", TPS65218_DCDC_5, REGULATOR_VOLTAGE,
 			   tps65218_dcdc56_pmic_ops, 1, -1, -1,
 			   TPS65218_REG_ENABLE1, TPS65218_ENABLE1_DC5_EN, 0, 0,
-			   NULL, 0, 0, 1000000),
+			   NULL, 0, 0, 1000000, TPS65218_REG_SEQ5,
+			   TPS65218_SEQ5_DC5_SEQ_MASK),
 	TPS65218_REGULATOR("DCDC6", TPS65218_DCDC_6, REGULATOR_VOLTAGE,
 			   tps65218_dcdc56_pmic_ops, 1, -1, -1,
 			   TPS65218_REG_ENABLE1, TPS65218_ENABLE1_DC6_EN, 0, 0,
-			   NULL, 0, 0, 1800000),
+			   NULL, 0, 0, 1800000, TPS65218_REG_SEQ5,
+			   TPS65218_SEQ5_DC6_SEQ_MASK),
 	TPS65218_REGULATOR("LDO1", TPS65218_LDO_1, REGULATOR_VOLTAGE,
 			   tps65218_ldo1_dcdc34_ops, 64,
 			   TPS65218_REG_CONTROL_LDO1,
 			   TPS65218_CONTROL_LDO1_MASK, TPS65218_REG_ENABLE2,
 			   TPS65218_ENABLE2_LDO1_EN, 0, 0, ldo1_dcdc3_ranges,
-			   2, 0, 0),
+			   2, 0, 0, TPS65218_REG_SEQ6,
+			   TPS65218_SEQ6_LDO1_SEQ_MASK),
 	TPS65218_REGULATOR("LS3", TPS65218_LS_3, REGULATOR_CURRENT,
 			   tps65218_ls3_ops, 0, 0, 0, TPS65218_REG_ENABLE2,
 			   TPS65218_ENABLE2_LS3_EN, TPS65218_REG_CONFIG2,
-			   TPS65218_CONFIG2_LS3ILIM_MASK, NULL, 0, 0, 0),
+			   TPS65218_CONFIG2_LS3ILIM_MASK, NULL, 0, 0, 0, 0, 0),
 };
 
 static int tps65218_regulator_probe(struct platform_device *pdev)
@@ -300,7 +343,8 @@ static int tps65218_regulator_probe(struct platform_device *pdev)
 	struct regulator_dev *rdev;
 	const struct of_device_id	*match;
 	struct regulator_config config = { };
-	int id;
+	int id, ret;
+	unsigned int val;
 
 	match = of_match_device(tps65218_of_match, &pdev->dev);
 	if (!match)
@@ -327,6 +371,12 @@ static int tps65218_regulator_probe(struct platform_device *pdev)
 		return PTR_ERR(rdev);
 	}
 
+	ret = tps65218_reg_read(tps, regulators[id].bypass_reg, &val);
+	if (ret)
+		return ret;
+
+	tps->info[id]->strobe = val & regulators[id].bypass_mask;
+
 	return 0;
 }
 
diff --git a/include/linux/mfd/tps65218.h b/include/linux/mfd/tps65218.h
index d58f3b5f585a..7fdf5326f34e 100644
--- a/include/linux/mfd/tps65218.h
+++ b/include/linux/mfd/tps65218.h
@@ -246,6 +246,7 @@ enum tps65218_irqs {
  * @name:		Voltage regulator name
  * @min_uV:		minimum micro volts
  * @max_uV:		minimum micro volts
+ * @strobe:		sequencing strobe value for the regulator
  *
  * This data is used to check the regualtor voltage limits while setting.
  */
@@ -254,6 +255,7 @@ struct tps_info {
 	const char *name;
 	int min_uV;
 	int max_uV;
+	int strobe;
 };
 
 /**
-- 
2.8.1
