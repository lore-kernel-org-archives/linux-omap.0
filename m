From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv9 1/2] OMAP : I2C : Remove reset at init
Date: Fri, 13 Jan 2012 12:27:05 +0530
Message-ID: <1326437826-7408-2-git-send-email-shubhrajyoti@ti.com>
References: <1326437826-7408-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1326437826-7408-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The reset in the driver at init is not needed anymore as the
following patch has removed the HWMOD_INIT_NO_RESET flag.
6d3c55f [OMAP: hwmod: fix the i2c-reset timeout during bootup]

This patch does the following
-removes the reset from the probe and implements a omap_i2c_reset
 function to reset.
- Reset is removed from omap_i2c_init, which was called
 not only during probe, but also after time out and error handling.
 omap_i2c_reset is added in those places to effect the reset.

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f713eac..3bfb1ae 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -310,15 +310,9 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 	}
 }
 
-static int omap_i2c_init(struct omap_i2c_dev *dev)
+static int omap_i2c_reset(struct omap_i2c_dev *dev)
 {
-	u16 psc = 0, scll = 0, sclh = 0, buf = 0;
-	u16 fsscll = 0, fssclh = 0, hsscll = 0, hssclh = 0;
-	unsigned long fclk_rate = 12000000;
 	unsigned long timeout;
-	unsigned long internal_clk = 0;
-	struct clk *fclk;
-
 	if (dev->rev >= OMAP_I2C_OMAP1_REV_2) {
 		/* Disable I2C controller before soft reset */
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
@@ -366,6 +360,16 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 							dev->westate);
 		}
 	}
+}
+
+static int omap_i2c_init(struct omap_i2c_dev *dev)
+{
+	u16 psc = 0, scll = 0, sclh = 0, buf = 0;
+	u16 fsscll = 0, fssclh = 0, hsscll = 0, hssclh = 0;
+	unsigned long fclk_rate = 12000000;
+	unsigned long internal_clk = 0;
+	struct clk *fclk;
+
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 
 	if (dev->flags & OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK) {
@@ -590,6 +594,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	if (r == 0) {
 		dev_err(dev->dev, "controller timed out\n");
 		omap_i2c_init(dev);
+		omap_i2c_reset(dev);
 		return -ETIMEDOUT;
 	}
 
@@ -600,6 +605,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
 			    OMAP_I2C_STAT_XUDF)) {
 		omap_i2c_init(dev);
+		omap_i2c_reset(dev);
 		return -EIO;
 	}
 
-- 
1.7.1
