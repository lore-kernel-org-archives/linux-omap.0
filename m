From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] regulator: lp87565: Add margin while populating ramp_delay
Date: Tue, 17 Apr 2018 13:48:11 +0530
Message-ID: <1523953091-1582-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: j-keerthy@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

The slew rate might need a +/- 15% margin as per the latest data manual:

	http://www.ti.com/lit/ds/snvsb22/snvsb22.pdf

Hence take a conservative approach to program 85% of the original
hardware slew rate so that the software accommodates the margin
delay while voltage switching. Hence reduce the default ramp_delay
populated in the descriptors also by 15%.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/regulator/lp87565-regulator.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 04a76ec..9ee08d6 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -95,6 +95,10 @@ static int lp87565_buck_set_ramp_delay(struct regulator_dev *rdev,
 
 	rdev->constraints->ramp_delay = lp87565_buck_ramp_delay[reg];
 
+	/* Conservatively give a 15% margin */
+	rdev->constraints->ramp_delay =
+				rdev->constraints->ramp_delay * 85 / 100;
+
 	return 0;
 }
 
@@ -154,32 +158,32 @@ static const struct lp87565_regulator regulators[] = {
 	LP87565_REGULATOR("BUCK0", LP87565_BUCK_0, "buck0", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK0_VOUT, LP87565_BUCK_VSET,
 			  LP87565_REG_BUCK0_CTRL_1,
-			  LP87565_BUCK_CTRL_1_EN, 3800,
+			  LP87565_BUCK_CTRL_1_EN, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK0_CTRL_2),
 	LP87565_REGULATOR("BUCK1", LP87565_BUCK_1, "buck1", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK1_VOUT, LP87565_BUCK_VSET,
 			  LP87565_REG_BUCK1_CTRL_1,
-			  LP87565_BUCK_CTRL_1_EN, 3800,
+			  LP87565_BUCK_CTRL_1_EN, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK1_CTRL_2),
 	LP87565_REGULATOR("BUCK2", LP87565_BUCK_2, "buck2", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK2_VOUT, LP87565_BUCK_VSET,
 			  LP87565_REG_BUCK2_CTRL_1,
-			  LP87565_BUCK_CTRL_1_EN, 3800,
+			  LP87565_BUCK_CTRL_1_EN, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK2_CTRL_2),
 	LP87565_REGULATOR("BUCK3", LP87565_BUCK_3, "buck3", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK3_VOUT, LP87565_BUCK_VSET,
 			  LP87565_REG_BUCK3_CTRL_1,
-			  LP87565_BUCK_CTRL_1_EN, 3800,
+			  LP87565_BUCK_CTRL_1_EN, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK3_CTRL_2),
 	LP87565_REGULATOR("BUCK10", LP87565_BUCK_10, "buck10", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK0_VOUT, LP87565_BUCK_VSET,
 			  LP87565_REG_BUCK0_CTRL_1,
-			  LP87565_BUCK_CTRL_1_EN, 3800,
+			  LP87565_BUCK_CTRL_1_EN, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK0_CTRL_2),
 	LP87565_REGULATOR("BUCK23", LP87565_BUCK_23, "buck23", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK2_VOUT, LP87565_BUCK_VSET,
 			  LP87565_REG_BUCK2_CTRL_1,
-			  LP87565_BUCK_CTRL_1_EN, 3800,
+			  LP87565_BUCK_CTRL_1_EN, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK2_CTRL_2),
 };
 
-- 
1.9.1
