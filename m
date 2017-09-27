From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] regulator: lp873x: Update the enable mask for LDOs and BUCKs
Date: Wed, 27 Sep 2017 17:55:40 +0530
Message-ID: <1506515140-26058-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, t-kristo@ti.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

The reset value of the EN_PIN_CTRL bit fields of LDOs and BUCKs
need not be set correctly. Hence update the enable mask to include
the EN_PIN_CTRL bit. While enabling this should be set to 1 so
that all the regulators are tied to EN pin.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/regulator/lp873x-regulator.c | 19 ++++++++++---------
 include/linux/mfd/lp873x.h           |  4 ++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/lp873x-regulator.c b/drivers/regulator/lp873x-regulator.c
index 70e3df6..77bea82 100644
--- a/drivers/regulator/lp873x-regulator.c
+++ b/drivers/regulator/lp873x-regulator.c
@@ -20,7 +20,7 @@
 #include <linux/mfd/lp873x.h>
 
 #define LP873X_REGULATOR(_name, _id, _of, _ops, _n, _vr, _vm, _er, _em, \
-			 _delay, _lr, _cr)				\
+			 _dv, _delay, _lr, _cr)				\
 	[_id] = {							\
 		.desc = {						\
 			.name			= _name,		\
@@ -36,6 +36,7 @@
 			.vsel_mask		= _vm,			\
 			.enable_reg		= _er,			\
 			.enable_mask		= _em,			\
+			.disable_val		= _dv,			\
 			.ramp_delay		= _delay,		\
 			.linear_ranges		= _lr,			\
 			.n_linear_ranges	= ARRAY_SIZE(_lr),	\
@@ -175,21 +176,21 @@ static int lp873x_buck_get_current_limit(struct regulator_dev *rdev)
 	LP873X_REGULATOR("BUCK0", LP873X_BUCK_0, "buck0", lp873x_buck01_ops,
 			 256, LP873X_REG_BUCK0_VOUT,
 			 LP873X_BUCK0_VOUT_BUCK0_VSET, LP873X_REG_BUCK0_CTRL_1,
-			 LP873X_BUCK0_CTRL_1_BUCK0_EN, 10000,
-			 buck0_buck1_ranges, LP873X_REG_BUCK0_CTRL_2),
+			 LP873X_BUCK_ENABLE_MASK, LP873X_BUCK_DISABLE_VAL,
+			 10000, buck0_buck1_ranges, LP873X_REG_BUCK0_CTRL_2),
 	LP873X_REGULATOR("BUCK1", LP873X_BUCK_1, "buck1", lp873x_buck01_ops,
 			 256, LP873X_REG_BUCK1_VOUT,
 			 LP873X_BUCK1_VOUT_BUCK1_VSET, LP873X_REG_BUCK1_CTRL_1,
-			 LP873X_BUCK1_CTRL_1_BUCK1_EN, 10000,
-			 buck0_buck1_ranges, LP873X_REG_BUCK1_CTRL_2),
+			 LP873X_BUCK_ENABLE_MASK, LP873X_BUCK_DISABLE_VAL,
+			 10000, buck0_buck1_ranges, LP873X_REG_BUCK1_CTRL_2),
 	LP873X_REGULATOR("LDO0", LP873X_LDO_0, "ldo0", lp873x_ldo01_ops, 26,
 			 LP873X_REG_LDO0_VOUT, LP873X_LDO0_VOUT_LDO0_VSET,
-			 LP873X_REG_LDO0_CTRL,
-			 LP873X_LDO0_CTRL_LDO0_EN, 0, ldo0_ldo1_ranges, 0xFF),
+			 LP873X_REG_LDO0_CTRL, LP873X_LDO_ENABLE_MASK,
+			 LP873X_LDO_DISABLE_VAL, 0, ldo0_ldo1_ranges, 0xFF),
 	LP873X_REGULATOR("LDO1", LP873X_LDO_1, "ldo1", lp873x_ldo01_ops, 26,
 			 LP873X_REG_LDO1_VOUT, LP873X_LDO1_VOUT_LDO1_VSET,
-			 LP873X_REG_LDO1_CTRL,
-			 LP873X_LDO1_CTRL_LDO1_EN, 0, ldo0_ldo1_ranges, 0xFF),
+			 LP873X_REG_LDO1_CTRL, LP873X_LDO_ENABLE_MASK,
+			 LP873X_LDO_DISABLE_VAL, 0, ldo0_ldo1_ranges, 0xFF),
 };
 
 static int lp873x_regulator_probe(struct platform_device *pdev)
diff --git a/include/linux/mfd/lp873x.h b/include/linux/mfd/lp873x.h
index edbec83..53888d4 100644
--- a/include/linux/mfd/lp873x.h
+++ b/include/linux/mfd/lp873x.h
@@ -77,6 +77,8 @@
 #define LP873X_BUCK0_CTRL_1_BUCK0_RDIS_EN	BIT(2)
 #define LP873X_BUCK0_CTRL_1_BUCK0_EN_PIN_CTRL	BIT(1)
 #define LP873X_BUCK0_CTRL_1_BUCK0_EN		BIT(0)
+#define LP873X_BUCK_ENABLE_MASK			(BIT(0) | BIT(1))
+#define	LP873X_BUCK_DISABLE_VAL			BIT(1)
 
 #define LP873X_BUCK0_CTRL_2_BUCK0_ILIM		0x38
 #define LP873X_BUCK0_CTRL_2_BUCK0_SLEW_RATE	0x07
@@ -96,6 +98,8 @@
 #define LP873X_LDO0_CTRL_LDO0_RDIS_EN		BIT(2)
 #define LP873X_LDO0_CTRL_LDO0_EN_PIN_CTRL	BIT(1)
 #define LP873X_LDO0_CTRL_LDO0_EN		BIT(0)
+#define LP873X_LDO_ENABLE_MASK			(BIT(0) | BIT(1))
+#define LP873X_LDO_DISABLE_VAL			BIT(1)
 
 #define LP873X_LDO1_CTRL_LDO1_RDIS_EN		BIT(2)
 #define LP873X_LDO1_CTRL_LDO1_EN_PIN_CTRL	BIT(1)
-- 
1.9.1
