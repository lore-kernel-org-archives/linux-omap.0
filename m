From: Keerthy <j-keerthy@TI.COM>
Subject: [PATCH 2/2] regulator: Palmas: Add has_regen3 check for TPS659038
Date: Tue, 17 Mar 2015 15:56:05 +0530
Message-ID: <1426587965-23553-3-git-send-email-j-keerthy@ti.com>
References: <1426587965-23553-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45965 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487AbbCQK0R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Mar 2015 06:26:17 -0400
In-Reply-To: <1426587965-23553-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@kernel.org, sameo@linux.intel.com, lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, j-keerthy@TI.COM

Palmas driver is used to cater to even TPS659038 but TPS659038 does not have
REGEN3 resource. Adding another field in the driver data to check on that.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
Tested for the regulator enumerations on DRA7 and BEAGLE-X15 boards.

REGEN3 is rightly not registered on TPS659038.

 drivers/regulator/palmas-regulator.c | 9 ++++++++-
 include/linux/mfd/palmas.h           | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 1819831..a3c56b6 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -916,6 +916,9 @@ static int palmas_ldo_registration(struct palmas_pmic *pmic,
 			    (id == PALMAS_REG_LDO6))
 				desc->enable_time = 2000;
 		} else {
+			if (!ddata->has_regen3 && id == PALMAS_REG_REGEN3)
+				continue;
+
 			desc->n_voltages = 1;
 			if (reg_init && reg_init->roof_floor)
 				desc->ops = &palmas_ops_ext_control_extreg;
@@ -1398,6 +1401,7 @@ static struct palmas_pmic_driver_data palmas_ddata = {
 	.ldo_begin = PALMAS_REG_LDO1,
 	.ldo_end = PALMAS_REG_LDOUSB,
 	.max_reg = PALMAS_NUM_REGS,
+	.has_regen3 = true,
 	.palmas_regs_info = palmas_generic_regs_info,
 	.palmas_matches = palmas_matches,
 	.sleep_req_info = palma_sleep_req_info,
@@ -1411,6 +1415,7 @@ static struct palmas_pmic_driver_data tps65917_ddata = {
 	.ldo_begin = TPS65917_REG_LDO1,
 	.ldo_end = TPS65917_REG_LDO5,
 	.max_reg = TPS65917_NUM_REGS,
+	.has_regen3 = true,
 	.palmas_regs_info = tps65917_regs_info,
 	.palmas_matches = tps65917_matches,
 	.sleep_req_info = tps65917_sleep_req_info,
@@ -1572,9 +1577,11 @@ static int palmas_regulators_probe(struct platform_device *pdev)
 	if (!pmic)
 		return -ENOMEM;
 
-	if (of_device_is_compatible(node, "ti,tps659038-pmic"))
+	if (of_device_is_compatible(node, "ti,tps659038-pmic")) {
 		palmas_generic_regs_info[PALMAS_REG_REGEN2].ctrl_addr =
 							TPS659038_REGEN2_CTRL;
+		palmas_ddata.has_regen3 = false;
+	}
 
 	pmic->dev = &pdev->dev;
 	pmic->palmas = palmas;
diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index ee7b1ce..bb270bd 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -117,6 +117,7 @@ struct palmas_pmic_driver_data {
 	int ldo_begin;
 	int ldo_end;
 	int max_reg;
+	bool has_regen3;
 	struct palmas_regs_info *palmas_regs_info;
 	struct of_regulator_match *palmas_matches;
 	struct palmas_sleep_requestor_info *sleep_req_info;
-- 
1.9.1

