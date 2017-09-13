From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 2/2] mfd: tps65218: Introduce dependency on CONFIG_OF
Date: Wed, 13 Sep 2017 17:47:10 +0530
Message-ID: <1505305030-13263-2-git-send-email-j-keerthy@ti.com>
References: <1505305030-13263-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505305030-13263-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Currently the driver boots only via device tree hence add a
dependency on CONFIG_OF. This leaves with a bunch of unused code
so clean that up.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/mfd/Kconfig    | 2 +-
 drivers/mfd/tps65218.c | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 44c529e..682336d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1400,7 +1400,7 @@ config MFD_TI_LP87565
 
 config MFD_TPS65218
 	tristate "TI TPS65218 Power Management chips"
-	depends on I2C
+	depends on I2C && OF
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 13834a0..910f569 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -215,17 +215,9 @@ static int tps65218_probe(struct i2c_client *client,
 				const struct i2c_device_id *ids)
 {
 	struct tps65218 *tps;
-	const struct of_device_id *match;
 	int ret;
 	unsigned int chipid;
 
-	match = of_match_device(of_tps65218_match_table, &client->dev);
-	if (!match) {
-		dev_err(&client->dev,
-			"Failed to find matching dt id\n");
-		return -EINVAL;
-	}
-
 	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
 	if (!tps)
 		return -ENOMEM;
-- 
1.9.1
