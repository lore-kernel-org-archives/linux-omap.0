From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 7/7] mfd: wl1273-core: Use devm_mfd_add_devices() for mfd_device registration
Date: Thu, 21 Apr 2016 17:55:58 +0530
Message-ID: <1461241558-26983-8-git-send-email-ldewangan@nvidia.com>
References: <1461241558-26983-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461241558-26983-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, milo.kim@ti.com, cw00.choi@samsung.com, k.kozlowski@samsung.com
Cc: sbkim73@samsung.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for MFD devices registration and get
rid of .remove callback to remove MFD child-devices. This is done
by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/mfd/wl1273-core.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/wl1273-core.c b/drivers/mfd/wl1273-core.c
index f7c52d9..7080465 100644
--- a/drivers/mfd/wl1273-core.c
+++ b/drivers/mfd/wl1273-core.c
@@ -170,15 +170,6 @@ static int wl1273_fm_set_volume(struct wl1273_core *core, unsigned int volume)
 	return 0;
 }
 
-static int wl1273_core_remove(struct i2c_client *client)
-{
-	dev_dbg(&client->dev, "%s\n", __func__);
-
-	mfd_remove_devices(&client->dev);
-
-	return 0;
-}
-
 static int wl1273_core_probe(struct i2c_client *client,
 				       const struct i2c_device_id *id)
 {
@@ -237,8 +228,8 @@ static int wl1273_core_probe(struct i2c_client *client,
 	dev_dbg(&client->dev, "%s: number of children: %d.\n",
 		__func__, children);
 
-	r = mfd_add_devices(&client->dev, -1, core->cells,
-			    children, NULL, 0, NULL);
+	r = devm_mfd_add_devices(&client->dev, -1, core->cells,
+				 children, NULL, 0, NULL);
 	if (r)
 		goto err;
 
@@ -258,7 +249,6 @@ static struct i2c_driver wl1273_core_driver = {
 	},
 	.probe = wl1273_core_probe,
 	.id_table = wl1273_driver_id_table,
-	.remove = wl1273_core_remove,
 };
 
 static int __init wl1273_core_init(void)
-- 
2.1.4
