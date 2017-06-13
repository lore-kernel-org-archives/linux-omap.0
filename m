From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/2] regulator: tps65910: Allow supply references to the same
 chip
Date: Tue, 13 Jun 2017 15:58:54 +0200
Message-ID: <32b58e90af76433e42051d3b370cb071903e5402.1497361550.git.mirq-linux@rere.qmqm.pl>
References: <0c5e903eed2005e39bdf7abdd1061dffc078109a.1497361550.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0c5e903eed2005e39bdf7abdd1061dffc078109a.1497361550.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This allows for (acyclic) references from tps6591x supplies to
its outputs.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/tps65910-regulator.c | 39 ++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index 81672a58fcc23..f7987168ba4ed 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -1082,7 +1082,8 @@ static int tps65910_probe(struct platform_device *pdev)
 	struct tps65910_reg *pmic;
 	struct tps65910_board *pmic_plat_data;
 	struct of_regulator_match *tps65910_reg_matches = NULL;
-	int i, err;
+	bool made_progress;
+	int i, err, pending;
 
 	pmic_plat_data = dev_get_platdata(tps65910->dev);
 	if (!pmic_plat_data && tps65910->dev->of_node)
@@ -1146,6 +1147,7 @@ static int tps65910_probe(struct platform_device *pdev)
 	if (!pmic->rdev)
 		return -ENOMEM;
 
+	/* prepare regulator description */
 	for (i = 0; i < pmic->num_regulators; i++, info++) {
 		/* Register the regulators */
 		pmic->info[i] = info;
@@ -1196,18 +1198,32 @@ static int tps65910_probe(struct platform_device *pdev)
 		pmic->desc[i].owner = THIS_MODULE;
 		pmic->desc[i].enable_reg = pmic->get_ctrl_reg(i);
 		pmic->desc[i].enable_mask = TPS65910_SUPPLY_STATE_ENABLED;
+	}
+
+	/* Register regulators - loop, as one regulator's output
+	 * might be anothers input */
+
+	config.dev = pmic->mfd->dev;
+	config.driver_data = pmic;
+	config.regmap = pmic->mfd->regmap;
+	pending = pmic->num_regulators;
+
+reg_retry:
+	made_progress = false;
+	for (i = 0; i < pmic->num_regulators; i++) {
+		if (pmic->rdev[i])
+			continue;
 
-		config.dev = tps65910->dev;
 		config.init_data = pmic_plat_data->tps65910_pmic_init_data[i];
-		config.driver_data = pmic;
-		config.regmap = tps65910->regmap;
-
 		if (tps65910_reg_matches)
 			config.of_node = tps65910_reg_matches[i].of_node;
 
 		rdev = devm_regulator_register(&pdev->dev, &pmic->desc[i],
 					       &config);
 		if (IS_ERR(rdev)) {
+			if (PTR_ERR(rdev) == -EPROBE_DEFER)
+				continue;
+
 			dev_err(tps65910->dev,
 				"failed to register %s regulator\n",
 				pdev->name);
@@ -1216,8 +1232,19 @@ static int tps65910_probe(struct platform_device *pdev)
 
 		/* Save regulator for cleanup */
 		pmic->rdev[i] = rdev;
+
+		made_progress = true;
+		--pending;
 	}
-	return 0;
+
+	/* all done? */
+	if (!pending)
+		return 0;
+
+	if (made_progress)
+		goto reg_retry;
+
+	return -EPROBE_DEFER;
 }
 
 static void tps65910_shutdown(struct platform_device *pdev)
-- 
2.11.0
