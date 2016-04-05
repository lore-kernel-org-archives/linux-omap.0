From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 04/20] mfd: as3711: Use devm_mfd_add_devices() for mfd_device registration
Date: Tue, 5 Apr 2016 17:18:16 +0530
Message-ID: <1459856912-17859-5-git-send-email-ldewangan@nvidia.com>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net
Cc: andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for mfd devices registration and get
rid of .remove callback to remove mfd devices. This is done
by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mfd/as3711.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/mfd/as3711.c b/drivers/mfd/as3711.c
index 09e1483..435bfa6 100644
--- a/drivers/mfd/as3711.c
+++ b/drivers/mfd/as3711.c
@@ -189,7 +189,7 @@ static int as3711_i2c_probe(struct i2c_client *client,
 		as3711_subdevs[AS3711_BACKLIGHT].pdata_size = 0;
 	}
 
-	ret = mfd_add_devices(as3711->dev, -1, as3711_subdevs,
+	ret = devm_mfd_add_devices(as3711->dev, -1, as3711_subdevs,
 			      ARRAY_SIZE(as3711_subdevs), NULL, 0, NULL);
 	if (ret < 0)
 		dev_err(&client->dev, "add mfd devices failed: %d\n", ret);
@@ -197,14 +197,6 @@ static int as3711_i2c_probe(struct i2c_client *client,
 	return ret;
 }
 
-static int as3711_i2c_remove(struct i2c_client *client)
-{
-	struct as3711 *as3711 = i2c_get_clientdata(client);
-
-	mfd_remove_devices(as3711->dev);
-	return 0;
-}
-
 static const struct i2c_device_id as3711_i2c_id[] = {
 	{.name = "as3711", .driver_data = 0},
 	{}
@@ -218,7 +210,6 @@ static struct i2c_driver as3711_i2c_driver = {
 		   .of_match_table = of_match_ptr(as3711_of_match),
 	},
 	.probe = as3711_i2c_probe,
-	.remove = as3711_i2c_remove,
 	.id_table = as3711_i2c_id,
 };
 
-- 
2.1.4
