From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] mfd: tps65010: fix init when the driver is built-in
Date: Fri,  8 Jan 2016 00:29:33 +0200
Message-ID: <1452205773-21962-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

tps65010 driver's initcall cannot succeed when the driver is built-in,
because it expects that the I2C probe is completed at initcall time;
this cannot happen as MFD is initialized before I2C. Also on systems
where the chip is not present there is unnecessary 30 ms delay during
the boot.

Instead of waiting for probe to finish, just register the I2C device.
If some boards need retry mechanism for startup glitches, that should be
done in the actual probe function. Also move the driver banner message
to the probe function, and make it print the chip model being probed.

The patch allows to use tps65010 again with OMAP1 (where it's required
to be built-in) and enables e.g. USB and LED functionality on OMAP5912 OSK.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/mfd/tps65010.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/mfd/tps65010.c b/drivers/mfd/tps65010.c
index 448f0a1..450c358 100644
--- a/drivers/mfd/tps65010.c
+++ b/drivers/mfd/tps65010.c
@@ -541,6 +541,8 @@ static int tps65010_probe(struct i2c_client *client,
 	int			status;
 	struct tps65010_board	*board = dev_get_platdata(&client->dev);
 
+	pr_info("%s: chip model %s\n", DRIVER_NAME, id->name);
+
 	if (the_tps) {
 		dev_dbg(&client->dev, "only one tps6501x chip allowed\n");
 		return -ENODEV;
@@ -1059,26 +1061,7 @@ EXPORT_SYMBOL(tps65013_set_low_pwr);
 
 static int __init tps_init(void)
 {
-	u32	tries = 3;
-	int	status = -ENODEV;
-
-	printk(KERN_INFO "%s: version %s\n", DRIVER_NAME, DRIVER_VERSION);
-
-	/* some boards have startup glitches */
-	while (tries--) {
-		status = i2c_add_driver(&tps65010_driver);
-		if (the_tps)
-			break;
-		i2c_del_driver(&tps65010_driver);
-		if (!tries) {
-			printk(KERN_ERR "%s: no chip?\n", DRIVER_NAME);
-			return -ENODEV;
-		}
-		pr_debug("%s: re-probe ...\n", DRIVER_NAME);
-		msleep(10);
-	}
-
-	return status;
+	return i2c_add_driver(&tps65010_driver);
 }
 /* NOTE:  this MUST be initialized before the other parts of the system
  * that rely on it ... but after the i2c bus on which this relies.
-- 
2.4.0
