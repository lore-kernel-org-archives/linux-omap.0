From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3] mfd: tps65217: Introduce dependency on CONFIG_OF
Date: Wed, 30 Aug 2017 11:20:08 +0530
Message-ID: <1504072208-28888-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: javier@dowhile0.org, eballetbo@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, tony@atomide.com, b.zolnierkie@samsung.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Currently the driver boots only via device tree hence add a
dependency on CONFIG_OF. This leaves with a bunch of unused code
so clean that up. This patch also makes use of probe_new function
in place of the probe function so as to avoid passing i2c_device_id.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v3:

  * Added more details to commit log.
  * No changes in code. Rebased to latest next branch.

Changes in v2:

  * Cleaned up chip_id and data attached to the match.
  * Cleaned up i2c_dev_id
  * dropped the rest of the patches in series for now

Boot tested and checked for regulator registrations on am335x-boneblack

 drivers/mfd/Kconfig                    |  2 +-
 drivers/mfd/tps65217.c                 | 35 +++++-----------------------------
 drivers/regulator/tps65217-regulator.c |  5 -----
 drivers/video/backlight/tps65217_bl.c  | 14 +++-----------
 include/linux/mfd/tps65217.h           |  6 ------
 5 files changed, 9 insertions(+), 53 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 95e8683..8177cbc 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1326,7 +1326,7 @@ config MFD_TPS65090
 
 config MFD_TPS65217
 	tristate "TI TPS65217 Power Management / White LED chips"
-	depends on I2C
+	depends on I2C && OF
 	select MFD_CORE
 	select REGMAP_I2C
 	select IRQ_DOMAIN
diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index f769c7d..e5a1a57 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -311,37 +311,20 @@ static bool tps65217_volatile_reg(struct device *dev, unsigned int reg)
 };
 
 static const struct of_device_id tps65217_of_match[] = {
-	{ .compatible = "ti,tps65217", .data = (void *)TPS65217 },
+	{ .compatible = "ti,tps65217"},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, tps65217_of_match);
 
-static int tps65217_probe(struct i2c_client *client,
-				const struct i2c_device_id *ids)
+static int tps65217_probe(struct i2c_client *client)
 {
 	struct tps65217 *tps;
 	unsigned int version;
-	unsigned long chip_id = ids->driver_data;
-	const struct of_device_id *match;
 	bool status_off = false;
 	int ret;
 
-	if (client->dev.of_node) {
-		match = of_match_device(tps65217_of_match, &client->dev);
-		if (!match) {
-			dev_err(&client->dev,
-				"Failed to find matching dt id\n");
-			return -EINVAL;
-		}
-		chip_id = (unsigned long)match->data;
-		status_off = of_property_read_bool(client->dev.of_node,
-					"ti,pmic-shutdown-controller");
-	}
-
-	if (!chip_id) {
-		dev_err(&client->dev, "id is null.\n");
-		return -ENODEV;
-	}
+	status_off = of_property_read_bool(client->dev.of_node,
+					   "ti,pmic-shutdown-controller");
 
 	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
 	if (!tps)
@@ -349,7 +332,6 @@ static int tps65217_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, tps);
 	tps->dev = &client->dev;
-	tps->id = chip_id;
 
 	tps->regmap = devm_regmap_init_i2c(client, &tps65217_regmap_config);
 	if (IS_ERR(tps->regmap)) {
@@ -418,19 +400,12 @@ static int tps65217_remove(struct i2c_client *client)
 	return 0;
 }
 
-static const struct i2c_device_id tps65217_id_table[] = {
-	{"tps65217", TPS65217},
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(i2c, tps65217_id_table);
-
 static struct i2c_driver tps65217_driver = {
 	.driver		= {
 		.name	= "tps65217",
 		.of_match_table = tps65217_of_match,
 	},
-	.id_table	= tps65217_id_table,
-	.probe		= tps65217_probe,
+	.probe_new	= tps65217_probe,
 	.remove		= tps65217_remove,
 };
 
diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
index 5324dc9..7b12e88 100644
--- a/drivers/regulator/tps65217-regulator.c
+++ b/drivers/regulator/tps65217-regulator.c
@@ -228,11 +228,6 @@ static int tps65217_regulator_probe(struct platform_device *pdev)
 	int i, ret;
 	unsigned int val;
 
-	if (tps65217_chip_id(tps) != TPS65217) {
-		dev_err(&pdev->dev, "Invalid tps chip version\n");
-		return -ENODEV;
-	}
-
 	/* Allocate memory for strobes */
 	tps->strobes = devm_kzalloc(&pdev->dev, sizeof(u8) *
 				    TPS65217_NUM_REGULATOR, GFP_KERNEL);
diff --git a/drivers/video/backlight/tps65217_bl.c b/drivers/video/backlight/tps65217_bl.c
index fd524ad..5ce8791 100644
--- a/drivers/video/backlight/tps65217_bl.c
+++ b/drivers/video/backlight/tps65217_bl.c
@@ -275,17 +275,9 @@ static int tps65217_bl_probe(struct platform_device *pdev)
 	struct tps65217_bl_pdata *pdata;
 	struct backlight_properties bl_props;
 
-	if (tps->dev->of_node) {
-		pdata = tps65217_bl_parse_dt(pdev);
-		if (IS_ERR(pdata))
-			return PTR_ERR(pdata);
-	} else {
-		pdata = dev_get_platdata(&pdev->dev);
-		if (!pdata) {
-			dev_err(&pdev->dev, "no platform data provided\n");
-			return -EINVAL;
-		}
-	}
+	pdata = tps65217_bl_parse_dt(pdev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
 
 	tps65217_bl = devm_kzalloc(&pdev->dev, sizeof(*tps65217_bl),
 				GFP_KERNEL);
diff --git a/include/linux/mfd/tps65217.h b/include/linux/mfd/tps65217.h
index eac2857..b5dd108 100644
--- a/include/linux/mfd/tps65217.h
+++ b/include/linux/mfd/tps65217.h
@@ -263,7 +263,6 @@ struct tps65217_board {
 struct tps65217 {
 	struct device *dev;
 	struct tps65217_board *pdata;
-	unsigned long id;
 	struct regulator_desc desc[TPS65217_NUM_REGULATOR];
 	struct regmap *regmap;
 	u8 *strobes;
@@ -278,11 +277,6 @@ static inline struct tps65217 *dev_to_tps65217(struct device *dev)
 	return dev_get_drvdata(dev);
 }
 
-static inline unsigned long tps65217_chip_id(struct tps65217 *tps65217)
-{
-	return tps65217->id;
-}
-
 int tps65217_reg_read(struct tps65217 *tps, unsigned int reg,
 					unsigned int *val);
 int tps65217_reg_write(struct tps65217 *tps, unsigned int reg,
-- 
1.9.1
