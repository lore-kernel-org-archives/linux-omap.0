From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/4] regulator: tps65917/palmas: Simplify multiple dereference of pdata->reg_init[idx]
Date: Thu, 5 May 2016 19:29:50 -0500
Message-ID: <1462494592-27909-3-git-send-email-nm@ti.com>
References: <1462494592-27909-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462494592-27909-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Keerthy <j-keerthy@ti.com>, Stephen Warren <swarren@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Converting dt to platform data logic involves picking up information
that is unique per regulator, however we can improve readability of
the code by allocating and referencing pdata->reg_init[idx] once in
the loop.

While at it, use sizeof(*pointer) when allocating pointer. This allows
for structure name changes with minimal code change.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/regulator/palmas-regulator.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 41b4e94a8d7d..3b9206224cd1 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -1492,19 +1492,19 @@ static void palmas_dt_to_pdata(struct device *dev,
 
 	for (idx = 0; idx < ddata->max_reg; idx++) {
 		static struct of_regulator_match *match;
+		struct palmas_reg_init *rinit;
 
 		match = &ddata->palmas_matches[idx];
 
 		if (!match->init_data || !match->of_node)
 			continue;
 
+		rinit = devm_kzalloc(dev, sizeof(*rinit), GFP_KERNEL);
 		pdata->reg_data[idx] = match->init_data;
+		pdata->reg_init[idx] = rinit;
 
-		pdata->reg_init[idx] = devm_kzalloc(dev,
-				sizeof(struct palmas_reg_init), GFP_KERNEL);
-
-		pdata->reg_init[idx]->warm_reset =
-			of_property_read_bool(match->of_node, "ti,warm-reset");
+		rinit->warm_reset = of_property_read_bool(match->of_node,
+							  "ti,warm-reset");
 
 		ret = of_property_read_u32(match->of_node, "ti,roof-floor",
 					   &prop);
@@ -1533,18 +1533,17 @@ static void palmas_dt_to_pdata(struct device *dev,
 					break;
 				}
 			}
-			pdata->reg_init[idx]->roof_floor = econtrol;
+			rinit->roof_floor = econtrol;
 		}
 
 		ret = of_property_read_u32(match->of_node, "ti,mode-sleep",
 					   &prop);
 		if (!ret)
-			pdata->reg_init[idx]->mode_sleep = prop;
+			rinit->mode_sleep = prop;
 
 		ret = of_property_read_bool(match->of_node, "ti,smps-range");
 		if (ret)
-			pdata->reg_init[idx]->vsel =
-				PALMAS_SMPS12_VOLTAGE_RANGE;
+			rinit->vsel = PALMAS_SMPS12_VOLTAGE_RANGE;
 
 		if (idx == PALMAS_REG_LDO8)
 			pdata->enable_ldo8_tracking = of_property_read_bool(
-- 
2.8.0
