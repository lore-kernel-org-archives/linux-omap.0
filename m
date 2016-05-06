From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 4/4] regulator: tps65917/palmas: Simplify multiple dereference of match->of_node
Date: Thu, 5 May 2016 19:29:52 -0500
Message-ID: <1462494592-27909-5-git-send-email-nm@ti.com>
References: <1462494592-27909-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462494592-27909-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Keerthy <j-keerthy@ti.com>, Stephen Warren <swarren@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Just dereference match->of_node once instead of using match->of_node.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/regulator/palmas-regulator.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index faa389be7ca3..f11d41dad9c1 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -1493,10 +1493,12 @@ static int palmas_dt_to_pdata(struct device *dev,
 	for (idx = 0; idx < ddata->max_reg; idx++) {
 		static struct of_regulator_match *match;
 		struct palmas_reg_init *rinit;
+		struct device_node *np;
 
 		match = &ddata->palmas_matches[idx];
+		np = match->of_node;
 
-		if (!match->init_data || !match->of_node)
+		if (!match->init_data || !np)
 			continue;
 
 		rinit = devm_kzalloc(dev, sizeof(*rinit), GFP_KERNEL);
@@ -1506,11 +1508,8 @@ static int palmas_dt_to_pdata(struct device *dev,
 		pdata->reg_data[idx] = match->init_data;
 		pdata->reg_init[idx] = rinit;
 
-		rinit->warm_reset = of_property_read_bool(match->of_node,
-							  "ti,warm-reset");
-
-		ret = of_property_read_u32(match->of_node, "ti,roof-floor",
-					   &prop);
+		rinit->warm_reset = of_property_read_bool(np, "ti,warm-reset");
+		ret = of_property_read_u32(np, "ti,roof-floor", &prop);
 		/* EINVAL: Property not found */
 		if (ret != -EINVAL) {
 			int econtrol;
@@ -1539,19 +1538,17 @@ static int palmas_dt_to_pdata(struct device *dev,
 			rinit->roof_floor = econtrol;
 		}
 
-		ret = of_property_read_u32(match->of_node, "ti,mode-sleep",
-					   &prop);
+		ret = of_property_read_u32(np, "ti,mode-sleep", &prop);
 		if (!ret)
 			rinit->mode_sleep = prop;
 
-		ret = of_property_read_bool(match->of_node, "ti,smps-range");
+		ret = of_property_read_bool(np, "ti,smps-range");
 		if (ret)
 			rinit->vsel = PALMAS_SMPS12_VOLTAGE_RANGE;
 
 		if (idx == PALMAS_REG_LDO8)
 			pdata->enable_ldo8_tracking = of_property_read_bool(
-						match->of_node,
-						"ti,enable-ldo8-tracking");
+						np, "ti,enable-ldo8-tracking");
 	}
 
 	pdata->ldo6_vibrator = of_property_read_bool(node, "ti,ldo6-vibrator");
-- 
2.8.0
