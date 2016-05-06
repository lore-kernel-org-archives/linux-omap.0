From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps65917/palmas: Simplify multiple dereference of ddata->palmas_matches[idx]" to the regulator tree
Date: Fri, 06 May 2016 18:19:01 +0100
Message-ID: <E1ayjP3-0006uN-CF@debutante>
References: <1462494592-27909-2-git-send-email-nm@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462494592-27909-2-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.orgMark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Keerthy <j-keerthy@ti.com>, Stephen Warren <swarren@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: tps65917/palmas: Simplify multiple dereference of ddata->palmas_matches[idx]

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

>From 036d193d3337365e0d69cff9bb2593bfc1210e7b Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Thu, 5 May 2016 19:29:49 -0500
Subject: [PATCH] regulator: tps65917/palmas: Simplify multiple dereference of
 ddata->palmas_matches[idx]

Converting dt to platform data logic involves picking up information
that is unique per regulator, however we can improve readability of
the code by dereferencing ddata->palmas_matches[idx] once in the loop.

While at it fix reuse of generic palmas_matches common variable
while reporting error for a specific regulator (which may be from
65917/palmas list).

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.8.1
