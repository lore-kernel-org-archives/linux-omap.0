From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH] regulator: twl6030: add support for vdd1, vdd2 and vdd3 regulators
Date: Thu, 23 Feb 2012 13:05:09 +0200
Message-ID: <1329995109-4795-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33415 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755175Ab2BWLFV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 06:05:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@ti.com>

vdd1 and vdd2 are now common regulators for twl4030 and twl6030. Also
added vdd3 as a new regulator for twl6030. twl6030 vdd1...vdd3 smps
regulator voltages can only be controlled through the smartreflex
voltage channel, thus the support for the voltage_get and set is
minimal and requires external controller.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 drivers/mfd/twl-core.c            |   15 ++++++++++++++
 drivers/regulator/twl-regulator.c |   39 +++++++++++++++++++++++++++++++++++++
 include/linux/i2c/twl.h           |    5 ++-
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index fae5f76..c788e36 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -949,6 +949,21 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 	/* twl6030 regulators */
 	if (twl_has_regulator() && twl_class_is_6030() &&
 			!(features & TWL6025_SUBCLASS)) {
+		child = add_regulator(TWL6030_REG_VDD1, pdata->vdd1,
+					features);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL6030_REG_VDD2, pdata->vdd2,
+					features);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL6030_REG_VDD3, pdata->vdd3,
+					features);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
 		child = add_regulator(TWL6030_REG_VMMC, pdata->vmmc,
 					features);
 		if (IS_ERR(child))
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 0afc9e1a..55a0e4d 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -561,6 +561,32 @@ static struct regulator_ops twl4030smps_ops = {
 	.get_voltage	= twl4030smps_get_voltage,
 };
 
+static int twl6030coresmps_set_voltage(struct regulator_dev *rdev, int min_uV,
+	int max_uV, unsigned *selector)
+{
+	struct twlreg_info *info = rdev_get_drvdata(rdev);
+
+	if (info->set_voltage)
+		return info->set_voltage(info->data, min_uV);
+
+	return 0;
+}
+
+static int twl6030coresmps_get_voltage(struct regulator_dev *rdev)
+{
+	struct twlreg_info *info = rdev_get_drvdata(rdev);
+
+	if (info->get_voltage)
+		return info->get_voltage(info->data);
+
+	return 0;
+}
+
+static struct regulator_ops twl6030coresmps_ops = {
+	.set_voltage	= twl6030coresmps_set_voltage,
+	.get_voltage	= twl6030coresmps_get_voltage,
+};
+
 static int twl6030ldo_list_voltage(struct regulator_dev *rdev, unsigned index)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
@@ -918,6 +944,16 @@ static struct regulator_ops twlsmps_ops = {
 		}, \
 	}
 
+#define TWL6030_ADJUSTABLE_SMPS(label) { \
+	.desc = { \
+		.name = #label, \
+		.id = TWL6030_REG_##label, \
+		.ops = &twl6030coresmps_ops, \
+		.type = REGULATOR_VOLTAGE, \
+		.owner = THIS_MODULE, \
+		}, \
+	}
+
 #define TWL6030_ADJUSTABLE_LDO(label, offset, min_mVolts, max_mVolts) { \
 	.base = offset, \
 	.min_mV = min_mVolts, \
@@ -1019,6 +1055,9 @@ static struct twlreg_info twl_regs[] = {
 	/* 6030 REG with base as PMC Slave Misc : 0x0030 */
 	/* Turnon-delay and remap configuration values for 6030 are not
 	   verified since the specification is not public */
+	TWL6030_ADJUSTABLE_SMPS(VDD1),
+	TWL6030_ADJUSTABLE_SMPS(VDD2),
+	TWL6030_ADJUSTABLE_SMPS(VDD3),
 	TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1000, 3300),
 	TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 1000, 3300),
 	TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 1000, 3300),
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 08a82d3..f66c031 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -712,6 +712,9 @@ struct twl4030_platform_data {
 	struct regulator_init_data		*vaux1;
 	struct regulator_init_data		*vaux2;
 	struct regulator_init_data		*vaux3;
+	struct regulator_init_data		*vdd1;
+	struct regulator_init_data		*vdd2;
+	struct regulator_init_data		*vdd3;
 	/* TWL4030 LDO regulators */
 	struct regulator_init_data		*vpll1;
 	struct regulator_init_data		*vpll2;
@@ -720,8 +723,6 @@ struct twl4030_platform_data {
 	struct regulator_init_data		*vsim;
 	struct regulator_init_data		*vaux4;
 	struct regulator_init_data		*vio;
-	struct regulator_init_data		*vdd1;
-	struct regulator_init_data		*vdd2;
 	struct regulator_init_data		*vintana1;
 	struct regulator_init_data		*vintana2;
 	struct regulator_init_data		*vintdig;
-- 
1.7.4.1

