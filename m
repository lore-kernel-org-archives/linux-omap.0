From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 9/9] mfd: tps6586x: Remove redundant i2c_device_id
Date: Sun, 4 Jun 2017 14:48:44 +0530
Message-ID: <1496567924-4278-10-git-send-email-j-keerthy@ti.com>
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

 drivers/mfd/tps6586x.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 5628a6b..5572cf6 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -503,8 +503,7 @@ static void tps6586x_print_version(struct i2c_client *client, int version)
 	dev_info(&client->dev, "Found %s, VERSIONCRC is %02x\n", name, version);
 }
 
-static int tps6586x_i2c_probe(struct i2c_client *client,
-					const struct i2c_device_id *id)
+static int tps6586x_i2c_probe(struct i2c_client *client)
 {
 	struct tps6586x_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct tps6586x *tps6586x;
@@ -594,20 +593,13 @@ static int tps6586x_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
-static const struct i2c_device_id tps6586x_id_table[] = {
-	{ "tps6586x", 0 },
-	{ },
-};
-MODULE_DEVICE_TABLE(i2c, tps6586x_id_table);
-
 static struct i2c_driver tps6586x_driver = {
 	.driver	= {
 		.name	= "tps6586x",
 		.of_match_table = of_match_ptr(tps6586x_of_match),
 	},
-	.probe		= tps6586x_i2c_probe,
+	.probe_new	= tps6586x_i2c_probe,
 	.remove		= tps6586x_i2c_remove,
-	.id_table	= tps6586x_id_table,
 };
 
 static int __init tps6586x_init(void)
-- 
1.9.1
