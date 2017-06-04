From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 5/9] mfd: lp8788: Remove redundant i2c_device_id
Date: Sun, 4 Jun 2017 14:48:40 +0530
Message-ID: <1496567924-4278-6-git-send-email-j-keerthy@ti.com>
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

 drivers/mfd/lp8788.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/lp8788.c b/drivers/mfd/lp8788.c
index acf6165..a46139d 100644
--- a/drivers/mfd/lp8788.c
+++ b/drivers/mfd/lp8788.c
@@ -170,7 +170,7 @@ static int lp8788_platform_init(struct lp8788 *lp)
 	.max_register = MAX_LP8788_REGISTERS,
 };
 
-static int lp8788_probe(struct i2c_client *cl, const struct i2c_device_id *id)
+static int lp8788_probe(struct i2c_client *cl)
 {
 	struct lp8788 *lp;
 	struct lp8788_platform_data *pdata = dev_get_platdata(&cl->dev);
@@ -212,19 +212,12 @@ static int lp8788_remove(struct i2c_client *cl)
 	return 0;
 }
 
-static const struct i2c_device_id lp8788_ids[] = {
-	{"lp8788", 0},
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, lp8788_ids);
-
 static struct i2c_driver lp8788_driver = {
 	.driver = {
 		.name = "lp8788",
 	},
-	.probe = lp8788_probe,
+	.probe_new = lp8788_probe,
 	.remove = lp8788_remove,
-	.id_table = lp8788_ids,
 };
 
 static int __init lp8788_init(void)
-- 
1.9.1
