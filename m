From: Claudio Foellmi <claudio.foellmi@ergon.ch>
Subject: [PATCH v2] i2c: omap: Trigger bus recovery in lockup case
Date: Wed,  4 Oct 2017 11:43:45 +0200
Message-ID: <1507110225-3050-1-git-send-email-claudio.foellmi@ergon.ch>
References: <e9b43138-6c01-bc99-9bac-355823bc0c19@ti.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <e9b43138-6c01-bc99-9bac-355823bc0c19@ti.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Claudio Foellmi <claudio.foellmi@ergon.ch>, "Nori, Sekhar" <nsekhar@ti.com>, "Cooper Jr., Franklin" <fcooper@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

A very conservative check for bus activity (to prevent interference
in multimaster setups) prevented the bus recovery methods from being
triggered in the case that SDA or SCL was stuck low.
This defeats the purpose of the recovery mechanism, which was introduced
for exactly this situation (a slave device keeping SDA pulled down).

Also added a check to make sure SDA is low before attempting recovery.
If SDA is not stuck low, recovery will not help, so we can skip it.

Note that bus lockups can persist across reboots. The only other options
are to reset or power cycle the offending slave device, and many i2c
slaves do not even have a reset pin.

If we see that one of the lines is low for the entire timeout duration,
we can actually be sure that there is no other master driving the bus.
It is therefore save for us to attempt a bus recovery.

Signed-off-by: Claudio Foellmi <claudio.foellmi@ergon.ch>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Vignesh R <vigneshr@ti.com>
---
Changes since v1:
Added a check before all bus recoveries, to make sure SDA actually is
low. This should prevent most unnecessary attempts, which are not
without risk.

The full discussion of v1 can be found at
http://patchwork.ozlabs.org/patch/813889/

 drivers/i2c/busses/i2c-omap.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 1ebb5e9..8cdf40a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -473,6 +473,22 @@ static int omap_i2c_init(struct omap_i2c_dev *omap)
 }
 
 /*
+ * Try bus recovery, but only if SDA is actually low.
+ */
+static int omap_i2c_recover_bus(struct omap_i2c_dev *omap)
+{
+	u16 systest;
+
+	systest = omap_i2c_read_reg(omap, OMAP_I2C_SYSTEST_REG);
+	if ((systest & OMAP_I2C_SYSTEST_SCL_I_FUNC) &&
+	    (systest & OMAP_I2C_SYSTEST_SDA_I_FUNC))
+		return 0; /* bus seems to already be fine */
+	if (!(systest & OMAP_I2C_SYSTEST_SCL_I_FUNC))
+		return -ETIMEDOUT; /* recovery would not fix SCL */
+	return i2c_recover_bus(&omap->adapter);
+}
+
+/*
  * Waiting on Bus Busy
  */
 static int omap_i2c_wait_for_bb(struct omap_i2c_dev *omap)
@@ -482,7 +498,7 @@ static int omap_i2c_wait_for_bb(struct omap_i2c_dev *omap)
 	timeout = jiffies + OMAP_I2C_TIMEOUT;
 	while (omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG) & OMAP_I2C_STAT_BB) {
 		if (time_after(jiffies, timeout))
-			return i2c_recover_bus(&omap->adapter);
+			return omap_i2c_recover_bus(omap);
 		msleep(1);
 	}
 
@@ -563,8 +579,13 @@ static int omap_i2c_wait_for_bb_valid(struct omap_i2c_dev *omap)
 		}
 
 		if (time_after(jiffies, timeout)) {
+			/*
+			 * SDA or SCL were low for the entire timeout without
+			 * any activity detected. Most likely, a slave is
+			 * locking up the bus with no master driving the clock.
+			 */
 			dev_warn(omap->dev, "timeout waiting for bus ready\n");
-			return -ETIMEDOUT;
+			return omap_i2c_recover_bus(omap);
 		}
 
 		msleep(1);
-- 
2.7.4
