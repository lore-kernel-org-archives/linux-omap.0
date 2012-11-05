From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv3 6/8] i2c: omap: make reset a seperate function
Date: Mon, 5 Nov 2012 17:53:41 +0530
Message-ID: <1352118223-3796-7-git-send-email-shubhrajyoti@ti.com>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38807 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753978Ab2KEMY2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 07:24:28 -0500
In-Reply-To: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, b-cousson@ti.com, balbi@ti.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

Implement reset as a separate function.
This will enable us to make sure that we don't do the
calculation again on every transfer.
Also at probe the reset is not added as the hwmod is doing that
for us.

Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
todo: reprodue the errors and optimise the reset if possible
 drivers/i2c/busses/i2c-omap.c |   39 ++++++++++++++++++++++++---------------
 1 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 393bb22..7393017 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -299,15 +299,9 @@ static void __omap_i2c_init(struct omap_i2c_dev *dev)
 		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
 }
 
-static int omap_i2c_init(struct omap_i2c_dev *dev)
+static int omap_i2c_reset(struct omap_i2c_dev *dev)
 {
-	u16 psc = 0, scll = 0, sclh = 0;
-	u16 fsscll = 0, fssclh = 0, hsscll = 0, hssclh = 0;
-	unsigned long fclk_rate = 12000000;
 	unsigned long timeout;
-	unsigned long internal_clk = 0;
-	struct clk *fclk;
-
 	if (dev->rev >= OMAP_I2C_OMAP1_REV_2) {
 		/* Disable I2C controller before soft reset */
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
@@ -345,14 +339,27 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 
 			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
 							dev->syscstate);
-			/*
-			 * Enabling all wakup sources to stop I2C freezing on
-			 * WFI instruction.
-			 * REVISIT: Some wkup sources might not be needed.
-			 */
-			dev->westate = OMAP_I2C_WE_ALL;
 		}
 	}
+	return 0;
+}
+
+static int omap_i2c_init(struct omap_i2c_dev *dev)
+{
+	u16 psc = 0, scll = 0, sclh = 0;
+	u16 fsscll = 0, fssclh = 0, hsscll = 0, hssclh = 0;
+	unsigned long fclk_rate = 12000000;
+	unsigned long internal_clk = 0;
+	struct clk *fclk;
+
+	if (dev->rev >= OMAP_I2C_REV_ON_3430_3530) {
+		/*
+		 * Enabling all wakup sources to stop I2C freezing on
+		 * WFI instruction.
+		 * REVISIT: Some wkup sources might not be needed.
+		 */
+		dev->westate = OMAP_I2C_WE_ALL;
+	}
 
 	if (dev->flags & OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK) {
 		/*
@@ -592,7 +599,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	dev->buf_len = 0;
 	if (timeout == 0) {
 		dev_err(dev->dev, "controller timed out\n");
-		omap_i2c_init(dev);
+		omap_i2c_reset(dev);
+		__omap_i2c_init(dev);
 		return -ETIMEDOUT;
 	}
 
@@ -602,7 +610,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	/* We have an error */
 	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
 			    OMAP_I2C_STAT_XUDF)) {
-		omap_i2c_init(dev);
+		omap_i2c_reset(dev);
+		__omap_i2c_init(dev);
 		return -EIO;
 	}
 
-- 
1.7.5.4

