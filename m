From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 6/9] mfd: lp3943: Remove redundant i2c_device_id
Date: Sun, 4 Jun 2017 14:48:41 +0530
Message-ID: <1496567924-4278-7-git-send-email-j-keerthy@ti.com>
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

 drivers/mfd/lp3943.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/lp3943.c b/drivers/mfd/lp3943.c
index 65a2a8f1..84ec685 100644
--- a/drivers/mfd/lp3943.c
+++ b/drivers/mfd/lp3943.c
@@ -105,7 +105,7 @@ int lp3943_update_bits(struct lp3943 *lp3943, u8 reg, u8 mask, u8 data)
 	.max_register = LP3943_MAX_REGISTERS,
 };
 
-static int lp3943_probe(struct i2c_client *cl, const struct i2c_device_id *id)
+static int lp3943_probe(struct i2c_client *cl)
 {
 	struct lp3943 *lp3943;
 	struct device *dev = &cl->dev;
@@ -128,12 +128,6 @@ static int lp3943_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 				    NULL, 0, NULL);
 }
 
-static const struct i2c_device_id lp3943_ids[] = {
-	{ "lp3943", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, lp3943_ids);
-
 #ifdef CONFIG_OF
 static const struct of_device_id lp3943_of_match[] = {
 	{ .compatible = "ti,lp3943", },
@@ -143,12 +137,11 @@ static int lp3943_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 #endif
 
 static struct i2c_driver lp3943_driver = {
-	.probe = lp3943_probe,
+	.probe_new = lp3943_probe,
 	.driver = {
 		.name = "lp3943",
 		.of_match_table = of_match_ptr(lp3943_of_match),
 	},
-	.id_table = lp3943_ids,
 };
 
 module_i2c_driver(lp3943_driver);
-- 
1.9.1
