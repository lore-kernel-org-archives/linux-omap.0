From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 16/27] mfd: Export OF module alias information in missing drivers
Date: Thu, 30 Jul 2015 18:18:41 +0200
Message-ID: <1438273132-20926-17-git-send-email-javier@osg.samsung.com>
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

The I2C core always reports the MODALIAS uevent as "i2c:<client name"
regardless if the driver was matched using the I2C id_table or the
of_match_table. So technically there's no need for a driver to export
the OF table since currently it's not used.

In fact, the I2C device ID table is mandatory for I2C drivers since
a i2c_device_id is passed to the driver's probe function even if the
I2C core used the OF table to match the driver.

And since the I2C core uses different tables, OF-only drivers needs to
have duplicated data that has to be kept in sync and also the dev node
compatible manufacturer prefix is stripped when reporting the MODALIAS.

To avoid the above, the I2C core behavior may be changed in the future
to not require an I2C device table for OF-only drivers and report the
OF module alias. So, it's better to also export the OF table to prevent
breaking module autoloading if that happens.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/mfd/rt5033.c   | 1 +
 drivers/mfd/tps65217.c | 1 +
 drivers/mfd/tps65218.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index db395a6c52bc..d60f91619c4a 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -124,6 +124,7 @@ static const struct of_device_id rt5033_dt_match[] = {
 	{ .compatible = "richtek,rt5033", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, rt5033_dt_match);
 
 static struct i2c_driver rt5033_driver = {
 	.driver = {
diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index bc455feb42be..55add0453ae9 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -156,6 +156,7 @@ static const struct of_device_id tps65217_of_match[] = {
 	{ .compatible = "ti,tps65217", .data = (void *)TPS65217 },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, tps65217_of_match);
 
 static int tps65217_probe(struct i2c_client *client,
 				const struct i2c_device_id *ids)
diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index cb38d725250f..80b9dc363cd8 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -211,6 +211,7 @@ static const struct of_device_id of_tps65218_match_table[] = {
 	{ .compatible = "ti,tps65218", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, of_tps65218_match_table);
 
 static int tps65218_probe(struct i2c_client *client,
 				const struct i2c_device_id *ids)
-- 
2.4.3
