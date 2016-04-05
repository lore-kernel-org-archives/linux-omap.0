From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 03/20] mfd: act8945a: Use devm_mfd_add_devices() for mfd_device registration
Date: Tue, 5 Apr 2016 17:18:15 +0530
Message-ID: <1459856912-17859-4-git-send-email-ldewangan@nvidia.com>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net
Cc: andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, Wenyou Yang <wenyou.yang@atmel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for mfd devices registration and get
rid of .remove callback to remove mfd devices. This is done
by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Wenyou Yang <wenyou.yang@atmel.com>
CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/mfd/act8945a.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/act8945a.c b/drivers/mfd/act8945a.c
index 525b546..10c6d2d 100644
--- a/drivers/mfd/act8945a.c
+++ b/drivers/mfd/act8945a.c
@@ -46,8 +46,9 @@ static int act8945a_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, regmap);
 
-	ret = mfd_add_devices(&i2c->dev, PLATFORM_DEVID_NONE, act8945a_devs,
-			      ARRAY_SIZE(act8945a_devs), NULL, 0, NULL);
+	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_NONE,
+				   act8945a_devs, ARRAY_SIZE(act8945a_devs),
+				   NULL, 0, NULL);
 	if (ret) {
 		dev_err(&i2c->dev, "Failed to add sub devices\n");
 		return ret;
@@ -56,13 +57,6 @@ static int act8945a_i2c_probe(struct i2c_client *i2c,
 	return 0;
 }
 
-static int act8945a_i2c_remove(struct i2c_client *i2c)
-{
-	mfd_remove_devices(&i2c->dev);
-
-	return 0;
-}
-
 static const struct i2c_device_id act8945a_i2c_id[] = {
 	{ "act8945a", 0 },
 	{}
@@ -81,7 +75,6 @@ static struct i2c_driver act8945a_i2c_driver = {
 		   .of_match_table = of_match_ptr(act8945a_of_match),
 	},
 	.probe = act8945a_i2c_probe,
-	.remove = act8945a_i2c_remove,
 	.id_table = act8945a_i2c_id,
 };
 
-- 
2.1.4
