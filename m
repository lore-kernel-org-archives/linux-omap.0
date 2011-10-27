From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/3] regulator: twl: adapt twl-regulator driver to dt
Date: Thu, 27 Oct 2011 13:34:32 +0530
Message-ID: <1319702674-16304-2-git-send-email-rnayak@ti.com>
References: <1319702674-16304-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1319702674-16304-1-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Modify the twl regulator driver to extract the regulator_init_data from
device tree when passed, instead of getting it through platform_data
structures (on non-DT builds)

Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
---
 drivers/regulator/Kconfig         |    1 +
 drivers/regulator/twl-regulator.c |  128 ++++++++++++++++++++++++-------------
 2 files changed, 84 insertions(+), 45 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 8106958..9c12ae8 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -135,6 +135,7 @@ config REGULATOR_MAX8998
 config REGULATOR_TWL4030
 	bool "TI TWL4030/TWL5030/TWL6030/TPS659x0 PMIC"
 	depends on TWL4030_CORE
+	select OF_REGULATOR if OF
 	help
 	  This driver supports the voltage regulators provided by
 	  this family of companion chips.
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 9a2e07a..d857116 100644
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
 
 
@@ -839,13 +842,14 @@ static struct regulator_ops twlsmps_ops = {
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
@@ -856,10 +860,11 @@ static struct regulator_ops twlsmps_ops = {
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
@@ -870,10 +875,11 @@ static struct regulator_ops twlsmps_ops = {
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
@@ -932,23 +938,23 @@ static struct regulator_ops twlsmps_ops = {
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
-	TWL4030_ADJUSTABLE_LDO(VDD1, 0x55, 15, 1000, 0x08),
-	TWL4030_ADJUSTABLE_LDO(VDD2, 0x63, 16, 1000, 0x08),
+	TWL4030_ADJUSTABLE_LDO(VIO, 0x4b, 14, 1000, 0x08, "ti,twl4030-vio"),
+	TWL4030_ADJUSTABLE_LDO(VDD1, 0x55, 15, 1000, 0x08, "ti,twl4030-vdd1"),
+	TWL4030_ADJUSTABLE_LDO(VDD2, 0x63, 16, 1000, 0x08, "ti,twl4030-vdd2"),
 	TWL4030_FIXED_LDO(VUSB1V5, 0x71, 1500, 17, 100, 0x08),
 	TWL4030_FIXED_LDO(VUSB1V8, 0x74, 1800, 18, 100, 0x08),
 	TWL4030_FIXED_LDO(VUSB3V1, 0x77, 3100, 19, 150, 0x08),
@@ -957,12 +963,12 @@ static struct twlreg_info twl_regs[] = {
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
@@ -970,15 +976,15 @@ static struct twlreg_info twl_regs[] = {
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
@@ -1005,22 +1011,37 @@ static u8 twl_get_smps_mult(void)
 
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
+			initdata = of_get_regulator_init_data(&pdev->dev);
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
 
@@ -1035,7 +1056,7 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
 	c->valid_ops_mask &= REGULATOR_CHANGE_VOLTAGE
 				| REGULATOR_CHANGE_MODE
 				| REGULATOR_CHANGE_STATUS;
-	switch (pdev->id) {
+	switch (id) {
 	case TWL4030_REG_VIO:
 	case TWL4030_REG_VDD1:
 	case TWL4030_REG_VDD2:
@@ -1049,7 +1070,7 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
 		break;
 	}
 
-	switch (pdev->id) {
+	switch (id) {
 	case TWL6025_REG_SMPS3:
 		if (twl_get_smps_mult() & SMPS_MULTOFFSET_SMPS3)
 			info->flags |= SMPS_EXTENDED_EN;
@@ -1070,7 +1091,8 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
 		break;
 	}
 
-	rdev = regulator_register(&info->desc, &pdev->dev, initdata, info, NULL);
+	rdev = regulator_register(&info->desc, &pdev->dev, initdata, info,
+							pdev->dev.of_node);
 	if (IS_ERR(rdev)) {
 		dev_err(&pdev->dev, "can't register %s, %ld\n",
 				info->desc.name, PTR_ERR(rdev));
@@ -1101,14 +1123,30 @@ static int __devexit twlreg_remove(struct platform_device *pdev)
 
 MODULE_ALIAS("platform:twl_reg");
 
+#if defined(CONFIG_OF)
+static const struct of_device_id twl_of_match[] __devinitconst = {
+	{ .compatible = "ti,twl6030" },
+	{ .compatible = "ti,twl6025" },
+	{ .compatible = "ti,twl5030" },
+	{ .compatible = "ti,twl4030" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, twl_of_match);
+#else
+#define twl_of_match NULL
+#endif
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
+		.of_match_table = twl_of_match,
+	},
 };
 
 static int __init twlreg_init(void)
-- 
1.7.1
