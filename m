From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 14/20] mfd: rt5033: Use devm_mfd_add_devices() for mfd_device registration
Date: Tue, 5 Apr 2016 17:18:26 +0530
Message-ID: <1459856912-17859-15-git-send-email-ldewangan@nvidia.com>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net
Cc: andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, Ingi Kim <ingi2.kim@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for mfd devices registration and get
rid of .remove callback to remove mfd devices. This is done
by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Ingi Kim <ingi2.kim@samsung.com>
CC: Javier Martinez Canillas <javier@osg.samsung.com>
---
 drivers/mfd/rt5033.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index 2b95485..9320684 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -97,7 +97,7 @@ static int rt5033_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	ret = mfd_add_devices(rt5033->dev, -1, rt5033_devs,
+	ret = devm_mfd_add_devices(rt5033->dev, -1, rt5033_devs,
 			ARRAY_SIZE(rt5033_devs), NULL, 0,
 			regmap_irq_get_domain(rt5033->irq_data));
 	if (ret < 0) {
@@ -110,13 +110,6 @@ static int rt5033_i2c_probe(struct i2c_client *i2c,
 	return 0;
 }
 
-static int rt5033_i2c_remove(struct i2c_client *i2c)
-{
-	mfd_remove_devices(&i2c->dev);
-
-	return 0;
-}
-
 static const struct i2c_device_id rt5033_i2c_id[] = {
 	{ "rt5033", },
 	{ }
@@ -135,7 +128,6 @@ static struct i2c_driver rt5033_driver = {
 		.of_match_table = of_match_ptr(rt5033_dt_match),
 	},
 	.probe = rt5033_i2c_probe,
-	.remove = rt5033_i2c_remove,
 	.id_table = rt5033_i2c_id,
 };
 module_i2c_driver(rt5033_driver);
-- 
2.1.4
