From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 20/20] mfd: wm8400: Use devm_mfd_add_devices() for mfd_device registration
Date: Tue, 5 Apr 2016 17:18:32 +0530
Message-ID: <1459856912-17859-21-git-send-email-ldewangan@nvidia.com>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net
Cc: andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for mfd devices registration and get
rid of .remove callback to remove mfd devices. This is done
by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Mark Brown <broonie@kernel.org>
CC: patches@opensource.wolfsonmicro.com
---
 drivers/mfd/wm8400-core.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/mfd/wm8400-core.c b/drivers/mfd/wm8400-core.c
index 3bd44a4..9fd8230 100644
--- a/drivers/mfd/wm8400-core.c
+++ b/drivers/mfd/wm8400-core.c
@@ -70,7 +70,7 @@ static int wm8400_register_codec(struct wm8400 *wm8400)
 		.pdata_size = sizeof(*wm8400),
 	};
 
-	return mfd_add_devices(wm8400->dev, -1, &cell, 1, NULL, 0, NULL);
+	return devm_mfd_add_devices(wm8400->dev, -1, &cell, 1, NULL, 0, NULL);
 }
 
 /*
@@ -111,7 +111,7 @@ static int wm8400_init(struct wm8400 *wm8400,
 	ret = wm8400_register_codec(wm8400);
 	if (ret != 0) {
 		dev_err(wm8400->dev, "Failed to register codec\n");
-		goto err_children;
+		return ret;
 	}
 
 	if (pdata && pdata->platform_init) {
@@ -119,21 +119,12 @@ static int wm8400_init(struct wm8400 *wm8400,
 		if (ret != 0) {
 			dev_err(wm8400->dev, "Platform init failed: %d\n",
 				ret);
-			goto err_children;
+			return ret;
 		}
 	} else
 		dev_warn(wm8400->dev, "No platform initialisation supplied\n");
 
 	return 0;
-
-err_children:
-	mfd_remove_devices(wm8400->dev);
-	return ret;
-}
-
-static void wm8400_release(struct wm8400 *wm8400)
-{
-	mfd_remove_devices(wm8400->dev);
 }
 
 static const struct regmap_config wm8400_regmap_config = {
@@ -176,15 +167,6 @@ static int wm8400_i2c_probe(struct i2c_client *i2c,
 	return wm8400_init(wm8400, dev_get_platdata(&i2c->dev));
 }
 
-static int wm8400_i2c_remove(struct i2c_client *i2c)
-{
-	struct wm8400 *wm8400 = i2c_get_clientdata(i2c);
-
-	wm8400_release(wm8400);
-
-	return 0;
-}
-
 static const struct i2c_device_id wm8400_i2c_id[] = {
        { "wm8400", 0 },
        { }
@@ -196,7 +178,6 @@ static struct i2c_driver wm8400_i2c_driver = {
 		.name = "WM8400",
 	},
 	.probe    = wm8400_i2c_probe,
-	.remove   = wm8400_i2c_remove,
 	.id_table = wm8400_i2c_id,
 };
 #endif
-- 
2.1.4
