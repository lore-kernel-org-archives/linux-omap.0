From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 3/9] mfd: palmas: Remove redundant i2c_device_id
Date: Sun, 4 Jun 2017 14:48:38 +0530
Message-ID: <1496567924-4278-4-git-send-email-j-keerthy@ti.com>
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

Boot tested on dra7-evm and dra72-evm and checked for regulator registrations.

 drivers/mfd/palmas.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 9103aff..db9e53c 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -499,8 +499,7 @@ struct palmas_driver_data {
 };
 MODULE_DEVICE_TABLE(of, of_palmas_match_tbl);
 
-static int palmas_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int palmas_i2c_probe(struct i2c_client *i2c)
 {
 	struct palmas *palmas;
 	struct palmas_platform_data *pdata;
@@ -717,23 +716,13 @@ static int palmas_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-static const struct i2c_device_id palmas_i2c_id[] = {
-	{ "palmas", },
-	{ "twl6035", },
-	{ "twl6037", },
-	{ "tps65913", },
-	{ /* end */ }
-};
-MODULE_DEVICE_TABLE(i2c, palmas_i2c_id);
-
 static struct i2c_driver palmas_i2c_driver = {
 	.driver = {
 		   .name = "palmas",
 		   .of_match_table = of_palmas_match_tbl,
 	},
-	.probe = palmas_i2c_probe,
+	.probe_new = palmas_i2c_probe,
 	.remove = palmas_i2c_remove,
-	.id_table = palmas_i2c_id,
 };
 
 static int __init palmas_i2c_init(void)
-- 
1.9.1
