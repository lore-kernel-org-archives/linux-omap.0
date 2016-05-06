From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps65917/palmas: Simplify multiple dereference of match->of_node" to the regulator tree
Date: Fri, 06 May 2016 18:18:52 +0100
Message-ID: <E1ayjOu-0006rR-IJ@debutante>
References: <1462494592-27909-5-git-send-email-nm@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462494592-27909-5-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.orgMark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Keerthy <j-keerthy@ti.com>, Stephen Warren <swarren@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: tps65917/palmas: Simplify multiple dereference of match->of_node

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

>From 6c7d614fa22d32d038b5a6e88d71acb2711e7035 Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Thu, 5 May 2016 19:29:52 -0500
Subject: [PATCH] regulator: tps65917/palmas: Simplify multiple dereference of
 match->of_node

Just dereference match->of_node once instead of using match->of_node.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.8.1
