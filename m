From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 1/3] regulator: twl: adapt twl-regulator driver to dt
Date: Tue, 13 Dec 2011 15:49:33 +0530
Message-ID: <1323771575-3550-2-git-send-email-rnayak@ti.com>
References: <1323771575-3550-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38764 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457Ab1LMKUY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 05:20:24 -0500
In-Reply-To: <1323771575-3550-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, linaro-dev@lists.linaro.org, Rajendra Nayak <rnayak@ti.com>

Modify the twl regulator driver to extract the regulator_init_data from
device tree when passed, instead of getting it through platform_data
structures (on non-DT builds)

Also add documentation for TWL regulator specific bindings.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 .../bindings/regulator/twl-regulator.txt           |   57 +++++++++
 drivers/regulator/twl-regulator.c                  |  128 +++++++++++++-------
 2 files changed, 139 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/twl-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/twl-regulator.txt b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
new file mode 100644
index 0000000..bdd96d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
@@ -0,0 +1,57 @@
+TWL family of regulators
+
+Required properties:
+- compatible:
+  - "ti,twl4030" for twl4030 regulators
+  - "ti,twl6025" for twl6025 regulators
+  - "ti,twl6030" for twl6030 regulators
+
+Additionally compatible can be used to specify the
+exact regulator/ldo instance like
+For twl6030 regulators/LDO's
+- compatible:
+  - "ti,twl6030-vaux1" for VAUX1 LDO
+  - "ti,twl6030-vaux2" for VAUX2 LDO
+  - "ti,twl6030-vaux3" for VAUX3 LDO
+  - "ti,twl6030-vmmc" for VMMC LDO
+  - "ti,twl6030-vpp" for VPP LDO
+  - "ti,twl6030-vusim" for VUSIM LDO
+For twl6025 regulators/LDO's
+- compatible:
+  - "ti,twl6025-ldo1" for LDO1 LDO
+  - "ti,twl6025-ldo2" for LDO2 LDO
+  - "ti,twl6025-ldo3" for LDO3 LDO
+  - "ti,twl6025-ldo4" for LDO4 LDO
+  - "ti,twl6025-ldo5" for LDO5 LDO
+  - "ti,twl6025-ldo6" for LDO6 LDO
+  - "ti,twl6025-ldo7" for LDO7 LDO
+  - "ti,twl6025-ldoln" for LDOLN LDO
+  - "ti,twl6025-ldousb" for LDOUSB LDO
+For twl4030 regulators/LDO's
+- compatible:
+  - "ti,twl4030-vaux1" for VAUX1 LDO
+  - "ti,twl4030-vaux2" for VAUX2 LDO
+  - "ti,twl5030-vaux2" for VAUX2 LDO
+  - "ti,twl4030-vaux3" for VAUX3 LDO
+  - "ti,twl4030-vaux4" for VAUX4 LDO
+  - "ti,twl4030-vmmc1" for VMMC1 LDO
+  - "ti,twl4030-vmmc2" for VMMC2 LDO
+  - "ti,twl4030-vpll1" for VPLL1 LDO
+  - "ti,twl4030-vpll2" for VPLL2 LDO
+  - "ti,twl4030-vsim" for VSIM LDO
+  - "ti,twl4030-vdac" for VDAC LDO
+  - "ti,twl4030-vintana2" for VINTANA2 LDO
+  - "ti,twl4030-vio" for VIO LDO
+  - "ti,twl4030-vdd1" for VDD1 LDO
+  - "ti,twl4030-vdd2" for VDD2 LDO
+
+Optional properties:
+- Any optional property defined in bindings/regulator/regulator.txt
+
+Example:
+
+	xyz: regulator@0 {
+		compatible = "ti,twl6030-vaux1","ti,twl6030";
+		regulator-min-microvolt  = <1000000>;
+		regulator-max-microvolt  = <3000000>;
+	};
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 181a2cf..e1a4134 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -14,8 +14,10 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
 #include <linux/i2c/twl.h>
 
 
@@ -58,6 +60,7 @@ struct twlreg_info {
 
 	/* chip specific features */
 	unsigned long 		features;
+	const char		*compatible;
 };
 
 
@@ -866,13 +869,14 @@ static struct regulator_ops twlsmps_ops = {
 		TWL_FIXED_LDO(label, offset, mVolts, 0x0, turnon_delay, \
 			0x0, TWL6030, twl6030fixed_ops)
 
-#define TWL4030_ADJUSTABLE_LDO(label, offset, num, turnon_delay, remap_conf) { \
+#define TWL4030_ADJUSTABLE_LDO(label, offset, num, turnon_delay, remap_conf, comp) { \
 	.base = offset, \
 	.id = num, \
 	.table_len = ARRAY_SIZE(label##_VSEL_table), \
 	.table = label##_VSEL_table, \
 	.delay = turnon_delay, \
 	.remap = remap_conf, \
+	.compatible = comp, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL4030_REG_##label, \
@@ -883,12 +887,13 @@ static struct regulator_ops twlsmps_ops = {
 		}, \
 	}
 
-#define TWL4030_ADJUSTABLE_SMPS(label, offset, num, turnon_delay, remap_conf) \
+#define TWL4030_ADJUSTABLE_SMPS(label, offset, num, turnon_delay, remap_conf, comp) \
 	{ \
 	.base = offset, \
 	.id = num, \
 	.delay = turnon_delay, \
 	.remap = remap_conf, \
+	.compatible = comp, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL4030_REG_##label, \
@@ -898,10 +903,11 @@ static struct regulator_ops twlsmps_ops = {
 		}, \
 	}
 
-#define TWL6030_ADJUSTABLE_LDO(label, offset, min_mVolts, max_mVolts) { \
+#define TWL6030_ADJUSTABLE_LDO(label, offset, min_mVolts, max_mVolts, comp) { \
 	.base = offset, \
 	.min_mV = min_mVolts, \
 	.max_mV = max_mVolts, \
+	.compatible = comp, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6030_REG_##label, \
@@ -912,10 +918,11 @@ static struct regulator_ops twlsmps_ops = {
 		}, \
 	}
 
-#define TWL6025_ADJUSTABLE_LDO(label, offset, min_mVolts, max_mVolts) { \
+#define TWL6025_ADJUSTABLE_LDO(label, offset, min_mVolts, max_mVolts, comp) { \
 	.base = offset, \
 	.min_mV = min_mVolts, \
 	.max_mV = max_mVolts, \
+	.compatible = comp, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6025_REG_##label, \
@@ -974,23 +981,23 @@ static struct regulator_ops twlsmps_ops = {
  * software control over them after boot.
  */
 static struct twlreg_info twl_regs[] = {
-	TWL4030_ADJUSTABLE_LDO(VAUX1, 0x17, 1, 100, 0x08),
-	TWL4030_ADJUSTABLE_LDO(VAUX2_4030, 0x1b, 2, 100, 0x08),
-	TWL4030_ADJUSTABLE_LDO(VAUX2, 0x1b, 2, 100, 0x08),
-	TWL4030_ADJUSTABLE_LDO(VAUX3, 0x1f, 3, 100, 0x08),
-	TWL4030_ADJUSTABLE_LDO(VAUX4, 0x23, 4, 100, 0x08),
-	TWL4030_ADJUSTABLE_LDO(VMMC1, 0x27, 5, 100, 0x08),
-	TWL4030_ADJUSTABLE_LDO(VMMC2, 0x2b, 6, 100, 0x08),
-	TWL4030_ADJUSTABLE_LDO(VPLL1, 0x2f, 7, 100, 0x00),
-	TWL4030_ADJUSTABLE_LDO(VPLL2, 0x33, 8, 100, 0x08),
-	TWL4030_ADJUSTABLE_LDO(VSIM, 0x37, 9, 100, 0x00),
-	TWL4030_ADJUSTABLE_LDO(VDAC, 0x3b, 10, 100, 0x08),
+	TWL4030_ADJUSTABLE_LDO(VAUX1, 0x17, 1, 100, 0x08, "ti,twl4030-vaux1"),
+	TWL4030_ADJUSTABLE_LDO(VAUX2_4030, 0x1b, 2, 100, 0x08, "ti,twl4030-vaux2"),
+	TWL4030_ADJUSTABLE_LDO(VAUX2, 0x1b, 2, 100, 0x08, "ti,twl5030-vaux2"),
+	TWL4030_ADJUSTABLE_LDO(VAUX3, 0x1f, 3, 100, 0x08, "ti,twl4030-vaux3"),
+	TWL4030_ADJUSTABLE_LDO(VAUX4, 0x23, 4, 100, 0x08, "ti,twl4030-vaux4"),
+	TWL4030_ADJUSTABLE_LDO(VMMC1, 0x27, 5, 100, 0x08, "ti,twl4030-vmmc1"),
+	TWL4030_ADJUSTABLE_LDO(VMMC2, 0x2b, 6, 100, 0x08, "ti,twl4030-vmmc2"),
+	TWL4030_ADJUSTABLE_LDO(VPLL1, 0x2f, 7, 100, 0x00, "ti,twl4030-vpll1"),
+	TWL4030_ADJUSTABLE_LDO(VPLL2, 0x33, 8, 100, 0x08, "ti,twl4030-vpll2"),
+	TWL4030_ADJUSTABLE_LDO(VSIM, 0x37, 9, 100, 0x00, "ti,twl4030-vsim"),
+	TWL4030_ADJUSTABLE_LDO(VDAC, 0x3b, 10, 100, 0x08, "ti,twl4030-vdac"),
 	TWL4030_FIXED_LDO(VINTANA1, 0x3f, 1500, 11, 100, 0x08),
-	TWL4030_ADJUSTABLE_LDO(VINTANA2, 0x43, 12, 100, 0x08),
+	TWL4030_ADJUSTABLE_LDO(VINTANA2, 0x43, 12, 100, 0x08, "ti,twl4030-vintana2"),
 	TWL4030_FIXED_LDO(VINTDIG, 0x47, 1500, 13, 100, 0x08),
-	TWL4030_ADJUSTABLE_LDO(VIO, 0x4b, 14, 1000, 0x08),
-	TWL4030_ADJUSTABLE_SMPS(VDD1, 0x55, 15, 1000, 0x08),
-	TWL4030_ADJUSTABLE_SMPS(VDD2, 0x63, 16, 1000, 0x08),
+	TWL4030_ADJUSTABLE_LDO(VIO, 0x4b, 14, 1000, 0x08, "ti,twl4030-vio"),
+	TWL4030_ADJUSTABLE_SMPS(VDD1, 0x55, 15, 1000, 0x08, "ti,twl4030-vdd1"),
+	TWL4030_ADJUSTABLE_SMPS(VDD2, 0x63, 16, 1000, 0x08, "ti,twl4030-vdd2"),
 	TWL4030_FIXED_LDO(VUSB1V5, 0x71, 1500, 17, 100, 0x08),
 	TWL4030_FIXED_LDO(VUSB1V8, 0x74, 1800, 18, 100, 0x08),
 	TWL4030_FIXED_LDO(VUSB3V1, 0x77, 3100, 19, 150, 0x08),
@@ -999,12 +1006,12 @@ static struct twlreg_info twl_regs[] = {
 	/* 6030 REG with base as PMC Slave Misc : 0x0030 */
 	/* Turnon-delay and remap configuration values for 6030 are not
 	   verified since the specification is not public */
-	TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1000, 3300),
-	TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 1000, 3300),
-	TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 1000, 3300),
-	TWL6030_ADJUSTABLE_LDO(VMMC, 0x68, 1000, 3300),
-	TWL6030_ADJUSTABLE_LDO(VPP, 0x6c, 1000, 3300),
-	TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74, 1000, 3300),
+	TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1000, 3300, "ti,twl6030-vaux1"),
+	TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 1000, 3300, "ti,twl6030-vaux2"),
+	TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 1000, 3300, "ti,twl6030-vaux3"),
+	TWL6030_ADJUSTABLE_LDO(VMMC, 0x68, 1000, 3300, "ti,twl6030-vmmc"),
+	TWL6030_ADJUSTABLE_LDO(VPP, 0x6c, 1000, 3300, "ti,twl6030-vpp"),
+	TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74, 1000, 3300, "ti,twl6030-vusim"),
 	TWL6030_FIXED_LDO(VANA, 0x50, 2100, 0),
 	TWL6030_FIXED_LDO(VCXIO, 0x60, 1800, 0),
 	TWL6030_FIXED_LDO(VDAC, 0x64, 1800, 0),
@@ -1012,15 +1019,15 @@ static struct twlreg_info twl_regs[] = {
 	TWL6030_FIXED_RESOURCE(CLK32KG, 0x8C, 0),
 
 	/* 6025 are renamed compared to 6030 versions */
-	TWL6025_ADJUSTABLE_LDO(LDO2, 0x54, 1000, 3300),
-	TWL6025_ADJUSTABLE_LDO(LDO4, 0x58, 1000, 3300),
-	TWL6025_ADJUSTABLE_LDO(LDO3, 0x5c, 1000, 3300),
-	TWL6025_ADJUSTABLE_LDO(LDO5, 0x68, 1000, 3300),
-	TWL6025_ADJUSTABLE_LDO(LDO1, 0x6c, 1000, 3300),
-	TWL6025_ADJUSTABLE_LDO(LDO7, 0x74, 1000, 3300),
-	TWL6025_ADJUSTABLE_LDO(LDO6, 0x60, 1000, 3300),
-	TWL6025_ADJUSTABLE_LDO(LDOLN, 0x64, 1000, 3300),
-	TWL6025_ADJUSTABLE_LDO(LDOUSB, 0x70, 1000, 3300),
+	TWL6025_ADJUSTABLE_LDO(LDO2, 0x54, 1000, 3300, "ti,twl6025-ldo2"),
+	TWL6025_ADJUSTABLE_LDO(LDO4, 0x58, 1000, 3300, "ti,twl6025-ldo4"),
+	TWL6025_ADJUSTABLE_LDO(LDO3, 0x5c, 1000, 3300, "ti,twl6025-ldo3"),
+	TWL6025_ADJUSTABLE_LDO(LDO5, 0x68, 1000, 3300, "ti,twl6025-ldo5"),
+	TWL6025_ADJUSTABLE_LDO(LDO1, 0x6c, 1000, 3300, "ti,twl6025-ldo1"),
+	TWL6025_ADJUSTABLE_LDO(LDO7, 0x74, 1000, 3300, "ti,twl6025-ldo7"),
+	TWL6025_ADJUSTABLE_LDO(LDO6, 0x60, 1000, 3300, "ti,twl6025-ldo6"),
+	TWL6025_ADJUSTABLE_LDO(LDOLN, 0x64, 1000, 3300, "ti,twl6025-ldoln"),
+	TWL6025_ADJUSTABLE_LDO(LDOUSB, 0x70, 1000, 3300, "ti,twl6025-ldousb"),
 
 	TWL6025_ADJUSTABLE_SMPS(SMPS3, 0x34),
 	TWL6025_ADJUSTABLE_SMPS(SMPS4, 0x10),
@@ -1047,22 +1054,38 @@ static u8 twl_get_smps_mult(void)
 
 static int __devinit twlreg_probe(struct platform_device *pdev)
 {
-	int				i;
+	int				i, id;
 	struct twlreg_info		*info;
 	struct regulator_init_data	*initdata;
 	struct regulation_constraints	*c;
 	struct regulator_dev		*rdev;
 
-	for (i = 0, info = NULL; i < ARRAY_SIZE(twl_regs); i++) {
-		if (twl_regs[i].desc.id != pdev->id)
-			continue;
-		info = twl_regs + i;
-		break;
+	if (pdev->dev.of_node) { /* dt based lookup */
+		for (i = 0, info = NULL; i < ARRAY_SIZE(twl_regs); i++) {
+			if (!twl_regs[i].compatible ||
+				!of_device_is_compatible(pdev->dev.of_node,
+						 twl_regs[i].compatible))
+				continue;
+			info = twl_regs + i;
+			id = twl_regs[i].desc.id;
+			initdata = of_get_regulator_init_data(&pdev->dev,
+							pdev->dev.of_node);
+			break;
+		}
+	} else {
+		/* pdev->id based lookup */
+		for (i = 0, info = NULL; i < ARRAY_SIZE(twl_regs); i++) {
+			if (twl_regs[i].desc.id != pdev->id)
+				continue;
+			info = twl_regs + i;
+			id = pdev->id;
+			initdata = pdev->dev.platform_data;
+			break;
+		}
 	}
 	if (!info)
 		return -ENODEV;
 
-	initdata = pdev->dev.platform_data;
 	if (!initdata)
 		return -EINVAL;
 
@@ -1077,7 +1100,7 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
 	c->valid_ops_mask &= REGULATOR_CHANGE_VOLTAGE
 				| REGULATOR_CHANGE_MODE
 				| REGULATOR_CHANGE_STATUS;
-	switch (pdev->id) {
+	switch (id) {
 	case TWL4030_REG_VIO:
 	case TWL4030_REG_VDD1:
 	case TWL4030_REG_VDD2:
@@ -1091,7 +1114,7 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
 		break;
 	}
 
-	switch (pdev->id) {
+	switch (id) {
 	case TWL6025_REG_SMPS3:
 		if (twl_get_smps_mult() & SMPS_MULTOFFSET_SMPS3)
 			info->flags |= SMPS_EXTENDED_EN;
@@ -1112,7 +1135,8 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
 		break;
 	}
 
-	rdev = regulator_register(&info->desc, &pdev->dev, initdata, info, NULL);
+	rdev = regulator_register(&info->desc, &pdev->dev, initdata, info,
+							pdev->dev.of_node);
 	if (IS_ERR(rdev)) {
 		dev_err(&pdev->dev, "can't register %s, %ld\n",
 				info->desc.name, PTR_ERR(rdev));
@@ -1143,14 +1167,26 @@ static int __devexit twlreg_remove(struct platform_device *pdev)
 
 MODULE_ALIAS("platform:twl_reg");
 
+static const struct of_device_id twl_of_match[] __devinitconst = {
+	{ .compatible = "ti,twl6030" },
+	{ .compatible = "ti,twl6025" },
+	{ .compatible = "ti,twl5030" },
+	{ .compatible = "ti,twl4030" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, twl_of_match);
+
 static struct platform_driver twlreg_driver = {
 	.probe		= twlreg_probe,
 	.remove		= __devexit_p(twlreg_remove),
 	/* NOTE: short name, to work around driver model truncation of
 	 * "twl_regulator.12" (and friends) to "twl_regulator.1".
 	 */
-	.driver.name	= "twl_reg",
-	.driver.owner	= THIS_MODULE,
+	.driver  = {
+		.name  = "twl_reg",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(twl_of_match),
+	},
 };
 
 static int __init twlreg_init(void)
-- 
1.7.1

