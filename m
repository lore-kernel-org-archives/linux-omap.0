From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 5/7] mfd: sec: Use devm_mfd_add_devices and devm_regmap_add_irq_chip
Date: Thu, 21 Apr 2016 17:55:56 +0530
Message-ID: <1461241558-26983-6-git-send-email-ldewangan@nvidia.com>
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
CC: Sangbeom Kim <sbkim73@samsung.com>
CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
CC: linux-samsung-soc@vger.kernel.org
---
 drivers/mfd/sec-core.c | 20 +++-----------------
 drivers/mfd/sec-irq.c  | 14 +++++---------
 2 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index 400e1d7..ca6b80d 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -481,29 +481,16 @@ static int sec_pmic_probe(struct i2c_client *i2c,
 		/* If this happens the probe function is problem */
 		BUG();
 	}
-	ret = mfd_add_devices(sec_pmic->dev, -1, sec_devs, num_sec_devs, NULL,
-			      0, NULL);
+	ret = devm_mfd_add_devices(sec_pmic->dev, -1, sec_devs, num_sec_devs,
+				   NULL, 0, NULL);
 	if (ret)
-		goto err_mfd;
+		return ret;
 
 	device_init_wakeup(sec_pmic->dev, sec_pmic->wakeup);
 	sec_pmic_configure(sec_pmic);
 	sec_pmic_dump_rev(sec_pmic);
 
 	return ret;
-
-err_mfd:
-	sec_irq_exit(sec_pmic);
-	return ret;
-}
-
-static int sec_pmic_remove(struct i2c_client *i2c)
-{
-	struct sec_pmic_dev *sec_pmic = i2c_get_clientdata(i2c);
-
-	mfd_remove_devices(sec_pmic->dev);
-	sec_irq_exit(sec_pmic);
-	return 0;
 }
 
 static void sec_pmic_shutdown(struct i2c_client *i2c)
@@ -583,7 +570,6 @@ static struct i2c_driver sec_pmic_driver = {
 		   .of_match_table = of_match_ptr(sec_dt_match),
 	},
 	.probe = sec_pmic_probe,
-	.remove = sec_pmic_remove,
 	.shutdown = sec_pmic_shutdown,
 	.id_table = sec_pmic_id,
 };
diff --git a/drivers/mfd/sec-irq.c b/drivers/mfd/sec-irq.c
index d77de43..5eb59c233d5 100644
--- a/drivers/mfd/sec-irq.c
+++ b/drivers/mfd/sec-irq.c
@@ -483,10 +483,11 @@ int sec_irq_init(struct sec_pmic_dev *sec_pmic)
 		return -EINVAL;
 	}
 
-	ret = regmap_add_irq_chip(sec_pmic->regmap_pmic, sec_pmic->irq,
-			  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-			  sec_pmic->irq_base, sec_irq_chip,
-			  &sec_pmic->irq_data);
+	ret = devm_regmap_add_irq_chip(sec_pmic->dev, sec_pmic->regmap_pmic,
+				       sec_pmic->irq,
+				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				       sec_pmic->irq_base, sec_irq_chip,
+				       &sec_pmic->irq_data);
 	if (ret != 0) {
 		dev_err(sec_pmic->dev, "Failed to register IRQ chip: %d\n", ret);
 		return ret;
@@ -500,8 +501,3 @@ int sec_irq_init(struct sec_pmic_dev *sec_pmic)
 
 	return 0;
 }
-
-void sec_irq_exit(struct sec_pmic_dev *sec_pmic)
-{
-	regmap_del_irq_chip(sec_pmic->irq, sec_pmic->irq_data);
-}
-- 
2.1.4
