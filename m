From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 10/34] mfd: tps65218: Use devm_regmap_add_irq_chip and clean up error path in probe()
Date: Tue, 12 Feb 2019 21:39:28 -0500
Message-ID: <20190213023952.21311-10-sashal@kernel.org>
References: <20190213023952.21311-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213023952.21311-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Keerthy <j-keerthy@ti.com>, Lee Jones <lee.jones@linaro.org>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

[ Upstream commit 75d4c5e03c2ae9902ab521024b10291f6fc9515b ]

Use devm_regmap_add_irq_chip and clean up error path in probe
and also the remove function.

Reported-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/tps65218.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 13834a0d2817..612f5ecda78f 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -243,9 +243,9 @@ static int tps65218_probe(struct i2c_client *client,
 
 	mutex_init(&tps->tps_lock);
 
-	ret = regmap_add_irq_chip(tps->regmap, tps->irq,
-			IRQF_ONESHOT, 0, &tps65218_irq_chip,
-			&tps->irq_data);
+	ret = devm_regmap_add_irq_chip(&client->dev, tps->regmap, tps->irq,
+				       IRQF_ONESHOT, 0, &tps65218_irq_chip,
+				       &tps->irq_data);
 	if (ret < 0)
 		return ret;
 
@@ -261,26 +261,9 @@ static int tps65218_probe(struct i2c_client *client,
 			      ARRAY_SIZE(tps65218_cells), NULL, 0,
 			      regmap_irq_get_domain(tps->irq_data));
 
-	if (ret < 0)
-		goto err_irq;
-
-	return 0;
-
-err_irq:
-	regmap_del_irq_chip(tps->irq, tps->irq_data);
-
 	return ret;
 }
 
-static int tps65218_remove(struct i2c_client *client)
-{
-	struct tps65218 *tps = i2c_get_clientdata(client);
-
-	regmap_del_irq_chip(tps->irq, tps->irq_data);
-
-	return 0;
-}
-
 static const struct i2c_device_id tps65218_id_table[] = {
 	{ "tps65218", TPS65218 },
 	{ },
@@ -293,7 +276,6 @@ static struct i2c_driver tps65218_driver = {
 		.of_match_table = of_tps65218_match_table,
 	},
 	.probe		= tps65218_probe,
-	.remove		= tps65218_remove,
 	.id_table       = tps65218_id_table,
 };
 
-- 
2.19.1
