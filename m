From: Dmitry Antipov <dmitry.antipov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/3] i2c-omap: use usleep_range(), get rid out of jiffies
Date: Tue, 17 Jan 2012 16:52:36 +0400
Message-ID: <1326804756-17703-1-git-send-email-dmitry.antipov@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Dmitry Antipov <dmitry.antipov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Use usleep_range() with return value to implement time-bounded
wait-for hardware loop where delay is applicable; use ktime
instead of jiffies for a busy-wait loop.

Signed-off-by: Dmitry Antipov <dmitry.antipov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index fa23faa..401a622 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -49,8 +49,8 @@
 #define OMAP_I2C_REV_ON_3430		0x3C
 #define OMAP_I2C_REV_ON_3530_4430	0x40
 
-/* timeout waiting for the controller to respond */
-#define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
+/* timeout waiting for the controller to respond, in usecs */
+#define OMAP_I2C_TIMEOUT USEC_PER_SEC
 
 /* For OMAP3 I2C_IV has changed to I2C_WE (wakeup enable) */
 enum {
@@ -333,16 +333,16 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, SYSC_SOFTRESET_MASK);
 		/* For some reason we need to set the EN bit before the
 		 * reset done bit gets set. */
-		timeout = jiffies + OMAP_I2C_TIMEOUT;
+		timeout = 0;
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 		while (!(omap_i2c_read_reg(dev, OMAP_I2C_SYSS_REG) &
 			 SYSS_RESETDONE_MASK)) {
-			if (time_after(jiffies, timeout)) {
+			if (timeout > OMAP_I2C_TIMEOUT) {
 				dev_warn(dev->dev, "timeout waiting "
 						"for controller reset\n");
 				return -ETIMEDOUT;
 			}
-			msleep(1);
+			timeout += usleep_range(1000, 2000);
 		}
 
 		/* SYSC register is cleared by the reset; rewrite it */
@@ -498,15 +498,14 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
  */
 static int omap_i2c_wait_for_bb(struct omap_i2c_dev *dev)
 {
-	unsigned long timeout;
+	unsigned long timeout = 0;
 
-	timeout = jiffies + OMAP_I2C_TIMEOUT;
 	while (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG) & OMAP_I2C_STAT_BB) {
-		if (time_after(jiffies, timeout)) {
+		if (timeout > OMAP_I2C_TIMEOUT) {
 			dev_warn(dev->dev, "timeout waiting for bus ready\n");
 			return -ETIMEDOUT;
 		}
-		msleep(1);
+		timeout += usleep_range(1000, 2000);
 	}
 
 	return 0;
@@ -564,13 +563,13 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	 * Don't write stt and stp together on some hardware.
 	 */
 	if (dev->b_hw && stop) {
-		unsigned long delay = jiffies + OMAP_I2C_TIMEOUT;
+		ktime_t start = ktime_get();
 		u16 con = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
 		while (con & OMAP_I2C_CON_STT) {
 			con = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
 
 			/* Let the user know if i2c is in a bad state */
-			if (time_after(jiffies, delay)) {
+			if (ktime_us_delta(ktime_get(), start) > OMAP_I2C_TIMEOUT) {
 				dev_err(dev->dev, "controller timed out "
 				"waiting for start condition to finish\n");
 				return -ETIMEDOUT;
@@ -588,7 +587,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	 * into arbitration and we're currently unable to recover from it.
 	 */
 	r = wait_for_completion_timeout(&dev->cmd_complete,
-					OMAP_I2C_TIMEOUT);
+					usecs_to_jiffies(OMAP_I2C_TIMEOUT));
 	dev->buf_len = 0;
 	if (r < 0)
 		return r;
-- 
1.7.7.5
