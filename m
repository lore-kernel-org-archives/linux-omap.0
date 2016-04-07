From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 04/20] mfd: as3711: Use devm_mfd_add_devices() for mfd_device registration
Date: Fri, 8 Apr 2016 00:12:58 +0530
Message-ID: <1460054594-32325-5-git-send-email-ldewangan@nvidia.com>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net, andreas.werner@men.de, tony@atomide.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for MFD devices registration and get
rid of .remove callback to remove MFD child-devices. This is done
by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

---
Changes from V1:
- Convert mfd to MFD.
- Run checkpatch with --strict option and fix warning.

 drivers/mfd/as3711.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/as3711.c b/drivers/mfd/as3711.c
index 09e1483..67b1241 100644
--- a/drivers/mfd/as3711.c
+++ b/drivers/mfd/as3711.c
@@ -189,22 +189,14 @@ static int as3711_i2c_probe(struct i2c_client *client,
 		as3711_subdevs[AS3711_BACKLIGHT].pdata_size = 0;
 	}
 
-	ret = mfd_add_devices(as3711->dev, -1, as3711_subdevs,
-			      ARRAY_SIZE(as3711_subdevs), NULL, 0, NULL);
+	ret = devm_mfd_add_devices(as3711->dev, -1, as3711_subdevs,
+				   ARRAY_SIZE(as3711_subdevs), NULL, 0, NULL);
 	if (ret < 0)
 		dev_err(&client->dev, "add mfd devices failed: %d\n", ret);
 
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
