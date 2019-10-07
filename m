From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: pbias: Get rid of struct pbias_regulator_data" to the regulator tree
Date: Mon,  7 Oct 2019 14:03:19 +0100 (BST)
Message-ID: <20191007130319.817382741D8E@ypsilon.sirena.org.uk>
References: <20191007114320.20977-1-axel.lin@ingics.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191007114320.20977-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Balaji T K <balajitk@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: pbias: Get rid of struct pbias_regulator_data

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.5

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

>From df8c542ee853f22dc0e5584ba0a70de397a3d73e Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 7 Oct 2019 19:43:20 +0800
Subject: [PATCH] regulator: pbias: Get rid of struct pbias_regulator_data

Only the desc field is really used, so use struct regulator_desc instead.
Then struct pbias_regulator_data can be removed.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20191007114320.20977-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/pbias-regulator.c | 69 +++++++++++------------------
 1 file changed, 26 insertions(+), 43 deletions(-)

diff --git a/drivers/regulator/pbias-regulator.c b/drivers/regulator/pbias-regulator.c
index a59811060bdc..bfc15dd3f730 100644
--- a/drivers/regulator/pbias-regulator.c
+++ b/drivers/regulator/pbias-regulator.c
@@ -38,15 +38,6 @@ struct pbias_reg_info {
 	int n_voltages;
 };
 
-struct pbias_regulator_data {
-	struct regulator_desc desc;
-	void __iomem *pbias_addr;
-	struct regulator_dev *dev;
-	struct regmap *syscon;
-	const struct pbias_reg_info *info;
-	int voltage;
-};
-
 struct pbias_of_data {
 	unsigned int offset;
 };
@@ -157,13 +148,13 @@ MODULE_DEVICE_TABLE(of, pbias_of_match);
 static int pbias_regulator_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct pbias_regulator_data *drvdata;
 	struct resource *res;
 	struct regulator_config cfg = { };
+	struct regulator_desc *desc;
+	struct regulator_dev *rdev;
 	struct regmap *syscon;
 	const struct pbias_reg_info *info;
-	int ret = 0;
-	int count, idx, data_idx = 0;
+	int ret, count, idx;
 	const struct pbias_of_data *data;
 	unsigned int offset;
 
@@ -172,10 +163,8 @@ static int pbias_regulator_probe(struct platform_device *pdev)
 	if (count < 0)
 		return count;
 
-	drvdata = devm_kcalloc(&pdev->dev,
-			       count, sizeof(struct pbias_regulator_data),
-			       GFP_KERNEL);
-	if (!drvdata)
+	desc = devm_kcalloc(&pdev->dev, count, sizeof(*desc), GFP_KERNEL);
+	if (!desc)
 		return -ENOMEM;
 
 	syscon = syscon_regmap_lookup_by_phandle(np, "syscon");
@@ -198,7 +187,7 @@ static int pbias_regulator_probe(struct platform_device *pdev)
 	cfg.regmap = syscon;
 	cfg.dev = &pdev->dev;
 
-	for (idx = 0; idx < PBIAS_NUM_REGS && data_idx < count; idx++) {
+	for (idx = 0; idx < PBIAS_NUM_REGS && count; idx++) {
 		if (!pbias_matches[idx].init_data ||
 			!pbias_matches[idx].of_node)
 			continue;
@@ -207,41 +196,35 @@ static int pbias_regulator_probe(struct platform_device *pdev)
 		if (!info)
 			return -ENODEV;
 
-		drvdata[data_idx].syscon = syscon;
-		drvdata[data_idx].info = info;
-		drvdata[data_idx].desc.name = info->name;
-		drvdata[data_idx].desc.owner = THIS_MODULE;
-		drvdata[data_idx].desc.type = REGULATOR_VOLTAGE;
-		drvdata[data_idx].desc.ops = &pbias_regulator_voltage_ops;
-		drvdata[data_idx].desc.volt_table = info->pbias_volt_table;
-		drvdata[data_idx].desc.n_voltages = info->n_voltages;
-		drvdata[data_idx].desc.enable_time = info->enable_time;
-		drvdata[data_idx].desc.vsel_reg = offset;
-		drvdata[data_idx].desc.vsel_mask = info->vmode;
-		drvdata[data_idx].desc.enable_reg = offset;
-		drvdata[data_idx].desc.enable_mask = info->enable_mask;
-		drvdata[data_idx].desc.enable_val = info->enable;
-		drvdata[data_idx].desc.disable_val = info->disable_val;
+		desc->name = info->name;
+		desc->owner = THIS_MODULE;
+		desc->type = REGULATOR_VOLTAGE;
+		desc->ops = &pbias_regulator_voltage_ops;
+		desc->volt_table = info->pbias_volt_table;
+		desc->n_voltages = info->n_voltages;
+		desc->enable_time = info->enable_time;
+		desc->vsel_reg = offset;
+		desc->vsel_mask = info->vmode;
+		desc->enable_reg = offset;
+		desc->enable_mask = info->enable_mask;
+		desc->enable_val = info->enable;
+		desc->disable_val = info->disable_val;
 
 		cfg.init_data = pbias_matches[idx].init_data;
-		cfg.driver_data = &drvdata[data_idx];
 		cfg.of_node = pbias_matches[idx].of_node;
 
-		drvdata[data_idx].dev = devm_regulator_register(&pdev->dev,
-					&drvdata[data_idx].desc, &cfg);
-		if (IS_ERR(drvdata[data_idx].dev)) {
-			ret = PTR_ERR(drvdata[data_idx].dev);
+		rdev = devm_regulator_register(&pdev->dev, desc, &cfg);
+		if (IS_ERR(rdev)) {
+			ret = PTR_ERR(rdev);
 			dev_err(&pdev->dev,
 				"Failed to register regulator: %d\n", ret);
-			goto err_regulator;
+			return ret;
 		}
-		data_idx++;
+		desc++;
+		count--;
 	}
 
-	platform_set_drvdata(pdev, drvdata);
-
-err_regulator:
-	return ret;
+	return 0;
 }
 
 static struct platform_driver pbias_regulator_driver = {
-- 
2.20.1
