From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 3/3] regulator: lp87565: Add 4-phase lp87561 regulator support
Date: Wed, 15 May 2019 15:38:48 +0530
Message-ID: <20190515100848.19560-4-j-keerthy@ti.com>
References: <20190515100848.19560-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515100848.19560-1-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

The LP8756x family has a single output 4-phase regulator
configuration. Add support for the same. The control
lies in the master buck which is buck0 for 4-phase
configuration. Enable/disable/voltage set happen via
buck0 registers.

Data Sheet: https://www.ti.com/lit/ds/symlink/lp87561-q1.pdf

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/regulator/lp87565-regulator.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 81eb4b890c0c..8255650df1cd 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -153,6 +153,12 @@ static const struct lp87565_regulator regulators[] = {
 			  LP87565_REG_BUCK2_CTRL_1,
 			  LP87565_BUCK_CTRL_1_EN, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK2_CTRL_2),
+	LP87565_REGULATOR("BUCK3210", LP87565_BUCK_3210, "buck3210",
+			  lp87565_buck_ops, 256, LP87565_REG_BUCK0_VOUT,
+			  LP87565_BUCK_VSET, LP87565_REG_BUCK0_CTRL_1,
+			  LP87565_BUCK_CTRL_1_EN |
+			  LP87565_BUCK_CTRL_1_FPWM_MP_0_2, 3230,
+			  buck0_1_2_3_ranges, LP87565_REG_BUCK0_CTRL_2),
 };
 
 static int lp87565_regulator_probe(struct platform_device *pdev)
@@ -172,6 +178,9 @@ static int lp87565_regulator_probe(struct platform_device *pdev)
 	if (lp87565->dev_type == LP87565_DEVICE_TYPE_LP87565_Q1) {
 		min_idx = LP87565_BUCK_10;
 		max_idx = LP87565_BUCK_23;
+	} else if (lp87565->dev_type == LP87565_DEVICE_TYPE_LP87561_Q1) {
+		min_idx = LP87565_BUCK_3210;
+		max_idx = LP87565_BUCK_3210;
 	}
 
 	for (i = min_idx; i <= max_idx; i++) {
-- 
2.17.1
