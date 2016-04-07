From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 15/20] mfd: sky81452: Use devm_mfd_add_devices() for mfd_device registration
Date: Fri, 8 Apr 2016 00:13:09 +0530
Message-ID: <1460054594-32325-16-git-send-email-ldewangan@nvidia.com>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net, andreas.werner@men.de, tony@atomide.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, Gyungoh Yoo <jack.yoo@skyworksinc.com>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for MFD devices registration and get
rid of .remove callback to remove MFD child-devices. This is done
by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Gyungoh Yoo <jack.yoo@skyworksinc.com>

---
Changes from V1:
- Convert mfd to MFD.
- Run checkpatch with --strict option and fix warning.

 drivers/mfd/sky81452.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/sky81452.c b/drivers/mfd/sky81452.c
index b0c9b04..30a2a67 100644
--- a/drivers/mfd/sky81452.c
+++ b/drivers/mfd/sky81452.c
@@ -64,19 +64,14 @@ static int sky81452_probe(struct i2c_client *client,
 	cells[1].platform_data = pdata->regulator_init_data;
 	cells[1].pdata_size = sizeof(*pdata->regulator_init_data);
 
-	ret = mfd_add_devices(dev, -1, cells, ARRAY_SIZE(cells), NULL, 0, NULL);
+	ret = devm_mfd_add_devices(dev, -1, cells, ARRAY_SIZE(cells),
+				   NULL, 0, NULL);
 	if (ret)
 		dev_err(dev, "failed to add child devices. err=%d\n", ret);
 
 	return ret;
 }
 
-static int sky81452_remove(struct i2c_client *client)
-{
-	mfd_remove_devices(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id sky81452_ids[] = {
 	{ "sky81452" },
 	{ }
@@ -97,7 +92,6 @@ static struct i2c_driver sky81452_driver = {
 		.of_match_table = of_match_ptr(sky81452_of_match),
 	},
 	.probe = sky81452_probe,
-	.remove = sky81452_remove,
 	.id_table = sky81452_ids,
 };
 
-- 
2.1.4
