From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] twl6030: regulator: Remove vsel tables and use formula for calculation
Date: Thu, 22 Apr 2010 14:18:32 +0530
Message-ID: <1271926112-7700-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51964 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841Ab0DVIsq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Apr 2010 04:48:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

All twl6030 regulators can be programmed from 1.0v to 3.3v
with 100mV steps.
The below formula can be used to calculate the vsel values
to be programmed in the VREG_VOLTAGE registers.

Voltage(in mV) = 1000mv + 100mv * (vsel - 1)

Ex: if vsel = 0x9, mV = 1000 + 100 * (9 -1) = 1800mV.

This patch removes all existing VSEL tables for twl6030 adjustable
regulators and just uses the formula directly for vsel calculations
after verifing they fall in the allowed range.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/regulator/twl-regulator.c |  138 ++++++++++++++++++++++++-------------
 1 files changed, 91 insertions(+), 47 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 9729d76..7e5892e 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -49,6 +49,7 @@ struct twlreg_info {
 
 	/* chip constraints on regulator behavior */
 	u16			min_mV;
+	u16			max_mV;
 
 	/* used by regulator core */
 	struct regulator_desc	desc;
@@ -318,31 +319,8 @@ static const u16 VIO_VSEL_table[] = {
 static const u16 VINTANA2_VSEL_table[] = {
 	2500, 2750,
 };
-static const u16 VAUX1_6030_VSEL_table[] = {
-	1000, 1300, 1800, 2500,
-	2800, 2900, 3000, 3000,
-};
-static const u16 VAUX2_6030_VSEL_table[] = {
-	1200, 1800, 2500, 2750,
-	2800, 2800, 2800, 2800,
-};
-static const u16 VAUX3_6030_VSEL_table[] = {
-	1000, 1200, 1300, 1800,
-	2500, 2800, 3000, 3000,
-};
-static const u16 VMMC_VSEL_table[] = {
-	1200, 1800, 2800, 2900,
-	3000, 3000, 3000, 3000,
-};
-static const u16 VPP_VSEL_table[] = {
-	1800, 1900, 2000, 2100,
-	2200, 2300, 2400, 2500,
-};
-static const u16 VUSIM_VSEL_table[] = {
-	1200, 1800, 2500, 2900,
-};
 
-static int twlldo_list_voltage(struct regulator_dev *rdev, unsigned index)
+static int twl4030ldo_list_voltage(struct regulator_dev *rdev, unsigned index)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
 	int			mV = info->table[index];
@@ -351,7 +329,7 @@ static int twlldo_list_voltage(struct regulator_dev *rdev, unsigned index)
 }
 
 static int
-twlldo_set_voltage(struct regulator_dev *rdev, int min_uV, int max_uV)
+twl4030ldo_set_voltage(struct regulator_dev *rdev, int min_uV, int max_uV)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
 	int			vsel;
@@ -375,7 +353,7 @@ twlldo_set_voltage(struct regulator_dev *rdev, int min_uV, int max_uV)
 	return -EDOM;
 }
 
-static int twlldo_get_voltage(struct regulator_dev *rdev)
+static int twl4030ldo_get_voltage(struct regulator_dev *rdev)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
 	int		vsel = twlreg_read(info, TWL_MODULE_PM_RECEIVER,
@@ -388,11 +366,67 @@ static int twlldo_get_voltage(struct regulator_dev *rdev)
 	return LDO_MV(info->table[vsel]) * 1000;
 }
 
-static struct regulator_ops twlldo_ops = {
-	.list_voltage	= twlldo_list_voltage,
+static struct regulator_ops twl4030ldo_ops = {
+	.list_voltage	= twl4030ldo_list_voltage,
 
-	.set_voltage	= twlldo_set_voltage,
-	.get_voltage	= twlldo_get_voltage,
+	.set_voltage	= twl4030ldo_set_voltage,
+	.get_voltage	= twl4030ldo_get_voltage,
+
+	.enable		= twlreg_enable,
+	.disable	= twlreg_disable,
+	.is_enabled	= twlreg_is_enabled,
+
+	.set_mode	= twlreg_set_mode,
+
+	.get_status	= twlreg_get_status,
+};
+
+static int twl6030ldo_list_voltage(struct regulator_dev *rdev, unsigned index)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+
+	return ((info->min_mV + (index * 100)) * 1000);
+}
+
+static int
+twl6030ldo_set_voltage(struct regulator_dev *rdev, int min_uV, int max_uV)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+	int			vsel;
+
+	if ((min_uV/1000 < info->min_mV) || (max_uV/1000 > info->max_mV))
+		return -EDOM;
+
+	/*
+	 * Use the below formula to calculate vsel
+	 * mV = 1000mv + 100mv * (vsel - 1)
+	 */
+	vsel = (min_uV/1000 - 1000)/100 + 1;
+	return twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE, vsel);
+
+}
+
+static int twl6030ldo_get_voltage(struct regulator_dev *rdev)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+	int		vsel = twlreg_read(info, TWL_MODULE_PM_RECEIVER,
+								VREG_VOLTAGE);
+
+	if (vsel < 0)
+		return vsel;
+
+	/*
+	 * Use the below formula to calculate vsel
+	 * mV = 1000mv + 100mv * (vsel - 1)
+	 */
+	return (1000 + (100 * (vsel - 1))) * 1000;
+}
+
+static struct regulator_ops twl6030ldo_ops = {
+	.list_voltage	= twl6030ldo_list_voltage,
+
+	.set_voltage	= twl6030ldo_set_voltage,
+	.get_voltage	= twl6030ldo_get_voltage,
 
 	.enable		= twlreg_enable,
 	.disable	= twlreg_disable,
@@ -438,24 +472,16 @@ static struct regulator_ops twlfixed_ops = {
 
 /*----------------------------------------------------------------------*/
 
-#define TWL4030_ADJUSTABLE_LDO(label, offset, num, turnon_delay, remap_conf) \
-		TWL_ADJUSTABLE_LDO(label, offset, num, turnon_delay, \
-			remap_conf, TWL4030)
 #define TWL4030_FIXED_LDO(label, offset, mVolts, num, turnon_delay, \
 			remap_conf) \
 		TWL_FIXED_LDO(label, offset, mVolts, num, turnon_delay, \
 			remap_conf, TWL4030)
-#define TWL6030_ADJUSTABLE_LDO(label, offset, num, turnon_delay, \
-			remap_conf) \
-		TWL_ADJUSTABLE_LDO(label, offset, num, turnon_delay, \
-			remap_conf, TWL6030)
 #define TWL6030_FIXED_LDO(label, offset, mVolts, num, turnon_delay, \
 			remap_conf) \
 		TWL_FIXED_LDO(label, offset, mVolts, num, turnon_delay, \
 			remap_conf, TWL6030)
 
-#define TWL_ADJUSTABLE_LDO(label, offset, num, turnon_delay, remap_conf, \
-		family) { \
+#define TWL4030_ADJUSTABLE_LDO(label, offset, num, turnon_delay, remap_conf) { \
 	.base = offset, \
 	.id = num, \
 	.table_len = ARRAY_SIZE(label##_VSEL_table), \
@@ -464,14 +490,32 @@ static struct regulator_ops twlfixed_ops = {
 	.remap = remap_conf, \
 	.desc = { \
 		.name = #label, \
-		.id = family##_REG_##label, \
+		.id = TWL4030_REG_##label, \
 		.n_voltages = ARRAY_SIZE(label##_VSEL_table), \
-		.ops = &twlldo_ops, \
+		.ops = &twl4030ldo_ops, \
 		.type = REGULATOR_VOLTAGE, \
 		.owner = THIS_MODULE, \
 		}, \
 	}
 
+#define TWL6030_ADJUSTABLE_LDO(label, offset, min_mVolts, max_mVolts, num, \
+		remap_conf) { \
+	.base = offset, \
+	.id = num, \
+	.min_mV = min_mVolts, \
+	.max_mV = max_mVolts, \
+	.remap = remap_conf, \
+	.desc = { \
+		.name = #label, \
+		.id = TWL6030_REG_##label, \
+		.n_voltages = (max_mVolts - min_mVolts)/100, \
+		.ops = &twl6030ldo_ops, \
+		.type = REGULATOR_VOLTAGE, \
+		.owner = THIS_MODULE, \
+		}, \
+	}
+
+
 #define TWL_FIXED_LDO(label, offset, mVolts, num, turnon_delay, remap_conf, \
 		family) { \
 	.base = offset, \
@@ -519,12 +563,12 @@ static struct twlreg_info twl_regs[] = {
 	/* 6030 REG with base as PMC Slave Misc : 0x0030 */
 	/* Turnon-delay and remap configuration values for 6030 are not
 	   verified since the specification is not public */
-	TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1, 0, 0x21),
-	TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 2, 0, 0x21),
-	TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 3, 0, 0x21),
-	TWL6030_ADJUSTABLE_LDO(VMMC, 0x68, 4, 0, 0x21),
-	TWL6030_ADJUSTABLE_LDO(VPP, 0x6c, 5, 0, 0x21),
-	TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74, 7, 0, 0x21),
+	TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1000, 3300, 1, 0x21),
+	TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 1000, 3300, 2, 0x21),
+	TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 1000, 3300, 3, 0x21),
+	TWL6030_ADJUSTABLE_LDO(VMMC, 0x68, 1000, 3300, 4, 0x21),
+	TWL6030_ADJUSTABLE_LDO(VPP, 0x6c, 1000, 3300, 5, 0x21),
+	TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74, 1000, 3300, 7, 0x21),
 	TWL6030_FIXED_LDO(VANA, 0x50, 2100, 15, 0, 0x21),
 	TWL6030_FIXED_LDO(VCXIO, 0x60, 1800, 16, 0, 0x21),
 	TWL6030_FIXED_LDO(VDAC, 0x64, 1800, 17, 0, 0x21),
-- 
1.5.4.7

