From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2] mfd: tps65010: fix init when the driver is built-in
Date: Mon, 11 Jan 2016 21:46:49 +0200
Message-ID: <1452541609-30689-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

tps65010 driver's initcall cannot succeed when the driver is built-in,
because it expects that the I2C probe is completed at initcall time;
this cannot happen as MFD is initialized before I2C. Also on systems
where the chip is not present there is unnecessary 30 ms delay during
the boot.

Instead of waiting for probe to finish, just register the I2C device.
If some boards need retry mechanism for startup glitches, that should be
done in the actual probe function. Also delete the driver banner message.

The patch allows to use tps65010 again with OMAP1 (where it's required
to be built-in) and enables e.g. USB and LED functionality on OMAP5912 OSK.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---

	v2: Delete the banner message.

	v1: http://marc.info/?t=145220586400001&r=1&w=2

 drivers/mfd/tps65010.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/mfd/tps65010.c b/drivers/mfd/tps65010.c
index 448f0a1..e40f8e6 100644
--- a/drivers/mfd/tps65010.c
+++ b/drivers/mfd/tps65010.c
@@ -1059,26 +1059,7 @@ EXPORT_SYMBOL(tps65013_set_low_pwr);
 
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
