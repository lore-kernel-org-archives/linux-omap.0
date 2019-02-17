From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: twl6030: Use regulator_list_voltage_linear_range for twl6030ldo_ops
Date: Sun, 17 Feb 2019 21:48:08 +0800
Message-ID: <20190217134809.18108-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolae Rosia <Nicolae_Rosia@mentor.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
List-Id: linux-omap@vger.kernel.org

Use linear range to replace the twl6030ldo_list_voltage implementation.
With this change, the min_mV is not used and can be removed from
struct twlreg_info.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/twl6030-regulator.c | 73 ++++++++++-----------------
 1 file changed, 27 insertions(+), 46 deletions(-)

diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index 78b964539775..dcaa6512d760 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -31,9 +31,6 @@ struct twlreg_info {
 	/* twl resource ID, for resource control state machine */
 	u8			id;
 
-	/* chip constraints on regulator behavior */
-	u16			min_mV;
-
 	u8			flags;
 
 	/* used by regulator core */
@@ -252,27 +249,6 @@ static struct regulator_ops twl6030coresmps_ops = {
 	.get_voltage	= twl6030coresmps_get_voltage,
 };
 
-static int twl6030ldo_list_voltage(struct regulator_dev *rdev, unsigned sel)
-{
-	struct twlreg_info *info = rdev_get_drvdata(rdev);
-
-	switch (sel) {
-	case 0:
-		return 0;
-	case 1 ... 24:
-		/* Linear mapping from 00000001 to 00011000:
-		 * Absolute voltage value = 1.0 V + 0.1 V × (sel – 00000001)
-		 */
-		return (info->min_mV + 100 * (sel - 1)) * 1000;
-	case 25 ... 30:
-		return -EINVAL;
-	case 31:
-		return 2750000;
-	default:
-		return -EINVAL;
-	}
-}
-
 static int
 twl6030ldo_set_voltage_sel(struct regulator_dev *rdev, unsigned selector)
 {
@@ -291,7 +267,7 @@ static int twl6030ldo_get_voltage_sel(struct regulator_dev *rdev)
 }
 
 static struct regulator_ops twl6030ldo_ops = {
-	.list_voltage	= twl6030ldo_list_voltage,
+	.list_voltage	= regulator_list_voltage_linear_range,
 
 	.set_voltage_sel = twl6030ldo_set_voltage_sel,
 	.get_voltage_sel = twl6030ldo_get_voltage_sel,
@@ -513,6 +489,11 @@ static struct regulator_ops twlsmps_ops = {
 };
 
 /*----------------------------------------------------------------------*/
+static const struct regulator_linear_range twl6030ldo_linear_range[] = {
+	REGULATOR_LINEAR_RANGE(0, 0, 0, 0),
+	REGULATOR_LINEAR_RANGE(1000000, 1, 24, 100000),
+	REGULATOR_LINEAR_RANGE(2750000, 31, 31, 0),
+};
 
 #define TWL6030_ADJUSTABLE_SMPS(label) \
 static const struct twlreg_info TWL6030_INFO_##label = { \
@@ -525,28 +506,30 @@ static const struct twlreg_info TWL6030_INFO_##label = { \
 		}, \
 	}
 
-#define TWL6030_ADJUSTABLE_LDO(label, offset, min_mVolts) \
+#define TWL6030_ADJUSTABLE_LDO(label, offset) \
 static const struct twlreg_info TWL6030_INFO_##label = { \
 	.base = offset, \
-	.min_mV = min_mVolts, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6030_REG_##label, \
 		.n_voltages = 32, \
+		.linear_ranges = twl6030ldo_linear_range, \
+		.n_linear_ranges = ARRAY_SIZE(twl6030ldo_linear_range), \
 		.ops = &twl6030ldo_ops, \
 		.type = REGULATOR_VOLTAGE, \
 		.owner = THIS_MODULE, \
 		}, \
 	}
 
-#define TWL6032_ADJUSTABLE_LDO(label, offset, min_mVolts) \
+#define TWL6032_ADJUSTABLE_LDO(label, offset) \
 static const struct twlreg_info TWL6032_INFO_##label = { \
 	.base = offset, \
-	.min_mV = min_mVolts, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6032_REG_##label, \
 		.n_voltages = 32, \
+		.linear_ranges = twl6030ldo_linear_range, \
+		.n_linear_ranges = ARRAY_SIZE(twl6030ldo_linear_range), \
 		.ops = &twl6030ldo_ops, \
 		.type = REGULATOR_VOLTAGE, \
 		.owner = THIS_MODULE, \
@@ -557,7 +540,6 @@ static const struct twlreg_info TWL6032_INFO_##label = { \
 static const struct twlreg_info TWLFIXED_INFO_##label = { \
 	.base = offset, \
 	.id = 0, \
-	.min_mV = mVolts, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6030##_REG_##label, \
@@ -574,7 +556,6 @@ static const struct twlreg_info TWLFIXED_INFO_##label = { \
 #define TWL6032_ADJUSTABLE_SMPS(label, offset) \
 static const struct twlreg_info TWLSMPS_INFO_##label = { \
 	.base = offset, \
-	.min_mV = 600, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6032_REG_##label, \
@@ -592,22 +573,22 @@ static const struct twlreg_info TWLSMPS_INFO_##label = { \
 TWL6030_ADJUSTABLE_SMPS(VDD1);
 TWL6030_ADJUSTABLE_SMPS(VDD2);
 TWL6030_ADJUSTABLE_SMPS(VDD3);
-TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1000);
-TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 1000);
-TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 1000);
-TWL6030_ADJUSTABLE_LDO(VMMC, 0x68, 1000);
-TWL6030_ADJUSTABLE_LDO(VPP, 0x6c, 1000);
-TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74, 1000);
+TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54);
+TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58);
+TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c);
+TWL6030_ADJUSTABLE_LDO(VMMC, 0x68);
+TWL6030_ADJUSTABLE_LDO(VPP, 0x6c);
+TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74);
 /* 6025 are renamed compared to 6030 versions */
-TWL6032_ADJUSTABLE_LDO(LDO2, 0x54, 1000);
-TWL6032_ADJUSTABLE_LDO(LDO4, 0x58, 1000);
-TWL6032_ADJUSTABLE_LDO(LDO3, 0x5c, 1000);
-TWL6032_ADJUSTABLE_LDO(LDO5, 0x68, 1000);
-TWL6032_ADJUSTABLE_LDO(LDO1, 0x6c, 1000);
-TWL6032_ADJUSTABLE_LDO(LDO7, 0x74, 1000);
-TWL6032_ADJUSTABLE_LDO(LDO6, 0x60, 1000);
-TWL6032_ADJUSTABLE_LDO(LDOLN, 0x64, 1000);
-TWL6032_ADJUSTABLE_LDO(LDOUSB, 0x70, 1000);
+TWL6032_ADJUSTABLE_LDO(LDO2, 0x54);
+TWL6032_ADJUSTABLE_LDO(LDO4, 0x58);
+TWL6032_ADJUSTABLE_LDO(LDO3, 0x5c);
+TWL6032_ADJUSTABLE_LDO(LDO5, 0x68);
+TWL6032_ADJUSTABLE_LDO(LDO1, 0x6c);
+TWL6032_ADJUSTABLE_LDO(LDO7, 0x74);
+TWL6032_ADJUSTABLE_LDO(LDO6, 0x60);
+TWL6032_ADJUSTABLE_LDO(LDOLN, 0x64);
+TWL6032_ADJUSTABLE_LDO(LDOUSB, 0x70);
 TWL6030_FIXED_LDO(VANA, 0x50, 2100, 0);
 TWL6030_FIXED_LDO(VCXIO, 0x60, 1800, 0);
 TWL6030_FIXED_LDO(VDAC, 0x64, 1800, 0);
-- 
2.17.1
