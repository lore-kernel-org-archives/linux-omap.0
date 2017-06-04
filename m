From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 2/9] mfd: tps65218: Remove redundant i2c_device_id
Date: Sun, 4 Jun 2017 14:48:37 +0530
Message-ID: <1496567924-4278-3-git-send-email-j-keerthy@ti.com>
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

Boot tested on am347x-gp-evm and checked for regulator registrations.

 drivers/mfd/tps65218.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 13834a0..53df80b 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -211,8 +211,7 @@ int tps65218_clear_bits(struct tps65218 *tps, unsigned int reg,
 };
 MODULE_DEVICE_TABLE(of, of_tps65218_match_table);
 
-static int tps65218_probe(struct i2c_client *client,
-				const struct i2c_device_id *ids)
+static int tps65218_probe(struct i2c_client *client)
 {
 	struct tps65218 *tps;
 	const struct of_device_id *match;
@@ -281,20 +280,22 @@ static int tps65218_remove(struct i2c_client *client)
 	return 0;
 }
 
+#if 0
 static const struct i2c_device_id tps65218_id_table[] = {
 	{ "tps65218", TPS65218 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, tps65218_id_table);
+#endif
 
 static struct i2c_driver tps65218_driver = {
 	.driver		= {
 		.name	= "tps65218",
 		.of_match_table = of_tps65218_match_table,
 	},
-	.probe		= tps65218_probe,
+	.probe_new	= tps65218_probe,
 	.remove		= tps65218_remove,
-	.id_table       = tps65218_id_table,
+	//.id_table       = tps65218_id_table,
 };
 
 module_i2c_driver(tps65218_driver);
-- 
1.9.1
