From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 10/13] I2C: OMAP: Don't check if wait_for_completion_timeout() returns less than zero
Date: Thu, 8 Mar 2012 18:48:02 +0530
Message-ID: <1331212685-6524-11-git-send-email-shubhrajyoti@ti.com>
References: <1331212685-6524-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1331212685-6524-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

By definition, wait_for_completion_timeout() returns an unsigned value and
therefore, it is not necessary to check if the return value is less than zero
as this is not possible.

This is based on a patch from Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Changes from his patch
- Declare a long as the wait_for_completion_timeout returns long.

Cc : Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
Original patch is
http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=ea02cece7b0000bc736e60c4188a11aaa74bc6e6

 drivers/i2c/busses/i2c-omap.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ed22e67..43c22a7 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -502,7 +502,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 			     struct i2c_msg *msg, int stop)
 {
 	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
-	int r;
+	unsigned long timeout;
 	u16 w;
 
 	dev_dbg(dev->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
@@ -570,12 +570,10 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	 * REVISIT: We should abort the transfer on signals, but the bus goes
 	 * into arbitration and we're currently unable to recover from it.
 	 */
-	r = wait_for_completion_timeout(&dev->cmd_complete,
-					OMAP_I2C_TIMEOUT);
+	timeout = wait_for_completion_timeout(&dev->cmd_complete,
+						OMAP_I2C_TIMEOUT);
 	dev->buf_len = 0;
-	if (r < 0)
-		return r;
-	if (r == 0) {
+	if (timeout == 0) {
 		dev_err(dev->dev, "controller timed out\n");
 		omap_i2c_init(dev);
 		omap_i2c_reset(dev);
-- 
1.7.1
