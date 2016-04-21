From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 3/7] mfd: max77686: Use devm_mfd_add_devices and devm_regmap_add_irq_chip
Date: Thu, 21 Apr 2016 17:55:54 +0530
Message-ID: <1461241558-26983-4-git-send-email-ldewangan@nvidia.com>
References: <1461241558-26983-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461241558-26983-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, milo.kim@ti.com, cw00.choi@samsung.com, k.kozlowski@samsung.com
Cc: sbkim73@samsung.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for adding MFD child devices and
devm_regmap_add_irq_chip() for IRQ chip registration.

This reduces the error code path and .remove callback for removing
MFD child devices and deleting IRQ chip data.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Chanwoo Choi <cw00.choi@samsung.com>
CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/mfd/max77686.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index 7a0457e..7b68ed7 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -230,38 +230,24 @@ static int max77686_i2c_probe(struct i2c_client *i2c,
 		return -ENODEV;
 	}
 
-	ret = regmap_add_irq_chip(max77686->regmap, max77686->irq,
-				  IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
-				  IRQF_SHARED, 0, irq_chip,
-				  &max77686->irq_data);
+	ret = devm_regmap_add_irq_chip(&i2c->dev, max77686->regmap,
+				       max77686->irq,
+				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
+				       IRQF_SHARED, 0, irq_chip,
+				       &max77686->irq_data);
 	if (ret < 0) {
 		dev_err(&i2c->dev, "failed to add PMIC irq chip: %d\n", ret);
 		return ret;
 	}
 
-	ret = mfd_add_devices(max77686->dev, -1, cells, n_devs, NULL, 0, NULL);
+	ret = devm_mfd_add_devices(max77686->dev, -1, cells, n_devs, NULL,
+				   0, NULL);
 	if (ret < 0) {
 		dev_err(&i2c->dev, "failed to add MFD devices: %d\n", ret);
-		goto err_del_irqc;
+		return ret;
 	}
 
 	return 0;
-
-err_del_irqc:
-	regmap_del_irq_chip(max77686->irq, max77686->irq_data);
-
-	return ret;
-}
-
-static int max77686_i2c_remove(struct i2c_client *i2c)
-{
-	struct max77686_dev *max77686 = i2c_get_clientdata(i2c);
-
-	mfd_remove_devices(max77686->dev);
-
-	regmap_del_irq_chip(max77686->irq, max77686->irq_data);
-
-	return 0;
 }
 
 static const struct i2c_device_id max77686_i2c_id[] = {
@@ -317,7 +303,6 @@ static struct i2c_driver max77686_i2c_driver = {
 		   .of_match_table = of_match_ptr(max77686_pmic_dt_match),
 	},
 	.probe = max77686_i2c_probe,
-	.remove = max77686_i2c_remove,
 	.id_table = max77686_i2c_id,
 };
 
-- 
2.1.4
