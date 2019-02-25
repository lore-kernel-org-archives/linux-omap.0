From: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Subject: [PATCH v2 2/2] regulator: tps65218: add support for LS2
Date: Mon, 25 Feb 2019 07:41:06 +0100
Message-ID: <1551076866-12578-3-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1551076866-12578-1-git-send-email-Christian.Hohnstaedt@wago.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551076866-12578-1-git-send-email-Christian.Hohnstaedt@wago.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: J Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Re-use the "tps65218_pmic_*_current_limit()" functions of LS3
and calculate the different required bit-shift by counting the
trailing 0s in "struct regulator_desc.csel_mask"

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
---
 drivers/regulator/tps65218-regulator.c | 18 +++++++++++++-----
 include/linux/mfd/tps65218.h           |  3 ++-
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index 5dd559e..95708d3 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -205,7 +205,8 @@ static int tps65218_pmic_set_input_current_lim(struct regulator_dev *dev,
 		return -EINVAL;
 
 	return tps65218_set_bits(tps, dev->desc->csel_reg, dev->desc->csel_mask,
-				 index << 2, TPS65218_PROTECT_L1);
+				 index << __builtin_ctz(dev->desc->csel_mask),
+				 TPS65218_PROTECT_L1);
 }
 
 static int tps65218_pmic_set_current_limit(struct regulator_dev *dev,
@@ -224,7 +225,8 @@ static int tps65218_pmic_set_current_limit(struct regulator_dev *dev,
 		return -EINVAL;
 
 	return tps65218_set_bits(tps, dev->desc->csel_reg, dev->desc->csel_mask,
-				 index << 2, TPS65218_PROTECT_L1);
+				 index << __builtin_ctz(dev->desc->csel_mask),
+				 TPS65218_PROTECT_L1);
 }
 
 static int tps65218_pmic_get_current_limit(struct regulator_dev *dev)
@@ -237,12 +239,13 @@ static int tps65218_pmic_get_current_limit(struct regulator_dev *dev)
 	if (retval < 0)
 		return retval;
 
-	index = (index & dev->desc->csel_mask) >> 2;
+	index = (index & dev->desc->csel_mask) >>
+					 __builtin_ctz(dev->desc->csel_mask);
 
 	return ls3_currents[index];
 }
 
-static struct regulator_ops tps65218_ls3_ops = {
+static struct regulator_ops tps65218_ls23_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65218_pmic_enable,
 	.disable		= tps65218_pmic_disable,
@@ -304,8 +307,13 @@ static const struct regulator_desc regulators[] = {
 			   TPS65218_ENABLE2_LDO1_EN, 0, 0, ldo1_dcdc3_ranges,
 			   2, 0, 0, TPS65218_REG_SEQ6,
 			   TPS65218_SEQ6_LDO1_SEQ_MASK),
+	TPS65218_REGULATOR("LS2", "regulator-ls2", TPS65218_LS_2,
+			   REGULATOR_CURRENT, tps65218_ls23_ops, 0, 0, 0,
+			   TPS65218_REG_ENABLE2, TPS65218_ENABLE2_LS2_EN,
+			   TPS65218_REG_CONFIG2, TPS65218_CONFIG2_LS2ILIM_MASK,
+			   NULL, 0, 0, 0, 0, 0),
 	TPS65218_REGULATOR("LS3", "regulator-ls3", TPS65218_LS_3,
-			   REGULATOR_CURRENT, tps65218_ls3_ops, 0, 0, 0,
+			   REGULATOR_CURRENT, tps65218_ls23_ops, 0, 0, 0,
 			   TPS65218_REG_ENABLE2, TPS65218_ENABLE2_LS3_EN,
 			   TPS65218_REG_CONFIG2, TPS65218_CONFIG2_LS3ILIM_MASK,
 			   NULL, 0, 0, 0, 0, 0),
diff --git a/include/linux/mfd/tps65218.h b/include/linux/mfd/tps65218.h
index 3cbe103..b0470c3 100644
--- a/include/linux/mfd/tps65218.h
+++ b/include/linux/mfd/tps65218.h
@@ -212,6 +212,7 @@ enum tps65218_regulator_id {
 	/* LDOs */
 	TPS65218_LDO_1,
 	/* LS's */
+	TPS65218_LS_2,
 	TPS65218_LS_3,
 };
 
@@ -222,7 +223,7 @@ enum tps65218_regulator_id {
 /* Number of LDO voltage regulators available */
 #define TPS65218_NUM_LDO		1
 /* Number of total LS current regulators available */
-#define TPS65218_NUM_LS			1
+#define TPS65218_NUM_LS			2
 /* Number of total regulators available */
 #define TPS65218_NUM_REGULATOR		(TPS65218_NUM_DCDC + TPS65218_NUM_LDO \
 					 + TPS65218_NUM_LS)
-- 
2.7.4
