From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH] mfd: palmas: constify struct regmap_irq_chip
Date: Mon, 19 Dec 2016 16:16:23 +0100
Message-ID: <20161219151623.20189-1-clabbe.montjoie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, lee.jones@linaro.org, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, LABBE Corentin <clabbe.montjoie@gmail.com>
List-Id: linux-omap@vger.kernel.org

From: LABBE Corentin <clabbe.montjoie@gmail.com>

The regmap_irq_chip struct is never modified and so can be set as const.
This permit to remove a casted access to match->data and use the proper
of_device_get_match_data()

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/mfd/palmas.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 8f8bacb..66f3aa0 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -300,7 +300,7 @@ static const struct regmap_irq palmas_irqs[] = {
 	},
 };
 
-static struct regmap_irq_chip palmas_irq_chip = {
+static const struct regmap_irq_chip palmas_irq_chip = {
 	.name = "palmas",
 	.irqs = palmas_irqs,
 	.num_irqs = ARRAY_SIZE(palmas_irqs),
@@ -313,7 +313,7 @@ static struct regmap_irq_chip palmas_irq_chip = {
 			PALMAS_INT1_MASK),
 };
 
-static struct regmap_irq_chip tps65917_irq_chip = {
+static const struct regmap_irq_chip tps65917_irq_chip = {
 	.name = "tps65917",
 	.irqs = tps65917_irqs,
 	.num_irqs = ARRAY_SIZE(tps65917_irqs),
@@ -453,20 +453,20 @@ static unsigned int tps659038_features;
 
 struct palmas_driver_data {
 	unsigned int *features;
-	struct regmap_irq_chip *irq_chip;
+	const struct regmap_irq_chip *irq_chip;
 };
 
-static struct palmas_driver_data palmas_data = {
+static const struct palmas_driver_data palmas_data = {
 	.features = &palmas_features,
 	.irq_chip = &palmas_irq_chip,
 };
 
-static struct palmas_driver_data tps659038_data = {
+static const struct palmas_driver_data tps659038_data = {
 	.features = &tps659038_features,
 	.irq_chip = &palmas_irq_chip,
 };
 
-static struct palmas_driver_data tps65917_data = {
+static const struct palmas_driver_data tps65917_data = {
 	.features = &tps659038_features,
 	.irq_chip = &tps65917_irq_chip,
 };
@@ -493,12 +493,11 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
 {
 	struct palmas *palmas;
 	struct palmas_platform_data *pdata;
-	struct palmas_driver_data *driver_data;
+	const struct palmas_driver_data *driver_data;
 	struct device_node *node = i2c->dev.of_node;
 	int ret = 0, i;
 	unsigned int reg, addr;
 	int slave;
-	const struct of_device_id *match;
 
 	pdata = dev_get_platdata(&i2c->dev);
 
@@ -522,12 +521,9 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
 	palmas->dev = &i2c->dev;
 	palmas->irq = i2c->irq;
 
-	match = of_match_device(of_palmas_match_tbl, &i2c->dev);
-
-	if (!match)
+	driver_data = of_device_get_match_data(&i2c->dev);
+	if (!driver_data)
 		return -ENODATA;
-
-	driver_data = (struct palmas_driver_data *)match->data;
 	palmas->features = *driver_data->features;
 
 	for (i = 0; i < PALMAS_NUM_CLIENTS; i++) {
-- 
2.10.2
