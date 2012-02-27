From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v3 1/2] regulator: twl: adapt twl-regulator driver to dt
Date: Mon, 27 Feb 2012 16:06:00 +0530
Message-ID: <1330338961-31765-2-git-send-email-rnayak@ti.com>
References: <1330338961-31765-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34892 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752125Ab2B0Kgp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Feb 2012 05:36:45 -0500
In-Reply-To: <1330338961-31765-1-git-send-email-rnayak@ti.com>
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
 .../bindings/regulator/twl-regulator.txt           |   66 +++++
 drivers/regulator/twl-regulator.c                  |  259 +++++++++++++-------
 2 files changed, 238 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/twl-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/twl-regulator.txt b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
new file mode 100644
index 0000000..ba9d2cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
@@ -0,0 +1,66 @@
+TWL family of regulators
+
+Required properties:
+For twl6030 regulators/LDOs
+- compatible:
+  - "ti,twl6030-vaux1" for VAUX1 LDO
+  - "ti,twl6030-vaux2" for VAUX2 LDO
+  - "ti,twl6030-vaux3" for VAUX3 LDO
+  - "ti,twl6030-vmmc" for VMMC LDO
+  - "ti,twl6030-vpp" for VPP LDO
+  - "ti,twl6030-vusim" for VUSIM LDO
+  - "ti,twl6030-vana" for VANA LDO
+  - "ti,twl6030-vcxio" for VCXIO LDO
+  - "ti,twl6030-vdac" for VDAC LDO
+  - "ti,twl6030-vusb" for VUSB LDO
+  - "ti,twl6030-clk32kg" for CLK32KG RESOURCE
+  - "ti,twl6030-vdd1" for VDD1 SMPS
+  - "ti,twl6030-vdd2" for VDD2 SMPS
+  - "ti,twl6030-vdd3" for VDD3 SMPS
+For twl6025 regulators/LDOs
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
+  - "ti,twl6025-smps3" for SMPS3 SMPS
+  - "ti,twl6025-smps4" for SMPS4 SMPS
+  - "ti,twl6025-vio" for VIO SMPS
+For twl4030 regulators/LDOs
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
+  - "ti,twl4030-vdd1" for VDD1 SMPS
+  - "ti,twl4030-vdd2" for VDD2 SMPS
+  - "ti,twl4030-vintana1" for VINTANA1 LDO
+  - "ti,twl4030-vintdig" for VINTDIG LDO
+  - "ti,twl4030-vusb1v5" for VUSB1V5 LDO
+  - "ti,twl4030-vusb1v8" for VUSB1V8 LDO
+  - "ti,twl4030-vusb3v1" for VUSB3V1 LDO
+
+Optional properties:
+- Any optional property defined in bindings/regulator/regulator.txt
+
+Example:
+
+	xyz: regulator@0 {
+		compatible = "ti,twl6030-vaux1";
+		regulator-min-microvolt  = <1000000>;
+		regulator-max-microvolt  = <3000000>;
+	};
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 8611282..2a13211 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -14,8 +14,11 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
 #include <linux/i2c/twl.h>
 
 
@@ -920,7 +923,8 @@ static struct regulator_ops twlsmps_ops = {
 		TWL_FIXED_LDO(label, offset, mVolts, 0x0, turnon_delay, \
 			0x0, TWL6030, twl6030fixed_ops)
 
-#define TWL4030_ADJUSTABLE_LDO(label, offset, num, turnon_delay, remap_conf) { \
+#define TWL4030_ADJUSTABLE_LDO(label, offset, num, turnon_delay, remap_conf) \
+static struct twlreg_info TWL4030_INFO_##label = { \
 	.base = offset, \
 	.id = num, \
 	.table_len = ARRAY_SIZE(label##_VSEL_table), \
@@ -938,7 +942,7 @@ static struct regulator_ops twlsmps_ops = {
 	}
 
 #define TWL4030_ADJUSTABLE_SMPS(label, offset, num, turnon_delay, remap_conf) \
-	{ \
+static struct twlreg_info TWL4030_INFO_##label = { \
 	.base = offset, \
 	.id = num, \
 	.delay = turnon_delay, \
@@ -952,7 +956,8 @@ static struct regulator_ops twlsmps_ops = {
 		}, \
 	}
 
-#define TWL6030_ADJUSTABLE_SMPS(label) { \
+#define TWL6030_ADJUSTABLE_SMPS(label) \
+static struct twlreg_info TWL6030_INFO_##label = { \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6030_REG_##label, \
@@ -962,7 +967,8 @@ static struct regulator_ops twlsmps_ops = {
 		}, \
 	}
 
-#define TWL6030_ADJUSTABLE_LDO(label, offset, min_mVolts, max_mVolts) { \
+#define TWL6030_ADJUSTABLE_LDO(label, offset, min_mVolts, max_mVolts) \
+static struct twlreg_info TWL6030_INFO_##label = { \
 	.base = offset, \
 	.min_mV = min_mVolts, \
 	.max_mV = max_mVolts, \
@@ -976,7 +982,8 @@ static struct regulator_ops twlsmps_ops = {
 		}, \
 	}
 
-#define TWL6025_ADJUSTABLE_LDO(label, offset, min_mVolts, max_mVolts) { \
+#define TWL6025_ADJUSTABLE_LDO(label, offset, min_mVolts, max_mVolts) \
+static struct twlreg_info TWL6025_INFO_##label = { \
 	.base = offset, \
 	.min_mV = min_mVolts, \
 	.max_mV = max_mVolts, \
@@ -991,7 +998,8 @@ static struct regulator_ops twlsmps_ops = {
 	}
 
 #define TWL_FIXED_LDO(label, offset, mVolts, num, turnon_delay, remap_conf, \
-		family, operations) { \
+		family, operations) \
+static struct twlreg_info TWLFIXED_INFO_##label = { \
 	.base = offset, \
 	.id = num, \
 	.min_mV = mVolts, \
@@ -1007,7 +1015,8 @@ static struct regulator_ops twlsmps_ops = {
 		}, \
 	}
 
-#define TWL6030_FIXED_RESOURCE(label, offset, turnon_delay) { \
+#define TWL6030_FIXED_RESOURCE(label, offset, turnon_delay) \
+static struct twlreg_info TWLRES_INFO_##label = { \
 	.base = offset, \
 	.delay = turnon_delay, \
 	.desc = { \
@@ -1019,7 +1028,8 @@ static struct regulator_ops twlsmps_ops = {
 		}, \
 	}
 
-#define TWL6025_ADJUSTABLE_SMPS(label, offset) { \
+#define TWL6025_ADJUSTABLE_SMPS(label, offset) \
+static struct twlreg_info TWLSMPS_INFO_##label = { \
 	.base = offset, \
 	.min_mV = 600, \
 	.max_mV = 2100, \
@@ -1037,62 +1047,57 @@ static struct regulator_ops twlsmps_ops = {
  * We list regulators here if systems need some level of
  * software control over them after boot.
  */
-static struct twlreg_info twl_regs[] = {
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
-	TWL4030_FIXED_LDO(VINTANA1, 0x3f, 1500, 11, 100, 0x08),
-	TWL4030_ADJUSTABLE_LDO(VINTANA2, 0x43, 12, 100, 0x08),
-	TWL4030_FIXED_LDO(VINTDIG, 0x47, 1500, 13, 100, 0x08),
-	TWL4030_ADJUSTABLE_LDO(VIO, 0x4b, 14, 1000, 0x08),
-	TWL4030_ADJUSTABLE_SMPS(VDD1, 0x55, 15, 1000, 0x08),
-	TWL4030_ADJUSTABLE_SMPS(VDD2, 0x63, 16, 1000, 0x08),
-	TWL4030_FIXED_LDO(VUSB1V5, 0x71, 1500, 17, 100, 0x08),
-	TWL4030_FIXED_LDO(VUSB1V8, 0x74, 1800, 18, 100, 0x08),
-	TWL4030_FIXED_LDO(VUSB3V1, 0x77, 3100, 19, 150, 0x08),
-	/* VUSBCP is managed *only* by the USB subchip */
-
-	/* 6030 REG with base as PMC Slave Misc : 0x0030 */
-	/* Turnon-delay and remap configuration values for 6030 are not
-	   verified since the specification is not public */
-	TWL6030_ADJUSTABLE_SMPS(VDD1),
-	TWL6030_ADJUSTABLE_SMPS(VDD2),
-	TWL6030_ADJUSTABLE_SMPS(VDD3),
-	TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1000, 3300),
-	TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 1000, 3300),
-	TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 1000, 3300),
-	TWL6030_ADJUSTABLE_LDO(VMMC, 0x68, 1000, 3300),
-	TWL6030_ADJUSTABLE_LDO(VPP, 0x6c, 1000, 3300),
-	TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74, 1000, 3300),
-	TWL6030_FIXED_LDO(VANA, 0x50, 2100, 0),
-	TWL6030_FIXED_LDO(VCXIO, 0x60, 1800, 0),
-	TWL6030_FIXED_LDO(VDAC, 0x64, 1800, 0),
-	TWL6030_FIXED_LDO(VUSB, 0x70, 3300, 0),
-	TWL6030_FIXED_RESOURCE(CLK32KG, 0x8C, 0),
-
-	/* 6025 are renamed compared to 6030 versions */
-	TWL6025_ADJUSTABLE_LDO(LDO2, 0x54, 1000, 3300),
-	TWL6025_ADJUSTABLE_LDO(LDO4, 0x58, 1000, 3300),
-	TWL6025_ADJUSTABLE_LDO(LDO3, 0x5c, 1000, 3300),
-	TWL6025_ADJUSTABLE_LDO(LDO5, 0x68, 1000, 3300),
-	TWL6025_ADJUSTABLE_LDO(LDO1, 0x6c, 1000, 3300),
-	TWL6025_ADJUSTABLE_LDO(LDO7, 0x74, 1000, 3300),
-	TWL6025_ADJUSTABLE_LDO(LDO6, 0x60, 1000, 3300),
-	TWL6025_ADJUSTABLE_LDO(LDOLN, 0x64, 1000, 3300),
-	TWL6025_ADJUSTABLE_LDO(LDOUSB, 0x70, 1000, 3300),
-
-	TWL6025_ADJUSTABLE_SMPS(SMPS3, 0x34),
-	TWL6025_ADJUSTABLE_SMPS(SMPS4, 0x10),
-	TWL6025_ADJUSTABLE_SMPS(VIO, 0x16),
-};
+TWL4030_ADJUSTABLE_LDO(VAUX1, 0x17, 1, 100, 0x08);
+TWL4030_ADJUSTABLE_LDO(VAUX2_4030, 0x1b, 2, 100, 0x08);
+TWL4030_ADJUSTABLE_LDO(VAUX2, 0x1b, 2, 100, 0x08);
+TWL4030_ADJUSTABLE_LDO(VAUX3, 0x1f, 3, 100, 0x08);
+TWL4030_ADJUSTABLE_LDO(VAUX4, 0x23, 4, 100, 0x08);
+TWL4030_ADJUSTABLE_LDO(VMMC1, 0x27, 5, 100, 0x08);
+TWL4030_ADJUSTABLE_LDO(VMMC2, 0x2b, 6, 100, 0x08);
+TWL4030_ADJUSTABLE_LDO(VPLL1, 0x2f, 7, 100, 0x00);
+TWL4030_ADJUSTABLE_LDO(VPLL2, 0x33, 8, 100, 0x08);
+TWL4030_ADJUSTABLE_LDO(VSIM, 0x37, 9, 100, 0x00);
+TWL4030_ADJUSTABLE_LDO(VDAC, 0x3b, 10, 100, 0x08);
+TWL4030_ADJUSTABLE_LDO(VINTANA2, 0x43, 12, 100, 0x08);
+TWL4030_ADJUSTABLE_LDO(VIO, 0x4b, 14, 1000, 0x08);
+TWL4030_ADJUSTABLE_SMPS(VDD1, 0x55, 15, 1000, 0x08);
+TWL4030_ADJUSTABLE_SMPS(VDD2, 0x63, 16, 1000, 0x08);
+/* VUSBCP is managed *only* by the USB subchip */
+/* 6030 REG with base as PMC Slave Misc : 0x0030 */
+/* Turnon-delay and remap configuration values for 6030 are not
+   verified since the specification is not public */
+TWL6030_ADJUSTABLE_SMPS(VDD1);
+TWL6030_ADJUSTABLE_SMPS(VDD2);
+TWL6030_ADJUSTABLE_SMPS(VDD3);
+TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1000, 3300);
+TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 1000, 3300);
+TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 1000, 3300);
+TWL6030_ADJUSTABLE_LDO(VMMC, 0x68, 1000, 3300);
+TWL6030_ADJUSTABLE_LDO(VPP, 0x6c, 1000, 3300);
+TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74, 1000, 3300);
+/* 6025 are renamed compared to 6030 versions */
+TWL6025_ADJUSTABLE_LDO(LDO2, 0x54, 1000, 3300);
+TWL6025_ADJUSTABLE_LDO(LDO4, 0x58, 1000, 3300);
+TWL6025_ADJUSTABLE_LDO(LDO3, 0x5c, 1000, 3300);
+TWL6025_ADJUSTABLE_LDO(LDO5, 0x68, 1000, 3300);
+TWL6025_ADJUSTABLE_LDO(LDO1, 0x6c, 1000, 3300);
+TWL6025_ADJUSTABLE_LDO(LDO7, 0x74, 1000, 3300);
+TWL6025_ADJUSTABLE_LDO(LDO6, 0x60, 1000, 3300);
+TWL6025_ADJUSTABLE_LDO(LDOLN, 0x64, 1000, 3300);
+TWL6025_ADJUSTABLE_LDO(LDOUSB, 0x70, 1000, 3300);
+TWL4030_FIXED_LDO(VINTANA2, 0x3f, 1500, 11, 100, 0x08);
+TWL4030_FIXED_LDO(VINTDIG, 0x47, 1500, 13, 100, 0x08);
+TWL4030_FIXED_LDO(VUSB1V5, 0x71, 1500, 17, 100, 0x08);
+TWL4030_FIXED_LDO(VUSB1V8, 0x74, 1800, 18, 100, 0x08);
+TWL4030_FIXED_LDO(VUSB3V1, 0x77, 3100, 19, 150, 0x08);
+TWL6030_FIXED_LDO(VANA, 0x50, 2100, 0);
+TWL6030_FIXED_LDO(VCXIO, 0x60, 1800, 0);
+TWL6030_FIXED_LDO(VDAC, 0x64, 1800, 0);
+TWL6030_FIXED_LDO(VUSB, 0x70, 3300, 0);
+TWL6030_FIXED_RESOURCE(CLK32KG, 0x8C, 0);
+TWL6025_ADJUSTABLE_SMPS(SMPS3, 0x34);
+TWL6025_ADJUSTABLE_SMPS(SMPS4, 0x10);
+TWL6025_ADJUSTABLE_SMPS(VIO, 0x16);
 
 static u8 twl_get_smps_offset(void)
 {
@@ -1112,38 +1117,114 @@ static u8 twl_get_smps_mult(void)
 	return value;
 }
 
+#define TWL_OF_MATCH(comp, family, label) \
+	{ \
+		.compatible = comp, \
+		.data = &family##_INFO_##label, \
+	}
+
+#define TWL4030_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWL4030, label)
+#define TWL6030_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWL6030, label)
+#define TWL6025_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWL6025, label)
+#define TWLFIXED_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWLFIXED, label)
+#define TWLRES_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWLRES, label)
+#define TWLSMPS_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWLSMPS, label)
+
+static const struct of_device_id twl_of_match[] __devinitconst = {
+	TWL4030_OF_MATCH("ti,twl4030-vaux1", VAUX1),
+	TWL4030_OF_MATCH("ti,twl4030-vaux2", VAUX2_4030),
+	TWL4030_OF_MATCH("ti,twl5030-vaux2", VAUX2),
+	TWL4030_OF_MATCH("ti,twl4030-vaux3", VAUX3),
+	TWL4030_OF_MATCH("ti,twl4030-vaux4", VAUX4),
+	TWL4030_OF_MATCH("ti,twl4030-vmmc1", VMMC1),
+	TWL4030_OF_MATCH("ti,twl4030-vmmc2", VMMC2),
+	TWL4030_OF_MATCH("ti,twl4030-vpll1", VPLL1),
+	TWL4030_OF_MATCH("ti,twl4030-vpll2", VPLL2),
+	TWL4030_OF_MATCH("ti,twl4030-vsim", VSIM),
+	TWL4030_OF_MATCH("ti,twl4030-vdac", VDAC),
+	TWL4030_OF_MATCH("ti,twl4030-vintana2", VINTANA2),
+	TWL4030_OF_MATCH("ti,twl4030-vio", VIO),
+	TWL4030_OF_MATCH("ti,twl4030-vdd1", VDD1),
+	TWL4030_OF_MATCH("ti,twl4030-vdd2", VDD2),
+	TWL6030_OF_MATCH("ti,twl6030-vdd1", VDD1),
+	TWL6030_OF_MATCH("ti,twl6030-vdd2", VDD2),
+	TWL6030_OF_MATCH("ti,twl6030-vdd3", VDD3),
+	TWL6030_OF_MATCH("ti,twl6030-vaux1", VAUX1_6030),
+	TWL6030_OF_MATCH("ti,twl6030-vaux2", VAUX2_6030),
+	TWL6030_OF_MATCH("ti,twl6030-vaux3", VAUX3_6030),
+	TWL6030_OF_MATCH("ti,twl6030-vmmc", VMMC),
+	TWL6030_OF_MATCH("ti,twl6030-vpp", VPP),
+	TWL6030_OF_MATCH("ti,twl6030-vusim", VUSIM),
+	TWL6025_OF_MATCH("ti,twl6025-ldo2", LDO2),
+	TWL6025_OF_MATCH("ti,twl6025-ldo4", LDO4),
+	TWL6025_OF_MATCH("ti,twl6025-ldo3", LDO3),
+	TWL6025_OF_MATCH("ti,twl6025-ldo5", LDO5),
+	TWL6025_OF_MATCH("ti,twl6025-ldo1", LDO1),
+	TWL6025_OF_MATCH("ti,twl6025-ldo7", LDO7),
+	TWL6025_OF_MATCH("ti,twl6025-ldo6", LDO6),
+	TWL6025_OF_MATCH("ti,twl6025-ldoln", LDOLN),
+	TWL6025_OF_MATCH("ti,twl6025-ldousb", LDOUSB),
+	TWLFIXED_OF_MATCH("ti,twl4030-vintana2", VINTANA2),
+	TWLFIXED_OF_MATCH("ti,twl4030-vintdig", VINTDIG),
+	TWLFIXED_OF_MATCH("ti,twl4030-vusb1v5", VUSB1V5),
+	TWLFIXED_OF_MATCH("ti,twl4030-vusb1v8", VUSB1V8),
+	TWLFIXED_OF_MATCH("ti,twl4030-vusb3v1", VUSB3V1),
+	TWLFIXED_OF_MATCH("ti,twl6030-vana", VANA),
+	TWLFIXED_OF_MATCH("ti,twl6030-vcxio", VCXIO),
+	TWLFIXED_OF_MATCH("ti,twl6030-vdac", VDAC),
+	TWLFIXED_OF_MATCH("ti,twl6030-vusb", VUSB),
+	TWLRES_OF_MATCH("ti,twl6030-clk32kg", CLK32KG),
+	TWLSMPS_OF_MATCH("ti,twl6025-smps3", SMPS3),
+	TWLSMPS_OF_MATCH("ti,twl6025-smps4", SMPS4),
+	TWLSMPS_OF_MATCH("ti,twl6025-vio", VIO),
+	{},
+};
+MODULE_DEVICE_TABLE(of, twl_of_match);
+
 static int __devinit twlreg_probe(struct platform_device *pdev)
 {
-	int				i;
+	int				i, id;
 	struct twlreg_info		*info;
 	struct regulator_init_data	*initdata;
 	struct regulation_constraints	*c;
 	struct regulator_dev		*rdev;
 	struct twl_regulator_driver_data	*drvdata;
-
-	for (i = 0, info = NULL; i < ARRAY_SIZE(twl_regs); i++) {
-		if (twl_regs[i].desc.id != pdev->id)
-			continue;
-		info = twl_regs + i;
-		break;
+	const struct of_device_id	*match;
+
+	match = of_match_device(twl_of_match, &pdev->dev);
+	if (match) {
+		info = match->data;
+		id = info->desc.id;
+		initdata = of_get_regulator_init_data(&pdev->dev,
+						      pdev->dev.of_node);
+		drvdata = NULL;
+	} else {
+		id = pdev->id;
+		initdata = pdev->dev.platform_data;
+		for (i = 0, info = NULL; i < ARRAY_SIZE(twl_of_match); i++) {
+			info = twl_of_match[i].data;
+			if (!info || info->desc.id != id)
+				continue;
+			break;
+		}
+		drvdata = initdata->driver_data;
+		if (!drvdata)
+			return -EINVAL;
 	}
+
 	if (!info)
 		return -ENODEV;
 
-	initdata = pdev->dev.platform_data;
 	if (!initdata)
 		return -EINVAL;
 
-	drvdata = initdata->driver_data;
-
-	if (!drvdata)
-		return -EINVAL;
-
-	/* copy the driver data into regulator data */
-	info->features = drvdata->features;
-	info->data = drvdata->data;
-	info->set_voltage = drvdata->set_voltage;
-	info->get_voltage = drvdata->get_voltage;
+	if (drvdata) {
+		/* copy the driver data into regulator data */
+		info->features = drvdata->features;
+		info->data = drvdata->data;
+		info->set_voltage = drvdata->set_voltage;
+		info->get_voltage = drvdata->get_voltage;
+	}
 
 	/* Constrain board-specific capabilities according to what
 	 * this driver and the chip itself can actually do.
@@ -1153,7 +1234,7 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
 	c->valid_ops_mask &= REGULATOR_CHANGE_VOLTAGE
 				| REGULATOR_CHANGE_MODE
 				| REGULATOR_CHANGE_STATUS;
-	switch (pdev->id) {
+	switch (id) {
 	case TWL4030_REG_VIO:
 	case TWL4030_REG_VDD1:
 	case TWL4030_REG_VDD2:
@@ -1167,7 +1248,7 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
 		break;
 	}
 
-	switch (pdev->id) {
+	switch (id) {
 	case TWL6025_REG_SMPS3:
 		if (twl_get_smps_mult() & SMPS_MULTOFFSET_SMPS3)
 			info->flags |= SMPS_EXTENDED_EN;
@@ -1188,7 +1269,8 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
 		break;
 	}
 
-	rdev = regulator_register(&info->desc, &pdev->dev, initdata, info, NULL);
+	rdev = regulator_register(&info->desc, &pdev->dev, initdata, info,
+							pdev->dev.of_node);
 	if (IS_ERR(rdev)) {
 		dev_err(&pdev->dev, "can't register %s, %ld\n",
 				info->desc.name, PTR_ERR(rdev));
@@ -1225,8 +1307,11 @@ static struct platform_driver twlreg_driver = {
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

