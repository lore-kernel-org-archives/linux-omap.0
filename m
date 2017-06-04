From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 1/9] mfd: tps65217: Remove redundant i2c_device_id
Date: Sun, 4 Jun 2017 14:48:36 +0530
Message-ID: <1496567924-4278-2-git-send-email-j-keerthy@ti.com>
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

Boot tested on am335x-bone and checked for regulator registrations.

 drivers/mfd/tps65217.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index f769c7d..c2e8385 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -316,12 +316,11 @@ static bool tps65217_volatile_reg(struct device *dev, unsigned int reg)
 };
 MODULE_DEVICE_TABLE(of, tps65217_of_match);
 
-static int tps65217_probe(struct i2c_client *client,
-				const struct i2c_device_id *ids)
+static int tps65217_probe(struct i2c_client *client)
 {
 	struct tps65217 *tps;
 	unsigned int version;
-	unsigned long chip_id = ids->driver_data;
+	unsigned long chip_id = 0;
 	const struct of_device_id *match;
 	bool status_off = false;
 	int ret;
@@ -418,19 +417,12 @@ static int tps65217_remove(struct i2c_client *client)
 	return 0;
 }
 
-static const struct i2c_device_id tps65217_id_table[] = {
-	{"tps65217", TPS65217},
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(i2c, tps65217_id_table);
-
 static struct i2c_driver tps65217_driver = {
 	.driver		= {
 		.name	= "tps65217",
 		.of_match_table = tps65217_of_match,
 	},
-	.id_table	= tps65217_id_table,
-	.probe		= tps65217_probe,
+	.probe_new	= tps65217_probe,
 	.remove		= tps65217_remove,
 };
 
-- 
1.9.1
