From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/4] regulator: tps65917/palmas: Simplify multiple dereference of ddata->palmas_matches[idx]
Date: Thu, 5 May 2016 19:29:49 -0500
Message-ID: <1462494592-27909-2-git-send-email-nm@ti.com>
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
the code by dereferencing ddata->palmas_matches[idx] once in the loop.

While at it fix reuse of generic palmas_matches common variable
while reporting error for a specific regulator (which may be from
65917/palmas list).

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/regulator/palmas-regulator.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index c83e06b2cedb..41b4e94a8d7d 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -1491,21 +1491,23 @@ static void palmas_dt_to_pdata(struct device *dev,
 	}
 
 	for (idx = 0; idx < ddata->max_reg; idx++) {
-		if (!ddata->palmas_matches[idx].init_data ||
-		    !ddata->palmas_matches[idx].of_node)
+		static struct of_regulator_match *match;
+
+		match = &ddata->palmas_matches[idx];
+
+		if (!match->init_data || !match->of_node)
 			continue;
 
-		pdata->reg_data[idx] = ddata->palmas_matches[idx].init_data;
+		pdata->reg_data[idx] = match->init_data;
 
 		pdata->reg_init[idx] = devm_kzalloc(dev,
 				sizeof(struct palmas_reg_init), GFP_KERNEL);
 
 		pdata->reg_init[idx]->warm_reset =
-			of_property_read_bool(ddata->palmas_matches[idx].of_node,
-					      "ti,warm-reset");
+			of_property_read_bool(match->of_node, "ti,warm-reset");
 
-		ret = of_property_read_u32(ddata->palmas_matches[idx].of_node,
-					   "ti,roof-floor", &prop);
+		ret = of_property_read_u32(match->of_node, "ti,roof-floor",
+					   &prop);
 		/* EINVAL: Property not found */
 		if (ret != -EINVAL) {
 			int econtrol;
@@ -1527,27 +1529,26 @@ static void palmas_dt_to_pdata(struct device *dev,
 					WARN_ON(1);
 					dev_warn(dev,
 						 "%s: Invalid roof-floor option: %u\n",
-					     palmas_matches[idx].name, prop);
+						 match->name, prop);
 					break;
 				}
 			}
 			pdata->reg_init[idx]->roof_floor = econtrol;
 		}
 
-		ret = of_property_read_u32(ddata->palmas_matches[idx].of_node,
-					   "ti,mode-sleep", &prop);
+		ret = of_property_read_u32(match->of_node, "ti,mode-sleep",
+					   &prop);
 		if (!ret)
 			pdata->reg_init[idx]->mode_sleep = prop;
 
-		ret = of_property_read_bool(ddata->palmas_matches[idx].of_node,
-					    "ti,smps-range");
+		ret = of_property_read_bool(match->of_node, "ti,smps-range");
 		if (ret)
 			pdata->reg_init[idx]->vsel =
 				PALMAS_SMPS12_VOLTAGE_RANGE;
 
 		if (idx == PALMAS_REG_LDO8)
 			pdata->enable_ldo8_tracking = of_property_read_bool(
-						ddata->palmas_matches[idx].of_node,
+						match->of_node,
 						"ti,enable-ldo8-tracking");
 	}
 
-- 
2.8.0
