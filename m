From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 4/9] mfd: lp873x: Remove redundant i2c_device_id
Date: Sun, 4 Jun 2017 14:48:39 +0530
Message-ID: <1496567924-4278-5-git-send-email-j-keerthy@ti.com>
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

Boot tested on dra71-evm and checked for regulator registrations.

 drivers/mfd/lp873x.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/lp873x.c b/drivers/mfd/lp873x.c
index 873c608..47be6b8 100644
--- a/drivers/mfd/lp873x.c
+++ b/drivers/mfd/lp873x.c
@@ -32,8 +32,7 @@
 	{ .name = "lp873x-gpio", },
 };
 
-static int lp873x_probe(struct i2c_client *client,
-			const struct i2c_device_id *ids)
+static int lp873x_probe(struct i2c_client *client)
 {
 	struct lp873x *lp873;
 	int ret;
@@ -76,19 +75,12 @@ static int lp873x_probe(struct i2c_client *client,
 };
 MODULE_DEVICE_TABLE(of, of_lp873x_match_table);
 
-static const struct i2c_device_id lp873x_id_table[] = {
-	{ "lp873x", 0 },
-	{ },
-};
-MODULE_DEVICE_TABLE(i2c, lp873x_id_table);
-
 static struct i2c_driver lp873x_driver = {
 	.driver	= {
 		.name	= "lp873x",
 		.of_match_table = of_lp873x_match_table,
 	},
-	.probe		= lp873x_probe,
-	.id_table	= lp873x_id_table,
+	.probe_new	= lp873x_probe,
 };
 module_i2c_driver(lp873x_driver);
 
-- 
1.9.1
