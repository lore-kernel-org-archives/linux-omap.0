From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv8 03/13] I2C: OMAP: Remove reset at init
Date: Mon, 18 Jun 2012 20:00:18 +0530
Message-ID: <1340029828-20751-4-git-send-email-shubhrajyoti@ti.com>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340029828-20751-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
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
 drivers/i2c/busses/i2c-omap.c |   38 +++++++++++++++++++++++---------------
 1 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 838a0ae..5da91b5 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -269,15 +269,9 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 				(i2c_dev->regs[reg] << i2c_dev->reg_shift));
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
@@ -315,16 +309,18 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 
 			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
 							dev->syscstate);
-			/*
-			 * Enabling all wakup sources to stop I2C freezing on
-			 * WFI instruction.
-			 * REVISIT: Some wkup sources might not be needed.
-			 */
-			dev->westate = OMAP_I2C_WE_ALL;
-			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
-							dev->westate);
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
@@ -433,6 +429,16 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
 				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0);
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
+	if (dev->rev >= OMAP_I2C_REV_ON_3430_3530) {
+		/*
+		 * Enabling all wakup sources to stop I2C freezing on
+		 * WFI instruction.
+		 * REVISIT: Some wkup sources might not be needed.
+		 */
+		dev->westate = OMAP_I2C_WE_ALL;
+		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
+	}
+
 	if (dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
 		dev->pscstate = psc;
 		dev->scllstate = scll;
@@ -541,6 +547,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	dev->buf_len = 0;
 	if (timeout == 0) {
 		dev_err(dev->dev, "controller timed out\n");
+		omap_i2c_reset(dev);
 		omap_i2c_init(dev);
 		return -ETIMEDOUT;
 	}
@@ -551,6 +558,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	/* We have an error */
 	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
 			    OMAP_I2C_STAT_XUDF)) {
+		omap_i2c_reset(dev);
 		omap_i2c_init(dev);
 		return -EIO;
 	}
-- 
1.7.5.4
