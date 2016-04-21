From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 1/7] mfd: as3722: Use devm_mfd_add_devices and devm_regmap_add_irq_chip
Date: Thu, 21 Apr 2016 17:55:52 +0530
Message-ID: <1461241558-26983-2-git-send-email-ldewangan@nvidia.com>
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
---
 drivers/mfd/as3722.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
index e1f597f..f87342c 100644
--- a/drivers/mfd/as3722.c
+++ b/drivers/mfd/as3722.c
@@ -385,9 +385,10 @@ static int as3722_i2c_probe(struct i2c_client *i2c,
 		return ret;
 
 	irq_flags = as3722->irq_flags | IRQF_ONESHOT;
-	ret = regmap_add_irq_chip(as3722->regmap, as3722->chip_irq,
-			irq_flags, -1, &as3722_irq_chip,
-			&as3722->irq_data);
+	ret = devm_regmap_add_irq_chip(as3722->dev, as3722->regmap,
+				       as3722->chip_irq,
+				       irq_flags, -1, &as3722_irq_chip,
+				       &as3722->irq_data);
 	if (ret < 0) {
 		dev_err(as3722->dev, "Failed to add regmap irq: %d\n", ret);
 		return ret;
@@ -395,33 +396,20 @@ static int as3722_i2c_probe(struct i2c_client *i2c,
 
 	ret = as3722_configure_pullups(as3722);
 	if (ret < 0)
-		goto scrub;
+		return ret;
 
-	ret = mfd_add_devices(&i2c->dev, -1, as3722_devs,
-			ARRAY_SIZE(as3722_devs), NULL, 0,
-			regmap_irq_get_domain(as3722->irq_data));
+	ret = devm_mfd_add_devices(&i2c->dev, -1, as3722_devs,
+				   ARRAY_SIZE(as3722_devs), NULL, 0,
+				   regmap_irq_get_domain(as3722->irq_data));
 	if (ret) {
 		dev_err(as3722->dev, "Failed to add MFD devices: %d\n", ret);
-		goto scrub;
+		return ret;
 	}
 
 	device_init_wakeup(as3722->dev, true);
 
 	dev_dbg(as3722->dev, "AS3722 core driver initialized successfully\n");
 	return 0;
-
-scrub:
-	regmap_del_irq_chip(as3722->chip_irq, as3722->irq_data);
-	return ret;
-}
-
-static int as3722_i2c_remove(struct i2c_client *i2c)
-{
-	struct as3722 *as3722 = i2c_get_clientdata(i2c);
-
-	mfd_remove_devices(as3722->dev);
-	regmap_del_irq_chip(as3722->chip_irq, as3722->irq_data);
-	return 0;
 }
 
 static int __maybe_unused as3722_i2c_suspend(struct device *dev)
@@ -470,7 +458,6 @@ static struct i2c_driver as3722_i2c_driver = {
 		.pm = &as3722_pm_ops,
 	},
 	.probe = as3722_i2c_probe,
-	.remove = as3722_i2c_remove,
 	.id_table = as3722_i2c_id,
 };
 
-- 
2.1.4
