From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/4] regulator: tps65917/palmas: Handle possible memory allocation failure
Date: Thu, 5 May 2016 19:29:51 -0500
Message-ID: <1462494592-27909-4-git-send-email-nm@ti.com>
References: <1462494592-27909-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462494592-27909-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Keerthy <j-keerthy@ti.com>, Stephen Warren <swarren@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Stop the palmas regulator driver from imagining that the allocations
will always succeed. Since regulator dt nodes are optional in nature and
can be described in downstream drivers via platform data, continue to
maintain code flow as prior when of node is not found.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/regulator/palmas-regulator.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 3b9206224cd1..faa389be7ca3 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -1467,10 +1467,10 @@ static struct palmas_pmic_driver_data tps65917_ddata = {
 	.ldo_register = tps65917_ldo_registration,
 };
 
-static void palmas_dt_to_pdata(struct device *dev,
-			       struct device_node *node,
-			       struct palmas_pmic_platform_data *pdata,
-			       struct palmas_pmic_driver_data *ddata)
+static int palmas_dt_to_pdata(struct device *dev,
+			      struct device_node *node,
+			      struct palmas_pmic_platform_data *pdata,
+			      struct palmas_pmic_driver_data *ddata)
 {
 	struct device_node *regulators;
 	u32 prop;
@@ -1479,7 +1479,7 @@ static void palmas_dt_to_pdata(struct device *dev,
 	regulators = of_get_child_by_name(node, "regulators");
 	if (!regulators) {
 		dev_info(dev, "regulator node not found\n");
-		return;
+		return 0;
 	}
 
 	ret = of_regulator_match(dev, regulators, ddata->palmas_matches,
@@ -1487,7 +1487,7 @@ static void palmas_dt_to_pdata(struct device *dev,
 	of_node_put(regulators);
 	if (ret < 0) {
 		dev_err(dev, "Error parsing regulator init data: %d\n", ret);
-		return;
+		return 0;
 	}
 
 	for (idx = 0; idx < ddata->max_reg; idx++) {
@@ -1500,6 +1500,9 @@ static void palmas_dt_to_pdata(struct device *dev,
 			continue;
 
 		rinit = devm_kzalloc(dev, sizeof(*rinit), GFP_KERNEL);
+		if (!rinit)
+			return -ENOMEM;
+
 		pdata->reg_data[idx] = match->init_data;
 		pdata->reg_init[idx] = rinit;
 
@@ -1552,6 +1555,8 @@ static void palmas_dt_to_pdata(struct device *dev,
 	}
 
 	pdata->ldo6_vibrator = of_property_read_bool(node, "ti,ldo6-vibrator");
+
+	return 0;
 }
 
 static const struct of_device_id of_palmas_match_tbl[] = {
@@ -1633,7 +1638,9 @@ static int palmas_regulators_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pmic);
 	pmic->palmas->pmic_ddata = driver_data;
 
-	palmas_dt_to_pdata(&pdev->dev, node, pdata, driver_data);
+	ret = palmas_dt_to_pdata(&pdev->dev, node, pdata, driver_data);
+	if (ret)
+		return ret;
 
 	ret = palmas_smps_read(palmas, PALMAS_SMPS_CTRL, &reg);
 	if (ret)
-- 
2.8.0
