From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 3/3] regulator: tps65917: Add support for SMPS12
Date: Tue, 23 May 2017 17:46:56 +0530
Message-ID: <1495541816-14801-4-git-send-email-j-keerthy@ti.com>
References: <1495541816-14801-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1495541816-14801-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org
Cc: j-keerthy@ti.com, t-kristo@ti.com, tony@atomide.com, mark.rutland@arm.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, afd@ti.com
List-Id: linux-omap@vger.kernel.org

App support for SMPS12 dual phase regulator.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---

Changes in v2:

  * Added Lee Jones's Ack.

 drivers/regulator/palmas-regulator.c | 18 +++++++++++++++---
 include/linux/mfd/palmas.h           |  2 ++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 31ae5ee..8018a44 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -264,6 +264,13 @@
 		.sleep_id	= TPS65917_EXTERNAL_REQSTR_ID_SMPS5,
 	},
 	{
+		.name		= "SMPS12",
+		.sname		= "smps1-in",
+		.vsel_addr	= TPS65917_SMPS1_VOLTAGE,
+		.ctrl_addr	= TPS65917_SMPS1_CTRL,
+		.sleep_id	= TPS65917_EXTERNAL_REQSTR_ID_SMPS12,
+	},
+	{
 		.name		= "LDO1",
 		.sname		= "ldo1-in",
 		.vsel_addr	= TPS65917_LDO1_VOLTAGE,
@@ -367,6 +374,7 @@
 	EXTERNAL_REQUESTOR_TPS65917(SMPS3, 1, 2),
 	EXTERNAL_REQUESTOR_TPS65917(SMPS4, 1, 3),
 	EXTERNAL_REQUESTOR_TPS65917(SMPS5, 1, 4),
+	EXTERNAL_REQUESTOR_TPS65917(SMPS12, 1, 5),
 	EXTERNAL_REQUESTOR_TPS65917(LDO1, 2, 0),
 	EXTERNAL_REQUESTOR_TPS65917(LDO2, 2, 1),
 	EXTERNAL_REQUESTOR_TPS65917(LDO3, 2, 2),
@@ -1305,7 +1313,8 @@ static int tps65917_smps_registration(struct palmas_pmic *pmic,
 		 */
 		desc = &pmic->desc[id];
 		desc->n_linear_ranges = 3;
-		if ((id == TPS65917_REG_SMPS2) && pmic->smps12)
+		if ((id == TPS65917_REG_SMPS2 || id == TPS65917_REG_SMPS1) &&
+		    pmic->smps12)
 			continue;
 
 		/* Initialise sleep/init values from platform data */
@@ -1427,6 +1436,7 @@ static int tps65917_smps_registration(struct palmas_pmic *pmic,
 	{ .name = "smps3", },
 	{ .name = "smps4", },
 	{ .name = "smps5", },
+	{ .name = "smps12",},
 	{ .name = "ldo1", },
 	{ .name = "ldo2", },
 	{ .name = "ldo3", },
@@ -1455,7 +1465,7 @@ static int tps65917_smps_registration(struct palmas_pmic *pmic,
 
 static struct palmas_pmic_driver_data tps65917_ddata = {
 	.smps_start = TPS65917_REG_SMPS1,
-	.smps_end = TPS65917_REG_SMPS5,
+	.smps_end = TPS65917_REG_SMPS12,
 	.ldo_begin = TPS65917_REG_LDO1,
 	.ldo_end = TPS65917_REG_LDO5,
 	.max_reg = TPS65917_NUM_REGS,
@@ -1643,8 +1653,10 @@ static int palmas_regulators_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (reg & PALMAS_SMPS_CTRL_SMPS12_SMPS123_EN)
+	if (reg & PALMAS_SMPS_CTRL_SMPS12_SMPS123_EN) {
 		pmic->smps123 = 1;
+		pmic->smps12 = 1;
+	}
 
 	if (reg & PALMAS_SMPS_CTRL_SMPS45_SMPS457_EN)
 		pmic->smps457 = 1;
diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index 5c9a1d4..6dec438 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -250,6 +250,7 @@ enum tps65917_regulators {
 	TPS65917_REG_SMPS3,
 	TPS65917_REG_SMPS4,
 	TPS65917_REG_SMPS5,
+	TPS65917_REG_SMPS12,
 	/* LDO regulators */
 	TPS65917_REG_LDO1,
 	TPS65917_REG_LDO2,
@@ -317,6 +318,7 @@ enum tps65917_external_requestor_id {
 	TPS65917_EXTERNAL_REQSTR_ID_SMPS3,
 	TPS65917_EXTERNAL_REQSTR_ID_SMPS4,
 	TPS65917_EXTERNAL_REQSTR_ID_SMPS5,
+	TPS65917_EXTERNAL_REQSTR_ID_SMPS12,
 	TPS65917_EXTERNAL_REQSTR_ID_LDO1,
 	TPS65917_EXTERNAL_REQSTR_ID_LDO2,
 	TPS65917_EXTERNAL_REQSTR_ID_LDO3,
-- 
1.9.1
