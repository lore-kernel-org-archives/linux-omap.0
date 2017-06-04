From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 7/9] mfd: tps65086: Remove redundant i2c_device_id
Date: Sun, 4 Jun 2017 14:48:42 +0530
Message-ID: <1496567924-4278-8-git-send-email-j-keerthy@ti.com>
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

 drivers/mfd/tps65086.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/tps65086.c b/drivers/mfd/tps65086.c
index 43119a6..975ac4a 100644
--- a/drivers/mfd/tps65086.c
+++ b/drivers/mfd/tps65086.c
@@ -68,8 +68,7 @@
 };
 MODULE_DEVICE_TABLE(of, tps65086_of_match_table);
 
-static int tps65086_probe(struct i2c_client *client,
-			  const struct i2c_device_id *ids)
+static int tps65086_probe(struct i2c_client *client)
 {
 	struct tps65086 *tps;
 	unsigned int version;
@@ -127,20 +126,13 @@ static int tps65086_remove(struct i2c_client *client)
 	return 0;
 }
 
-static const struct i2c_device_id tps65086_id_table[] = {
-	{ "tps65086", 0 },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(i2c, tps65086_id_table);
-
 static struct i2c_driver tps65086_driver = {
 	.driver		= {
 		.name	= "tps65086",
 		.of_match_table = tps65086_of_match_table,
 	},
-	.probe		= tps65086_probe,
+	.probe_new	= tps65086_probe,
 	.remove		= tps65086_remove,
-	.id_table       = tps65086_id_table,
 };
 module_i2c_driver(tps65086_driver);
 
-- 
1.9.1
