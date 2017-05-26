From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps65917: Add support for SMPS12" to the regulator tree
Date: Fri, 26 May 2017 12:42:04 +0100
Message-ID: <E1dEDd6-0000nW-Co@debutante>
References: <1495197739-17446-4-git-send-email-j-keerthy@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1495197739-17446-4-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>broonie@kernel.orglee.jones@linaro.org, robh+dt@kernel.org, j-keerthy@ti.com, t-kristo@ti.com, tony@atomide.com, mark.rutland@arm.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.orglinux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: tps65917: Add support for SMPS12

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From be035303182a1260803a1871065d7b1e67c9ebe9 Mon Sep 17 00:00:00 2001
From: Keerthy <j-keerthy@ti.com>
Date: Tue, 23 May 2017 17:46:56 +0530
Subject: [PATCH] regulator: tps65917: Add support for SMPS12

App support for SMPS12 dual phase regulator.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/palmas-regulator.c | 18 +++++++++++++++---
 include/linux/mfd/palmas.h           |  2 ++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 31ae5ee3a80d..8018a44ed4f7 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -264,6 +264,13 @@ static struct palmas_regs_info tps65917_regs_info[] = {
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
@@ -367,6 +374,7 @@ static struct palmas_sleep_requestor_info tps65917_sleep_req_info[] = {
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
@@ -1427,6 +1436,7 @@ static struct of_regulator_match tps65917_matches[] = {
 	{ .name = "smps3", },
 	{ .name = "smps4", },
 	{ .name = "smps5", },
+	{ .name = "smps12",},
 	{ .name = "ldo1", },
 	{ .name = "ldo2", },
 	{ .name = "ldo3", },
@@ -1455,7 +1465,7 @@ static struct palmas_pmic_driver_data palmas_ddata = {
 
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
index 5c9a1d44c125..6dec43826303 100644
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
2.11.0
