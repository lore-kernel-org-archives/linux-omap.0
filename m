From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 03/10] I2C: OMAP: Recover from Bus Busy condition
Date: Fri, 10 Feb 2012 19:29:58 +0530
Message-ID: <1328882405-15284-4-git-send-email-shubhrajyoti@ti.com>
References: <1328882405-15284-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1328882405-15284-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>

In case a peripheral is driving SDA bus low (ie. a start condition), provide
a constant clock output using the test mode of the OMAP I2C controller to
try and clear the bus. Soft reset I2C controller after attempting the bus clear
to ensure that controller is in a good state.

Based upon Vikram Pandita's patch from TI Android 3.0.
I acknowledge the contributions and suggestions of Jon and Hemant.

A couple differences from the original patch ...
1. Add a new function for bus clear
2. Ensure that the CON.I2C_EN bit is set when using the SYSTEST feature to
   output a permanent clock. This bit needs to be set and typically it would
   be set by the unidle function but this is not the case for all OMAP
   generations.
3. Program the SYSTEST setting only the bits we care about. However, restore
   SYSTEST registers to there original state as some OMAP generations do not
   implement perform a soft-reset.
4. Clear the CON register after performing the bus clear, so when we call the
   init function the controller is disabled and the init function will
   re-enable later.

Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
Original patch can be found here:
http://git.omapzoom.org/?p=kernel/omap.git;a=commit;h=a2ab04192ba25e60f95ba1ff3af5601a2d7b5bd1

 drivers/i2c/busses/i2c-omap.c |   33 ++++++++++++++++++++++++++++++---
 1 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a115d2c..f19bb7e 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -147,16 +147,15 @@ enum {
 #define OMAP_I2C_SCLH_HSSCLH	8
 
 /* I2C System Test Register (OMAP_I2C_SYSTEST): */
-#ifdef DEBUG
 #define OMAP_I2C_SYSTEST_ST_EN		(1 << 15)	/* System test enable */
 #define OMAP_I2C_SYSTEST_FREE		(1 << 14)	/* Free running mode */
 #define OMAP_I2C_SYSTEST_TMODE_MASK	(3 << 12)	/* Test mode select */
-#define OMAP_I2C_SYSTEST_TMODE_SHIFT	(12)		/* Test mode select */
+#define OMAP_I2C_SYSTEST_TMODE_TEST	(2 << 12)	/* Test mode select */
+#define OMAP_I2C_SYSTEST_TMODE_LOOP	(3 << 12)	/* Test mode select */
 #define OMAP_I2C_SYSTEST_SCL_I		(1 << 3)	/* SCL line sense in */
 #define OMAP_I2C_SYSTEST_SCL_O		(1 << 2)	/* SCL line drive out */
 #define OMAP_I2C_SYSTEST_SDA_I		(1 << 1)	/* SDA line sense in */
 #define OMAP_I2C_SYSTEST_SDA_O		(1 << 0)	/* SDA line drive out */
-#endif
 
 /* OCP_SYSSTATUS bit definitions */
 #define SYSS_RESETDONE_MASK		(1 << 0)
@@ -319,6 +318,7 @@ static int omap_i2c_reset(struct omap_i2c_dev *dev)
 							dev->westate);
 		}
 	}
+	return 0;
 }
 
 static int omap_i2c_init(struct omap_i2c_dev *dev)
@@ -471,6 +471,31 @@ static int omap_i2c_wait_for_bb(struct omap_i2c_dev *dev)
 }
 
 /*
+ * Bus Clear
+ */
+static int omap_i2c_bus_clear(struct omap_i2c_dev *dev)
+{
+	u16 w;
+
+	/*
+	 * Per the I2C specification, if we are stuck in a bus busy state
+	 * we can attempt a bus clear to try and recover the bus by sending
+	 * at least 9 clock pulses on SCL. Put the I2C in a test mode so it
+	 * will output a continuous clock on SCL.
+	 */
+	w = omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
+	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
+	omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG,
+		(OMAP_I2C_SYSTEST_ST_EN | OMAP_I2C_SYSTEST_TMODE_TEST));
+	msleep(1);
+	omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG, w);
+	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
+	omap_i2c_reset(dev);
+	omap_i2c_init(dev);
+	return omap_i2c_wait_for_bb(dev);
+}
+
+/*
  * Low level master read/write transaction.
  */
 static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
@@ -597,6 +622,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	r = omap_i2c_wait_for_bb(dev);
 	if (r < 0)
+		r = omap_i2c_bus_clear(dev);
+	if (r < 0)
 		goto out;
 
 	if (dev->set_mpu_wkup_lat != NULL)
-- 
1.7.1
