From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 8/9] mfd: tps65090: Remove redundant i2c_device_id
Date: Sun, 4 Jun 2017 14:48:43 +0530
Message-ID: <1496567924-4278-9-git-send-email-j-keerthy@ti.com>
References: <1496567924-4278-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1496567924-4278-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, milo.kim@ti.com, lee.jones@linaro.org
Cc: j-keerthy@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

With the introduction of probe_new function the i2c_device_id
is no longer needed. Hence the remove the same and use probe_new
instead of probe.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Compile tested.

 drivers/mfd/tps65090.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/tps65090.c b/drivers/mfd/tps65090.c
index d7ec318..200a9c8 100644
--- a/drivers/mfd/tps65090.c
+++ b/drivers/mfd/tps65090.c
@@ -174,8 +174,7 @@ static bool is_volatile_reg(struct device *dev, unsigned int reg)
 MODULE_DEVICE_TABLE(of, tps65090_of_match);
 #endif
 
-static int tps65090_i2c_probe(struct i2c_client *client,
-			      const struct i2c_device_id *id)
+static int tps65090_i2c_probe(struct i2c_client *client)
 {
 	struct tps65090_platform_data *pdata = dev_get_platdata(&client->dev);
 	int irq_base = 0;
@@ -249,20 +248,13 @@ static int tps65090_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
-static const struct i2c_device_id tps65090_id_table[] = {
-	{ "tps65090", 0 },
-	{ },
-};
-MODULE_DEVICE_TABLE(i2c, tps65090_id_table);
-
 static struct i2c_driver tps65090_driver = {
 	.driver	= {
 		.name	= "tps65090",
 		.of_match_table = of_match_ptr(tps65090_of_match),
 	},
-	.probe		= tps65090_i2c_probe,
+	.probe_new	= tps65090_i2c_probe,
 	.remove		= tps65090_i2c_remove,
-	.id_table	= tps65090_id_table,
 };
 
 static int __init tps65090_init(void)
-- 
1.9.1
